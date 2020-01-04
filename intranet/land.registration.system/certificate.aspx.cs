/* Empiria Land **********************************************************************************************
*                                                                                                            *
*  Solution  : Empiria Land                                     System   : Land Intranet Application         *
*  Namespace : Empiria.Land.WebApp                              Assembly : Empiria.Land.Intranet.dll         *
*  Type      : CertificateViewer                                Pattern  : Explorer Web Page                 *
*  Version   : 3.0                                              License  : Please read license.txt file      *
*                                                                                                            *
*  Summary   : Displays a land certificate.                                                                  *
*                                                                                                            *
************************* Copyright(c) La Vía Óntica SC, Ontica LLC and contributors. All rights reserved. **/
using System;

using Empiria.Land.Certification;
using Empiria.Land.Registration.Transactions;

namespace Empiria.Land.WebApp {

  public partial class CertificateViewer : System.Web.UI.Page {

    #region Fields

    private static readonly string QR_CODE_SERVICE_URL = ConfigurationData.GetString("QRCodeServiceURL");

    private static readonly string SEARCH_SERVICES_SERVER_ADDRESS = ConfigurationData.Get<string>("SearchServicesServerBaseAddress");

    private static readonly bool DISPLAY_VEDA_ELECTORAL_UI =
                                      ConfigurationData.Get<bool>("DisplayVedaElectoralUI", false);

    protected Certificate Certificate = null;
    protected bool ParseComplete = true;

    #endregion Fields

    #region Constructors and parsers

    protected void Page_Load(object sender, EventArgs e) {
      if (!String.IsNullOrWhiteSpace(Request.QueryString["uid"])) {
        string uid = Request.QueryString["uid"];

        this.Certificate = Certificate.TryParse(uid);

        Assertion.AssertObject(this.Certificate, $"Invalid certificate number '{uid}'.");

      } else if (!String.IsNullOrWhiteSpace(Request.QueryString["certificateId"])) {
        int certificateId = int.Parse(Request.QueryString["certificateId"]);

        this.Certificate = Certificate.Parse(certificateId);
      }

    }

    #endregion Constructors and parsers

    #region Methods

    protected string GetLogoSource() {
      if (DISPLAY_VEDA_ELECTORAL_UI) {
        return "../themes/default/customer/government.seal.veda.png";
      }
      return "../themes/default/customer/government.seal.png";
    }

    protected string GetIssueDate() {
      if (this.Certificate.IsClosed) {
        return EmpiriaString.SpeechDate(this.Certificate.IssueTime).ToUpperInvariant();
      } else {
        return AsWarning("SIN FECHA DE EXPEDICIÓN");
      }
    }

    protected string GetDigitalString() {
      if (this.Certificate.Signed()) {
        return this.Certificate.GetDigitalString();
      } else {
        return AsWarning("SIN VALOR LEGAL * * * * * SIN VALOR LEGAL");
      }
    }

    protected string GetDigitalSeal() {
      if (!this.Certificate.Signed()) {
        return AsWarning("NO DISPONIBLE SIN FIRMA");
      } else {
        return this.Certificate.GetDigitalSeal();
      }
    }

    protected string GetDigitalSignature() {
      if (!this.Certificate.IsClosed) {
        return AsWarning("*** EL CERTIFICADO NO HA SIDO CERRADO **** ");

      } else if (this.Certificate.Signed()) {
        return this.Certificate.GetDigitalSignature();
      } else {
        return AsWarning("SIN FIRMA ELECTRÓNICA");
      }
    }

    protected string GetDigitalSignatureMessage() {
      if (!this.Certificate.IsClosed) {
        return AsWarning("*** EL CERTIFICADO NO HA SIDO CERRADO **** ");

      } else if (this.Certificate.Signed()) {
        return "Firmado y sellado electrónicamente de conformidad " +
                "con las leyes y regulaciones vigentes.";
      } else {
        return AsWarning("*** NO ES VALIDO SIN FIRMA ELECTRÓNICA. **** ");
      }
    }

    protected string GetQRCodeSecurityHash() {
      if (!this.Certificate.Signed()) {
        return AsWarning("NO DISPONIBLE SIN FIRMA");
      } else if (!this.Certificate.Transaction.Workflow.DeliveredOrReturned && this.Certificate.Transaction.Workflow.CurrentStatus != LRSTransactionStatus.Archived) {
        return AsWarning("ESTE CERTIFICADO NO ES VÁLIDO SI NO SE MARCA COMO ENTREGADO.");
      } else {
        return this.Certificate.QRCodeSecurityHash();
      }
    }

    protected string GetCertificateText() {
      string text = Certificate.AsText;

      text = ReplaceImagePaths(text);
      text = ReplaceQRUrls(text);
      text = FixHtmlErrors(text);

      return text;
    }

    protected string GetPaymentReceipt() {
      if (this.Certificate.Transaction.PaymentOrderData.RouteNumber.Length != 0) {
        return this.Certificate.Transaction.PaymentOrderData.RouteNumber;
      } else {
        return this.Certificate.Transaction.Payments.ReceiptNumbers;
      }
    }


    protected string GetCurrentUserInitials() {
      if (ExecutionServer.IsAuthenticated) {
        var user = Security.EmpiriaUser.Current.AsContact();

        return user.Nickname;
      }
      return String.Empty;
    }


    protected string GetSignedByName() {
      return this.Certificate.SignedBy.FullName.ToUpper();
    }


    protected string GetSignedByJobTitle() {
      return this.Certificate.SignedBy.JobTitle;
    }


    protected string QRCodeSource() {
      if (this.Certificate.Signed()) {
        return $"{QR_CODE_SERVICE_URL}?size=120&amp;data={SEARCH_SERVICES_SERVER_ADDRESS}/?" +
               $"type=certificate%26uid={this.Certificate.UID}%26hash={this.Certificate.QRCodeSecurityHash()}";
      } else {
        return String.Empty;
      }
    }

    protected string ResourceQRCodeSource() {
      if (this.Certificate.Property.IsEmptyInstance || this.Certificate.Unsigned()) {
        return String.Empty;
      }

      return $"{QR_CODE_SERVICE_URL}?size=120&amp;data={SEARCH_SERVICES_SERVER_ADDRESS}/?" +
             $"type=resource%26uid={this.Certificate.Property.UID}%26hash={this.Certificate.Property.QRCodeSecurityHash()}";
    }

    protected string DisplayQRCodeStyle() {
      if (this.Certificate.Property.IsEmptyInstance || this.Certificate.Unsigned()) {
        return "none";
      } else {
        return "inline";
      }
    }

    private string ReplaceImagePaths(string text) {
      if (text.Contains("assets/government.seal.png")) {
        text = text.Replace("assets/government.seal.png", "../themes/default/customer/government.seal.png");

        return text.Replace("height=\"84pt\"", "");

      } else if (text.Contains("assets/government.seal.veda.png")) {
        text = text.Replace("assets/government.seal.veda.png", "../themes/default/customer/government.seal.veda.png");

        return text.Replace("height=\"84pt\"", "");

      } else {
        return text.Replace("assets/seal.logo.left.png", "../themes/default/customer/seal.logo.left.png");

      }
    }

    private string ReplaceQRUrls(string text) {
      if (!this.Request.Url.AbsoluteUri.Contains("tlaxcala.gob.mx")) {
        return text;
      } else {
        return text.Replace("192.168.2.22", "registropublico.tlaxcala.gob.mx");
      }
    }

    private string FixHtmlErrors(string text) {
      text = text.Replace("alt=\"\" title=\"\"></td>", "alt=\"\" title=\"\" /></td>");

      text = text.Replace("INSCRITO<strong>", "INSCRITO</strong>");
      text = text.Replace("<BR>", "<br/>");
      text = text.Replace("&", "&amp;");
      text = text.Replace("&amp;nbsp;", "&nbsp;");
      text = text.Replace("&amp;amp;", "&amp;");

      return text;
    }

    private string AsWarning(string text) {
      return "<span style='color:red;'><strong>*****" + text + "*****</strong></span>";
    }

    #endregion Methods

  } // class CertificateViewer

} // namespace Empiria.Land.WebApp
