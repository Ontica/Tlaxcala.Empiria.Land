/* Empiria® Land 2014 ****************************************************************************************
*																																																						 *
*	 Solution  : Empiria® Land                                    System   : Land Intranet Application         *
*	 Namespace : Empiria.Web.UI.LRS                               Assembly : Empiria.Land.Intranet.dll         *
*	 Type      : LRSTransactionEditor                             Pattern  : Editor Page                       *
*	 Date      : 28/Mar/2014                                      Version  : 1.5  License: CC BY-NC-SA 4.0     *
*																																																						 *
*  Summary   : Land Registration System Transaction Editor.                                                  *
*																																																						 *
**************************************************** Copyright © La Vía Óntica SC + Ontica LLC. 1994-2014. **/
using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;

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
      if (!String.IsNullOrWhiteSpace(Request["isNew"])) {
        onloadScript = "alert('El trámite fue creado correctamente.');";
      }
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

    protected bool CanReceiveTransaction() {
      return (transaction.Payments.ReceiptNumbers.Length != 0 && transaction.Status == TransactionStatus.Payment);
    }

    private void GoToTransaction() {
      Response.Redirect("transaction.editor.aspx?id=" + GetCommandParameter("id", true), true);
    }

    private void LoadEditor() {
      txtTransactionKey.Value = transaction.UniqueCode;
      cboRecorderOffice.Value = transaction.RecorderOffice.Id.ToString();

      txtReceiptNumber.Value = transaction.Payments.ReceiptNumbers;

      if (!transaction.IsNew) {
        txtReceiptTotal.Value = transaction.Payments.Total.ToString("N2");
      }

      FixedList<LRSDocumentType> list = transaction.TransactionType.GetDocumentTypes();


      HtmlSelectContent.LoadCombo(this.cboDocumentType, list, "Id", "Name",
                                  "( Seleccionar )", String.Empty, "No consta");

      LRSHtmlSelectControls.LoadTransactionActTypesCategoriesCombo(this.cboRecordingActTypeCategory);
      cboDocumentType.Value = transaction.DocumentType.Id.ToString();
      txtDocumentNumber.Value = transaction.DocumentDescriptor;
      txtRequestedBy.Value = transaction.RequestedBy;
      txtContactEMail.Value = transaction.ExtensionData.RequesterEmail;
      txtContactPhone.Value = transaction.ExtensionData.RequesterPhone;
      cboManagementAgency.Value = transaction.ManagementAgency.Id.ToString();

      txtRequestNotes.Value = transaction.ExtensionData.RequesterNotes;
      txtOfficeNotes.Value = transaction.ExtensionData.OfficeNotes;

      cboRecordingActType.SelectedIndex = 0;
      cboLawArticle.SelectedIndex = 0;
      cboReceipts.SelectedIndex = 0;
      txtOperationValue.Value = String.Empty;
      txtRecordingRightsFee.Value = String.Empty;
      txtSheetsRevisionFee.Value = String.Empty;
      txtAclarationFee.Value = String.Empty;
      txtUsufructFee.Value = String.Empty;
      txtServidumbreFee.Value = String.Empty;
      txtSignCertificationFee.Value = String.Empty;
      txtForeignRecordFee.Value = String.Empty;
      txtDiscount.Value = String.Empty;

      if (transaction.IsNew) {
        cmdSaveTransaction.Value = "Crear la solicitud";
      } else {
        cmdSaveTransaction.Value = "Guardar la solicitud";
        LoadRecordingActCombos();
        LoadReceiptsCombo();
      }
    }

    private void LoadReceiptsCombo() {
      cboReceipts.Items.Clear();
      if (transaction.Payments.ReceiptNumbers.Length != 0) {
        cboReceipts.Items.Add(new ListItem(transaction.Payments.ReceiptNumbers, 
                                           transaction.Payments.ReceiptNumbers));
      }
      foreach(LRSPayment payment in this.transaction.Payments) {
        if (!cboReceipts.Items.Contains(new ListItem(payment.ReceiptNo, payment.ReceiptNo))) {
          cboReceipts.Items.Add(new ListItem(payment.ReceiptNo, payment.ReceiptNo));
        }
      }
      cboReceipts.Items.Add(new ListItem("Otro", String.Empty));
    }

    private void LoadRecordingActCombos() {
      if (!String.IsNullOrEmpty(cboRecordingActTypeCategory.Value)) {
        RecordingActTypeCategory recordingActTypeCategory = RecordingActTypeCategory.Parse(int.Parse(cboRecordingActTypeCategory.Value));
        FixedList<RecordingActType> list = recordingActTypeCategory.GetItems();

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

      transaction.RecorderOffice = RecorderOffice.Parse(int.Parse(cboRecorderOffice.Value));
      if (txtReceiptTotal.Value.Length != 0 && txtReceiptNumber.Value.Length != 0) {
        decimal total = decimal.Parse(txtReceiptTotal.Value);
        transaction.AddPayment(txtReceiptNumber.Value, total);
      }     
      transaction.DocumentDescriptor = txtDocumentNumber.Value;
      transaction.DocumentType = LRSDocumentType.Parse(int.Parse(cboDocumentType.Value));
      transaction.RequestedBy = txtRequestedBy.Value.Replace("\'\'", "\"").Replace("\'", "¿");
      transaction.ExtensionData.RequesterEmail = txtContactEMail.Value;
      transaction.ExtensionData.RequesterPhone = txtContactPhone.Value;
      transaction.ManagementAgency = Contact.Parse(int.Parse(cboManagementAgency.Value));
      transaction.Save();
      onloadScript = "alert('Los cambios efectuados en la información del trámite se guardaron correctamente.');";

      transaction.Save();

      if (!isNew) {
        return;
      }

      if (transaction.TransactionType.Id == 702) {
        switch (transaction.DocumentType.Id) {
          case 709: //Certificación de escrituras
            AppendConcept(2110, 887, decimal.Parse(txtReceiptTotal.Value));
            return;
          case 710: // Propiedad/No propiedad
            AppendConcept(2111, 859, decimal.Parse(txtReceiptTotal.Value));
            return;
          case 711: // Certificado de inscripción
            AppendConcept(2112, 859, decimal.Parse(txtReceiptTotal.Value));
            return;
          case 712: // Certificado de NO inscripción
            AppendConcept(2113, 859, decimal.Parse(txtReceiptTotal.Value));
            return;
          case 713: // Libertad de gravamen
            AppendConcept(2114, 859, decimal.Parse(txtReceiptTotal.Value));
            return;
          case 714: //Capitulaciones matrimoniales
            AppendConcept(2115, 859, decimal.Parse(txtReceiptTotal.Value));
            return;
          case 715: //Búsqueda de bienes
            AppendConcept(2116, 887, decimal.Parse(txtReceiptTotal.Value));
            return;
          case 724: // Copias certificadas
            AppendConcept(2117, 886, decimal.Parse(txtReceiptTotal.Value));
            return;
        } // switch
      }
    }

    private void ApplyVoidReceipt() {
      if (transaction.IsFeeWaiverApplicable) {
        transaction.ApplyFeeWaiver();
      }
    }

    private void ApplyReceipt() {
      decimal total = decimal.Zero;
      if (txtReceiptTotal.Value.Length != 0) {
        total = decimal.Parse(txtReceiptTotal.Value);     
      }
      transaction.AddPayment(txtReceiptNumber.Value, total);
    }

    private void SaveAndReceiveTransaction() {
      SaveTransaction();
      string s = transaction.ValidateStatusChange(TransactionStatus.Received);

      transaction.Receive(String.Empty);

      onloadScript = "alert('Este trámite fue recibido satistactoriamente.');doOperation('redirectThis')";
    }

    private void ReentryTransaction() {
      SaveTransaction();
      transaction.DoReentry("Trámite reingresado");

      onloadScript = "alert('Este trámite fue reingresado correctamente.');doOperation('redirectThis')";
    }

    private void CopyTransaction() {
      SaveTransaction();
      LRSTransaction copy = this.transaction.MakeCopy();
    
      onloadScript = @"alert('Este trámite fue copiado correctamente.\n\nEl nuevo trámite es el " + copy.UniqueCode +
                     @".\n\nAl cerrar esta ventana se mostrará el nuevo trámite.');";
      onloadScript += "doOperation('goToTransaction', " + copy.Id.ToString() + ");";
    }

    protected string GetRecordingActs() {   
      const string template = "<tr class='{CLASS}'><td>{COUNT}</td><td style='white-space:normal'>{ACT}</td><td>{LAW}</td><td align='right'>{RECEIPT}</td>" +
                              "<td align='right'>{OP.VALUE}</td><td align='right'>{REC.RIGHTS}</td>" +
                              "<td align='right'>{SHEETS}</td><td align='right'>{ACLARATION}</td>" +
                              "<td align='right'>{USUFRUCT}</td><td align='right'>{SERVIDUMBRE}</td>" +
                              "<td align='right'>{SIGN.CERT}</td><td align='right'>{FOREIGN}</td>" +
                              "<td align='right'>{SUBTOTAL}</td><td align='right'>{DISCOUNT}</td><td align='right'><b>{TOTAL}</b></td>" +
                              "<td><img src='../themes/default/buttons/trash.gif' alt='' onclick='return doOperation(\"deleteRecordingAct\", {ID})'</td></tr>";

      const string footer = "<tr class='totalsRow'><td colspan='14' align='right'><b>Total:</b></td><td align='right'><b>{TOTAL}</b></td><td>&nbsp;</td></tr>";
      decimal total = 0;
      string html = String.Empty;
      FixedList<LRSTransactionItem> list = transaction.Items;

      for (int i = 0; i < list.Count; i++) {
        string temp = template.Replace("{COUNT}", (i + 1).ToString());
        temp = temp.Replace("{CLASS}", ((i % 2) == 0) ? "detailsItem" : "detailsOddItem");
        temp = temp.Replace("{ACT}", list[i].TransactionItemType.DisplayName);
        temp = temp.Replace("{LAW}", list[i].TreasuryCode.Name);
        temp = temp.Replace("{RECEIPT}", list[i].Payment.ReceiptNo);
        temp = temp.Replace("{OP.VALUE}", list[i].OperationValue.ToString());
        temp = temp.Replace("{REC.RIGHTS}", list[i].Fee.RecordingRights.ToString("N2"));
        temp = temp.Replace("{SHEETS}", list[i].Fee.SheetsRevision != 0 ? list[i].Fee.SheetsRevision.ToString("N2") : String.Empty);
        temp = temp.Replace("{ACLARATION}", list[i].Fee.Aclaration != 0 ? list[i].Fee.Aclaration.ToString("N2") : String.Empty);
        temp = temp.Replace("{USUFRUCT}", list[i].Fee.Usufruct != 0 ? list[i].Fee.Usufruct.ToString("N2") : String.Empty);
        temp = temp.Replace("{SERVIDUMBRE}", list[i].Fee.Easement != 0 ? list[i].Fee.Easement.ToString("N2") : String.Empty);
        temp = temp.Replace("{SIGN.CERT}", list[i].Fee.SignCertification != 0 ? list[i].Fee.SignCertification.ToString("N2") : String.Empty);
        temp = temp.Replace("{FOREIGN}", list[i].Fee.ForeignRecord != 0 ? list[i].Fee.ForeignRecord.ToString("N2") : String.Empty);
        temp = temp.Replace("{SUBTOTAL}", list[i].Fee.SubTotal.ToString("N2"));
        temp = temp.Replace("{DISCOUNT}", list[i].Fee.Discount.Amount.ToString("N2"));
        temp = temp.Replace("{TOTAL}", list[i].Fee.Total.ToString("C2"));
        temp = temp.Replace("{ID}", list[i].Id.ToString());
        html += temp;
        total += list[i].Fee.Total;
      }
      return html + footer.Replace("{TOTAL}", total.ToString("C2"));
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

      //act.ReceiptNumber = cboReceipts.Value.Length != 0 ? cboReceipts.Value : txtRecordingActReceipt.Value;
      act.Save();
      transaction.Save();

      onloadScript = "doCommand('onClickTabStripCmd', getElement('tabStripItem_1'));";
      onloadScript += "alert('El acto jurídico se agregó correctamente.');";
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
      fee.Aclaration = decimal.Parse(txtAclarationFee.Value);
      fee.Usufruct = decimal.Parse(txtUsufructFee.Value);
      fee.Easement = decimal.Parse(txtServidumbreFee.Value);
      fee.SignCertification = decimal.Parse(txtSignCertificationFee.Value);
      fee.ForeignRecord = decimal.Parse(txtForeignRecordFee.Value);
      fee.Discount = Discount.Parse(DiscountType.Unknown, decimal.Parse(txtDiscount.Value));

      return fee;
    }

    private void DeleteRecordingAct() {
      LRSTransactionItem item = transaction.Items.Find( (x) => x.Id == int.Parse(GetCommandParameter("id")));

      transaction.RemoveItem(item);

      transaction.Save();

      onloadScript = "doCommand('onClickTabStripCmd', getElement('tabStripItem_1'));";
      onloadScript += "alert('Se eliminó el acto jurídico/concepto de la lista.');";
    }

    protected string GetTitle() {
      if (this.transaction.IsNew) {
        return this.transaction.UniqueCode + ": " + this.transaction.TransactionType.Name;
      } else {
        return this.transaction.TransactionType.Name + ": " + this.transaction.UniqueCode;
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
