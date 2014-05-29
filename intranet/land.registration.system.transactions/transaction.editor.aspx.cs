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
        return (transaction.RecordingActs.Count != 0);
      }
    }

    protected bool CanReceiveTransaction() {
      return (transaction.ReceiptNumber.Length != 0 && transaction.Status == TransactionStatus.Payment);
    }

    private void GoToTransaction() {
      Response.Redirect("transaction.editor.aspx?id=" + GetCommandParameter("id", true), true);
    }

    private void LoadEditor() {
      txtTransactionKey.Value = transaction.Key;
      cboRecorderOffice.Value = transaction.RecorderOffice.Id.ToString();

      txtReceiptNumber.Value = transaction.ReceiptNumber;

      if (!transaction.IsNew) {
        txtReceiptTotal.Value = transaction.ReceiptTotal.ToString("N2");
      }

      FixedList<LRSDocumentType> list = transaction.TransactionType.GetDocumentTypes();


      HtmlSelectContent.LoadCombo(this.cboDocumentType, list, "Id", "Name",
                                  "( Seleccionar )", String.Empty, "No consta");

      LRSHtmlSelectControls.LoadTransactionActTypesCategoriesCombo(this.cboRecordingActTypeCategory);
      cboDocumentType.Value = transaction.DocumentType.Id.ToString();
      txtDocumentNumber.Value = transaction.DocumentNumber;
      txtRequestedBy.Value = transaction.RequestedBy;
      txtContactEMail.Value = transaction.ContactEMail;
      txtContactPhone.Value = transaction.ContactPhone;
      cboManagementAgency.Value = transaction.ManagementAgency.Id.ToString();

      txtRequestNotes.Value = transaction.RequestNotes;
      txtOfficeNotes.Value = transaction.OfficeNotes;

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
      List<string> receipts = this.transaction.GetRecordingActsReceipts();

      cboReceipts.Items.Clear();
      if (transaction.ReceiptNumber.Length != 0) {
        cboReceipts.Items.Add(new ListItem(transaction.ReceiptNumber, transaction.ReceiptNumber));
      }
      for (int i = 0; i < receipts.Count; i++) {
        if (!cboReceipts.Items.Contains(new ListItem(receipts[i], receipts[i]))) {
          cboReceipts.Items.Add(new ListItem(receipts[i], receipts[i]));
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
      if (txtReceiptTotal.Value.Length != 0) {
        transaction.ReceiptTotal = decimal.Parse(txtReceiptTotal.Value);
      } else {
        transaction.ReceiptTotal = decimal.Zero;
      }
      if (txtReceiptNumber.Value.Length != 0) {
        transaction.ReceiptNumber = txtReceiptNumber.Value;
      } else {
        transaction.ReceiptNumber = String.Empty;
      }

      transaction.DocumentNumber = txtDocumentNumber.Value;
      transaction.DocumentType = LRSDocumentType.Parse(int.Parse(cboDocumentType.Value));
      transaction.RequestedBy = txtRequestedBy.Value.Replace("\'\'", "\"").Replace("\'", "¿");
      transaction.ContactEMail = txtContactEMail.Value;
      transaction.ContactPhone = txtContactPhone.Value;
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
      transaction.ReceiptTotal = decimal.Zero;
      transaction.ReceiptNumber = "No aplica";
      transaction.Save();

      foreach (LRSTransactionAct act in transaction.RecordingActs) {
        act.ReceiptNumber = transaction.ReceiptNumber;
        act.Save();
      }
    }

    private void ApplyReceipt() {
      if (txtReceiptTotal.Value.Length != 0) {
        transaction.ReceiptTotal = decimal.Parse(txtReceiptTotal.Value);
      } else {
        transaction.ReceiptTotal = decimal.Zero;
      }
      transaction.ReceiptNumber = txtReceiptNumber.Value;
      transaction.Save();
      foreach (LRSTransactionAct act in transaction.RecordingActs) {
        act.ReceiptNumber = transaction.ReceiptNumber;
        act.Save();
      }
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
      LRSTransaction copy = new LRSTransaction(this.transaction.TransactionType);
      copy.RecorderOffice = this.transaction.RecorderOffice;
      copy.DocumentNumber = this.transaction.DocumentNumber;
      copy.DocumentType = this.transaction.DocumentType;
      copy.RequestedBy = this.transaction.RequestedBy;
      copy.RequestNotes = this.transaction.RequestNotes;

      bool isSpecialCase = (transaction.TransactionType.Id == 704 || (transaction.TransactionType.Id == 700 && transaction.DocumentType.Id == 722));

      if (isSpecialCase) {
        copy.ReceiptTotal = decimal.Zero;
        copy.ReceiptNumber = "No aplica";
      }
      copy.Save();

      foreach (LRSTransactionAct act in transaction.RecordingActs) {
        LRSTransactionAct newAct = new LRSTransactionAct(copy);

        newAct.RecordingActType = act.RecordingActType;
        newAct.LawArticle = act.LawArticle;
        newAct.OperationValue = act.OperationValue;
        newAct.Quantity = act.Quantity;
        newAct.Unit = act.Unit;
        newAct.Notes = act.Notes;
        if (isSpecialCase) {
          newAct.ReceiptNumber = copy.ReceiptNumber;
        }
        newAct.Save();
        //newAct.ReceiptNumber = transaction.ReceiptNumber;
      }
      onloadScript = @"alert('Este trámite fue copiado correctamente.\n\nEl nuevo trámite es el " + copy.Key +
                     @".\n\nAl cerrar esta ventana se mostrará el nuevo trámite.');";
      onloadScript += "doOperation('goToTransaction', " + copy.Id.ToString() + ");";
    }

    protected string GetRecordingActs() {
      FixedList<LRSTransactionAct> list = transaction.RecordingActs;
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
      for (int i = 0; i < list.Count; i++) {
        string temp = template.Replace("{COUNT}", (i + 1).ToString());
        temp = temp.Replace("{CLASS}", ((i % 2) == 0) ? "detailsItem" : "detailsOddItem");
        temp = temp.Replace("{ACT}", list[i].RecordingActType.DisplayName);
        temp = temp.Replace("{LAW}", list[i].LawArticle.Name);
        temp = temp.Replace("{RECEIPT}", list[i].ReceiptNumber);
        temp = temp.Replace("{OP.VALUE}", list[i].OperationValue.ToString());
        temp = temp.Replace("{REC.RIGHTS}", list[i].Fee.RecordingRights.ToString("N2"));
        temp = temp.Replace("{SHEETS}", list[i].Fee.SheetsRevision != 0 ? list[i].Fee.SheetsRevision.ToString("N2") : String.Empty);
        temp = temp.Replace("{ACLARATION}", list[i].Fee.Aclaration != 0 ? list[i].Fee.Aclaration.ToString("N2") : String.Empty);
        temp = temp.Replace("{USUFRUCT}", list[i].Fee.Usufruct != 0 ? list[i].Fee.Usufruct.ToString("N2") : String.Empty);
        temp = temp.Replace("{SERVIDUMBRE}", list[i].Fee.Easement != 0 ? list[i].Fee.Easement.ToString("N2") : String.Empty);
        temp = temp.Replace("{SIGN.CERT}", list[i].Fee.SignCertification != 0 ? list[i].Fee.SignCertification.ToString("N2") : String.Empty);
        temp = temp.Replace("{FOREIGN}", list[i].Fee.ForeignRecord != 0 ? list[i].Fee.ForeignRecord.ToString("N2") : String.Empty);
        temp = temp.Replace("{SUBTOTAL}", list[i].Fee.SubTotal.ToString("N2"));
        temp = temp.Replace("{DISCOUNT}", list[i].Fee.Discount.ToString("N2"));
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

      FixedList<LRSTransactionTrack> track = this.transaction.Track;

      string html = String.Empty;
      double subTotalWorkTimeSeconds = 0.0d;
      double subTotalElapsedTimeSeconds = 0.0d;
      double workTimeSeconds = 0.0d;
      double elapsedTimeSeconds = 0.0d;

      LRSTransactionTrack o = null;
      bool hasReentries = false;
      for (int i = 0; i < track.Count; i++) {
        string temp = String.Empty;
        o = track[i];
        if (o.CurrentStatus == TransactionStatus.Reentry) {
          temp = subTotalTemplate.Replace("{WORK.TOTAL.TIME}", EmpiriaString.TimeSpanString(subTotalWorkTimeSeconds));
          temp = temp.Replace("{TOTAL.TIME}", EmpiriaString.TimeSpanString(subTotalElapsedTimeSeconds));
          subTotalWorkTimeSeconds = 0.0d;
          subTotalElapsedTimeSeconds = 0.0d;
          hasReentries = true;
          html += temp;
        }

        temp = template.Replace("{CURRENT.STATUS}", o.CurrentStatus == TransactionStatus.Reentry ? "<b>" + o.CurrentStatusName + "</b>" : o.CurrentStatusName);

        temp = temp.Replace("{CLASS}", ((i % 2) == 0) ? "detailsItem" : "detailsOddItem");
        temp = temp.Replace("{RESPONSIBLE}", o.Responsible.Alias);

        string dateFormat = "dd/MMM/yyyy HH:mm";
        if (o.CheckInTime.Year == DateTime.Today.Year) {
          dateFormat = "dd/MMM HH:mm";
        }
        temp = temp.Replace("{CHECK.IN}", o.CheckInTime.ToString(dateFormat));
        temp = temp.Replace("{END.PROCESS}", o.EndProcessTime != ExecutionServer.DateMaxValue ? o.EndProcessTime.ToString(dateFormat) : "&nbsp;");
        temp = temp.Replace("{CHECK.OUT}", o.CheckOutTime != ExecutionServer.DateMaxValue ? o.CheckOutTime.ToString(dateFormat) : "&nbsp;");

        TimeSpan elapsedTime = o.OfficeWorkElapsedTime;
        temp = temp.Replace("{ELAPSED.TIME}", elapsedTime == TimeSpan.Zero ? "&nbsp;" : EmpiriaString.TimeSpanString(elapsedTime));
        temp = temp.Replace("{STATUS}", o.StatusName);

        temp = temp.Replace("{NOTES}", o.Notes);
        html += temp;

        subTotalWorkTimeSeconds += elapsedTime.TotalSeconds;
        subTotalElapsedTimeSeconds += o.ElapsedTime.TotalSeconds;
        workTimeSeconds += elapsedTime.TotalSeconds;
        elapsedTimeSeconds += o.ElapsedTime.TotalSeconds;
      }
      if (hasReentries) {
        string temp = subTotalTemplate.Replace("{WORK.TOTAL.TIME}", EmpiriaString.TimeSpanString(subTotalWorkTimeSeconds));
        temp = temp.Replace("{TOTAL.TIME}", EmpiriaString.TimeSpanString(subTotalElapsedTimeSeconds));
        html += temp;
      }
      html += footer.Replace("{WORK.TOTAL.TIME}", EmpiriaString.TimeSpanString(workTimeSeconds));
      html = html.Replace("{TOTAL.TIME}", EmpiriaString.TimeSpanString(elapsedTimeSeconds));
      html = html.Replace("{NEXT.STATUS}", (o != null && o.Status == TrackStatus.OnDelivery) ? "Próximo estado: &nbsp;<b>" + o.NextStatusName + "</b>" : String.Empty);

      return html;
    }

    private void AppendConcept() {
      LRSTransactionAct act = new LRSTransactionAct(this.transaction);

      act.RecordingActType = RecordingActType.Parse(int.Parse(Request.Form[cboRecordingActType.ClientID]));
      act.LawArticle = LRSLawArticle.Parse(int.Parse(Request.Form[cboLawArticle.ClientID]));
      act.ReceiptNumber = cboReceipts.Value.Length != 0 ? cboReceipts.Value : txtRecordingActReceipt.Value;
      act.OperationValue = Money.Parse(decimal.Parse(txtOperationValue.Value));
      act.Fee.RecordingRights = decimal.Parse(txtRecordingRightsFee.Value);
      act.Fee.SheetsRevision = decimal.Parse(txtSheetsRevisionFee.Value);
      act.Fee.Aclaration = decimal.Parse(txtAclarationFee.Value);
      act.Fee.Usufruct = decimal.Parse(txtUsufructFee.Value);
      act.Fee.Easement = decimal.Parse(txtServidumbreFee.Value);
      act.Fee.SignCertification = decimal.Parse(txtSignCertificationFee.Value);
      act.Fee.ForeignRecord = decimal.Parse(txtForeignRecordFee.Value);
      act.Fee.Discount = decimal.Parse(txtDiscount.Value);

      act.Save();
      onloadScript = "doCommand('onClickTabStripCmd', getElement('tabStripItem_1'));";
      onloadScript += "alert('El acto jurídico se agregó correctamente.');";
    }

    private void AppendConcept(int conceptTypeId, int lawArticleId, decimal amount) {
      LRSTransactionAct act = new LRSTransactionAct(this.transaction);
      act.RecordingActType = RecordingActType.Parse(conceptTypeId);
      act.LawArticle = LRSLawArticle.Parse(lawArticleId);
      act.Quantity = 1m;
      act.Fee.RecordingRights = amount;
      act.Save();
    }

    private void DeleteRecordingAct() {
      LRSTransactionAct act = LRSTransactionAct.Parse(int.Parse(GetCommandParameter("id")));

      act.Delete();
      onloadScript = "doCommand('onClickTabStripCmd', getElement('tabStripItem_1'));";
      onloadScript += "alert('Se eliminó el acto jurídico/concepto de la lista.');";
    }

    protected string GetTitle() {
      if (this.transaction.IsNew) {
        return this.transaction.Key + ": " + this.transaction.TransactionType.Name;
      } else {
        return this.transaction.TransactionType.Name + ": " + this.transaction.Key;
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
