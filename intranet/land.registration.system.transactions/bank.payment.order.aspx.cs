/* Empiria Land **********************************************************************************************
*                                                                                                            *
*  Solution  : Empiria Land                                     System   : Land Intranet Application         *
*  Namespace : Empiria.Land.WebApp                              Assembly : Empiria.Land.Intranet.dll         *
*  Type      : ObjectSearcher                                   Pattern  : Explorer Web Page                 *
*  Version   : 3.0                                              License  : Please read license.txt file      *
*                                                                                                            *
*  Summary   :                                                                                               *
*                                                                                                            *
************************* Copyright(c) La Vía Óntica SC, Ontica LLC and contributors. All rights reserved. **/
using System;

using Empiria.OnePoint.EPayments;

using Empiria.Land.Registration.Transactions;


namespace Empiria.Land.WebApp {

  public partial class BankPaymentOrder : System.Web.UI.Page {

    #region Fields

    private static readonly bool DISPLAY_VEDA_ELECTORAL_UI =
                                        ConfigurationData.Get<bool>("DisplayVedaElectoralUI", false);

    protected LRSTransaction transaction = null;
    protected FormerPaymentOrderDTO paymentOrderData = null;

    #endregion Fields

    #region Constructors and parsers

    protected void Page_Load(object sender, EventArgs e) {
      Initialize();
    }

    #endregion Constructors and parsers

    #region Private methods

    private async void Initialize() {
      if (Request.QueryString["uid"] != null) {
        transaction = LRSTransaction.TryParse(Request.QueryString["uid"]);

        Assertion.Require(transaction, "transaction");

      } else if (Request.QueryString["id"] != null) {
        transaction = LRSTransaction.Parse(int.Parse(Request.QueryString["id"]));
      }

      this.paymentOrderData = await EPaymentsUseCases.RequestPaymentOrderData(this.transaction);
    }


    protected string DistrictName {
      get {
        return String.Empty;
      }
    }


    protected string CustomerOfficeName() {
      return "Dirección de Notarías y Registros Públicos";
    }


    protected string GetPaymentOrderFooter() {
      return @"* Este documento deberá <b>ENTREGARSE en la <u>Caja de la Secretaría de Finanzas</u></b>," +
              "o en una sucursal Banamex al momento de efectuar el pago.";
    }

    protected string GetHeader() {
      return GetQuantitiesHeader();
    }

    private string GetQuantitiesHeader() {
      const string aj = "<td style='white-space:nowrap'>#</td>" +
                          "<td style='white-space:nowrap'>Clave</td>" +
                          "<td style='white-space:nowrap;width:30%'>Acto jurídico / Concepto</td>" +
                          "<td style='white-space:nowrap'>Fundamento</td>" +
                          "<td style='white-space:nowrap' align='right'>Valor operac</td>" +
                          "<td align='right'>Derechos reg</td>" +
                          "<td align='right'>Cotejo</td>" +
                          "<td align='right'>Otros</td>" +
                          "<td align='right'>Subtotal</td>" +
                          "<td align='right'>Descuento</td>" +
                          "<td align='right'>Total</td>";
      const string cert = "<td style='white-space:nowrap'>#</td>" +
                          "<td style='white-space:nowrap'>Clave</td>" +
                          "<td style='white-space:nowrap;width:60%'>Concepto</td>" +
                          "<td style='white-space:nowrap'>Fundamento</td>" +
                          "<td align='right'>Subtotal</td>" +
                          "<td align='right'>Descuento</td>" +
                          "<td align='right'>Total</td>";
      if (transaction.TransactionType.Id == 702) {
        return cert;
      } else {
        return aj;
      }
    }

    protected string GetCurrentUserInitials() {
      if (ExecutionServer.IsAuthenticated) {
        var user = Empiria.Security.EmpiriaUser.Current.AsContact();

        return user.Nickname;
      } else {
        return "Interesado";
      }
    }


    protected string GetDocumentLogo() {
      if (DISPLAY_VEDA_ELECTORAL_UI) {
        return "../themes/default/customer/government.seal.veda.png";
      }
      return "../themes/default/customer/government.seal.png";
    }


    protected string GetItems() {
      if (transaction.TransactionType.Id == 702) {
        return GetCertificate();
      } else {
        return GetRecordingActsWithTotals();
      }
    }

    protected string GetCertificate() {
      const string cert = "<tr width='24px'><td style='white-space:nowrap'>{NUMBER}</td>" +
                            "<td style='white-space:nowrap'>{CODE}</td>" +
                            "<td style='white-space:nowrap;width:30%'>{CONCEPT}</td>" +
                            "<td style='white-space:nowrap'>{LAW.ARTICLE}</td>" +
                            "<td align='right'>{SUBTOTAL}</td>" +
                            "<td align='right'>{DISCOUNTS}</td>" +
                            "<td align='right'><b>{TOTAL}</b></td>" +
                           "</tr>";
      FixedList<LRSTransactionItem> list = transaction.Items;
      string html = String.Empty;

      for (int i = 0; i < list.Count; i++) {
        LRSTransactionItem recordingAct = list[i];
        string temp = cert.Replace("{NUMBER}", (i + 1).ToString("00"));
        temp = temp.Replace("{CODE}", recordingAct.TreasuryCode.FinancialConceptCode);
        temp = temp.Replace("{CONCEPT}", recordingAct.TransactionItemType.DisplayName);
        temp = temp.Replace("{LAW.ARTICLE}", recordingAct.TreasuryCode.Name);
        if (!recordingAct.Quantity.Unit.IsEmptyInstance) {
          temp = temp.Replace("{QTY}", recordingAct.Quantity.Amount.ToString("N0"));
          temp = temp.Replace("{UNIT}", recordingAct.Quantity.Unit.Name);
        } else {
          temp = temp.Replace("{QTY}", "&nbsp;");
          temp = temp.Replace("{UNIT}", "&nbsp;");
        }
        temp = temp.Replace("{SUBTOTAL}", recordingAct.Fee.SubTotal.ToString("C2"));
        temp = temp.Replace("{DISCOUNTS}", recordingAct.Fee.Discount.Amount.ToString("C2"));
        temp = temp.Replace("{TOTAL}", recordingAct.Fee.Total.ToString("C2"));
        temp = temp.Replace("{NOTES}", recordingAct.Notes);
        html += temp;
      }
      return html;
    }

    protected string GetConcepts() {
      const string template = "<tr width='24px'><td>{NUMBER}</td>" +
                              "<td style='white-space:nowrap'>{CODE}</td>" +
                              "<td style='white-space:normal'>{CONCEPT}&nbsp;&nbsp;</td>" +
                              "<td align='right' style='white-space:nowrap'>{OPERATION.VALUE}</td>" +
                              "<td align='right' style='white-space:nowrap'>{QTY}</td>" +
                              "<td style='white-space:nowrap'>{UNIT}</td>" +
                              "<td style='white-space:normal'><b>{LAW.ARTICLE}</b></td>" +
                              "<td style='white-space:nowrap'>{NOTES}</td></tr>";
      FixedList<LRSTransactionItem> list = transaction.Items;
      string html = String.Empty;

      for (int i = 0; i < list.Count; i++) {
        LRSTransactionItem recordingAct = list[i];
        string temp = template.Replace("{NUMBER}", (i + 1).ToString("00"));
        temp = temp.Replace("{CODE}", recordingAct.TreasuryCode.FinancialConceptCode);
        temp = temp.Replace("{CONCEPT}", recordingAct.TransactionItemType.DisplayName);
        temp = temp.Replace("{OPERATION.VALUE}", recordingAct.OperationValue.Amount != decimal.Zero ? recordingAct.OperationValue.ToString() : "&nbsp;");
        if (!recordingAct.Quantity.Unit.IsEmptyInstance) {
          temp = temp.Replace("{QTY}", recordingAct.Quantity.Amount.ToString("N0"));
          temp = temp.Replace("{UNIT}", recordingAct.Quantity.Unit.Name);
        } else {
          temp = temp.Replace("{QTY}", "&nbsp;");
          temp = temp.Replace("{UNIT}", "&nbsp;");
        }
        temp = temp.Replace("{LAW.ARTICLE}", recordingAct.TreasuryCode.Name);
        temp = temp.Replace("{NOTES}", recordingAct.Notes);
        html += temp;
      }
      return html;
    }

    protected string GetRecordingActsWithTotals() {
      FixedList<LRSTransactionItem> list = transaction.Items;
      const string template = "<tr width='24px'><td>{NUMBER}</td><td>{CONCEPT.CODE}</td>" +
                              "<td style='white-space:normal'>{RECORDING.ACT}&nbsp; &nbsp; &nbsp;</td>" +
                              "<td style='white-space:nowrap'>{LAW.ARTICLE}</td>" +
                              "<td align='right' style='white-space:nowrap'>{OPERATION.VALUE}</td>" +
                              "<td align='right' style='white-space:nowrap'>{RECORDING.RIGHTS}</td>" +
                              "<td align='right' style='white-space:nowrap'>{SHEETS.REVISION}</td>" +
                              "<td align='right' style='white-space:nowrap'>{OTHERS.FEE}</td>" +
                              "<td align='right' style='white-space:nowrap'>{SUBTOTAL}</td>" +
                              "<td align='right' style='white-space:nowrap'>{DISCOUNTS}</td>" +
                              "<td align='right' style='white-space:nowrap'><b>{TOTAL}</b></td></tr>";

      const string othersTemplate = "<tr width='24px'><td colspan='3'>&nbsp;</td><td><i>Otros conceptos:</i></td><td colspan='7'><i>{CONCEPTS}</i></td></tr>";

      const string totalsTemplate = "<tr width='24px' class='upperSeparatorRow'><td colspan='4'>{TOTAL_SPEECH}</td><td align='right'><b>Total</b>:</td>" +
                "<td align='right'><b>{0}</b></td><td align='right'><b>{1}</b></td><td align='right'><b>{2}</b></td>" +
                "<td align='right'><b>{3}</b></td><td align='right'><b>{4}</b></td><td align='right' style='font-size:11pt'><b>{5}</b></td></tr>";

      string html = String.Empty;

      for (int i = 0; i < list.Count; i++) {
        LRSTransactionItem recordingAct = list[i];
        string temp = template.Replace("{NUMBER}", (i + 1).ToString("00"));
        temp = temp.Replace("{RECORDING.ACT}", recordingAct.TransactionItemType.DisplayName);
        temp = temp.Replace("{LAW.ARTICLE}", recordingAct.TreasuryCode.Name);
        temp = temp.Replace("{CONCEPT.CODE}", recordingAct.TreasuryCode.FinancialConceptCode);
        temp = temp.Replace("{OPERATION.VALUE}", recordingAct.OperationValue.ToString());
        temp = temp.Replace("{RECORDING.RIGHTS}", recordingAct.Fee.RecordingRights.ToString("C2"));
        temp = temp.Replace("{SHEETS.REVISION}", recordingAct.Fee.SheetsRevision.ToString("C2"));
        decimal othersFee = recordingAct.Fee.ForeignRecordingFee;
        temp = temp.Replace("{OTHERS.FEE}", (othersFee).ToString("C2"));
        temp = temp.Replace("{SUBTOTAL}", recordingAct.Fee.SubTotal.ToString("C2"));
        temp = temp.Replace("{DISCOUNTS}", recordingAct.Fee.Discount.Amount.ToString("C2"));
        temp = temp.Replace("{TOTAL}", recordingAct.Fee.Total.ToString("C2"));
        html += temp;
        if (othersFee != decimal.Zero) {
          temp = String.Empty;
          if (recordingAct.Fee.ForeignRecordingFee != decimal.Zero) {
            temp += " Trámite foráneo: " + recordingAct.Fee.ForeignRecordingFee.ToString("C2") + " &nbsp;";
          }
          html += othersTemplate.Replace("{CONCEPTS}", temp);
        }
      }

      LRSFee totalFee = transaction.Items.TotalFee;

      string temp1 = totalsTemplate.Replace("{0}", totalFee.RecordingRights.ToString("C2"));
      temp1 = temp1.Replace("{1}", totalFee.SheetsRevision.ToString("C2"));
      temp1 = temp1.Replace("{2}", totalFee.ForeignRecordingFee.ToString("C2"));
      temp1 = temp1.Replace("{3}", totalFee.SubTotal.ToString("C2"));
      temp1 = temp1.Replace("{4}", totalFee.Discount.Amount.ToString("C2"));
      temp1 = temp1.Replace("{5}", totalFee.Total.ToString("C2"));

      temp1 = temp1.Replace("{TOTAL_SPEECH}", EmpiriaString.SpeechMoney(totalFee.Total));

      return html + temp1;
    }

    #endregion Private methods

  } // class TransactionReceipt

} // namespace Empiria.Land.WebApp
