/* Empiria Land **********************************************************************************************
*                                                                                                            *
*  Solution  : Empiria Land                                     System   : Land Intranet Application         *
*  Namespace : Empiria.Land.WebApp                              Assembly : Empiria.Land.Intranet.dll         *
*  Type      : CertificateViewer                                Pattern  : Explorer Web Page                 *
*  Version   : 3.0                                              License  : Please read license.txt file      *
*                                                                                                            *
*  Summary   : Displays a land certificate.                                                                  *
*                                                                                                            *
********************************** Copyright(c) 2009-2017. La Vía Óntica SC, Ontica LLC and contributors.  **/
using System;

using Empiria.Land.Certification;

namespace Empiria.Land.WebApp {

  public partial class CertificateViewer : System.Web.UI.Page {

    #region Fields

    private Certificate certificate = null;

    #endregion Fields

    #region Constructors and parsers

    protected void Page_Load(object sender, EventArgs e) {
      if (!String.IsNullOrWhiteSpace(Request.QueryString["uid"])) {
        string uid = Request.QueryString["uid"];

        this.certificate = Certificate.TryParse(uid);

        Assertion.AssertObject(this.certificate, $"Invalid certificate number '{uid}'.");

      } else if (!String.IsNullOrWhiteSpace(Request.QueryString["certificateId"])) {
        int certificateId = int.Parse(Request.QueryString["certificateId"]);

        this.certificate = Certificate.Parse(certificateId);
      }
    }

    #endregion Constructors and parsers

    #region Methods

    protected string GetCertificateText() {
      string text = certificate.AsText;

      text = ReplaceImagePaths(text);
      text = ReplaceQRUrls(text);
      text = FixHtmlErrors(text);

      return text;
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

    #endregion Methods

  } // class CertificateViewer

} // namespace Empiria.Land.WebApp
