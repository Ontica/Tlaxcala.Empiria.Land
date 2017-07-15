/* Empiria Land **********************************************************************************************
*                                                                                                            *
*  Solution  : Empiria Land                                     System   : Land Intranet Application         *
*  Namespace : Empiria.Land.WebApp                              Assembly : Empiria.Land.Intranet.dll         *
*  Type      : DocumentEditor                                   Pattern  : Explorer Web Page                 *
*  Version   : 3.0                                              License  : Please read license.txt file      *
*                                                                                                            *
*  Summary   : Allows the edition of documents and their recording acts.                                     *
*                                                                                                            *
********************************** Copyright(c) 2009-2017. La Vía Óntica SC, Ontica LLC and contributors.  **/
using System;
using System.Web.UI;

using Empiria.Land.Registration;
using Empiria.Land.Registration.Transactions;
using Empiria.Land.UI;
using Empiria.Presentation.Web;

namespace Empiria.Land.WebApp {

  public partial class DocumentEditor : WebPage {

    #region Fields

    protected LRSDocumentEditorControl oRecordingDocumentEditor = null;
    protected AppendRecordingActEditorControlBase oRecordingActEditor = null;

    protected RecordingDocument document = null;
    protected string OnLoadScript = String.Empty;

    #endregion Fields

    #region Protected methods

    protected void Page_Init(object sender, EventArgs e) {
      LoadControls();
    }

    private void LoadControls() {
      oRecordingDocumentEditor = (LRSDocumentEditorControl)
                                  Page.LoadControl(LRSDocumentEditorControl.ControlVirtualPath);
      spanRecordingDocumentEditor.Controls.Add(oRecordingDocumentEditor);

      oRecordingActEditor = (AppendRecordingActEditorControlBase)
                             Page.LoadControl(AppendRecordingActEditorControlBase.ControlVirtualPath);
      spanRecordingActEditor.Controls.Add(oRecordingActEditor);
    }

    protected void Page_Load(object sender, EventArgs e) {
      Initialize();
      oRecordingDocumentEditor.LoadRecordingDocument(document);
      oRecordingActEditor.Initialize(document);
      if (!IsPostBack) {
        LoadEditor();
      } else {
        ExecuteCommand();
      }
    }

    protected FixedList<RecordingAct> RecordingActs {
      get {
        return document.RecordingActs;
      }
    }

    private void LoadEditor() {
      cboRecordingType.Value = document.DocumentType.Id.ToString();
      txtObservations.Value = document.Notes;
      cboSheetsCount.Value = document.SheetsCount.ToString();
    }

    protected string GetLegacyDataViewerUrl() {
      return ConfigurationData.GetString("LegacyDataViewer.Url");
    }

    #endregion Protected methods

    #region Private methods

    private void ExecuteCommand() {
      switch (base.CommandName) {
        case "saveDocument":
          SaveDocument();
          SetRefreshPageScript();
          return;
        case "appendRecordingAct":
          oRecordingActEditor.CreateRecordingActs();
          SetRefreshPageScript();
          return;
        case "deleteRecordingAct":
          DeleteRecordingAct();
          SetRefreshPageScript();
          return;
        case "redirectMe":
          Response.Redirect("document.editor.aspx?documentId=" + document.Id.ToString(), true);
          return;
        default:
          throw new NotImplementedException(base.CommandName);
      }
    }

    private void DeleteRecordingAct() {
      int id = GetCommandParameter<int>("id");

      var recordingAct = RecordingAct.Parse(id);

      var document = recordingAct.Document;
      document.RemoveRecordingAct(recordingAct);

      string msg = "Se eliminó el acto jurídico " + recordingAct.RecordingActType.DisplayName;
      if (!recordingAct.PhysicalRecording.IsEmptyInstance &&
          recordingAct.PhysicalRecording.Status == RecordableObjectStatus.Deleted) {
        msg += ", así como la partida correspondiente.";
      }
      SetMessageBox(msg);
    }

    protected bool IsReadyForEdition() {
      return document.IsReadyForEdition();
    }

    protected bool IsReadyToAppendRecordingActs() {
      if (document.IsEmptyInstance) {
        return false;
      }
      return this.IsReadyForEdition();
    }

    private void SaveDocument() {
      RecordingDocumentType documentType = RecordingDocumentType.Parse(int.Parse(cboRecordingType.Value));
      RecordingDocument document = oRecordingDocumentEditor.FillRecordingDocument(documentType);

      Assertion.Assert(document != null && !document.IsEmptyInstance,
                       "Recording document can't be null or an empty instance.");

      document.Notes = txtObservations.Value;
      document.SheetsCount = int.Parse(cboSheetsCount.Value);

      document.Save();

      oRecordingDocumentEditor.LoadRecordingDocument(document);
      Assertion.Assert(!document.IsEmptyInstance && !document.IsNew,
                       "Recording document after transaction attachment can't be null or an empty instance.");
      SetMessageBox("El documento " + document.UID + " se guardó correctamente.");
    }

    private void Initialize() {
      int documentId = int.Parse(Request.QueryString["documentId"]);
      int selectedRecordingActId = int.Parse(Request.QueryString["selectedRecordingActId"] ?? "-1");

      if (documentId != 0) {
        this.document = RecordingDocument.Parse(documentId);
      } else {
        this.document = RecordingDocument.Empty;
      }
    }

    protected string GetRecordingActsGrid() {
      return RecordingActsGrid.Parse(this.document);
    }

    private void SetMessageBox(string msg) {
      OnLoadScript += "showAlert('" + msg + "');";
    }

    private void SetRefreshPageScript() {
      OnLoadScript += "sendPageCommand('redirectMe');";
    }

    #endregion Private methods

  } // class DocumentEditor

} // namespace Empiria.Land.WebApp
