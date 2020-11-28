/* Empiria Land **********************************************************************************************
*                                                                                                            *
*  Solution  : Empiria Land                                     System   : Land Intranet Application         *
*  Namespace : Empiria.Land.WebApp                              Assembly : Empiria.Land.Intranet.dll         *
*  Type      : RecordingBookAnalyzer                            Pattern  : Explorer Web Page                 *
*  Version   : 3.0                                              License  : Please read license.txt file      *
*                                                                                                            *
*  Summary   :                                                                                               *
*                                                                                                            *
************************* Copyright(c) La Vía Óntica SC, Ontica LLC and contributors. All rights reserved. **/
using System;
using System.Web.UI;
using System.Web.UI.WebControls;

using Empiria.Presentation;
using Empiria.Presentation.Web;
using Empiria.Presentation.Web.Content;

using Empiria.Contacts;
using Empiria.Land.Documentation;
using Empiria.Land.Registration;
using Empiria.Land.UI;

namespace Empiria.Land.WebApp {

  public partial class RecordingBookAnalyzer : WebPage {

    #region Fields

    protected LRSDocumentEditorControl oRecordingDocumentEditor = null;
    protected RecordingBook recordingBook = null;
    protected PhysicalRecording recording = null;
    protected RecordingBookImageSet imageSet = null;

    protected int currentImagePosition = 0;
    protected string gRecordingActs = String.Empty;

    protected int recordingsPerViewerPage = 25;

    #endregion Fields

    #region Constructors and parsers

    protected void Page_Init(object sender, EventArgs e) {
      LoadDocumentEditorControl();
    }

    private void LoadDocumentEditorControl() {
      oRecordingDocumentEditor = (LRSDocumentEditorControl) Page.LoadControl(LRSDocumentEditorControl.ControlVirtualPath);
      spanRecordingDocumentEditor.Controls.Add(oRecordingDocumentEditor);
    }

    protected void Page_Load(object sender, EventArgs e) {
      Initialize();
      if (IsPostBack) {
        DoCommand();
      } else {
        LoadControls();
      }
      hdnCurrentImagePosition.Value = currentImagePosition.ToString();
    }

    private void LoadControls() {
      cboRecordingType.Value = recording.MainDocument.DocumentType.Id.ToString();
      LoadRecordingActTypeCategoriesCombo();
      LoadRecorderOfficersCombo();
      LoadStatusCombo();
      if (recording.Id > 0) {
        LoadRecordingControls();
      } else {
        LoadAnotherPropertyRecorderOfficesCombo();
        LoadRecordingActsPropertiesCombo();
        cboStatus.Disabled = true;
      }
      LoadRecordingViewerPagesCombo();
    }

    private void DoCommand() {
      switch (base.CommandName) {
        case "saveRecording":
          SaveRecording();
          RefreshPage();
          return;
        case "appendRecordingAct":
          AppendRecordingAct();
          RefreshPage();
          return;
        case "newRecording":
          Response.Redirect("recording.book.analyzer.aspx?bookId=" + recordingBook.Id.ToString() +
                            "&id=-1&image=" + hdnCurrentImagePosition.Value);
          return;
        case "deleteRecording":
          DeleteRecording();
          Response.Redirect("recording.book.analyzer.aspx?bookId=" + recordingBook.Id.ToString() +
                            "&id=0&image=" + hdnCurrentImagePosition.Value, true);
          return;
        case "modifyRecordingActType":
          ModifyRecordingActType();
          RefreshPage();
          return;
        case "deleteRecordingAct":
          DeleteRecordingAct();
          RefreshPage();
          return;
        case "gotoRecording":
          GoToRecording();
          Response.Redirect("recording.book.analyzer.aspx?bookId=" + recordingBook.Id.ToString() +
                            "&id=" + recording.Id.ToString(), true);
          return;
        case "moveToRecording":
          MoveToRecording();
          Response.Redirect("recording.book.analyzer.aspx?bookId=" + recordingBook.Id.ToString() +
                            "&id=" + recording.Id.ToString(), true);
          return;
        case "refreshImagesStatistics":
          RefreshImagesStatistics();
          RefreshPage();
          return;
        case "refresh":
          this.recordingBook.Refresh();
          RefreshPage();
          return;
        default:
          throw new NotImplementedException(base.CommandName);
      }
    }

    #endregion Constructors and parsers

    #region Private methods

    private void RefreshPage() {
      Response.Redirect("recording.book.analyzer.aspx?bookId=" + recordingBook.Id.ToString() +
                        "&id=" + recording.Id.ToString() + "&image=" + hdnCurrentImagePosition.Value, true);
    }

    private void LoadRecordingControls() {
      this.SetRecordingNumberControls();

      if (this.DisplayImages() && (recording.StartImageIndex > 0)) {
        txtImageStartIndex.Value = recording.StartImageIndex.ToString();
        txtImageEndIndex.Value = recording.EndImageIndex.ToString();
      }
      if (recording.MainDocument.PresentationTime.Date != ExecutionServer.DateMinValue) {
        txtPresentationDate.Value = recording.MainDocument.PresentationTime.ToString("dd/MMM/yyyy");
        txtPresentationTime.Value = recording.MainDocument.PresentationTime.ToString("HH:mm");
      }
      if (recording.MainDocument.AuthorizationTime.Date != ExecutionServer.DateMinValue) {
        txtAuthorizationDate.Value = recording.MainDocument.AuthorizationTime.ToString("dd/MMM/yyyy");
      }
      cboAuthorizedBy.Value = recording.AuthorizedBy.Id.ToString();
      cboStatus.Value = ((char) recording.Status).ToString();
      txtObservations.Value = recording.Notes;

      cboRecordingActTypeCategory.Value = "0";

      gRecordingActs = LRSGridControls.GetPhysicalRecordingActsGrid(this.recording);
      LoadRecordingActsPropertiesCombo();
      LoadAnotherPropertyRecorderOfficesCombo();
    }

    private void LoadAnotherPropertyRecorderOfficesCombo() {
      LRSHtmlSelectControls.LoadRecorderOfficeCombo(this.cboAnotherRecorderOffice, ComboControlUseMode.ObjectCreation,
                                                    recordingBook.RecorderOffice);

      HtmlSelectContent.LoadCombo(this.cboAnotherRecordingBook, "No existen libros de traslativo para ese Distrito",
                                  String.Empty, String.Empty);

      cboAnotherRecording.Items.Clear();
      cboAnotherRecording.Items.Add(new ListItem("¿Libro?", String.Empty));

      cboAnotherProperty.Items.Clear();
      cboAnotherProperty.Items.Add(new ListItem("( ¿Inscripción? )", String.Empty));
    }

    private void LoadRecordingActsPropertiesCombo() {
      cboProperty.Items.Clear();

      cboProperty.Items.Add(new ListItem("Crear un nuevo folio real", "0"));
      foreach (var recordingAct in recording.MainDocument.RecordingActs) {
        var item = new ListItem(recordingAct.Resource.UID, recordingAct.Resource.Id.ToString());
        if (!cboProperty.Items.Contains(item)) {
          cboProperty.Items.Add(item);
        }
      }
      if (cboProperty.Items.Count > 1) {
        cboProperty.Items.Insert(0, new ListItem("( Seleccionar predio )", ""));
      }
    }

    private void LoadStatusCombo() {
      cboStatus.Items.Clear();
      if (recording.Status == RecordableObjectStatus.Closed) {
        cboStatus.Items.Add(new ListItem("Cerrada", ((char) RecordableObjectStatus.Closed).ToString()));
      } else if (recording.Status == RecordableObjectStatus.Registered) {
        cboStatus.Items.Add(new ListItem("Registrada", ((char) RecordableObjectStatus.Registered).ToString()));
      } else {
        cboStatus.Items.Add(new ListItem("No vigente", ((char) RecordableObjectStatus.Obsolete).ToString()));
        cboStatus.Items.Add(new ListItem("No legible", ((char) RecordableObjectStatus.NoLegible).ToString()));
        cboStatus.Items.Add(new ListItem("Vigente", ((char) RecordableObjectStatus.Incomplete).ToString()));
      }
    }

    private void DeleteRecordingAct() {
      int recordingActId = int.Parse(GetCommandParameter("recordingActId"));

      RecordingAct recordingAct = recording.GetRecordingAct(recordingActId);

      recording.MainDocument.RemoveRecordingAct(recordingAct);
    }

    private void DeleteRecording() {
      int recordingId = int.Parse(GetCommandParameter("id"));

      if (recordingId != recording.Id) {
        return;
      }
      if (recording.RecordingActs.Count > 0) {
        return;
      }
      recording.Delete();

      this.recordingBook.Refresh();
    }

    private void ModifyRecordingActType() {
      throw new NotImplementedException("OOJJOO");

      //int recordingActId = int.Parse(GetCommandParameter("recordingActId"));
      //int recordingActTypeId = int.Parse(Request.Form["cboRecordingActType"]);

      //RecordingAct recordingAct = recording.GetRecordingAct(recordingActId);
      //RecordingActType recordingActType = RecordingActType.Parse(recordingActTypeId);
      //recordingAct.RecordingActType = recordingActType;
      //recordingAct.Save();
    }

    private void RefreshImagesStatistics() {
      throw new NotImplementedException();

      //recordingBook.ImagingFilesFolder.RenameDirectoryImages();
      //recordingBook.ImagingFilesFolder.UpdateStatistics();
      //recordingBook.ImagingFilesFolder.Save();

      //recordingBook.Refresh();
    }

    private void SaveRecording() {
      string rawRecordingNumber = this.txtRecordingNumber.Value + cboBisRecordingNumber.Value;
      var dto = new RecordingDTO(this.recordingBook, rawRecordingNumber);

      if (this.DisplayImages() && txtImageStartIndex.Value.Length != 0) {
        dto.StartImageIndex = int.Parse(txtImageStartIndex.Value);
        dto.EndImageIndex = int.Parse(txtImageEndIndex.Value);
      }
      dto.PresentationTime = EmpiriaString.ToDateTime(txtPresentationDate.Value + " " + txtPresentationTime.Value);
      dto.AuthorizationDate = EmpiriaString.ToDate(txtAuthorizationDate.Value);
      dto.AuthorizedBy = Contact.Parse(int.Parse(cboAuthorizedBy.Value));

      dto.Notes = txtObservations.Value;
      dto.MainDocument = oRecordingDocumentEditor.FillRecordingDocument(RecordingDocumentType.Parse(int.Parse(cboRecordingType.Value)));

      dto.Status = (RecordableObjectStatus) Convert.ToChar(cboStatus.Value);

      if (recording.IsNew) {
        recording = this.recordingBook.AddRecording(dto);
      } else {
        recording.Update(dto);
      }
      this.recordingBook.Refresh();
    }

    private void AppendRecordingAct() {
      int propertyId = int.Parse(cboProperty.Value);

      Resource resource = null;
      if (propertyId == 0) {
        resource = new RealEstate(RealEstateExtData.Empty);
      } else if (propertyId == -1) {
        resource = RealEstate.Parse(int.Parse(Request.Form["cboAnotherProperty"]));
      } else {
        resource = RealEstate.Parse(propertyId);
      }

      RecordingActType recordingActType = RecordingActType.Parse(int.Parse(Request.Form["cboRecordingActType"]));
      var recordingAct = recording.AppendRecordingAct(recordingActType, resource, null);
      recordingAct.SetAsMarginalNote(DateTime.Now, "Hello");
    }

    private void CleanControls() {
      cboRecordingType.Value = String.Empty;
      cboStatus.Value = String.Empty;
      txtRecordingNumber.Value = String.Empty;
      cboBisRecordingNumber.Value = String.Empty;
      txtImageStartIndex.Value = String.Empty;
      txtImageEndIndex.Value = String.Empty;

      cboRecordingActTypeCategory.Value = "0";
      txtPresentationDate.Value = String.Empty;
      txtPresentationTime.Value = String.Empty;
      txtAuthorizationDate.Value = String.Empty;
      cboAuthorizedBy.Value = String.Empty;
      txtObservations.Value = String.Empty;
    }

    private void MoveToImage(string position) {
      switch (position) {
        case "First":
          currentImagePosition = 0;
          break;
        case "Previous":
          currentImagePosition = Math.Max(currentImagePosition - 1, 0);
          break;
        case "Next":
          throw new NotImplementedException();

          //currentImagePosition = Math.Min(currentImagePosition + 1, recordingBook.ImagingFilesFolder.FilesCount - 1);
          //break;
        case "Last":
          throw new NotImplementedException();
          //currentImagePosition = recordingBook.ImagingFilesFolder.FilesCount - 1;
          //break;
        default:
          currentImagePosition = int.Parse(position) - 1;
          break;
      }
    }

    private void GoToRecording() {
      int recordingId = int.Parse(GetCommandParameter("id"));

      recording = recordingBook.GetRecording(recordingId);
    }

    private void MoveToRecording() {
      string position = GetCommandParameter("goto");
      PhysicalRecording newRecording = null;
      switch (position) {
        case "First":
          newRecording = recordingBook.GetFirstRecording();
          break;
        case "Previous":
          newRecording = recordingBook.GetPreviousRecording(this.recording);
          break;
        case "Next":
          newRecording = recordingBook.GetNextRecording(this.recording);
          break;
        case "Last":
          newRecording = recordingBook.GetLastRecording();
          break;
        default:
          if (EmpiriaString.IsInteger(position)) {
            newRecording = recordingBook.GetRecording(int.Parse(position));
          }
          break;
      }
      if (newRecording != null) {
        this.recording = newRecording;
      }
    }

    protected bool DisplayImages() {
      return recordingBook.HasImageSet;
    }

    private void Initialize() {
      recordingBook = RecordingBook.Parse(int.Parse(Request.QueryString["bookId"]));
      imageSet = RecordingBookImageSet.Parse(recordingBook.ImageSetId);

      if (String.IsNullOrEmpty(Request.QueryString["id"])) {
        recording = recordingBook.GetLastRecording();
        if (recording != null) {
          Response.Redirect("recording.book.analyzer.aspx?bookId=" + recordingBook.Id.ToString() +
                            "&id=" + recording.Id.ToString(), true);
        } else {
          Response.Redirect("recording.book.analyzer.aspx?bookId=" + recordingBook.Id.ToString() +
                            "&id=-1", true);
        }
      } else if (int.Parse(Request.QueryString["id"]) == -1 || int.Parse(Request.QueryString["id"]) == 0) {
        recording = this.recordingBook.GetNewRecording();
      } else {
        recording = PhysicalRecording.Parse(int.Parse(Request.QueryString["id"]));
      }
      if (!String.IsNullOrEmpty(Request.QueryString["image"])) {
        currentImagePosition = int.Parse(Request.QueryString["image"]);
      } else if (!IsPostBack && !recording.IsNew && DisplayImages()) {
        currentImagePosition = recording.StartImageIndex - 1;
      } else {
        currentImagePosition = -1;
      }
      if (IsPostBack && !String.IsNullOrEmpty(hdnCurrentImagePosition.Value)) {
        currentImagePosition = int.Parse(hdnCurrentImagePosition.Value);
      }
      oRecordingDocumentEditor.LoadRecordingDocument(recording.MainDocument);
    }

    private void LoadRecorderOfficersCombo() {
      LRSHtmlSelectControls.LoadRecorderOfficersCombo(this.cboAuthorizedBy, ComboControlUseMode.ObjectCreation,
                                                      recordingBook, null);
    }

    private void LoadRecordingActTypeCategoriesCombo() {
      LRSHtmlSelectControls.LoadLegacyTraslativeActTypesCategoriesCombo(this.cboRecordingActTypeCategory);
    }

    protected string GetRecordingsViewerGrid() {
      return LRSGridControls.GetRecordingsSummaryTable(this.recordingBook.Recordings, this.recordingsPerViewerPage, 0);
    }

    protected int RecordingViewerPages() {
      return Convert.ToInt32((Math.Ceiling((double) this.recordingBook.Recordings.Count / (double) this.recordingsPerViewerPage)));
    }

    private void LoadRecordingViewerPagesCombo() {
      cboRecordingViewerPage.Items.Clear();
      int pages = RecordingViewerPages();
      for (int i = 0; i < pages; i++) {
        cboRecordingViewerPage.Items.Add(new ListItem((i + 1).ToString(), i.ToString()));
      }
    }

    private void SetRecordingNumberControls() {
      string recordingNumberMainPart = String.Empty;
      string bisSuffixPart = String.Empty;

      RecordingBook.SplitRecordingNumber(recording.Number, out recordingNumberMainPart, out bisSuffixPart);

      txtRecordingNumber.Value = recordingNumberMainPart;
      cboBisRecordingNumber.Value = bisSuffixPart;
    }

    #endregion Private methods

  } // class RecordingBookAnalyzer

} // namespace Empiria.Land.WebApp
