/* Empiria Land **********************************************************************************************
*                                                                                                            *
*  Solution  : Empiria Land                                     System   : Land Intranet Application         *
*  Namespace : Empiria.Land.WebApp                              Assembly : Empiria.Land.Intranet.dll         *
*  Type      : RecordingBookAnalyzer                            Pattern  : Explorer Web Page                 *
*  Version   : 3.0                                              License  : Please read license.txt file      *
*                                                                                                            *
*  Summary   :                                                                                               *
*                                                                                                            *
********************************** Copyright(c) 2009-2017. La Vía Óntica SC, Ontica LLC and contributors.  **/
using System;
using System.Web.UI;
using System.Web.UI.WebControls;

using Empiria.Contacts;
using Empiria.Land.Documentation;
using Empiria.Land.Registration;
using Empiria.Land.UI;
using Empiria.Presentation;
using Empiria.Presentation.Web;
using Empiria.Presentation.Web.Content;

namespace Empiria.Land.WebApp {

  public partial class RecordingBookAnalyzer : WebPage {

    #region Fields

    protected LRSDocumentEditorControl oRecordingDocumentEditor = null;
    protected LRSDocumentEditorControl oAnnotationDocumentEditor = null;
    protected RecordingBook recordingBook = null;
    protected Recording recording = null;
    protected RecordingBookImageSet imageSet = null;

    protected int currentImagePosition = 0;
    protected string gRecordingActs = String.Empty;
    protected string gAnnotationActs = String.Empty;

    protected int recordingsPerViewerPage = 25;

    #endregion Fields

    #region Constructors and parsers

    protected void Page_Init(object sender, EventArgs e) {
      LoadDocumentEditorControl();
    }

    private void LoadDocumentEditorControl() {
      oRecordingDocumentEditor = (LRSDocumentEditorControl) Page.LoadControl(LRSDocumentEditorControl.ControlVirtualPath);
      spanRecordingDocumentEditor.Controls.Add(oRecordingDocumentEditor);

      oAnnotationDocumentEditor = (LRSDocumentEditorControl) Page.LoadControl(LRSDocumentEditorControl.ControlVirtualPath);
      spanAnnotationDocumentEditor.Controls.Add(oAnnotationDocumentEditor);
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
      LoadAnnotationActsCategoriesCombo();
      LoadRecorderOfficersCombo();
      if (recording.Id > 0) {
        LoadRecordingControls();
      } else {
        LoadAnotherPropertyRecorderOfficesCombo();
        cboStatus.Disabled = true;
      }
      LoadRecordingViewerPagesCombo();
    }

    private void DoCommand() {
      switch (base.CommandName) {
        case "saveRecording":
          switch ((RecordableObjectStatus) Convert.ToChar(cboStatus.Value)) {
            case RecordableObjectStatus.NoLegible:
              RegisterAsNoLegibleRecording(false);
              RefreshPage();
              return;
            case RecordableObjectStatus.Obsolete:
              RegisterAsObsoleteRecording(false);
              RefreshPage();
              return;
            case RecordableObjectStatus.Pending:
              RegisterAsPendingRecording(false);
              RefreshPage();
              return;
            case RecordableObjectStatus.Incomplete:
              RegisterAsIncompleteRecording(false);
              RefreshPage();
              return;
          }
          return;
        case "registerAsNoLegibleRecording":
          RegisterAsNoLegibleRecording(true);
          RefreshPage();
          return;
        case "appendRecordingAct":
          AppendRecordingAct();
          RefreshPage();
          return;
        case "registerAsObsoleteRecording":
          RegisterAsObsoleteRecording(true);
          RefreshPage();
          return;
        case "registerAsPendingRecording":
          RegisterAsPendingRecording(true);
          RefreshPage();
          return;
        case "registerAsIncompleteRecording":
          RegisterAsIncompleteRecording(true);
          RefreshPage();
          return;
        case "appendAnnotation":
          AppendAnnotation();
          RefreshPage();
          return;
        case "appendNoLegibleAnnotation":
          AppendNoLegibleAnnotation();
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
        case "appendPropertyToAnnotation":
          AppendPropertyToAnnotation();
          RefreshPage();
          return;
        case "appendPropertyToRecordingAct":
          AppendPropertyToRecordingAct();
          RefreshPage();
          return;
        case "modifyRecordingActType":
          ModifyRecordingActType();
          RefreshPage();
          return;
        case "deleteRecordingAct":
          DeleteRecordingAct();
          RefreshPage();
          return;
        case "deleteRecordingActProperty":
          DeleteRecordingActProperty();
          RefreshPage();
          return;
        case "deleteAnnotation":
          DeleteAnnotation();
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
      string bisSuffixTag = String.Empty;
      int number = Recording.SplitRecordingNumber(recording.Number, out bisSuffixTag);
      txtRecordingNumber.Value = number.ToString("0000");
      cboBisRecordingNumber.Value = bisSuffixTag;

      if (this.DisplayImages() && (recording.StartImageIndex > 0)) {
        txtImageStartIndex.Value = recording.StartImageIndex.ToString();
        txtImageEndIndex.Value = recording.EndImageIndex.ToString();
      } else {
        txtImageStartIndex.Value = String.Empty;
        txtImageStartIndex.Disabled = true;
        txtImageEndIndex.Value = String.Empty;
        txtImageEndIndex.Disabled = true;
      }
      cboRecordingActTypeCategory.Value = "0";
      if (recording.MainDocument.PresentationTime.Date != ExecutionServer.DateMaxValue) {
        txtPresentationDate.Value = recording.MainDocument.PresentationTime.ToString("dd/MMM/yyyy");
        txtPresentationTime.Value = recording.MainDocument.PresentationTime.ToString("HH:mm");
      }
      if (recording.MainDocument.AuthorizationTime.Date != ExecutionServer.DateMaxValue) {
        txtAuthorizationDate.Value = recording.MainDocument.AuthorizationTime.ToString("dd/MMM/yyyy");
      }
      cboAuthorizedBy.Value = recording.AuthorizedBy.Id.ToString();

      LoadStatusCombo();
      cboStatus.Value = ((char) recording.Status).ToString();
      txtObservations.Value = recording.Notes;

      cboAnnotationCategory.Value = "0";

      gRecordingActs = LRSGridControls.GetPhysicalRecordingActsGrid(this.recording);
      gAnnotationActs = String.Empty;
      LoadRecordingActsPropertiesCombo();
      LoadAnotherPropertyRecorderOfficesCombo();
      LoadAnnotationsPropertiesCombo();
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
      if (recording.RecordingActs.Count != 0) {
        cboProperty.Items.Add(new ListItem("( Seleccionar )", ""));
      }
      foreach (var recordingAct in recording.MainDocument.RecordingActs) {

        var item = new ListItem(recordingAct.Resource.UID, recordingAct.Resource.Id.ToString());
        cboProperty.Items.Add(item);
      }
      cboProperty.Items.Add(new ListItem("Crear un nuevo folio", "0"));
      cboProperty.Items.Add(new ListItem("Seleccionar un predio", "-1"));
    }

    private void LoadAnnotationsPropertiesCombo() {
      cboAnnotationProperty.Items.Clear();
      for (int i = 0; i < cboProperty.Items.Count - 1; i++) {
        cboAnnotationProperty.Items.Add(cboProperty.Items[i]);
      }
    }

    private void LoadStatusCombo() {
      cboStatus.Items.Clear();
      if (recording.Status == RecordableObjectStatus.Closed) {
        cboStatus.Items.Add(new ListItem("Cerrada", ((char) RecordableObjectStatus.Closed).ToString()));
        return;
      }
      if (recording.Status == RecordableObjectStatus.Registered) {
        cboStatus.Items.Add(new ListItem("Registrada", ((char) RecordableObjectStatus.Registered).ToString()));
        return;
      }
      if (recording.IsNew) {
        cboStatus.Items.Add(new ListItem(String.Empty, String.Empty));
      } else {
        cboStatus.Items.Add(new ListItem("No vigente", ((char) RecordableObjectStatus.Obsolete).ToString()));
        cboStatus.Items.Add(new ListItem("No legible", ((char) RecordableObjectStatus.NoLegible).ToString()));
        cboStatus.Items.Add(new ListItem("Pendiente", ((char) RecordableObjectStatus.Pending).ToString()));
        if (recording.RecordingActs.Count != 0) {
          cboStatus.Items.Add(new ListItem("Incompleta", ((char) RecordableObjectStatus.Incomplete).ToString()));
        }
      }
    }

    private void DeleteAnnotation() {
      throw new NotImplementedException();
      //int recordingActId = int.Parse(GetCommandParameter("recordingActId"));
      //int propertyId = int.Parse(GetCommandParameter("propertyId"));

      //RecordingAct recordingAct = RecordingAct.Parse(recordingActId);
      //Property property = Property.Parse(propertyId);

      //recordingAct.RemoveProperty(property);
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

    private void DeleteRecordingActProperty() {
      throw new NotImplementedException();

      //int recordingActId = int.Parse(GetCommandParameter("recordingActId"));
      //int propertyId = int.Parse(GetCommandParameter("propertyId"));

      //RecordingAct recordingAct = this.recording.GetRecordingAct(recordingActId);
      //Property property = Property.Parse(propertyId);
      //recordingAct.RemoveProperty(property);
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

    private void AppendPropertyToAnnotation() {
      throw new NotImplementedException("OOJJOO");

      //int annotationId = int.Parse(GetCommandParameter("annotationId"));
      //int propertyId = int.Parse(cboAnnotationProperty.Value);

      //var annotation = InformationAct.Parse(annotationId);
      //Property property = Property.Parse(propertyId);

      //annotation.AttachProperty(property, ResourceRole.Informative);
    }

    private void AppendPropertyToRecordingAct() {
      throw new NotImplementedException("OOJJOO");

      //int recordingActId = int.Parse(GetCommandParameter("recordingActId"));

      //RecordingAct recordingAct = recording.GetRecordingAct(recordingActId);

      //recordingAct.AttachResource(new Property());
    }

    private void RegisterAsNoLegibleRecording(bool appendMode) {
      throw new NotImplementedException("OOJJOO");

      //if (appendMode) {
      //  this.recording = Recording.Empty;
      //}
      //recording.RecordingBook = this.recordingBook;
      //recording.SetNumber(int.Parse(txtRecordingNumber.Value), cboBisRecordingNumber.Value);
      //recording.Status = RecordableObjectStatus.NoLegible;
      //SetRecordingImageIndex();
      //recording.Notes = txtObservations.Value;
      //if (txtPresentationDate.Value.Length != 0 && txtPresentationTime.Value.Length != 0) {
      //  recording.PresentationTime = EmpiriaString.ToDateTime(txtPresentationDate.Value + " " + txtPresentationTime.Value);
      //}
      //if (txtAuthorizationDate.Value.Length != 0) {
      //  recording.AuthorizationTime = EmpiriaString.ToDate(txtAuthorizationDate.Value);
      //}
      //if (cboAuthorizedBy.Value.Length != 0) {
      //  recording.AuthorizedBy = Contact.Parse(int.Parse(cboAuthorizedBy.Value));
      //}
      //RecordingDocumentType documentType = RecordingDocumentType.Parse(int.Parse(cboRecordingType.Value));
      //recording.Document = oRecordingDocumentEditor.FillRecordingDocument(documentType);
      //recording.Save();

      //this.recordingBook.Refresh();
    }

    private void SetAnnotationImageIndex(Recording annotation) {
      throw new NotImplementedException("OOJJOO");
      //if (!annotation.RecordingBook.ImagingFilesFolder.IsEmptyInstance &&
      //     txtAnnotationImageStartIndex.Value.Length != 0) {
      //  annotation.StartImageIndex = int.Parse(txtAnnotationImageStartIndex.Value);
      //  annotation.EndImageIndex = int.Parse(txtAnnotationImageEndIndex.Value);
      //}
    }

    private void RegisterAsObsoleteRecording(bool appendMode) {
      throw new NotImplementedException("OOJJOO");
      //if (appendMode) {
      //  this.recording = new Recording();
      //}
      //recording.RecordingBook = this.recordingBook;
      //recording.SetNumber(int.Parse(txtRecordingNumber.Value), cboBisRecordingNumber.Value);
      //recording.Status = RecordableObjectStatus.Obsolete;
      //SetRecordingImageIndex();
      //recording.Notes = txtObservations.Value;
      //if (txtPresentationDate.Value.Length != 0 && txtPresentationTime.Value.Length != 0) {
      //  recording.PresentationTime = EmpiriaString.ToDateTime(txtPresentationDate.Value + " " + txtPresentationTime.Value);
      //}
      //if (txtAuthorizationDate.Value.Length != 0) {
      //  recording.AuthorizedTime = EmpiriaString.ToDate(txtAuthorizationDate.Value);
      //}
      //if (cboAuthorizedBy.Value.Length != 0) {
      //  recording.AuthorizedBy = Contact.Parse(int.Parse(cboAuthorizedBy.Value));
      //}
      //recording.ReceiptTotal = decimal.Parse(txtRecordingPayment.Value);
      //recording.ReceiptNumber = EmpiriaString.TrimAll(txtRecordingPaymentReceipt.Value);
      //recording.Document = oRecordingDocumentEditor.FillRecordingDocument(RecordingDocumentType.Parse(int.Parse(cboRecordingType.Value)));
      //recording.Save();

      //this.recordingBook.Refresh();
    }

    private void RegisterAsPendingRecording(bool appendMode) {
      throw new NotImplementedException("OOJJOO");

      //if (appendMode) {
      //  this.recording = new Recording();
      //}
      //recording.RecordingBook = this.recordingBook;
      //recording.SetNumber(int.Parse(txtRecordingNumber.Value), cboBisRecordingNumber.Value);
      //recording.Status = RecordableObjectStatus.Pending;
      //SetRecordingImageIndex();
      //recording.PresentationTime = EmpiriaString.ToDateTime(txtPresentationDate.Value + " " + txtPresentationTime.Value);
      //recording.AuthorizedTime = EmpiriaString.ToDate(txtAuthorizationDate.Value);
      //recording.AuthorizedBy = Contact.Parse(int.Parse(cboAuthorizedBy.Value));
      //recording.ReceiptTotal = decimal.Parse(txtRecordingPayment.Value);
      //recording.ReceiptNumber = EmpiriaString.TrimAll(txtRecordingPaymentReceipt.Value);
      //recording.Notes = txtObservations.Value;
      //recording.Document = oRecordingDocumentEditor.FillRecordingDocument(RecordingDocumentType.Parse(int.Parse(cboRecordingType.Value)));
      //recording.Save();

      //this.recordingBook.Refresh();
    }

    private void RegisterAsIncompleteRecording(bool appendRecordingAct) {
      var dto = new RecordingDTO(this.recordingBook, txtRecordingNumber.Value);

      if (this.DisplayImages() && txtImageStartIndex.Value.Length != 0) {
        dto.StartImageIndex = int.Parse(txtImageStartIndex.Value);
        dto.EndImageIndex = int.Parse(txtImageEndIndex.Value);
      }
      dto.PresentationTime = EmpiriaString.ToDateTime(txtPresentationDate.Value + " " + txtPresentationTime.Value);
      dto.AuthorizationDate = EmpiriaString.ToDate(txtAuthorizationDate.Value);
      dto.AuthorizedBy = Contact.Parse(int.Parse(cboAuthorizedBy.Value));

      dto.Notes = txtObservations.Value;
      dto.MainDocument = oRecordingDocumentEditor.FillRecordingDocument(RecordingDocumentType.Parse(int.Parse(cboRecordingType.Value)));

      dto.Status = RecordableObjectStatus.Incomplete;

      recording = this.recordingBook.AddRecording(dto);

      if (appendRecordingAct) {
        this.AppendRecordingAct();
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
      recording.MainDocument.AppendRecordingAct(recordingActType, resource, null, this.recording);


      //recording.Document.
      //recording.CreateRecordingAct(recordingActType, property);
    }

    private void AppendAnnotation() {
      throw new NotImplementedException("OOJJOO");

      //Recording annotation = new Recording();
      //annotation.RecordingBook = RecordingBook.Parse(int.Parse(Request.Form["cboAnnotationBook"]));
      //annotation.SetNumber(int.Parse(txtAnnotationNumber.Value), cboBisAnnotationNumber.Value);
      //annotation.Status = RecordableObjectStatus.Incomplete;
      //SetAnnotationImageIndex(annotation);
      //annotation.BaseRecordingId = -2;
      //annotation.PresentationTime = EmpiriaString.ToDateTime(txtAnnotationPresentationDate.Value + " " + txtAnnotationPresentationTime.Value);
      //annotation.AuthorizedTime = EmpiriaString.ToDate(txtAnnotationAuthorizationDate.Value);
      //annotation.AuthorizedBy = Contact.Parse(int.Parse(Request.Form["cboAnnotationAuthorizedBy"]));
      //annotation.ReceiptTotal = decimal.Parse(txtAnnotationPayment.Value);
      //annotation.ReceiptNumber = EmpiriaString.TrimAll(txtAnnotationPaymentReceipt.Value);
      //annotation.Notes = txtAnnotationObservations.Value;
      //annotation.Document = oAnnotationDocumentEditor.FillRecordingDocument(RecordingDocumentType.Parse(int.Parse(cboAnnotationDocumentType.Value)));
      //annotation.Save();
      //Property property = Property.Parse(int.Parse(cboAnnotationProperty.Value));
      //RecordingActType annotationRecordingActType = RecordingActType.Parse(int.Parse(Request.Form["cboAnnotation"]));
      //annotation.CreateRecordingAct(annotationRecordingActType, property);

      //annotation.RecordingBook.Refresh();
    }

    private void AppendNoLegibleAnnotation() {
      throw new NotImplementedException("OOJJOO");

      //Recording annotation = new Recording();
      //annotation.RecordingBook = RecordingBook.Parse(int.Parse(Request.Form["cboAnnotationBook"]));
      //annotation.SetNumber(int.Parse(txtAnnotationNumber.Value), cboBisAnnotationNumber.Value);
      //annotation.Status = RecordableObjectStatus.NoLegible;
      //SetAnnotationImageIndex(annotation);
      //if (txtAnnotationPresentationTime.Value.Length != 0) {
      //  annotation.PresentationTime = EmpiriaString.ToDateTime(txtAnnotationPresentationDate.Value + " " + txtAnnotationPresentationTime.Value);
      //} else if (txtAnnotationPresentationDate.Value.Length != 0) {
      //  annotation.PresentationTime = EmpiriaString.ToDate(txtAnnotationPresentationDate.Value);
      //}
      //if (txtAnnotationAuthorizationDate.Value.Length != 0) {
      //  annotation.AuthorizedTime = EmpiriaString.ToDate(txtAnnotationAuthorizationDate.Value);
      //}
      //if (Request.Form["cboAnnotationAuthorizedBy"].Length != 0) {
      //  annotation.AuthorizedBy = Contact.Parse(int.Parse(Request.Form["cboAnnotationAuthorizedBy"]));
      //}
      //annotation.ReceiptTotal = decimal.Parse(txtAnnotationPayment.Value);
      //annotation.ReceiptNumber = EmpiriaString.TrimAll(txtAnnotationPaymentReceipt.Value);
      //annotation.Notes = txtAnnotationObservations.Value;
      //annotation.Document = oAnnotationDocumentEditor.FillRecordingDocument(RecordingDocumentType.Parse(int.Parse(cboAnnotationDocumentType.Value)));
      //annotation.Save();
      //Property property = Property.Parse(int.Parse(cboAnnotationProperty.Value));
      //RecordingActType annotationRecordingActType = RecordingActType.Parse(int.Parse(Request.Form["cboAnnotation"]));
      //annotation.CreateRecordingAct(annotationRecordingActType, property);

      //annotation.RecordingBook.Refresh();
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

      cboAnnotationCategory.Value = "0";
      txtAnnotationNumber.Value = String.Empty;
      cboBisAnnotationNumber.Value = String.Empty;
      txtAnnotationImageStartIndex.Value = String.Empty;
      txtAnnotationImageEndIndex.Value = String.Empty;
      txtAnnotationPresentationDate.Value = String.Empty;
      txtAnnotationPresentationTime.Value = String.Empty;
      txtAnnotationAuthorizationDate.Value = String.Empty;
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
      Recording newRecording = null;
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

    protected string GetCurrentImagePath() {
      var imageSet = Land.Documentation.RecordingBookImageSet.Parse(recordingBook.ImageSetId);

      if (!imageSet.IsEmptyInstance) {
        return ".." + imageSet.UrlRelativePath +
                      imageSet.ImagesNamesArray[currentImagePosition];
      } else {
        return String.Empty;
      }
    }

    private void Initialize() {
      recordingBook = RecordingBook.Parse(int.Parse(Request.QueryString["bookId"]));
      recording = recordingBook.GetFirstRecording();
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
        recording = this.recordingBook.CreateNew();
      } else {
        recording = Recording.Parse(int.Parse(Request.QueryString["Id"]));
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
      Recording annotation = this.recordingBook.CreateNew();
      oAnnotationDocumentEditor.LoadRecordingDocument(annotation.MainDocument);
    }

    private void LoadRecorderOfficersCombo() {
      LRSHtmlSelectControls.LoadRecorderOfficersCombo(this.cboAuthorizedBy, ComboControlUseMode.ObjectCreation,
                                                      recordingBook, null);
    }

    private void LoadRecordingActTypeCategoriesCombo() {
      LRSHtmlSelectControls.LoadLegacyTraslativeActTypesCategoriesCombo(this.cboRecordingActTypeCategory);
    }

    private void LoadAnnotationActsCategoriesCombo() {
      LRSHtmlSelectControls.LoadLegacyAnnotationActTypesCategoriesCombo(this.cboAnnotationCategory);
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

    #endregion Private methods

  } // class RecordingBookAnalyzer

} // namespace Empiria.Land.WebApp
