/* Empiria Land **********************************************************************************************
*                                                                                                            *
*  Solution  : Empiria Land                                     System   : Land Intranet Application         *
*  Namespace : Empiria.Land.WebApp                              Assembly : Empiria.Land.Intranet.dll         *
*  Type      : RecordingEditor                                  Pattern  : Explorer Web Page                 *
*  Version   : 3.0                                              License  : Please read license.txt file      *
*                                                                                                            *
*  Summary   :                                                                                               *
*                                                                                                            *
************************* Copyright(c) La Vía Óntica SC, Ontica LLC and contributors. All rights reserved. **/
using System;
using System.Web.UI;

using Empiria.Land.Documentation;
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
    protected TransactionDocumentSet documentSet = null;

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
        case "openDocument":
          OpenDocument();
          SetRefreshPageScript();
          return;
        case "closeDocument":
          CloseDocument();
          SetRefreshPageScript();
          return;
        case "deleteDocument":
          DeleteDocument();
          SetRefreshPageScript();
          return;
        case "refreshDocument":
          Response.Redirect("recording.editor.aspx?transactionId=" + transaction.Id.ToString(), true);
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

    private void CloseDocument() {
      if (this.CanCloseDocument()) {
        transaction.Document.Security.Close();
      }
    }

    private void OpenDocument() {
      if (this.transaction.Document.Security.Signed()) {
        SetMessageBox("Este documento no puede ser abierto porque ya está firmado.\n\n" +
                      "Necesita solicitar una revocación de firma en la Dirección.");
        return;
      }
      if (this.CanOpenDocument()) {
        transaction.Document.Security.Open();
      }
    }

    private void DeleteDocument() {
      if (this.CanDeleteDocument()) {
        transaction.RemoveDocument();
      }
    }

    private void GenerateImagingControlID() {
      transaction.Document.Imaging.GenerateImagingControlID();

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

    protected bool CanCloseDocument() {
      if (this.transaction.IsEmptyInstance) {
        return false;
      }
      if (this.transaction.Document.IsEmptyInstance) {
        return false;
      }
      if (this.transaction.Document.RecordingActs.Count == 0) {
        return false;
      }
      return this.transaction.Document.Security.IsReadyToClose();
    }

    protected bool CanOpenDocument() {
      if (this.transaction.IsEmptyInstance) {
        return false;
      }
      if (this.transaction.Document.IsEmptyInstance) {
        return false;
      }
      return this.transaction.Document.Security.IsReadyToOpen();
    }

    protected bool CanDeleteDocument() {
      if (this.transaction.IsEmptyInstance) {
        return false;
      }
      if (this.transaction.Document.IsEmptyInstance) {
        return false;
      }
      if (this.transaction.Document.Security.Signed()) {
        return false;
      }
      if (this.transaction.Document.RecordingActs.Count > 0) {
        return false;
      }
      return this.transaction.Document.Security.IsReadyForEdition();
    }

    protected bool IsReadyForEdition() {
      if (this.transaction.IsEmptyInstance) {
        return false;
      }
      if (this.transaction.Document.IsEmptyInstance) {
        return IsReadyForCreation();
      }
      return this.transaction.Document.Security.IsReadyForEdition();
    }

    private bool IsReadyForCreation() {
      if (!(ExecutionServer.CurrentPrincipal.IsInRole("Land.Registrar") ||
            ExecutionServer.CurrentPrincipal.IsInRole("Land.Certificator") ||
            ExecutionServer.CurrentPrincipal.IsInRole("Land.LegalAdvisor"))) {
        return false;
      }
      if (!this.transaction.Document.IsEmptyInstance) {
        return false;
      }

      Assertion.Assert(!transaction.IsEmptyInstance,
                       "Transaction can't be the empty instance.");

      if (!(transaction.Workflow.CurrentStatus == LRSTransactionStatus.Recording ||
            transaction.Workflow.CurrentStatus == LRSTransactionStatus.Elaboration ||
            transaction.Workflow.CurrentStatus == LRSTransactionStatus.Juridic)) {
        return false;
      }

      if (transaction.Workflow.GetCurrentTask().Responsible.Id == ExecutionServer.CurrentUserId) {
        return true;
      } else {
        return false;
      }
    }

    protected bool IsReadyToAppendRecordingActs() {
      if (this.transaction.IsEmptyInstance) {
        return false;
      }
      if (this.transaction.Document.IsEmptyInstance) {
        return false;
      }
      return this.IsReadyForEdition();
    }

    protected bool IsReadyForPrintFinalSeal() {
      if (transaction.IsEmptyInstance || transaction.Document.IsEmptyInstance) {
        return false;
      }
      if (this.transaction.Document.RecordingActs.Count == 0) {
        return false;
      }
      if (ExecutionServer.CurrentPrincipal.IsInRole("Land.Registrar") ||
          ExecutionServer.CurrentPrincipal.IsInRole("Land.Signer") ||
          ExecutionServer.CurrentPrincipal.IsInRole("Land.QualitySupervisor") ||
          ExecutionServer.CurrentPrincipal.IsInRole("Land.LegalAdvisor")) {
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
      documentSet = TransactionDocumentSet.ParseFor(transaction);
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
