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

using Empiria.Land.Registration.Transactions;

namespace Empiria.Web.UI.FSM {

  public partial class TransactionReceiptOLD : System.Web.UI.Page {

    #region Fields

    protected LRSTransaction transaction = null;

    #endregion Fields

    #region Constructors and parsers

    protected void Page_Load(object sender, EventArgs e) {
      Initialize();
    }

    #endregion Constructors and parsers

    #region Private methods

    private void Initialize() {
      transaction = LRSTransaction.Parse(int.Parse(Request.QueryString["id"]));
      //oPaymentHeaderControl.Transaction = transaction;
      //oPaymentHeaderControl.Title = "Boleta de recepción";
    }

    protected void LoadData(int transactionId) {
      //transaction = AccountTransaction.Parse(transactionId);
      //collectTotal = CollectTotal.Parse(transaction.AppliedToId);
      //accountId = transaction.AccountId;
      //account = FinancialAccount.Parse(accountId);
      //if (ExecutionServer.ServerId == 41) {
      //  account.RebuildCreditBalances();
      //}
      //CRTransaction crTransaction = transaction.GetCRTransaction();
      //instrumentType = crTransaction.BaseInstrumentType.DisplayName;

      //fromDate = transaction.TransactionDate;
      //toDate = transaction.TransactionDate;

      //accountData = FinancialAccountData.GetAccount(accountId);
      //statement = new AccountStatement(accountId, fromDate, toDate);

      //LoadPaymentsControl(transactionId);
    }

    protected string GetDigitalString() {
      string temp = "||" + transaction.Id.ToString() + "|" + transaction.Key + "|" + transaction.ReceiptTotal.ToString("N2") + "|" +
      transaction.ReceivedBy.Id.ToString() + "|" + transaction.PresentationTime.ToString("yyyyMMddTHH:mm") + "||";

      return temp;
    }

    protected string GetDigitalSign() {
      string temp = Empiria.Security.Cryptographer.CreateDigitalSign(GetDigitalString());
      return EmpiriaString.DivideLongString(temp, 90, " ");
    }

    protected string GetRecordingActs() {
      const string template = "<tr width='24px'><td>{NUMBER}</td><td style='white-space:normal'>{RECORDING.ACT}&nbsp; &nbsp; &nbsp;</td>" +
                              "<td style='white-space:nowrap'>{LAW.ARTICLE}</td>" +
                              "<td style='white-space:nowrap'>{RECEIPT}</td>" +
                              "<td align='right' style='white-space:nowrap'>{OPERATION.VALUE}</td>" +
                              "<td align='right' style='white-space:nowrap'>{RECORDING.RIGHTS}</td>" +
                              "<td align='right' style='white-space:nowrap'>{SHEETS.REVISION}</td>" +
                              "<td align='right' style='white-space:nowrap'>{OTHERS.FEE}</td>" +
                              "<td align='right' style='white-space:nowrap'>{SUBTOTAL}</td>" +
                              "<td align='right' style='white-space:nowrap'>{DISCOUNTS}</td>" +
                              "<td align='right' style='white-space:nowrap'><b>{TOTAL}</b></td></tr>";

      const string othersTemplate = "<tr width='24px'><td colspan='2'></td><td colspan='2'><i>Detalle de otros conceptos:</i></td><td colspan='8'><i>{CONCEPTS}</i></td></tr>";

      const string totalsTemplate = "<tr width='24px' class='upperSeparatorRow'><td colspan='5' align='right'><b>Total</b>:</td>" +
                "<td align='right'><b>{0}</b></td><td align='right'><b>{1}</b></td><td align='right'><b>{2}</b></td>" +
                "<td align='right'><b>{3}</b></td><td align='right'><b>{4}</b></td><td align='right' style='font-size:11pt'><b>{5}</b></td></tr>";

      string html = String.Empty;

      ObjectList<LRSTransactionAct> list = transaction.RecordingActs;
      for (int i = 0; i < list.Count; i++) {
        LRSTransactionAct recordingAct = list[i];
        string temp = template.Replace("{NUMBER}", (i + 1).ToString("00"));
        temp = temp.Replace("{RECORDING.ACT}", recordingAct.RecordingActType.DisplayName);
        temp = temp.Replace("{LAW.ARTICLE}", recordingAct.LawArticle.Name);
        temp = temp.Replace("{RECEIPT}", transaction.ReceiptNumber);
        temp = temp.Replace("{OPERATION.VALUE}", recordingAct.OperationValue.Amount.ToString("C2"));
        temp = temp.Replace("{RECORDING.RIGHTS}", recordingAct.Fee.RecordingRights.ToString("C2"));
        temp = temp.Replace("{SHEETS.REVISION}", recordingAct.Fee.SheetsRevision.ToString("C2"));
        decimal othersFee = recordingAct.Fee.Aclaration + recordingAct.Fee.Usufruct + recordingAct.Fee.Easement +
                            recordingAct.Fee.SignCertification + recordingAct.Fee.ForeignRecord;
        temp = temp.Replace("{OTHERS.FEE}", (othersFee).ToString("C2"));
        temp = temp.Replace("{SUBTOTAL}", recordingAct.Fee.SubTotal.ToString("C2"));
        temp = temp.Replace("{DISCOUNTS}", recordingAct.Fee.Discount.ToString("C2"));
        temp = temp.Replace("{TOTAL}", recordingAct.Fee.Total.ToString("C2"));
        html += temp;
        if (othersFee != decimal.Zero) {
          temp = String.Empty;
          if (recordingAct.Fee.Aclaration != decimal.Zero) {
            temp = " Aclaración: " + recordingAct.Fee.Aclaration.ToString("C2") + " &nbsp;";
          }
          if (recordingAct.Fee.Usufruct != decimal.Zero) {
            temp += " Usufructo: " + recordingAct.Fee.Usufruct.ToString("C2") + " &nbsp;";
          }
          if (recordingAct.Fee.Easement != decimal.Zero) {
            temp += " Servidumbre: " + recordingAct.Fee.Easement.ToString("C2") + " &nbsp;";
          }
          if (recordingAct.Fee.SignCertification != decimal.Zero) {
            temp += " Reconocimiento de firma: " + recordingAct.Fee.SignCertification.ToString("C2") + " &nbsp;";
          }
          if (recordingAct.Fee.ForeignRecord != decimal.Zero) {
            temp += " Trámite foráneo: " + recordingAct.Fee.ForeignRecord.ToString("C2") + " &nbsp;";
          }
          html += othersTemplate.Replace("{CONCEPTS}", temp);
        }
      }

      LRSFee totalFee = transaction.TotalFee;

      string temp1 = totalsTemplate.Replace("{0}", totalFee.RecordingRights.ToString("C2"));
      temp1 = temp1.Replace("{1}", totalFee.SheetsRevision.ToString("C2"));
      temp1 = temp1.Replace("{2}", (totalFee.Aclaration + totalFee.Usufruct + totalFee.Easement +
                                    totalFee.SignCertification + totalFee.ForeignRecord).ToString("C2"));
      temp1 = temp1.Replace("{3}", totalFee.SubTotal.ToString("C2"));
      temp1 = temp1.Replace("{4}", totalFee.Discount.ToString("C2"));
      temp1 = temp1.Replace("{5}", totalFee.Total.ToString("C2"));
      return html + temp1;
    }

    private void LoadPaymentsControl(int transactionId) {
      //DataTable table = AccountTransactionData.GetTranstotalFeeactionApplications(transactionId);

      //DataView view = new DataView(table, String.Empty, "TransactionDate, Notes, OrganizationId", DataViewRowState.CurrentRows);

      //paymentsRepeater.ItemTemplate = Page.LoadTemplate("~/templates/fsm/gas.credit.receipt.payed.items.ascx");
      //paymentsRepeater.DataSource = view;
      //paymentsRepeater.DataBind();
    }

    #endregion Private methods

  } // class TransactionReceipt

} // namespace Empiria.Web.UI.FSM