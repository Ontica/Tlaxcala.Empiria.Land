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

    static private readonly bool DISPLAY_BANK_PAYMENT_ORDER = ConfigurationData.Get<bool>("DisplayBankPaymentOrder", true);

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

      if (id != 0) {
        transaction = LRSTransaction.Parse(id);
      } else {
        var transactionType = LRSTransactionType.Parse(int.Parse(Request.QueryString["typeId"]));
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
        case "appendPaymentAndReceive":
          ApplyReceipt();
          SaveAndReceiveTransaction();
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

        case "deleteCertificate":
          DeleteCertificate();
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
        txtReceiptTotal.Value = transaction.Items.TotalFee.Total.ToString("N2");
      }

      FixedList<LRSDocumentType> list = transaction.TransactionType.GetDocumentTypes();


      HtmlSelectContent.LoadCombo(this.cboDocumentType, list, "Id", "Name",
                                  "( Seleccionar )", String.Empty, "No consta");


      var agenciesList = LRSTransaction.GetAgenciesList();

      agenciesList.Sort((x, y) => x.Alias.CompareTo(y.Alias));

      HtmlSelectContent.LoadCombo(this.cboManagementAgency, agenciesList,
                                  "Id", "Alias", "( Seleccionar notaría/agencia que tramita )");


      LRSHtmlSelectControls.LoadTransactionActTypesCategoriesCombo(this.cboRecordingActTypeCategory);
      cboDocumentType.Value = transaction.DocumentType.Id.ToString();
      txtDocumentNumber.Value = transaction.DocumentDescriptor;

      txtRequestedBy.Value = transaction.RequestedBy;
      txtRFC.Value = transaction.ExtensionData.RFC;

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
      if (DISPLAY_BANK_PAYMENT_ORDER) {
        onloadScript = "createNewWindow('bank.payment.order.aspx?id=" + transaction.Id.ToString() + "')";
      } else {
        onloadScript = "createNewWindow('payment.order.aspx?id=" + transaction.Id.ToString() + "')";
      }
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
      transaction.ExtensionData.RFC = txtRFC.Value;

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

      ShowAlertBox("Este trámite fue recibido satistactoriamente.");
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

    private void DeleteCertificate() {
      string uid = GetCommandParameter("uid");

      Certificate certificate = transaction.GetIssuedCertificates().Find( x => x.UID == uid);

      Assertion.AssertObject(certificate, "El certificado no fue encontrado en este trámite.");

      if (certificate.CanDelete()) {
        certificate.Delete();
      } else {
        SetOKScriptMsg("El certificado no puede ser eliminado.");
      }
    }

    protected string GetCertificates() {
      const string template = "<tr class='{CLASS}'><td>{{CERTIFICATE-UID}}</td>" +
                              "<td style='white-space:normal'>{{TYPE}}</td>" +
                              "<td>{{PROPERTY-UID}}</td>" +
                              "<td style='white-space:normal;width:25%'>{{OWNER-NAME}}</td>" +
                              "<td>{{ISSUED-BY}}</td>" +
                              "<td>{{ISSUE-TIME}}</td>" +
                              "<td>{{STATUS}}</td>" +
                              "<td style='width:25%;white-space:normal;'>{{OPTIONS-COMBO}}</td>" +
                              "</tr>";

      FixedList<Certificate> certificates = this.transaction.GetIssuedCertificates();

      string html = String.Empty;
      for (int i = 0; i < certificates.Count; i++) {
        Certificate certificate = certificates[i];

        string status = "Cerrado";

        if (certificate.Status == CertificateStatus.Deleted) {
          status = "Eliminado";
        } else if (!certificate.UseESign) {
          status = "Cerrado";
        } else if (certificate.UseESign && certificate.Signed()) {
          status = "Cerrado<br /> y firmado";
        } else if (certificate.UseESign && certificate.Unsigned()) {
          status = "Cerrado<br />sin firma";
        }

        string temp = template;
        temp = temp.Replace("{CLASS}", ((i % 2) == 0) ? "detailsItem" : "detailsOddItem");
        temp = temp.Replace("{{TYPE}}", certificate.CertificateType.DisplayName);
        temp = temp.Replace("{{PROPERTY-UID}}", certificate.Property.UID);
        temp = temp.Replace("{{OWNER-NAME}}", certificate.OwnerName);

        if (certificate.IssueTime != ExecutionServer.DateMaxValue) {
          temp = temp.Replace("{{ISSUED-BY}}", certificate.IssuedBy.Nickname);
          temp = temp.Replace("{{ISSUE-TIME}}", certificate.IssueTime.ToString("dd/MMM/yyyy HH:mm"));
          temp = temp.Replace("{{STATUS}}", status);
          temp = temp.Replace("{{OPTIONS-COMBO}}", "{{VIEW-LINK}}");

          if (transaction.Workflow.CurrentStatus == LRSTransactionStatus.Elaboration ||
              transaction.Workflow.CurrentStatus == LRSTransactionStatus.Recording) {

            if (certificate.Unsigned()) {
              temp = temp.Replace("{{VIEW-LINK}}", "<a href=\"javascript:doOperation('editCertificate', '{{CERTIFICATE-UID}}')\">Editar</a> | " +
                                                   "<a href=\"javascript:doOperation('viewCertificate', '{{CERTIFICATE_ID}}')\">Imprimir</a>");

            } else {
              temp = temp.Replace("{{VIEW-LINK}}", "<a href=\"javascript:doOperation('viewCertificate', '{{CERTIFICATE_ID}}')\">Imprimir</a>" +
                                                   "<br/>Si desea editarlo, primero se debe revocar la firma.");
            }

          } else {
            temp = temp.Replace("{{VIEW-LINK}}", "<a href=\"javascript:doOperation('viewCertificate', '{{CERTIFICATE_ID}}')\">Imprimir</a>");
          }

        } else {
          temp = temp.Replace("{{ISSUED-BY}}", "&nbsp;");
          temp = temp.Replace("{{ISSUE-TIME}}", "No emitido");
          temp = temp.Replace("{{STATUS}}", "Pendiente");
          if ((transaction.Workflow.CurrentStatus == LRSTransactionStatus.Elaboration ||
              transaction.Workflow.CurrentStatus == LRSTransactionStatus.Recording) &&
              certificate.Unsigned()) {
            temp = temp.Replace("{{OPTIONS-COMBO}}", "{{EDIT-LINK}} &nbsp; | &nbsp; {{DELETE-LINK}} ");
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
                              "{DELETE.CELL}";
      const string deleteCell = "<td><img src='../themes/default/buttons/trash.gif' alt='' onclick='return doOperation(\"deleteRecordingAct\", {ID})'</td></tr>";

      const string footer = "<tr class='totalsRow'><td>&nbsp;</td><td colspan='2'>{MESSAGE}</td><td colspan='6' align='right'><b>Total:</b></td><td align='right'><b>{TOTAL}</b></td><td>&nbsp;</td></tr>";
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
          temp = temp.Replace("{DELETE.CELL}", "&nbsp;");
        }
        temp = temp.Replace("{ID}", list[i].Id.ToString());

        html += temp;
        total += list[i].Fee.Total;
      }

      string message = "&nbsp;";
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
        return "&nbsp;";
      }

      if (this.transaction.PresentationTime != ExecutionServer.DateMaxValue) {
        title = "Presentado el: " + this.transaction.PresentationTime.ToString("dd/MMMM/yyy HH:mm");
      }
      if (this.transaction.IsReentry) {
        title += "<br/>Reingresado el: " + this.transaction.LastReentryTime.ToString("dd/MMMM/yyy HH:mm");
      }
      return title;
    }

    private void RedirectEditor() {
      var isNew = (int.Parse(Request.QueryString["id"]) == 0);
      if (isNew) {
        Response.Redirect("transaction.editor.aspx?id=" + transaction.Id.ToString() + "&isNew=true");
      }
    }

    private async void SendCertificateToCITYS() {
      int status = 0;
      try {
        var connector = new Empiria.Land.Connectors.CitysConnector();

        var certificate = transaction.GetIssuedCertificates()[0];

        var fileInfo = CreatePDFFile(certificate);
        status = await connector.SendAvisoPreventivo(certificate, System.IO.File.ReadAllBytes(fileInfo.FullName));

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


    private void ShowAlertBox(string message) {
      onloadScript = "alert('" + EmpiriaString.FormatForScripting(message) + "');doOperation('redirectThis')";
    }

  } // class TransactionEditor

} // namespace Empiria.Land.WebApp
