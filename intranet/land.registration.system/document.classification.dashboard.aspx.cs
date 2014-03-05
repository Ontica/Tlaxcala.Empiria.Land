/* Empiria® Land 2014 ****************************************************************************************
*																																																						 *
*	 Solution  : Empiria® Land                                    System   : Land Intranet Application         *
*	 Namespace : Empiria.Web.UI.Workflow                          Assembly : Empiria.Land.Intranet.dll         *
*	 Type      : TasksDashboard                                   Pattern  : Explorer Web Page                 *
*	 Date      : 28/Mar/2014                                      Version  : 1.5  License: CC BY-NC-SA 4.0     *
*																																																						 *
*  Summary   : Multiview dashboard used for workflow task management.                                        *
*																																																						 *
**************************************************** Copyright © La Vía Óntica SC + Ontica LLC. 1994-2014. **/
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using Empiria.Documents;
using Empiria.Documents.IO;
using Empiria.Land.Registration;
using Empiria.Land.Registration.Data;
using Empiria.Land.UI;
using Empiria.Presentation;
using Empiria.Presentation.Web;

namespace Empiria.Web.UI.LRS {

  public partial class DocumentClassificationDashboard : MultiViewDashboard {

    #region Fields

    private RecorderOffice selectedRecorderOffice = RecorderOffice.Empty;

    #endregion Fields

    #region Protected methods

    protected void Page_Init(object sender, EventArgs e) {
      selectedRecorderOffice = LRSHtmlSelectControls.ParseRecorderOffice(this, cboRecorderOffice.UniqueID);
    }

    public sealed override Repeater ItemsRepeater {
      get { return this.itemsRepeater; }
    }

    protected sealed override bool ExecutePageCommand() {
      switch (base.CommandName) {
        case "updateUserInterface":
          LoadPageControls();
          base.LoadRepeater();
          return true;
        case "sendRecordingBookToQualityControl":
          SendRecordingBookToQualityControl();
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
        selectedRecorderOffice = RecorderOffice.Empty;
        return RecordingBooksData.GetVolumeRecordingBooks(selectedRecorderOffice, RecordingBookStatus.Assigned,
                                                          GetRecordingBookFilter(), String.Empty);
      } else if (base.SelectedTabStrip == 1) {
        return RecordingBooksData.GetVolumeRecordingBooks(selectedRecorderOffice, RecordingBookStatus.Pending,
                                                          GetRecordingBookFilter(), String.Empty);
      } else if (base.SelectedTabStrip == 2) {
        return RecordingBooksData.GetVolumeRecordingBooks(selectedRecorderOffice, RecordingBookStatus.Revision,
                                                          GetRecordingBookFilter(), String.Empty);
      } else if (base.SelectedTabStrip == 3) {
        return RecordingBooksData.GetVolumeRecordingBooks(selectedRecorderOffice, RecordingBookStatus.Closed,
                                                          GetRecordingBookFilter(), String.Empty);
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
      filter += " AND ";
      filter += "([AssignedToId] = " + ExecutionServer.CurrentUserId + ")";
      return filter;
    }

    private string GetRecordingBookFilter() {
      return "([AssignedToId] = " + ExecutionServer.CurrentUserId + ")";
    }

    protected sealed override void LoadPageControls() {
      LRSHtmlSelectControls.LoadRecorderOfficeCombo(this.cboRecorderOffice, ComboControlUseMode.ObjectSearch, selectedRecorderOffice);
      LoadInboxInQuickMode();
    }

    private void LoadInboxInQuickMode() {
      if (base.CommandName == "setInbox") {
        LoadRepeater();
      }
      if (!IsPostBack) {
        LoadRepeater();
      }
    }

    private void SendRecordingBookToQualityControl() {
      int recordingBookId = int.Parse(GetCommandParameter("id"));

      RecordingBook recordingBook = RecordingBook.Parse(recordingBookId);
      recordingBook.SendToRevision();

      base.SetOKScriptMsg("El libro registral " + recordingBook.Name + " fue enviado al área de control de calidad.");
    }

    protected sealed override void SetRepeaterTemplates() {
      if (base.SelectedTabStrip == 0) {
        itemsRepeater.HeaderTemplate = Page.LoadTemplate("~/templates/land.registration.system/recording.book.pending.classification.header.ascx");
        itemsRepeater.ItemTemplate = Page.LoadTemplate("~/templates/land.registration.system/recording.book.pending.classification.items.ascx");
        base.ViewColumnsCount = 3;
      } else if (base.SelectedTabStrip == 1) {
        itemsRepeater.HeaderTemplate = Page.LoadTemplate("~/templates/empty.header.ascx");
        base.ViewColumnsCount = 3;
      } else if (base.SelectedTabStrip == 2) {
        itemsRepeater.HeaderTemplate = Page.LoadTemplate("~/templates/empty.header.ascx");
        base.ViewColumnsCount = 3;
      } else if (base.SelectedTabStrip == 3) {
        itemsRepeater.HeaderTemplate = Page.LoadTemplate("~/templates/empty.header.ascx");
        base.ViewColumnsCount = 3;
      } else {
        itemsRepeater.HeaderTemplate = Page.LoadTemplate("~/templates/empty.header.ascx");
      }
    }

    #endregion Protected methods

  } // class DocumentClassificationDashboard

} // namespace Empiria.Web.UI.Workflow