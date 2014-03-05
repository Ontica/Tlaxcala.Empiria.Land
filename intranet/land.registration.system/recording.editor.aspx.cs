/* Empiria® Land 2014 ****************************************************************************************
*																																																						 *
*	 Solution  : Empiria® Land                                    System   : Land Intranet Application         *
*	 Namespace : Empiria.Web.UI                                   Assembly : Empiria.Land.Intranet.dll         *
*	 Type      : ObjectSearcher                                   Pattern  : Explorer Web Page                 *
*	 Date      : 28/Mar/2014                                      Version  : 1.5  License: CC BY-NC-SA 4.0     *
*																																																						 *
*  Summary   : Gets user credentials and redirects users to the workplace start page.                        *
*																																																						 *
**************************************************** Copyright © La Vía Óntica SC + Ontica LLC. 1994-2014. **/
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
    protected LRSTransaction transaction = null;
    private ObjectList<Recording> recordings = null;
    protected string OnLoadScript = String.Empty;

    #endregion Fields

    #region Protected methods

    protected void Page_Init(object sender, EventArgs e) {
      LoadDocumentEditorControl();
    }

    private void LoadDocumentEditorControl() {
      oRecordingDocumentEditor = (LRSDocumentEditorControl) Page.LoadControl(LRSDocumentEditorControl.ControlVirtualPath);
      spanRecordingDocumentEditor.Controls.Add(oRecordingDocumentEditor);
    }

    protected void Page_Load(object sender, EventArgs e) {
      Initialize();
      oRecordingDocumentEditor.LoadRecordingDocument(transaction.Document);
      if (!IsPostBack) {
        LoadEditor();
      } else {
        ExecuteCommand();
      }
    }

    private void LoadEditor() {
      cboRecordingType.Value = transaction.Document.RecordingDocumentType.Id.ToString();
      txtObservations.Value = transaction.Document.Notes;
      cboSheetsCount.Value = transaction.Document.SheetsCount.ToString();
      cboSealPosition.Value = transaction.Document.SealUpperPosition.ToString("N1");

      LoadRecordingActTypeCategoriesCombo();
      LoadPrecedentRecordingCombos();
    }

    private void LoadRecordingActTypeCategoriesCombo() {
      LRSHtmlSelectControls.LoadRecordingActTypesCategoriesCombo(this.cboRecordingActTypeCategory);
    }

    private void LoadPrecedentRecordingCombos() {
      LRSHtmlSelectControls.LoadDomainRecordingSections(this.cboPrecedentRecordingSection,
                                                        ComboControlUseMode.ObjectCreation);

      //ObjectList<RecordingBook> recordingBookList = recordingBook.RecorderOffice.GetTraslativeRecordingBooks();

      //if (recordingBookList.Count != 0) {
      //  HtmlSelectContent.LoadCombo(this.cboAnotherRecordingBook, recordingBookList, "Id", "FullName",
      //                              "( Seleccionar el libro registral donde se encuentra )", String.Empty, String.Empty);
      //} else {
      HtmlSelectContent.LoadCombo(this.cboPrecedentRecordingBook, "No encontré volúmenes en el Distrito o Sección seleccionados",
                                  String.Empty, String.Empty);
      //}

      cboPrecedentRecording.Items.Clear();
      cboPrecedentRecording.Items.Add(new ListItem("¿Libro?", String.Empty));

      cboPrecedentProperty.Items.Clear();
      cboPrecedentProperty.Items.Add(new ListItem("( ¿Inscripción? )", String.Empty));
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
          AppendRecordingAct();
          SetRefreshPageScript();
          return;
        case "deleteBookRecording":
          DeleteBookRecording();
          SetRefreshPageScript();
          return;
        case "redirectMe":
          Response.Redirect("recording.editor.aspx?transactionId=" + transaction.Id.ToString(), true);
          return;
        default:
          throw new NotImplementedException(base.CommandName);
      }
    }

    private void DeleteBookRecording() {
      int recordingId = int.Parse(GetCommandParameter("id", true));

      Recording recording = Recording.Parse(recordingId);
      recording.Cancel();
      SetMessageBox("Se canceló la " + recording.FullNumber);
    }

    private void AppendRecordingAct() {
      Assertion.Require(transaction != null && !transaction.IsEmptyInstance,
                        "Transaction can not be null or an empty instance.");
      Assertion.Require(transaction.Document != null && !transaction.Document.IsEmptyInstance,
                        "Document can not be an empty instance.");

      RecordingTask task = ParseRecordingTaskParameters();
      task.AssertValid();
      task.DoRecording();
      recordings = transaction.Document.GetRecordings(transaction);
    }

    private RecordingTask ParseRecordingTaskParameters() {
      RecordingTask task = new RecordingTask(
         transactionId: GetCommandParameter<int>("transactionId", -1),
         documentId: GetCommandParameter<int>("documentId", -1),
         recordingActTypeCategoryId: GetCommandParameter<int>("recordingActTypeCategoryId", -1),
         recordingActTypeId: GetCommandParameter<int>("recordingActTypeId"),
         propertyType: (PropertyRecordingType) Enum.Parse(typeof(PropertyRecordingType),
                                                          GetCommandParameter<string>("propertyType")),
         recorderOfficeId: GetCommandParameter<int>("recorderOfficeId", -1),
         precedentRecordingBookId: GetCommandParameter<int>("precedentRecordingBookId", -1),
         precedentRecordingId: GetCommandParameter<int>("precedentRecordingId", -1),
         precedentPropertyId: GetCommandParameter<int>("precedentPropertyId", -1),
         targetRecordingActId: GetCommandParameter<int>("targetRecordingActId", -1),
         quickAddRecordingNumber: GetCommandParameter<int>("quickAddRecordingNumber", -1),
         quickAddBisRecordingSuffixTag: GetCommandParameter<string>("quickAddBisRecordingSuffixTag", String.Empty)
      );
      return task;
    }


    private ObjectList<Recording> GetRecordings() {
      if (recordings == null) {
        recordings = transaction.Document.GetRecordings(transaction);
      }
      return recordings;
    }

    protected bool IsReadyForEdition() {
      if (transaction.IsEmptyInstance) {
        return false;
      }
      if (!User.CanExecute("LRSTransaction.Register")) {
        return false;
      }
      if (transaction.Status == TransactionStatus.Recording) {
        return true;
      }
      return false;
    }

    protected bool IsReadyForPrintFinalSeal() {
      if (transaction.IsEmptyInstance || transaction.Document.IsEmptyInstance) {
        return false;
      }
      if (GetRecordings().Count == 0) {
        return false;
      }
      if (User.CanExecute("LRSTransaction.Register") || !User.CanExecute("LRSTransaction.DocumentSigner")) {
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

      Assertion.Require(transaction != null && !transaction.IsEmptyInstance,
                        "Transaction cant' be null or an empty instance.");
      Assertion.Require(int.Parse(cboSheetsCount.Value) != 0 && decimal.Parse(cboSealPosition.Value) != 0,
                        "Document sheets count or seal position has invalid data.");
      Assertion.Require(document != null && !document.IsEmptyInstance,
                        "Recording document can't be null or an empty instance.");

      document.Notes = txtObservations.Value;
      document.SheetsCount = int.Parse(cboSheetsCount.Value);
      document.SealUpperPosition = decimal.Parse(cboSealPosition.Value);
      transaction.AttachDocument(document);
      oRecordingDocumentEditor.LoadRecordingDocument(document);
      Assertion.Require(!transaction.Document.IsEmptyInstance && !transaction.Document.IsNew,
                        "Recording document after transaction attachment can't be null or an empty instance.");
      SetMessageBox("El documento " + transaction.Document.DocumentKey + " se guardó correctamente.");
    }

    private void Initialize() {
      int transactionId = int.Parse(Request.QueryString["transactionId"]);
      if (transactionId != 0) {
        transaction = LRSTransaction.Parse(transactionId);
      } else {
        transaction = LRSTransaction.Empty;
      }
    }

    protected string GetDocumentRecordings() {
      const string row = "<tr class='{CLASS}' valign='top'>" +
                         "<td style='white-space:nowrap;'><img src='../themes/default/buttons/document.sm.gif' alt='' title='Imprime el sello específico para esta partida' onclick='return doOperation(\"viewRecordingSeal\", {ID})' /> Sello partida</td>" +
                         "<td style='white-space:nowrap;'>Número</td><td>{DATE}</td><td style='white-space:nowrap;'>{DISTRICT}</td><td style='white-space:nowrap;'>{SECTION}</td>" +
                         "<td><a href='javascript:doOperation(\"viewRecordingBookIndex\", {ID})'>{VOLUME}</a></td><td>{NUMBER}</td><td style='width:50%'>{REGISTER}</td>" +
                         "<td align='center'><img src='../themes/default/buttons/trash.gif' alt='' onclick='return doOperation(\"deleteBookRecording\", {ID})' /></td></tr>";

      ObjectList<Recording> recordings = GetRecordings();

      string html = String.Empty;
      for (int i = 0; i < recordings.Count; i++) {
        string temp = row.Replace("{CLASS}", ((i % 2) == 0) ? "detailsItem" : "detailsOddItem");
        temp = temp.Replace("{ID}", recordings[i].Id.ToString());
        temp = temp.Replace("{DATE}", recordings[i].AuthorizedTime.ToString("dd/MMM/yyyy HH:mm"));
        temp = temp.Replace("{DISTRICT}", recordings[i].RecordingBook.RecorderOffice.Alias);
        temp = temp.Replace("{SECTION}", recordings[i].RecordingBook.RecordingSectionType.Name);
        temp = temp.Replace("{VOLUME}", recordings[i].RecordingBook.Name);
        temp = temp.Replace("{NUMBER}", recordings[i].Number);
        temp = temp.Replace("{REGISTER}", recordings[i].CapturedBy.Alias);
        html += temp;
      }
      return html;
    }

    protected string RecordingActsGrid() {
      ObjectList<Recording> recordings = this.GetRecordings();

      return LRSGridControls.GetRecordingActsGrid(recordings);
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