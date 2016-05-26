/* Empiria Land **********************************************************************************************
*																																																						 *
*  Solution  : Empiria Land                                     System   : Land Intranet Application         *
*  Namespace : Empiria.Land.WebApp                              Assembly : Empiria.Land.Intranet.dll         *
*  Type      : RecordingEditor                                  Pattern  : Explorer Web Page                 *
*  Version   : 2.1                                              License  : Please read license.txt file      *
*                                                                                                            *
*  Summary   : Gets user credentials and redirects users to the workplace start page.                        *
*                                                                                                            *
********************************** Copyright(c) 2009-2016. La Vía Óntica SC, Ontica LLC and contributors.  **/
using System;
using System.Web.UI;

using Empiria.Land.Registration;
using Empiria.Land.Registration.Transactions;
using Empiria.Land.UI;
using Empiria.Presentation.Web;

namespace Empiria.Land.WebApp {

  public partial class RecordingEditor : WebPage {

    #region Fields

    protected LRSDocumentEditorControl oRecordingDocumentEditor = null;
    protected AppendRecordingActEditorControlBase oRecordingActEditor = null;
    protected LRSTransaction transaction = null;
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
      oRecordingDocumentEditor.LoadRecordingDocument(transaction.Document);
      oRecordingActEditor.Initialize(transaction.Document);
      if (!IsPostBack) {
        LoadEditor();
      } else {
        ExecuteCommand();
      }
    }

    protected FixedList<RecordingAct> RecordingActs {
      get {
        return transaction.Document.RecordingActs;
      }
    }

    private void LoadEditor() {
      cboRecordingType.Value = transaction.Document.DocumentType.Id.ToString();
      txtObservations.Value = transaction.Document.Notes;
      cboSheetsCount.Value = transaction.Document.SheetsCount.ToString();
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
        case "generateImagingControlID":
          GenerateImagingControlID();
          return;
        case "redirectMe":
          Response.Redirect("recording.editor.aspx?transactionId=" + transaction.Id.ToString(), true);
          return;
        default:
          throw new NotImplementedException(base.CommandName);
      }
    }

    private void GenerateImagingControlID() {
      transaction.Document.GenerateImagingControlID();

      SetMessageBox("Se generó el número de control para este documento.");
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
      if (transaction.IsEmptyInstance) {
        return false;
      }
      if (!ExecutionServer.CurrentPrincipal.IsInRole("LRSTransaction.Register")) {
        return false;
      }
      if (!(transaction.Workflow.CurrentStatus == LRSTransactionStatus.Recording ||
            transaction.Workflow.CurrentStatus == LRSTransactionStatus.Elaboration)) {
        return false;
      }
      if (transaction.Document.IsEmptyInstance) {
        return true;
      }
      if (transaction.Document.Status != RecordableObjectStatus.Incomplete) {
        return false;
      }
      return true;
    }

    protected bool IsReadyToAppendRecordingActs() {
      if (this.transaction.IsEmptyInstance) {
        return false;
      }
      if (this.transaction.Document.IsEmptyInstance) {
        return false;
      }
      if (!(ExecutionServer.CurrentPrincipal.IsInRole("LRSTransaction.Register") ||
            ExecutionServer.CurrentPrincipal.IsInRole("LRSTransaction.Certificates"))) {
        return false;
      }
      if (!(this.transaction.Workflow.CurrentStatus == LRSTransactionStatus.Recording ||
            this.transaction.Workflow.CurrentStatus == LRSTransactionStatus.Elaboration)) {
        return false;
      }
      if (this.transaction.Document.Status != RecordableObjectStatus.Incomplete) {
        return false;
      }
      return true;
    }

    protected bool IsReadyForPrintFinalSeal() {
      if (transaction.IsEmptyInstance || transaction.Document.IsEmptyInstance) {
        return false;
      }
      if (this.transaction.Document.RecordingActs.Count == 0) {
        return false;
      }
      if (ExecutionServer.CurrentPrincipal.IsInRole("LRSTransaction.Register") ||
          !ExecutionServer.CurrentPrincipal.IsInRole("LRSTransaction.DocumentSigner")) {
        return true;
      }
      return false;
    }

    protected bool IsReadyForGenerateImagingControlID() {
      return LRSWorkflowRules.IsReadyForGenerateImagingControlID(transaction);
    }

    private void SaveDocument() {
      RecordingDocumentType documentType = RecordingDocumentType.Parse(int.Parse(cboRecordingType.Value));
      RecordingDocument document = oRecordingDocumentEditor.FillRecordingDocument(documentType);

      Assertion.Assert(transaction != null && !transaction.IsEmptyInstance,
                       "Transaction can't be null or an empty instance.");
      Assertion.Assert(document != null && !document.IsEmptyInstance,
                       "Recording document can't be null or an empty instance.");

      document.Notes = txtObservations.Value;
      document.SheetsCount = int.Parse(cboSheetsCount.Value);

      //if (document.IsNew) {
      //  transaction.AttachDocument(document);
      //} else {
      //  document.Save();
      //}

      transaction.AttachDocument(document);

      oRecordingDocumentEditor.LoadRecordingDocument(document);
      Assertion.Assert(!transaction.Document.IsEmptyInstance && !transaction.Document.IsNew,
                       "Recording document after transaction attachment can't be null or an empty instance.");
      SetMessageBox("El documento " + transaction.Document.UID + " se guardó correctamente.");
    }

    private void Initialize() {
      int transactionId = int.Parse(Request.QueryString["transactionId"]);
      if (transactionId != 0) {
        transaction = LRSTransaction.Parse(transactionId);
      } else {
        transaction = LRSTransaction.Empty;
      }
    }

    protected string GetRecordingActsGrid() {
      return RecordingActsGrid.Parse(this.transaction.Document);
    }

    private void SetMessageBox(string msg) {
      OnLoadScript += "alert('" + msg + "');";
    }

    private void SetRefreshPageScript() {
      OnLoadScript += "sendPageCommand('redirectMe');";
    }

    #endregion Private methods

  } // class RecordingEditor

} // namespace Empiria.Land.WebApp
