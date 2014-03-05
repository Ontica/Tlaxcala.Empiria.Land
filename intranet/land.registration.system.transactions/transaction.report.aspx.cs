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
using System.Data;

using Empiria.Contacts;

using Empiria.Land.Registration.Data;
using Empiria.Land.Registration.Transactions;

namespace Empiria.Web.UI.FSM {

  public partial class TransactionReport : System.Web.UI.Page {

    #region Fields

    protected bool hasReturnItems = false;
    private DataView returnedView = null;
    //protected DocumentRecordingTransaction transaction = null;

    #endregion Fields

    #region Constructors and parsers

    protected void Page_Load(object sender, EventArgs e) {
      Initialize();
    }

    #endregion Constructors and parsers

    #region Private methods

    private void Initialize() {
      Contact me = Contact.Parse(ExecutionServer.CurrentUserId);

      string filter = "TransactionStatus = 'L'";
      string sort = "PresentationTime, TransactionKey";
      returnedView = TransactionData.GetLRSResponsibleTransactionInbox(me, TrackStatus.OnDelivery, filter, sort);

      hasReturnItems = (returnedView.Count != 0);
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

    protected string GetOKTransactions() {
      Contact me = Contact.Parse(ExecutionServer.CurrentUserId);

      string filter = "TransactionStatus = 'D'";
      string sort = "PresentationTime, TransactionKey";
      DataView view = TransactionData.GetLRSResponsibleTransactionInbox(me, TrackStatus.OnDelivery, filter, sort);
      const string template = "<tr width='24px' style='vertical-align:top'><td>{NUMBER}</td><td style='white-space:nowrap'>{TRAMITE}</td>" +
                              "<td style='white-space:nowrap'>{TIPO}</td>" +
                              "<td style='width:40%;white-space:normal'>{INTERESADO}</td>" +
                              "<td style='white-space:nowrap'>{RECIBO}</td>" +
                              "<td align='right' style='white-space:nowrap'>{IMPORTE}</td>" +
                              "<td align='right' style='white-space:nowrap'>{PRESENTACION}</td>" +
                              "<td align='right' style='white-space:nowrap'>{ELABORACIÓN}</td><td width='40%'>&nbsp;</td>";


      string html = String.Empty;
      for (int i = 0; i < view.Count; i++) {
        string temp = template.Replace("{NUMBER}", (i + 1).ToString("00"));
        temp = temp.Replace("{TRAMITE}", (string) view[i]["TransactionKey"]);
        temp = temp.Replace("{TIPO}", (string) view[i]["TransactionType"]);
        temp = temp.Replace("{INTERESADO}", (string) view[i]["RequestedBy"]);
        temp = temp.Replace("{RECIBO}", (string) view[i]["ReceiptNumber"]);
        temp = temp.Replace("{IMPORTE}", ((decimal) view[i]["ReceiptTotal"]).ToString("C2"));
        temp = temp.Replace("{PRESENTACION}", ((DateTime) view[i]["PresentationTime"]).ToString("dd/MMM/yyyy HH:mm"));
        temp = temp.Replace("{ELABORACIÓN}", ((DateTime) view[i]["ElaborationTime"]).ToString("dd/MMM/yyyy HH:mm"));
        html += temp;
      }
      return html;
    }

    protected string GetReturnTransactions() {
      const string template = "<tr width='24px' style='vertical-align:top'><td>{NUMBER}</td><td style='white-space:nowrap'>{TRAMITE}</td>" +
                              "<td style='white-space:nowrap'>{TIPO}</td>" +
                              "<td style='width:40%;white-space:normal'>{INTERESADO}</td>" +
                              "<td style='white-space:nowrap'>{RECIBO}</td>" +
                              "<td align='right' style='white-space:nowrap'>{IMPORTE}</td>" +
                              "<td align='right' style='white-space:nowrap'>{PRESENTACION}</td>" +
                              "<td align='right' style='white-space:nowrap'>{ELABORACIÓN}</td><td width='40%'>&nbsp;</td>";


      string html = String.Empty;
      for (int i = 0; i < returnedView.Count; i++) {
        string temp = template.Replace("{NUMBER}", (i + 1).ToString("00"));
        temp = temp.Replace("{TRAMITE}", (string) returnedView[i]["TransactionKey"]);
        temp = temp.Replace("{TIPO}", (string) returnedView[i]["TransactionType"]);
        temp = temp.Replace("{INTERESADO}", (string) returnedView[i]["RequestedBy"]);
        temp = temp.Replace("{RECIBO}", (string) returnedView[i]["ReceiptNumber"]);
        temp = temp.Replace("{IMPORTE}", ((decimal) returnedView[i]["ReceiptTotal"]).ToString("C2"));
        temp = temp.Replace("{PRESENTACION}", ((DateTime) returnedView[i]["PresentationTime"]).ToString("dd/MMM/yyyy HH:mm"));
        temp = temp.Replace("{ELABORACIÓN}", ((DateTime) returnedView[i]["ElaborationTime"]).ToString("dd/MMM/yyyy HH:mm"));
        html += temp;
      }
      return html;
    }

    protected string GetRecordingActs() {
      //ObjectList<RecordingAct> list = transaction.Recording.RecordingActs;
      //const string template = "<tr width='24px'><td>{NUMBER}</td><td style='white-space:nowrap'>{RECORDING.ACT}&nbsp; &nbsp; &nbsp;</td><td style='white-space:nowrap'>{PROPERTY}</td>" + 
      //                        "<td align='center' style='white-space:nowrap'>{PROPERTY.AMOUNT}</td>" +
      //                        "<td align='center' style='white-space:nowrap'>{OPERATION.AMOUNT}</td>" +
      //                        "<td align='center' style='white-space:nowrap'>{ANNOTATIONS.COUNT}<td>{OBSERVATIONS}</td>";

      string html = String.Empty;
      //for (int i = 0; i < list.Count; i++) {
      //  RecordingAct recordingAct = list[i];
      //  string temp = template.Replace("{NUMBER}", (i + 1).ToString("00"));
      //  temp = temp.Replace("{RECORDING.ACT}", recordingAct.RecordingActType.DisplayName);
      //  temp = temp.Replace("{PROPERTY}", recordingAct.PropertiesEvents[0].Property.UniqueCode);
      //  temp = temp.Replace("{PROPERTY.AMOUNT}", recordingAct.AppraisalAmount.Amount.ToString("C2"));
      //  temp = temp.Replace("{OPERATION.AMOUNT}", recordingAct.OperationAmount.Amount.ToString("C2"));        
      //  temp = temp.Replace("{ANNOTATIONS.COUNT}", "1");
      //  temp = temp.Replace("{OBSERVATIONS}", String.Empty);
      //  html += temp;
      //}
      return html;
    }

    private void LoadPaymentsControl(int transactionId) {
      //DataTable table = AccountTransactionData.GetTransactionApplications(transactionId);

      //DataView view = new DataView(table, String.Empty, "TransactionDate, Notes, OrganizationId", DataViewRowState.CurrentRows);

      //paymentsRepeater.ItemTemplate = Page.LoadTemplate("~/templates/fsm/gas.credit.receipt.payed.items.ascx");
      //paymentsRepeater.DataSource = view;
      //paymentsRepeater.DataBind();
    }

    #endregion Private methods

  } // class TransactionReceipt

} // namespace Empiria.Web.UI.FSM