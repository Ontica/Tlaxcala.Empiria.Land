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
      int certificateId = int.Parse(Request.QueryString["certificateId"]);

      certificate = Certificate.Parse(certificateId);
    }

    #endregion Constructors and parsers

    #region Methods

    protected string GetCertificateText() {
      string text = certificate.AsText;

      text = ReplaceImagePaths(text);
      return text;
    }

    private string ReplaceImagePaths(string text) {
      if (text.Contains("assets/government.seal.png")) {
        text = text.Replace("assets/government.seal.png", "../themes/default/customer/government.seal.png");
        return text.Replace("height=\"84pt\"", "");
      } else {
        return text.Replace("assets/seal.logo.left.png", "../themes/default/customer/seal.logo.left.png");
      }
    }

    #endregion Methods

  } // class CertificateViewer

} // namespace Empiria.Land.WebApp
