﻿/* Empiria® Land 2015 ****************************************************************************************
*																																																						 *
*	 Solution  : Empiria® Land                                    System   : Land Intranet Application         *
*	 Namespace : Empiria.Web.UI                                   Assembly : Empiria.Land.Intranet.dll         *
*	 Type      : ObjectSearcher                                   Pattern  : Explorer Web Page                 *
*	 Date      : 04/Jan/2015                                      Version  : 2.0  License: LICENSE.TXT file    *
*																																																						 *
*  Summary   : Gets user credentials and redirects users to the workplace start page.                        *
*																																																						 *
**************************************************** Copyright © La Vía Óntica SC + Ontica LLC. 2009-2015. **/
using System;
using System.Web.UI;
using System.Web.UI.WebControls;

using Empiria.Land.Registration;
using Empiria.Land.Registration.Transactions;
using Empiria.Land.UI;
using Empiria.Presentation;
using Empiria.Presentation.Web;
using Empiria.Presentation.Web.Content;

namespace Empiria.Web.UI.LRS {

  public partial class RecordingEditor : WebPage {

    #region Fields

    protected LRSDocumentEditorControl oRecordingDocumentEditor = null;
    protected RecordingActEditorControlBase oRecordingActEditor = null;
    protected LRSTransaction transaction = null;
    protected string OnLoadScript = String.Empty;

    #endregion Fields

    #region Protected methods

    protected void Page_Init(object sender, EventArgs e) {
      LoadControls();
    }

    private void LoadControls() {
      oRecordingDocumentEditor = (LRSDocumentEditorControl) Page.LoadControl(LRSDocumentEditorControl.ControlVirtualPath);
      spanRecordingDocumentEditor.Controls.Add(oRecordingDocumentEditor);

      oRecordingActEditor = (RecordingActEditorControlBase) Page.LoadControl(RecordingActEditorControlBase.ControlVirtualPath);
      spanRecordingActEditor.Controls.Add(oRecordingActEditor);
    }

    protected void Page_Load(object sender, EventArgs e) {
      Initialize();
      oRecordingDocumentEditor.LoadRecordingDocument(transaction.Document);
      oRecordingActEditor.Initialize(transaction, transaction.Document);
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

    #endregion Protected methods

    #region Private methods

    private void ExecuteCommand() {
      switch (base.CommandName) {
        case "saveDocument":
          SaveDocument();
          SetRefreshPageScript();
          return;
        case "appendRecordingAct":
          oRecordingActEditor.CreateRecordingAct();
          SetRefreshPageScript();
          return;
        case "deleteRecordingAct":
          DeleteRecordingAct();
          SetRefreshPageScript();
          return;
        case "redirectMe":
          Response.Redirect("recording.editor.aspx?transactionId=" + transaction.Id.ToString(), true);
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
      if (transaction.IsEmptyInstance) {
        return false;
      }
      if (!ExecutionServer.CurrentPrincipal.IsInRole("LRSTransaction.Register")) {
        return false;
      }
      if (transaction.Status != TransactionStatus.Recording) {
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
      return oRecordingActEditor.IsReadyForEdition();
    }

    protected bool IsReadyForPrintFinalSeal() {
      if (transaction.IsEmptyInstance || transaction.Document.IsEmptyInstance) {
        return false;
      }
      if (this.transaction.Document.RecordingActs.Count == 0) {
        return false;
      }
      if (Empiria.ExecutionServer.CurrentPrincipal.IsInRole("LRSTransaction.Register") ||
          !Empiria.ExecutionServer.CurrentPrincipal.IsInRole("LRSTransaction.DocumentSigner")) {
        return true;
      }
      return false;
    }

    protected bool IsReadyForPrintRecordingCover() {
      return false;
    }

    private void SaveDocument() {
      RecordingDocumentType documentType = RecordingDocumentType.Parse(int.Parse(cboRecordingType.Value));
      RecordingDocument document = oRecordingDocumentEditor.FillRecordingDocument(documentType);

      Assertion.Assert(transaction != null && !transaction.IsEmptyInstance,
                       "Transaction cant' be null or an empty instance.");
      Assertion.Assert(document != null && !document.IsEmptyInstance,
                       "Recording document can't be null or an empty instance.");

      document.Notes = txtObservations.Value;
      document.SheetsCount = int.Parse(cboSheetsCount.Value);
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

    protected string RecordingActsGrid() {
      return LRSGridControls.GetRecordingActsGrid(this.transaction.Document);
    }

    private void SetMessageBox(string msg) {
      OnLoadScript += "alert('" + msg + "');";
    }

    private void SetRefreshPageScript() {
      OnLoadScript += "sendPageCommand('redirectMe');";
    }

    #endregion Private methods

  } // class PropertyEditor

} // namespace Empiria.Web.UI.LRS
