﻿/* Empiria Land **********************************************************************************************
*																																																						 *
*  Solution  : Empiria Land                                     System   : Land Intranet Application         *
*  Namespace : Empiria.Land.WebApp                              Assembly : Empiria.Land.Intranet.dll         *
*  Type      : ObjectSearcher                                   Pattern  : Explorer Web Page                 *
*  Version   : 2.0                                              License  : Please read license.txt file      *
*                                                                                                            *
*  Summary   : Gets user credentials and redirects users to the workplace start page.                        *
*																																																						 *
********************************** Copyright(c) 2009-2015. La Vía Óntica SC, Ontica LLC and contributors.  **/
using System;

using Empiria.Land.Registration.Transactions;

namespace Empiria.Land.WebApp {

  public partial class TransactionReceipt : System.Web.UI.Page {

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
    }

    protected string CustomerOfficeName() {
      if (ExecutionServer.LicenseName == "Tlaxcala") {
        return "Dirección de Notarías y Registros Públicos";
      } else {
        return "Dirección de Catastro y Registro Público";
      }
    }

    protected string DistrictName {
      get {
        if (ExecutionServer.LicenseName == "Zacatecas") {
          return "Registro Público del Distrito de Zacatecas";
        }
        return String.Empty;
      }
    }

    protected string GetHeader() {
      if (ExecutionServer.LicenseName == "Tlaxcala") {
        return GetQuantitiesHeader();
      } else {
        return GetNoQuantitiesHeader();
      }
    }

    private string GetNoQuantitiesHeader() {
      const string aj = "<td class='hdr' style='white-space:nowrap'>#</td>" +
                          "<td class='hdr' style='width:30%'>Concepto</td>" +
                          "<td class='hdr' style='white-space:nowrap'>Base gravable</td>" +
                          "<td class='hdr' style='white-space:nowrap'>Cant</td>" +
                          "<td class='hdr' style='white-space:nowrap'>Unidad</td>" +
                          "<td class='hdr' style='width:30%;'>Fundamento</td>" +
                          "<td class='hdr' style='width:30%;'>Observaciones</td>";
      return aj;
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

    protected string GetItems() {
      if (ExecutionServer.LicenseName == "Tlaxcala") {
        if (transaction.TransactionType.Id == 702) {
          return GetCertificate();
        } else {
          return GetRecordingActsWithTotals();
        }
      } else {
        return GetConcepts();
      }
    }

    protected string GetCertificate() {
      const string cert = "<tr width='24px'><td style='white-space:nowrap'>{NUMBER}</td>" +
                      "<td style='white-space:nowrap'>{CODE}</td>" +
                      "<td style='white-space:nowrap;width:30%'>{CONCEPT}</td>" +
                      "<td style='white-space:nowrap'>{LAW.ARTICLE}</td>" +
                      "<td align='right'>{SUBTOTAL}</td>" +
                      "<td align='right'>{DISCOUNTS}</td>" +
                      "<td align='right'><b>{TOTAL}</b></td></tr>";
      FixedList<LRSTransactionItem> list = transaction.Items;
      string html = String.Empty;

      for (int i = 0; i < list.Count; i++) {
        LRSTransactionItem item = list[i];
        string temp = cert.Replace("{NUMBER}", (i + 1).ToString("00"));
        temp = temp.Replace("{CODE}", item.TreasuryCode.FinancialConceptCode);
        temp = temp.Replace("{CONCEPT}", item.TransactionItemType.DisplayName);
        temp = temp.Replace("{LAW.ARTICLE}", item.TreasuryCode.Name);
        if (!item.Quantity.Unit.IsEmptyInstance) {
          temp = temp.Replace("{QTY}", item.Quantity.Amount.ToString("N0"));
          temp = temp.Replace("{UNIT}", item.Quantity.Unit.Name);
        } else {
          temp = temp.Replace("{QTY}", "&nbsp;");
          temp = temp.Replace("{UNIT}", "&nbsp;");
        }
        temp = temp.Replace("{SUBTOTAL}", item.Fee.SubTotal.ToString("C2"));
        temp = temp.Replace("{DISCOUNTS}", item.Fee.Discount.Amount.ToString("C2"));
        temp = temp.Replace("{TOTAL}", item.Fee.Total.ToString("C2"));
        temp = temp.Replace("{NOTES}", item.Notes);
        html += temp;
      }
      return html;
    }

    protected string GetConcepts() {
      FixedList<LRSTransactionItem> list = transaction.Items;

      const string template = "<tr width='24px'><td>{NUMBER}</td>" +
                              "<td style='white-space:normal'>{CONCEPT}&nbsp; &nbsp; &nbsp;</td>" +
                              "<td align='right' style='white-space:nowrap'>{OPERATION.VALUE}</td>" +
                              "<td align='right' style='white-space:nowrap'>{QTY}</td>" +
                              "<td style='white-space:nowrap'>{UNIT}</td>" +
                              "<td style='white-space:normal'>{LAW.ARTICLE}</td>" +
                              "<td style='white-space:nowrap'>{NOTES}</td></tr>";

      string html = String.Empty;
      for (int i = 0; i < list.Count; i++) {
        LRSTransactionItem item = list[i];
        string temp = template.Replace("{NUMBER}", (i + 1).ToString("00"));
        temp = temp.Replace("{CONCEPT}", item.TransactionItemType.DisplayName);
        temp = temp.Replace("{OPERATION.VALUE}", item.OperationValue.Amount != decimal.Zero ? item.OperationValue.ToString() : "&nbsp;");

        if (!item.Quantity.Unit.IsEmptyInstance) {
          temp = temp.Replace("{QTY}", item.Quantity.Amount.ToString("N0"));
          temp = temp.Replace("{UNIT}", item.Quantity.Unit.Name);
        } else {
          temp = temp.Replace("{QTY}", "&nbsp;");
          temp = temp.Replace("{UNIT}", "&nbsp;");
        }
        temp = temp.Replace("{LAW.ARTICLE}", item.TreasuryCode.Name);
        temp = temp.Replace("{NOTES}", item.Notes);
        html += temp;
      }
      return html;
    }

    protected string GetRecordingActsWithTotals() {
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

      FixedList<LRSTransactionItem> list = transaction.Items;
      for (int i = 0; i < list.Count; i++) {
        LRSTransactionItem item = list[i];
        string temp = template.Replace("{NUMBER}", (i + 1).ToString("00"));
        temp = temp.Replace("{RECORDING.ACT}", item.TransactionItemType.DisplayName);
        temp = temp.Replace("{LAW.ARTICLE}", item.TreasuryCode.Name);
        temp = temp.Replace("{CONCEPT.CODE}", item.TreasuryCode.FinancialConceptCode);
        temp = temp.Replace("{OPERATION.VALUE}", item.OperationValue.Amount.ToString("C2"));
        temp = temp.Replace("{RECORDING.RIGHTS}", item.Fee.RecordingRights.ToString("C2"));
        temp = temp.Replace("{SHEETS.REVISION}", item.Fee.SheetsRevision.ToString("C2"));
        decimal othersFee = item.Fee.ForeignRecordingFee;
        temp = temp.Replace("{OTHERS.FEE}", othersFee.ToString("C2"));
        temp = temp.Replace("{SUBTOTAL}", item.Fee.SubTotal.ToString("C2"));
        temp = temp.Replace("{DISCOUNTS}", item.Fee.Discount.Amount.ToString("C2"));
        temp = temp.Replace("{TOTAL}", item.Fee.Total.ToString("C2"));
        html += temp;
        if (othersFee != decimal.Zero) {
          temp = String.Empty;
          if (item.Fee.ForeignRecordingFee != decimal.Zero) {
            temp += " Trámite foráneo: " + item.Fee.ForeignRecordingFee.ToString("C2") + " &nbsp;";
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
