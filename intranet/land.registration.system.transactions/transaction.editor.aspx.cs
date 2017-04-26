/* Empiria Land **********************************************************************************************
*                                                                                                            *
*  Solution  : Empiria Land                                     System   : Land Intranet Application         *
*  Namespace : Empiria.Web.UI.LRS                               Assembly : Empiria.Land.Intranet.dll         *
*  Type      : LRSTransactionEditor                             Pattern  : Editor Page                       *
*  Version   : 3.0                                              License  : Please read license.txt file      *
*                                                                                                            *
*  Summary   : Land Registration System Transaction Editor.                                                  *
*                                                                                                            *
********************************** Copyright(c) 2009-2017. La Vía Óntica SC, Ontica LLC and contributors.  **/
using System;

using Empiria.Contacts;
using Empiria.DataTypes;
using Empiria.Presentation.Web;
using Empiria.Presentation.Web.Content;

using Empiria.Land.Certification;
using Empiria.Land.Registration;
using Empiria.Land.Registration.Transactions;
using Empiria.Land.UI;

namespace Empiria.Land.WebApp {

  public partial class LRSTransactionEditor : WebPage {

    #region Fields

    protected LRSTransaction transaction = null;
    private string onloadScript = String.Empty;

    protected bool AutoCreateCertificateEnabled = false;

    #endregion Fields

    protected void Page_Load(object sender, EventArgs e) {
      Initialize();
      if (!IsPostBack) {
        LoadEditor();
      } else {
        ExecuteCommand();
      }
    }

    private void Initialize() {
      int id = int.Parse(Request.QueryString["id"]);
      //if (!String.IsNullOrWhiteSpace(Request["isNew"])) {
      //  onloadScript = "alert('El trámite fue creado correctamente.');";
      //}
      if (id != 0) {
        transaction = LRSTransaction.Parse(id);
      } else {
        LRSTransactionType transactionType = LRSTransactionType.Parse(int.Parse(Request.QueryString["typeId"]));
        transaction = new LRSTransaction(transactionType);
      }
    }

    private void ExecuteCommand() {
      switch (base.CommandName) {
        case "redirectThis":
          RedirectEditor();
          return;
        case "saveTransaction":
          SaveTransaction();
          RedirectEditor();
          return;
        case "reentryTransaction":
          ReentryTransaction();
          return;
        case "copyTransaction":
          CopyTransaction();
          return;
        case "goToTransaction":
          GoToTransaction();
          return;
        case "saveAndReceiveTransaction":
          SaveAndReceiveTransaction();
          RedirectEditor();
          return;
        case "cancelTransaction":
          RedirectEditor();
          return;
        case "appendRecordingAct":
          AppendConcept();
          LoadEditor();
          return;
        case "deleteRecordingAct":
          DeleteRecordingAct();
          RedirectEditor();
          return;
        case "applyReceipt":
          ApplyReceipt();
          RedirectEditor();
          return;
        case "appendPayment":
          ApplyReceipt();
          RedirectEditor();
          return;
        case "printTransactionReceipt":
          PrintTransactionReceipt();
          LoadEditor();
          return;
        case "printOrderPayment":
          PrintOrderPayment();
          LoadEditor();
          return;
        case "undeleteTransaction":
          UndeleteTransaction();
          LoadEditor();
          return;

        case "autoCreateCertificate":
          AutoCreateCertificate();
          LoadEditor();
          return;

        case "sendCertificateToCITYS":
          SendCertificateToCITYS();
          return;
        default:
          throw new NotImplementedException(base.CommandName);
      }
    }

    protected string OnloadScript() {
      return onloadScript;
    }

    protected bool HasRecordingActs {
      get {
        return (transaction.Items.Count != 0);
      }
    }

    protected bool CanAppendItems() {
      if (transaction.IsNew) {
        return false;
      }
      if (!IsEditable()) {
        return false;
      }
      if (LRSWorkflowRules.IsEmptyItemsTransaction(transaction)) {
        return false;
      }
      return true;
    }

    protected bool CanReceivePayment() {
      if (transaction.Workflow.CurrentStatus != LRSTransactionStatus.Payment) {
        return false;
      }
      if (transaction.Items.Count == 0) {
        return false;
      }
      return ExecutionServer.CurrentPrincipal.IsInRole("LRSTransaction.ReceiveTransaction");
    }

    protected bool CanReceiveTransaction() {
      if (transaction.Workflow.CurrentStatus != LRSTransactionStatus.Payment) {
        return false;
      }
      return ExecutionServer.CurrentPrincipal.IsInRole("LRSTransaction.ReceiveTransaction");
    }

    protected bool IsEditable() {
      if (transaction.Workflow.CurrentStatus != LRSTransactionStatus.Payment) {
        return false;
      }
      if (transaction.Payments.Count > 0) {
        return false;
      }
      return true;
    }

    protected bool IsStorable() {
      if (transaction.Workflow.CurrentStatus == LRSTransactionStatus.Payment) {
        return IsEditable();
      }
      if (transaction.Workflow.CurrentStatus == LRSTransactionStatus.Control &&
          ExecutionServer.CurrentPrincipal.IsInRole("LRSTransaction.ControlDesk")) {
        return true;
      }
      return false;
    }

    protected string GetCertificatesSystemUrl() {
      return ConfigurationData.GetString("CertificatesSystem.Url");
    }

    protected bool IsReadyForReception() {
      if (!CanReceiveTransaction()) {
        return false;
      }
      if (transaction.Workflow.IsEmptyItemsTransaction) {
        return true;
      }
      return transaction.Payments.Count > 0;
    }

    private void GoToTransaction() {
      Response.Redirect("transaction.editor.aspx?id=" + GetCommandParameter("id", true), true);
    }

    private void LoadEditor() {
      txtTransactionKey.Value = transaction.UID;

      cboRecorderOffice.Value = transaction.RecorderOffice.Id.ToString();

      txtReceiptNumber.Value = transaction.Payments.ReceiptNumbers;

      if (!transaction.IsNew) {
        txtReceiptTotal.Value = transaction.Payments.Total.ToString("N2");
      }

      FixedList<LRSDocumentType> list = transaction.TransactionType.GetDocumentTypes();


      HtmlSelectContent.LoadCombo(this.cboDocumentType, list, "Id", "Name",
                                  "( Seleccionar )", String.Empty, "No consta");


      HtmlSelectContent.LoadCombo(this.cboManagementAgency, LRSTransaction.GetAgenciesList(),
                                  "Id", "Alias", "( Seleccionar notaría/agencia que tramita )");

      LRSHtmlSelectControls.LoadTransactionActTypesCategoriesCombo(this.cboRecordingActTypeCategory);
      cboDocumentType.Value = transaction.DocumentType.Id.ToString();
      txtDocumentNumber.Value = transaction.DocumentDescriptor;
      txtRequestedBy.Value = transaction.RequestedBy;

      cboManagementAgency.Value = transaction.Agency.Id.ToString();

      //txtOfficeNotes.Value = transaction.ExtensionData.OfficeNotes;

      cboRecordingActType.SelectedIndex = 0;
      cboLawArticle.SelectedIndex = 0;
      txtOperationValue.Value = String.Empty;
      txtRecordingRightsFee.Value = String.Empty;
      txtSheetsRevisionFee.Value = String.Empty;
      txtForeignRecordFee.Value = String.Empty;
      txtDiscount.Value = String.Empty;

      if (transaction.IsNew) {
        cmdSaveTransaction.Value = "Crear la solicitud";
      } else {
        cmdSaveTransaction.Value = "Guardar la solicitud";
        LoadRecordingActCombos();
      }
    }

    private void LoadRecordingActCombos() {
      if (!String.IsNullOrEmpty(cboRecordingActTypeCategory.Value)) {
        var recordingActTypeCategory = RecordingActTypeCategory.Parse(int.Parse(cboRecordingActTypeCategory.Value));
        FixedList<RecordingActType> list = recordingActTypeCategory.RecordingActTypes;

        HtmlSelectContent.LoadCombo(this.cboRecordingActType, list, "Id", "DisplayName",
                                    "( Seleccionar el acto jurídico )");
      } else {
        cboRecordingActType.Items.Clear();
        cboRecordingActType.Items.Add("( Seleccionar primero el tipo de acto jurídico )");
        return;
      }
    }

    private void UndeleteTransaction() {
      transaction.Workflow.Undelete();
    }

    protected bool ShowDocumentsEditor() {
      if (transaction.IsNew || transaction.IsEmptyInstance) {
        return false;
      }
      if (transaction.Workflow.CurrentStatus == LRSTransactionStatus.Payment) {
        return false;
      }
      return true;
    }

    protected bool ShowPrintPaymentOrderButton {
      get {
        if (this.transaction.Workflow.IsEmptyItemsTransaction) {
          return false;
        }
        if (transaction.Workflow.CurrentStatus == LRSTransactionStatus.Payment) {
          return true;
        }
        if (this.transaction.TransactionType.Id == 706) {
          return true;
        }
        return false;
      }
    }

    protected bool ShowTransactionVoucher {
      get {
        if (transaction.Workflow.CurrentStatus != LRSTransactionStatus.Payment) {
          return true;
        }
        if (this.transaction.TransactionType.Id == 706) {
          return true;
        }
        return false;
      }
    }

    private void PrintOrderPayment() {
      onloadScript = "createNewWindow('payment.order.aspx?id=" + transaction.Id.ToString() + "')";
    }

    private void PrintTransactionReceipt() {
      onloadScript = "createNewWindow('transaction.receipt.aspx?id=" + transaction.Id.ToString() + "')";
    }

    private decimal CalculatePayment() {
      //FixedList<RecordingAct> list = transaction.Recording.RecordingActs;
      decimal total = 0m;
      //for (int i = 0; i < list.Count; i++) {
      //  RecordingAct recordingAct = list[i];
      //  decimal maxvalue = Math.Max(recordingAct.AppraisalAmount.Amount, recordingAct.OperationAmount.Amount);
      //  decimal subTotal = CalculatePayment(maxvalue);
      //  total += subTotal;
      //}
      return total;
    }

    private void SaveTransaction() {
      bool isNew = transaction.IsNew;

      if (transaction.Workflow.CurrentStatus == LRSTransactionStatus.Payment &&
          txtReceiptTotal.Value.Length != 0 &&
          txtReceiptNumber.Value.Length != 0) {
        decimal total = decimal.Parse(txtReceiptTotal.Value);
        transaction.AddPayment(txtReceiptNumber.Value, total);
      }
      transaction.RecorderOffice = RecorderOffice.Parse(int.Parse(cboRecorderOffice.Value));
      transaction.DocumentDescriptor = txtDocumentNumber.Value;
      transaction.DocumentType = LRSDocumentType.Parse(int.Parse(cboDocumentType.Value));
      transaction.RequestedBy = txtRequestedBy.Value.Replace("\'\'", "\"").Replace("\'", "¿");
      transaction.Agency = Contact.Parse(int.Parse(cboManagementAgency.Value));
      transaction.Save();
      onloadScript = "alert('Los cambios efectuados en la información del trámite se guardaron correctamente.');";
    }

    private void ApplyVoidReceipt() {
      if (transaction.IsFeeWaiverApplicable) {
        transaction.ApplyFeeWaiver();
      }
    }

    private void ApplyReceipt() {
      Assertion.AssertObject(txtReceiptNumber.Value, "txtReceiptNumber value can't be null.");
      Assertion.Assert(decimal.Parse(txtReceiptTotal.Value) == transaction.Items.TotalFee.Total,
                       "Receipt total should be equal to the transaction total.");

      transaction.AddPayment(txtReceiptNumber.Value, decimal.Parse(txtReceiptTotal.Value));
    }

    private void SaveAndReceiveTransaction() {
      SaveTransaction();

      string s = LRSWorkflowRules.ValidateStatusChange(transaction, LRSTransactionStatus.Received);

      transaction.Workflow.Receive(String.Empty);

      onloadScript = "alert('Este trámite fue recibido satistactoriamente.');doOperation('redirectThis')";
    }

    private void ReentryTransaction() {
      try {
        transaction.Workflow.Reentry();
        onloadScript = "alert('Este trámite fue reingresado correctamente.');doOperation('redirectThis')";
      } catch (Exception e) {
        onloadScript = "alert('" + EmpiriaString.FormatForScripting(e.Message) + "');doOperation('redirectThis')";
      }
    }

    private void CopyTransaction() {
      SaveTransaction();
      LRSTransaction copy = this.transaction.MakeCopy();

      onloadScript = @"alert('Este trámite fue copiado correctamente.\n\nEl nuevo trámite es el " + copy.UID +
                     @".\n\nAl cerrar esta ventana se mostrará el nuevo trámite.');";
      onloadScript += "doOperation('goToTransaction', " + copy.Id.ToString() + ");";
    }

    protected bool CanCreateCertificate() {
      if (this.transaction.Workflow.CurrentStatus != LRSTransactionStatus.Elaboration &&
          this.transaction.Workflow.CurrentStatus != LRSTransactionStatus.Recording) {
        return false;
      }
      if (!(ExecutionServer.CurrentPrincipal.IsInRole("LRSTransaction.Register") ||
            ExecutionServer.CurrentPrincipal.IsInRole("LRSTransaction.Certificates"))) {
        return false;
      }
      return (this.transaction.Workflow.GetCurrentTask().Responsible.Id == ExecutionServer.CurrentUserId);
    }

    protected string GetCertificates() {
      const string template = "<tr class='{CLASS}'><td>{{CERTIFICATE-UID}}</td>" +
                              "<td style='white-space:normal'>{{TYPE}}</td>" +
                              "<td>{{PROPERTY-UID}}</td>" +
                              "<td style='white-space:normal;width:25%'>{{OWNER-NAME}}</td>" +
                              "<td>{{ISSUED-BY}}</td>" +
                              "<td>{{ISSUE-TIME}}</td>" +
                              "<td>{{STATUS}}</td>" +
                              "<td style='width:25%'>{{OPTIONS-COMBO}}</td>" +
                              "</tr>";

      FixedList<Certificate> certificates = this.transaction.GetIssuedCertificates();

      string html = String.Empty;
      for (int i = 0; i < certificates.Count; i++) {
        Certificate certificate = certificates[i];

        string temp = template;
        temp = temp.Replace("{CLASS}", ((i % 2) == 0) ? "detailsItem" : "detailsOddItem");
        temp = temp.Replace("{{TYPE}}", certificate.CertificateType.DisplayName);
        temp = temp.Replace("{{PROPERTY-UID}}", certificate.Property.UID);
        temp = temp.Replace("{{OWNER-NAME}}", certificate.OwnerName);

        if (certificate.IssueTime != ExecutionServer.DateMaxValue) {
          temp = temp.Replace("{{ISSUED-BY}}", certificate.IssuedBy.Nickname);
          temp = temp.Replace("{{ISSUE-TIME}}", certificate.IssueTime.ToString("dd/MMM/yyyy HH:mm"));
          temp = temp.Replace("{{STATUS}}", certificate.Status == CertificateStatus.Closed ? "Cerrado" : "Eliminado");
          temp = temp.Replace("{{OPTIONS-COMBO}}", "{{VIEW-LINK}}");

          if (transaction.Workflow.CurrentStatus == LRSTransactionStatus.Elaboration ||
              transaction.Workflow.CurrentStatus == LRSTransactionStatus.Recording) {
            temp = temp.Replace("{{VIEW-LINK}}", "<a href=\"javascript:doOperation('editCertificate', '{{CERTIFICATE-UID}}')\">Ver o imprimir</a>");
            //temp = temp.Replace("{{VIEW-LINK}}", "<a href=\"javascript:doOperation('viewCertificate', '{{CERTIFICATE_ID}}')\">Imprimir</a>");
          } else {
            temp = temp.Replace("{{VIEW-LINK}}", "<a href=\"javascript:doOperation('viewCertificate', '{{CERTIFICATE_ID}}')\">Imprimir</a>");
          }
        } else {
          temp = temp.Replace("{{ISSUED-BY}}", "&#160;");
          temp = temp.Replace("{{ISSUE-TIME}}", "No emitido");
          temp = temp.Replace("{{STATUS}}", "Pendiente");
          if (transaction.Workflow.CurrentStatus == LRSTransactionStatus.Elaboration ||
              transaction.Workflow.CurrentStatus == LRSTransactionStatus.Recording) {
            temp = temp.Replace("{{OPTIONS-COMBO}}", "{{EDIT-LINK}}&#160;&#160; |&#160;&#160; {{DELETE-LINK}} ");
            temp = temp.Replace("{{EDIT-LINK}}", "<a href=\"javascript:doOperation('editCertificate', '{{CERTIFICATE-UID}}')\">Editar</a>");
            temp = temp.Replace("{{DELETE-LINK}}", "<a href=\"javascript:doOperation('deleteCertificate', '{{CERTIFICATE-UID}}')\">Eliminar</a>");
          } else {
            temp = temp.Replace("{{OPTIONS-COMBO}}", "{{VIEW-LINK}}");
            temp = temp.Replace("{{VIEW-LINK}}", "<a href=\"javascript:doOperation('viewCertificate', '{{CERTIFICATE_ID}}')\">Imprimir</a>");
          }
        }
        temp = temp.Replace("{{CERTIFICATE_ID}}", certificate.Id.ToString());
        temp = temp.Replace("{{CERTIFICATE-UID}}", certificate.UID);
        html += temp;
      }
      return html;
    }

    protected string GetRecordingActs() {
      const string template = "<tr class='{CLASS}'><td>{COUNT}</td><td style='white-space:normal'>{ACT}</td>" +
                              "<td align='right'>{OP.VALUE}</td><td>{LAW}</td>" +
                              "<td align='right'>{REC.RIGHTS}</td>" +
                              "<td align='right'>{SHEETS}</td><td align='right'>{FOREIGN}</td>" +
                              "<td align='right'>{SUBTOTAL}</td><td align='right'>{DISCOUNT}</td><td align='right'><b>{TOTAL}</b></td>" +
                              "{DELETE.CELL} </tr >"; ///error en </ tr>
      const string deleteCell = "<td><img src='../themes/default/buttons/trash.gif' alt='' onclick='return doOperation(\"deleteRecordingAct\", {ID})' /></td>";

      const string footer = "<tr class='totalsRow'><td>&#160;</td><td colspan='2'>{MESSAGE}</td><td colspan='6' align='right'><b>Total:</b></td><td align='right'><b>{TOTAL}</b></td><td>&#160;</td></tr>";
      decimal total = 0;
      string html = String.Empty;
      FixedList<LRSTransactionItem> list = transaction.Items;

      for (int i = 0; i < list.Count; i++) {
        string temp = template.Replace("{COUNT}", (i + 1).ToString());
        temp = temp.Replace("{CLASS}", ((i % 2) == 0) ? "detailsItem" : "detailsOddItem");
        temp = temp.Replace("{ACT}", list[i].TransactionItemType.DisplayName);
        temp = temp.Replace("{LAW}", list[i].TreasuryCode.Name);
        temp = temp.Replace("{RECEIPT}", list[i].Payment.ReceiptNo);
        temp = temp.Replace("{OP.VALUE}", list[i].OperationValue.Amount != 0 ? list[i].OperationValue.ToString() : "N/A");
        temp = temp.Replace("{REC.RIGHTS}", list[i].Fee.RecordingRights.ToString("N2"));
        temp = temp.Replace("{SHEETS}", list[i].Fee.SheetsRevision != 0 ? list[i].Fee.SheetsRevision.ToString("N2") : String.Empty);
        temp = temp.Replace("{FOREIGN}", list[i].Fee.ForeignRecordingFee != 0 ? list[i].Fee.ForeignRecordingFee.ToString("N2") : String.Empty);
        temp = temp.Replace("{SUBTOTAL}", list[i].Fee.SubTotal.ToString("N2"));
        temp = temp.Replace("{DISCOUNT}", list[i].Fee.Discount.Amount.ToString("N2"));
        temp = temp.Replace("{TOTAL}", list[i].Fee.Total.ToString("C2"));

        if (this.IsEditable()) {
          temp = temp.Replace("{DELETE.CELL}", deleteCell);
        } else {
          temp = temp.Replace("{DELETE.CELL}", "&#160;");
        }
        temp = temp.Replace("{ID}", list[i].Id.ToString());

        html += temp;
        total += list[i].Fee.Total;
      }

      string message = "&#160;";
      if (this.IsEditable() && this.transaction.Items.Count > 0) {
        message = "<a href=\"javascript:doOperation('showConceptsEditor')\">Agregar más conceptos</a>";
      } else if (transaction.Workflow.IsEmptyItemsTransaction) {
        message = "Este trámite no lleva conceptos";
      } else if (!this.IsEditable()) {
        if (this.transaction.Items.Count == 0) {
          message = "No se han definido conceptos/actos";
        } else if (this.transaction.Items.Count > 0) {
          //message = "Imprimir orden de pago";
        }
      }
      return html + footer.Replace("{TOTAL}", total.ToString("C2"))
                          .Replace("{MESSAGE}", message);
    }

    protected string GetTransactionTrack() {
      const string template = "<tr class='{CLASS}' valign='top'><td>{CURRENT.STATUS}</td>" +
                              "<td style='white-space:nowrap;'>{RESPONSIBLE}</td><td align='right'>{CHECK.IN}</td><td align='right'>{END.PROCESS}</td><td align='right'>{CHECK.OUT}</td>" +
                              "<td align='right'>{ELAPSED.TIME}</td><td>{STATUS}</td><td style='white-space:normal;width:30%;'>{NOTES}</td></tr>";

      const string subTotalTemplate = "<tr class='detailsGreenItem'><td colspan='5'>&#160;</td><td  align='right'><b>{WORK.TOTAL.TIME}</b></td><td>&#160;</td><td>Duración total: <b>{TOTAL.TIME}</b></td></tr>";

      const string footer = "<tr class='detailsSuperHeader' valign='middle'><td colspan='5' style='height:28px'>&#160;&#160;{NEXT.STATUS}</td><td  align='right'><b>{WORK.TOTAL.TIME}</b></td><td>&#160;</td><td>&#160;&#160;&#160;Duración total: <b>{TOTAL.TIME}</b></td></tr>";

      LRSWorkflowTaskList taskList = this.transaction.Workflow.Tasks;

      string html = String.Empty;
      double subTotalWorkTimeSeconds = 0.0d;
      double subTotalElapsedTimeSeconds = 0.0d;
      double workTimeSeconds = 0.0d;
      double elapsedTimeSeconds = 0.0d;

      LRSWorkflowTask task = null;
      bool hasReentries = false;
      for (int i = 0; i < taskList.Count; i++) {
        string temp = String.Empty;
        task = taskList[i];
        if (task.CurrentStatus == LRSTransactionStatus.Reentry) {
          temp = subTotalTemplate.Replace("{WORK.TOTAL.TIME}", EmpiriaString.TimeSpanString(subTotalWorkTimeSeconds));
          temp = temp.Replace("{TOTAL.TIME}", EmpiriaString.TimeSpanString(subTotalElapsedTimeSeconds));
          subTotalWorkTimeSeconds = 0.0d;
          subTotalElapsedTimeSeconds = 0.0d;
          hasReentries = true;
          html += temp;
        }

        temp = template.Replace("{CURRENT.STATUS}", task.CurrentStatus == LRSTransactionStatus.Reentry ?
                                                    "<b>" + task.CurrentStatusName + "</b>" : task.CurrentStatusName);

        temp = temp.Replace("{CLASS}", ((i % 2) == 0) ? "detailsItem" : "detailsOddItem");
        temp = temp.Replace("{RESPONSIBLE}", task.Responsible.Alias);

        string dateFormat = "dd/MMM/yyyy HH:mm";
        if (task.CheckInTime.Year == DateTime.Today.Year) {
          dateFormat = "dd/MMM HH:mm";
        }
        temp = temp.Replace("{CHECK.IN}", task.CheckInTime.ToString(dateFormat));
        temp = temp.Replace("{END.PROCESS}", task.EndProcessTime != ExecutionServer.DateMaxValue ?
                                                      task.EndProcessTime.ToString(dateFormat) : "&#160;");
        temp = temp.Replace("{CHECK.OUT}", task.CheckOutTime != ExecutionServer.DateMaxValue ?
                                                      task.CheckOutTime.ToString(dateFormat) : "&#160;");

        TimeSpan elapsedTime = task.OfficeWorkElapsedTime;
        temp = temp.Replace("{ELAPSED.TIME}", elapsedTime == TimeSpan.Zero ?
                                                  "&#160;" : EmpiriaString.TimeSpanString(elapsedTime));
        temp = temp.Replace("{STATUS}", task.StatusName);

        temp = temp.Replace("{NOTES}", task.Notes);
        html += temp;

        subTotalWorkTimeSeconds += elapsedTime.TotalSeconds;
        subTotalElapsedTimeSeconds += task.ElapsedTime.TotalSeconds;
        workTimeSeconds += elapsedTime.TotalSeconds;
        elapsedTimeSeconds += task.ElapsedTime.TotalSeconds;
      }
      if (hasReentries) {
        string temp = subTotalTemplate.Replace("{WORK.TOTAL.TIME}",
                                               EmpiriaString.TimeSpanString(subTotalWorkTimeSeconds));
        temp = temp.Replace("{TOTAL.TIME}", EmpiriaString.TimeSpanString(subTotalElapsedTimeSeconds));
        html += temp;
      }
      html += footer.Replace("{WORK.TOTAL.TIME}", EmpiriaString.TimeSpanString(workTimeSeconds));
      html = html.Replace("{TOTAL.TIME}", EmpiriaString.TimeSpanString(elapsedTimeSeconds));
      html = html.Replace("{NEXT.STATUS}", (task != null && task.Status == WorkflowTaskStatus.OnDelivery) ?
                                                      "Próximo estado:&#160;<b>" + task.NextStatusName + "</b>" : String.Empty);

      return html;
    }

    private void AutoCreateCertificate() {
      string certificateType = Request.Form[cboCertificateType.ClientID];
      string propertyUID = Request.Form[txtCertificatePropertyUID.ClientID];
      string ownerName = Request.Form[txtCertificateOwnerName.ClientID];

      RealEstate property = propertyUID.Length > 0 ? RealEstate.TryParseWithUID(propertyUID) : RealEstate.Empty;

      if (property == null) {
        onloadScript = "alert('El folio real proporcionado no existe.');doOperation('redirectThis')";
        return;
      }

      if (AutoCreateCertificateEnabled) {
        var certificate = Certificate.AutoCreate(this.transaction, certificateType, property, ownerName);

        onloadScript = "alert('El certificado fue generado correctamente.');doOperation('redirectThis')";
      } else {
        onloadScript = "alert('La funcionalidad para crear certificados automáticos aún no está disponible.');doOperation('redirectThis')";
      }

      cboCertificateType.Value = String.Empty;
      txtCertificatePropertyUID.Value = String.Empty;
      txtCertificateOwnerName.Value = String.Empty;
    }

    private void AppendConcept() {
      LRSFee fee = this.ParseFee();

      int recordingActTypeId = int.Parse(Request.Form[cboRecordingActType.ClientID]);
      int treasuryCodeId = int.Parse(Request.Form[cboLawArticle.ClientID]);
      Money operationValue = Money.Parse(decimal.Parse(txtOperationValue.Value));

      this.transaction.AddItem(RecordingActType.Parse(recordingActTypeId),
                               LRSLawArticle.Parse(treasuryCodeId), operationValue,
                               Quantity.Parse(DataTypes.Unit.Empty, 1m), fee);
    }

    private void AppendConcept(int conceptTypeId, int lawArticleId, decimal amount) {
      var fee = new LRSFee();
      fee.RecordingRights = amount;

      this.transaction.AddItem(RecordingActType.Parse(conceptTypeId),
                                                        LRSLawArticle.Parse(lawArticleId), Money.Empty,
                                                        Quantity.Parse(DataTypes.Unit.Empty, 1m), fee);
    }

    private LRSFee ParseFee() {
      var fee = new LRSFee();

      fee.RecordingRights = decimal.Parse(txtRecordingRightsFee.Value);
      fee.SheetsRevision = decimal.Parse(txtSheetsRevisionFee.Value);
      fee.ForeignRecordingFee = decimal.Parse(txtForeignRecordFee.Value);
      fee.Discount = Discount.Parse(DiscountType.Unknown, decimal.Parse(txtDiscount.Value));

      return fee;
    }

    private void DeleteRecordingAct() {
      LRSTransactionItem item = transaction.Items.Find( (x) => x.Id == int.Parse(GetCommandParameter("id")));

      transaction.RemoveItem(item);

      transaction.Save();
    }

    protected string GetTitle() {
      if (this.transaction.IsNew) {
        return this.transaction.UID + ": " + this.transaction.TransactionType.Name;
      } else {
        return this.transaction.TransactionType.Name + ": " + this.transaction.UID;
      }
    }


    protected string GetRightTitle() {
      string title = String.Empty;
      if (this.transaction.IsNew) {
        return "&#160;";
      }

      if (this.transaction.PresentationTime != ExecutionServer.DateMaxValue) {
        title = "Presentado el: " + this.transaction.PresentationTime.ToString("dd/MMMM/yyy HH:mm");
      }
      if (this.transaction.IsReentry) {
        title += "<br></br>Reingresado el: " + this.transaction.LastReentryTime.ToString("dd/MMMM/yyy HH:mm");
      }
      return title;
    }

    private void RedirectEditor() {
      var isNew = (int.Parse(Request.QueryString["id"]) == 0);
      if (isNew) {
        Response.Redirect("transaction.editor.aspx?id=" + transaction.Id.ToString() + "&isNew=true");
        //} else {
        //  Response.Redirect("transaction.editor.aspx?id=" + transaction.Id.ToString());
      }
    }

    private void SendCertificateToCITYS() {
      int status = 0;
      try {
        var connector = new Empiria.Land.Connectors.CitysConnector();

        var certificate = transaction.GetIssuedCertificates()[0];

        var fileInfo = CreatePDFFile(certificate);
        status = connector.SendAvisoPreventivo(certificate, System.IO.File.ReadAllBytes(fileInfo.FullName));

        onloadScript = String.Format("alert('El certificado fue enviado correctamente al sistema CITYS. Status {0}.');" +
                                     "doOperation('redirectThis')", status);

      } catch (System.ServiceModel.FaultException e) {
        onloadScript = "alert('Problema del cliente: {0}\\nProblema del servidor: {1}\\n:Motivo: {2}');doOperation('redirectThis')";
        onloadScript = String.Format(onloadScript, e.Code.IsSenderFault, e.Code.IsReceiverFault, EmpiriaString.FormatForScripting(e.Reason.ToString()));
      } catch (Exception e) {
        onloadScript = "alert('HTTP Status:{0}\\nProblema:{1}');doOperation('redirectThis')";
        onloadScript = String.Format(onloadScript, status, EmpiriaString.FormatForScripting(e.ToString()));
      }
    }

    private System.IO.FileInfo CreatePDFFile(Certificate certificate) {
      const string filePath = @"E:\empiria.files\tlaxcala.citys\";
      const string url = "http://192.168.2.22/intranet/";   // http://192.168.2.22/testing.intranet/

      System.IO.StreamWriter sw = System.IO.File.CreateText(filePath + certificate.UID + ".html");

      Server.Execute("../land.registration.system/certificate.aspx?certificateId=" + certificate.Id, sw);
      sw.Close();
      sw.Dispose();

      PDFTech.PDFDocument.License = "COFIGBER-2022-189-P0050";
      PDFTech.PDFCreationOptions options = new PDFTech.PDFCreationOptions();

      options.SetMargin(30, 30, 30, 30);
      options.DefaultCharset = PDFTech.Charset.Unicode;
      options.Viewer.ViewerPreferences = PDFTech.ViewerPreference.FitWindow;

      PDFTech.PDFDocument pdf = new PDFTech.PDFDocument(filePath + certificate.UID + ".pdf", options);

      pdf.ImportHTML(url + "emitted.certificates/" + certificate.UID + ".html", true);
      pdf.Save();

      return new System.IO.FileInfo(pdf.FileName);
    }

  } // class TransactionEditor

} // namespace Empiria.Land.WebApp
