/* Empiria Land **********************************************************************************************
*																																																						 *
*	 Solution  : Empiria Land                                     System   : Land Intranet Application         *
*	 Namespace : Empiria.Web.UI.LRS                               Assembly : Empiria.Land.Intranet.dll         *
*	 Type      : LRSTransactionEditor                             Pattern  : Editor Page                       *
*  Version   : 2.0                                              License  : Please read license.txt file      *
*																																																						 *
*  Summary   : Land Registration System Transaction Editor.                                                  *
*																																																						 *
********************************** Copyright(c) 2009-2015. La Vía Óntica SC, Ontica LLC and contributors.  **/
using System;

using Empiria.Contacts;
using Empiria.DataTypes;
using Empiria.Presentation.Web;
using Empiria.Presentation.Web.Content;
using Empiria.Land.Registration;
using Empiria.Land.Registration.Transactions;
using Empiria.Land.UI;

namespace Empiria.Web.UI.LRS {

  public partial class LRSTransactionEditor : WebPage {

    #region Fields

    protected LRSTransaction transaction = null;
    private string onloadScript = String.Empty;

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
      if (transaction.IsEmptyItemsTransaction) {
        return false;
      }
      return true;
    }

    protected bool ShowDocumentsEditor() {
      if (transaction.IsNew || transaction.IsEmptyInstance) {
        return false;
      }
      if (transaction.Status == TransactionStatus.Payment) {
        return false;
      }
      if (transaction.IsEmptyItemsTransaction) {
        return false;
      }
      return true;
    }

    protected bool CanReceivePayment() {
      if (transaction.Status != TransactionStatus.Payment) {
        return false;
      }
      if (transaction.Items.Count == 0) {
        return false;
      }
      return ExecutionServer.CurrentPrincipal.IsInRole("LRSTransaction.ReceiveTransaction");
    }

    protected bool CanReceiveTransaction() {
      if (transaction.Status != TransactionStatus.Payment) {
        return false;
      }
      return ExecutionServer.CurrentPrincipal.IsInRole("LRSTransaction.ReceiveTransaction");
    }

    protected bool IsEditable() {
      if (transaction.DocumentType.Id == 734) {
        return true;
      }
      if (transaction.Status != TransactionStatus.Payment) {
        return false;
      }
      if (transaction.Payments.Count > 0) {
        return false;
      }
      return true;
    }

    protected bool IsStorable() {
      if (transaction.Status == TransactionStatus.Payment) {
        return IsEditable();
      }
      if (transaction.Status == TransactionStatus.Control &&
          ExecutionServer.CurrentPrincipal.IsInRole("LRSTransaction.ControlDesk")) {
        return true;
      }
      return false;
    }

    protected bool IsReadyForReception() {
      if (!CanReceiveTransaction()) {
        return false;
      }
      if (transaction.IsEmptyItemsTransaction) {
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
        RecordingActTypeCategory recordingActTypeCategory = RecordingActTypeCategory.Parse(int.Parse(cboRecordingActTypeCategory.Value));
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
      transaction.Undelete();
    }

    protected bool ShowPrintPaymentOrderButton {
      get {
        if (this.transaction.IsEmptyItemsTransaction) {
          return false;
        }
        if (this.transaction.Status == TransactionStatus.Payment) {
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
        if (this.transaction.Status != TransactionStatus.Payment) {
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

      if (transaction.Status == TransactionStatus.Payment &&
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

      //if (!isNew) {
      //  return;
      //}

      //if (transaction.TransactionType.Id == 702) {
      //  switch (transaction.DocumentType.Id) {
      //    case 709: //Certificación de escrituras
      //      AppendConcept(2110, 887, decimal.Parse(txtReceiptTotal.Value));
      //      return;
      //    case 710: // Propiedad/No propiedad
      //      AppendConcept(2111, 859, decimal.Parse(txtReceiptTotal.Value));
      //      return;
      //    case 711: // Certificado de inscripción
      //      AppendConcept(2112, 859, decimal.Parse(txtReceiptTotal.Value));
      //      return;
      //    case 712: // Certificado de NO inscripción
      //      AppendConcept(2113, 859, decimal.Parse(txtReceiptTotal.Value));
      //      return;
      //    case 713: // Libertad de gravamen
      //      AppendConcept(2114, 859, decimal.Parse(txtReceiptTotal.Value));
      //      return;
      //    case 714: //Capitulaciones matrimoniales
      //      AppendConcept(2115, 859, decimal.Parse(txtReceiptTotal.Value));
      //      return;
      //    case 715: //Búsqueda de bienes
      //      AppendConcept(2116, 887, 150.00m);
      //      return;
      //    case 724: // Copias certificadas
      //      AppendConcept(2117, 886, decimal.Parse(txtReceiptTotal.Value));
      //      return;
      //  } // switch
      //}
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
      string s = transaction.ValidateStatusChange(TransactionStatus.Received);

      transaction.Receive(String.Empty);

      onloadScript = "alert('Este trámite fue recibido satistactoriamente.');doOperation('redirectThis')";
    }

    private void ReentryTransaction() {
      transaction.DoReentry("Trámite reingresado");

      onloadScript = "alert('Este trámite fue reingresado correctamente.');doOperation('redirectThis')";
    }

    private void CopyTransaction() {
      SaveTransaction();
      LRSTransaction copy = this.transaction.MakeCopy();

      onloadScript = @"alert('Este trámite fue copiado correctamente.\n\nEl nuevo trámite es el " + copy.UID +
                     @".\n\nAl cerrar esta ventana se mostrará el nuevo trámite.');";
      onloadScript += "doOperation('goToTransaction', " + copy.Id.ToString() + ");";
    }

    protected string GetRecordingActs() {
      const string template = "<tr class='{CLASS}'><td>{COUNT}</td><td style='white-space:normal'>{ACT}</td>" +
                              "<td align='right'>{OP.VALUE}</td><td>{LAW}</td>" +
                              "<td align='right'>{REC.RIGHTS}</td>" +
                              "<td align='right'>{SHEETS}</td><td align='right'>{FOREIGN}</td>" +
                              "<td align='right'>{SUBTOTAL}</td><td align='right'>{DISCOUNT}</td><td align='right'><b>{TOTAL}</b></td>" +
                              "<td><img src='../themes/default/buttons/trash.gif' alt='' onclick='return doOperation(\"deleteRecordingAct\", {ID})'</td></tr>";

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
        temp = temp.Replace("{ID}", list[i].Id.ToString());

        html += temp;
        total += list[i].Fee.Total;
      }

      string message = "&nbsp;";
      if (this.IsEditable() && this.transaction.Items.Count > 0) {
        message = "<a href=\"javascript:doOperation('showConceptsEditor')\">Agregar más conceptos</a>";
      } else if (transaction.IsEmptyItemsTransaction) {
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

      const string subTotalTemplate = "<tr class='detailsGreenItem'><td colspan='5'>&nbsp;</td><td  align='right'><b>{WORK.TOTAL.TIME}</b></td><td>&nbsp;</td><td>Duración total: <b>{TOTAL.TIME}</b></td></tr>";

      const string footer = "<tr class='detailsSuperHeader' valign='middle'><td colspan='5' style='height:28px'>&nbsp;&nbsp;{NEXT.STATUS}</td><td  align='right'><b>{WORK.TOTAL.TIME}</b></td><td>&nbsp;</td><td>&nbsp;&nbsp;&nbsp;Duración total: <b>{TOTAL.TIME}</b></td></tr>";

      LRSTransactionTaskList taskList = this.transaction.Tasks;

      string html = String.Empty;
      double subTotalWorkTimeSeconds = 0.0d;
      double subTotalElapsedTimeSeconds = 0.0d;
      double workTimeSeconds = 0.0d;
      double elapsedTimeSeconds = 0.0d;

      LRSTransactionTask task = null;
      bool hasReentries = false;
      for (int i = 0; i < taskList.Count; i++) {
        string temp = String.Empty;
        task = taskList[i];
        if (task.CurrentStatus == TransactionStatus.Reentry) {
          temp = subTotalTemplate.Replace("{WORK.TOTAL.TIME}", EmpiriaString.TimeSpanString(subTotalWorkTimeSeconds));
          temp = temp.Replace("{TOTAL.TIME}", EmpiriaString.TimeSpanString(subTotalElapsedTimeSeconds));
          subTotalWorkTimeSeconds = 0.0d;
          subTotalElapsedTimeSeconds = 0.0d;
          hasReentries = true;
          html += temp;
        }

        temp = template.Replace("{CURRENT.STATUS}", task.CurrentStatus == TransactionStatus.Reentry ?
                                                    "<b>" + task.CurrentStatusName + "</b>" : task.CurrentStatusName);

        temp = temp.Replace("{CLASS}", ((i % 2) == 0) ? "detailsItem" : "detailsOddItem");
        temp = temp.Replace("{RESPONSIBLE}", task.Responsible.Alias);

        string dateFormat = "dd/MMM/yyyy HH:mm";
        if (task.CheckInTime.Year == DateTime.Today.Year) {
          dateFormat = "dd/MMM HH:mm";
        }
        temp = temp.Replace("{CHECK.IN}", task.CheckInTime.ToString(dateFormat));
        temp = temp.Replace("{END.PROCESS}", task.EndProcessTime != ExecutionServer.DateMaxValue ?
                                                      task.EndProcessTime.ToString(dateFormat) : "&nbsp;");
        temp = temp.Replace("{CHECK.OUT}", task.CheckOutTime != ExecutionServer.DateMaxValue ?
                                                      task.CheckOutTime.ToString(dateFormat) : "&nbsp;");

        TimeSpan elapsedTime = task.OfficeWorkElapsedTime;
        temp = temp.Replace("{ELAPSED.TIME}", elapsedTime == TimeSpan.Zero ?
                                                  "&nbsp;" : EmpiriaString.TimeSpanString(elapsedTime));
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
      html = html.Replace("{NEXT.STATUS}", (task != null && task.Status == TrackStatus.OnDelivery) ?
                                                      "Próximo estado: &nbsp;<b>" + task.NextStatusName + "</b>" : String.Empty);

      return html;
    }

    private void AppendConcept() {
      LRSFee fee = this.ParseFee();

      int recordingActTypeId = int.Parse(Request.Form[cboRecordingActType.ClientID]);
      int treasuryCodeId = int.Parse(Request.Form[cboLawArticle.ClientID]);
      Money operationValue = Money.Parse(decimal.Parse(txtOperationValue.Value));

      LRSTransactionItem act = this.transaction.AddItem(RecordingActType.Parse(recordingActTypeId),
                                                        LRSLawArticle.Parse(treasuryCodeId), operationValue,
                                                        Quantity.Parse(DataTypes.Unit.Empty, 1m), fee);

      act.Save();
      transaction.Save();
    }

    private void AppendConcept(int conceptTypeId, int lawArticleId, decimal amount) {
      var fee = new LRSFee();
      fee.RecordingRights = amount;

      LRSTransactionItem act = this.transaction.AddItem(RecordingActType.Parse(conceptTypeId),
                                                        LRSLawArticle.Parse(lawArticleId), Money.Empty,
                                                        Quantity.Parse(DataTypes.Unit.Empty, 1m), fee);
      act.Save();
      transaction.Save();
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

    private void RedirectEditor() {
      var isNew = (int.Parse(Request.QueryString["id"]) == 0);
      if (isNew) {
        Response.Redirect("transaction.editor.aspx?id=" + transaction.Id.ToString() + "&isNew=true");
        //} else {
        //  Response.Redirect("transaction.editor.aspx?id=" + transaction.Id.ToString());
      }
    }

  } // class ObjectEditor

} // namespace Empiria.Web.UI.Editors
