/* Empiria Land **********************************************************************************************
*																																																						 *
*  Solution  : Empiria Land                                     System   : Land Intranet Application         *
*  Namespace : Empiria.Land.WebApp                              Assembly : Empiria.Land.Intranet.dll         *
*  Type      : TasksDashboard                                   Pattern  : Explorer Web Page                 *
*  Version   : 2.1                                              License  : Please read license.txt file      *
*																																																						 *
*  Summary   : Multiview dashboard used for workflow task management.                                        *
*                                                                                                            *
********************************** Copyright(c) 2009-2016. La Vía Óntica SC, Ontica LLC and contributors.  **/
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

using Empiria.Contacts;
using Empiria.DataTypes;
using Empiria.Documents;
using Empiria.Documents.IO;
using Empiria.Land.Registration;
using Empiria.Land.Registration.Data;
using Empiria.Land.UI;
using Empiria.Presentation;
using Empiria.Presentation.Web;

namespace Empiria.Land.WebApp {

  public partial class DocumentDigitalizationDashboard : MultiViewDashboard {

    #region Fields

    private RecorderOffice selectedRecorderOffice = null;
    private RecordingActTypeCategory selectedRecordingBookClass = null;

    #endregion Fields

    #region Protected methods

    protected void Page_Init(object sender, EventArgs e) {
      selectedRecorderOffice = LRSHtmlSelectControls.ParseRecorderOffice(this, cboRecorderOffice.UniqueID);
      selectedRecordingBookClass = LRSHtmlSelectControls.ParseRecordingActTypeCategory(this, cboRecordingClass.UniqueID);
    }

    public sealed override Repeater ItemsRepeater {
      get { return this.itemsRepeater; }
    }

    protected sealed override bool ExecutePageCommand() {
      switch (base.CommandName) {
        case "processImagingDirectories":
          ProcessImagingDirectories();
          base.LoadRepeater();
          return true;
        case "updateUserInterface":
          LoadPageControls();
          base.LoadRepeater();
          return true;
        case "createRecordBookWithDirectory":
          CreateRecordingBookWithDirectory();
          base.LoadRepeater();
          return true;
        case "deleteDirectory":
          DeleteDirectory();
          base.LoadRepeater();
          return true;
        case "assignRecordingBook":
          AssignRecordingBook();
          base.LoadRepeater();
          return true;
        case "unassignRecordingBook":
          UnassignRecordingBook();
          base.LoadRepeater();
          return true;
        case "sendRecordingBookToLastAnalyst":
          SendRecordingBookToLastAnalyst();
          base.LoadRepeater();
          return true;
        case "sendRecordingBookToQualityControl":
          SendRecordingBookToQualityControl();
          base.LoadRepeater();
          return true;
        case "updateRecordingsControlCount":
          UpdateRecordingsControlCount();
          base.LoadRepeater();
          return true;
        case "updateRecordingsControlDates":
          UpdateRecordingsControlDates();
          base.LoadRepeater();
          return true;
        case "closeRecordingBook":
          CloseRecordingBook();
          base.LoadRepeater();
          return true;
        default:
          return false;
      }
    }

    protected sealed override void Initialize() {
      base.LoadInboxesInQuickMode = true;
    }

    protected sealed override DataView LoadDataSource() {
      if (base.SelectedTabStrip == 0) {
        return DocumentsData.GetFilesFolders(RecordBookDirectory.DirectoryType, GetDirectoriesFilter(), "FilesFolderDisplayName DESC");
      } else if (base.SelectedTabStrip == 1) {
        return RecordingBooksData.GetVolumeRecordingBooks(selectedRecorderOffice, RecordingBookStatus.Pending,
                                                          GetRecordingBooksFilter(), "BookAsText DESC");
      } else if (base.SelectedTabStrip == 2) {
        return RecordingBooksData.GetVolumeRecordingBooks(selectedRecorderOffice, RecordingBookStatus.Assigned,
                                                          GetRecordingBooksFilter(), "BookAsText DESC");
      } else if (base.SelectedTabStrip == 3) {
        return RecordingBooksData.GetVolumeRecordingBooks(selectedRecorderOffice, RecordingBookStatus.Revision,
                                                          GetRecordingBooksFilter(), "BookAsText");
      } else if (base.SelectedTabStrip == 4) {
        return RecordingBooksData.GetVolumeRecordingBooks(selectedRecorderOffice, RecordingBookStatus.Closed,
                                                          GetRecordingBooksFilter(), "BookAsText");
      } else {
        return new DataView();
      }
    }

    private string GetDirectoriesFilter() {
      string filter = DocumentsData.GetFilesFoldersFilter(selectedRecorderOffice, txtSearchExpression.Value);

      if (filter.Length != 0) {
        filter += " AND ";
      }
      filter += "([FilesFolderStatus] IN ('" +
                (char) FilesFolderStatus.Pending + "', '" + (char) FilesFolderStatus.Obsolete + "'))";

      return filter;
    }

    private string GetRecordingBooksFilter() {
      string filter = String.Empty;

      if (!selectedRecordingBookClass.IsEmptyInstance) {
        filter += "[RecordingSectionId] = " + selectedRecordingBookClass.Id.ToString();
      }
      if (txtSearchExpression.Value.Length != 0) {
        if (filter.Length != 0) {
          filter += " AND ";
        }
        filter += "[BookNo] LIKE '%" + txtSearchExpression.Value + "%'";
      }
      return filter;
    }

    protected sealed override void LoadPageControls() {
      LRSHtmlSelectControls.LoadRecorderOfficeCombo(this.cboRecorderOffice, ComboControlUseMode.ObjectSearch, selectedRecorderOffice);
      LRSHtmlSelectControls.LoadRecordingBookClassesCombo(this.cboRecordingClass, "( Todos )", selectedRecordingBookClass);

      if (base.SelectedTabStrip == 5) {
        //LRSHtmlSelectControls.
      }
    }

    protected sealed override void SetRepeaterTemplates() {
      if (base.SelectedTabStrip == 0) {
        itemsRepeater.HeaderTemplate = Page.LoadTemplate("~/templates/land.registration.system/recording.book.creation.header.ascx");
        if (RecordingBook.UseBookLevel) {
          itemsRepeater.ItemTemplate = Page.LoadTemplate("~/templates/land.registration.system/recording.book.creation.bookLevel.items.ascx");
        } else {
          itemsRepeater.ItemTemplate = Page.LoadTemplate("~/templates/land.registration.system/recording.book.creation.noBookLevel.items.ascx");
        }
        base.ViewColumnsCount = 3;
      } else if (base.SelectedTabStrip == 1) {
        itemsRepeater.HeaderTemplate = Page.LoadTemplate("~/templates/land.registration.system/recording.book.unassigned.header.ascx");
        itemsRepeater.ItemTemplate = Page.LoadTemplate("~/templates/land.registration.system/recording.book.unassigned.items.ascx");
        base.ViewColumnsCount = 3;
      } else if (base.SelectedTabStrip == 2) {
        itemsRepeater.HeaderTemplate = Page.LoadTemplate("~/templates/land.registration.system/recording.book.assigned.header.ascx");
        itemsRepeater.ItemTemplate = Page.LoadTemplate("~/templates/land.registration.system/recording.book.assigned.items.ascx");
        base.ViewColumnsCount = 3;
      } else if (base.SelectedTabStrip == 3) {
        itemsRepeater.HeaderTemplate = Page.LoadTemplate("~/templates/land.registration.system/recording.book.onrevision.header.ascx");
        itemsRepeater.ItemTemplate = Page.LoadTemplate("~/templates/land.registration.system/recording.book.onrevision.items.ascx");
        base.ViewColumnsCount = 3;
      } else if (base.SelectedTabStrip == 4) {
        itemsRepeater.HeaderTemplate = Page.LoadTemplate("~/templates/land.registration.system/recording.book.closed.header.ascx");
        itemsRepeater.ItemTemplate = Page.LoadTemplate("~/templates/land.registration.system/recording.book.closed.items.ascx");
        base.ViewColumnsCount = 3;
      } else {
        itemsRepeater.HeaderTemplate = Page.LoadTemplate("~/templates/empty.header.ascx");
      }
    }

    #endregion Protected methods

    #region Private methods

    private void AssignRecordingBook() {
      int recordingBookId = int.Parse(GetCommandParameter("id"));
      int analystId = int.Parse(GetCommandParameter("analystId"));
      string notes = GetCommandParameter("notes", false);

      RecordingBook recordingBook = RecordingBook.Parse(recordingBookId);
      recordingBook.Assign(Contact.Parse(analystId), notes);

      base.SetOKScriptMsg("El libro registral " + recordingBook.AsText + " fue asignado para su análisis.");
    }

    private void CloseRecordingBook() {
      int recordingBookId = int.Parse(GetCommandParameter("id"));
      string esign = GetCommandParameter("esign");
      string notes = GetCommandParameter("notes", false);

      RecordingBook recordingBook = RecordingBook.Parse(recordingBookId);
      if (recordingBook.Close(esign, notes)) {
        base.SetOKScriptMsg("El libro registral " + recordingBook.AsText + " fue cerrado correctamente.");
      } else {
        base.SetOKScriptMsg("La firma electrónica proporcionada no es válida.");
      }
    }

    private void UnassignRecordingBook() {
      int recordingBookId = int.Parse(GetCommandParameter("id"));
      string notes = GetCommandParameter("notes", false);

      RecordingBook recordingBook = RecordingBook.Parse(recordingBookId);
      recordingBook.Unassign(notes);

      base.SetOKScriptMsg("El libro registral " + recordingBook.AsText + " ya no tiene analista asignado.");
    }

    private void SendRecordingBookToLastAnalyst() {
      int recordingBookId = int.Parse(GetCommandParameter("id"));
      string notes = GetCommandParameter("notes", false);

      RecordingBook recordingBook = RecordingBook.Parse(recordingBookId);
      if (!recordingBook.AssignedTo.IsEmptyInstance) {
        recordingBook.Assign(recordingBook.AssignedTo, notes);
      } else {
        recordingBook.Unassign(notes);
      }
      base.SetOKScriptMsg("Se regresó el libro registral " + recordingBook.AsText + " al área de análisis y captura.");
    }

    private void SendRecordingBookToQualityControl() {
      int recordingBookId = int.Parse(GetCommandParameter("id"));

      RecordingBook recordingBook = RecordingBook.Parse(recordingBookId);
      recordingBook.SendToRevision();

      base.SetOKScriptMsg("El libro registral " + recordingBook.AsText + " fue enviado al área de control de calidad.");
    }

    private void UpdateRecordingsControlCount() {
      int recordingBookId = int.Parse(GetCommandParameter("id"));
      int controlRecordingsCount = int.Parse(GetCommandParameter("controlRecordingsCount"));

      RecordingBook recordingBook = RecordingBook.Parse(recordingBookId);
      recordingBook.EndRecordingIndex = controlRecordingsCount;
      recordingBook.Save();

      base.SetOKScriptMsg("El número de inscripciones de control fue actualizado correctamente.");
    }

    private void UpdateRecordingsControlDates() {
      int recordingBookId = int.Parse(GetCommandParameter("id"));
      DateTime fromDate = EmpiriaString.ToDate(GetCommandParameter("fromDate"));
      DateTime toDate = EmpiriaString.ToDate(GetCommandParameter("toDate"));

      RecordingBook recordingBook = RecordingBook.Parse(recordingBookId);
      recordingBook.RecordingsControlTimePeriod = new TimeFrame(fromDate, toDate);
      recordingBook.Save();

      base.SetOKScriptMsg("Las fechas de control del libro fueron actualizadas correctamente.");
    }

    private void CreateRecordingBookWithDirectory() {
      int directoryId = int.Parse(GetCommandParameter("id"));
      int capturedById = int.Parse(GetCommandParameter("capturedById"));
      int reviewedById = int.Parse(GetCommandParameter("reviewedById"));
      int recordingSectionTypeId = int.Parse(GetCommandParameter("recordingsClassId"));
      DateTime fromDate = EmpiriaString.ToDate(GetCommandParameter("fromDate"));
      DateTime toDate = EmpiriaString.ToDate(GetCommandParameter("toDate"));
      int controlRecordingsCount = int.Parse(GetCommandParameter("controlRecordingsCount"));

      RecordBookDirectory directory = RecordBookDirectory.Parse(directoryId);
      Contact imagesCapturedBy = Contact.Parse(capturedById);
      Contact imagesReviewedBy = Contact.Parse(reviewedById);
      RecordingSection sectionType = RecordingSection.Parse(recordingSectionTypeId);

      directory.CreateRecordingBook(sectionType, imagesCapturedBy, imagesReviewedBy,
                                    controlRecordingsCount, new TimeFrame(fromDate, toDate));

      base.SetOKScriptMsg("El libro registral digitalizado en el directorio " + directory.DisplayName + "\\nfue creado correctamente.");
    }

    private void DeleteDirectory() {
      base.SetOKScriptMsg("El directorio fue eliminado del sistema.");
    }

    private void ProcessImagingDirectories() {
      //RecordBookDirectory.UpdateFilesCount(selectedRecorderOffice);

      //base.SetOKScriptMsg(selectedRecorderOffice.FullName + " revisado");
      int processedDirectories = RecordBookDirectory.ProcessDirectories(selectedRecorderOffice);
      string msg = String.Empty;

      if (processedDirectories >= 1) {
        msg = "Se procesaron " + processedDirectories.ToString("N0") + " directorios con imágenes digitalizadas ";
        msg += "para la Oficialía " + selectedRecorderOffice.FullName + ".";
      } else if (processedDirectories == 1) {
        msg = "Se procesó un directorio con imágenes digitalizadas ";
        msg += "para el Distrito " + selectedRecorderOffice.FullName + ".";
      } else if (processedDirectories == 0) {
        msg = "No se encontró ningún nuevo directorio con imágenes digitalizadas ";
        msg += "para el Distrito " + selectedRecorderOffice.FullName + ".";
      }
      base.SetOKScriptMsg(msg);
    }

    #endregion Private methods

  } // class DocumentDigitalizationDashboard

} // namespace Empiria.Land.WebApp
