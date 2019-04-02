/* Empiria Land **********************************************************************************************
*                                                                                                            *
*  Solution  : Empiria Land                                     System   : Land Intranet Application         *
*  Namespace : Empiria.Land.WebApp                              Assembly : Empiria.Land.Intranet.dll         *
*  Type      : CadastralCard                                    Pattern  : Explorer Web Page                 *
*  Version   : 3.0                                              License  : Please read license.txt file      *
*                                                                                                            *
*  Summary   :                                                                                               *
*                                                                                                            *
********************************** Copyright(c) 2009-2017. La Vía Óntica SC, Ontica LLC and contributors.  **/
using System;

using Empiria.Land.Connectors;
using Empiria.Land.Registration;

namespace Empiria.Land.WebApp {

  public partial class CadastralCard : System.Web.UI.Page {

    #region Fields

    private static readonly bool DISPLAY_VEDA_ELECTORAL_UI =
                                      ConfigurationData.Get<bool>("DisplayVedaElectoralUI", false);

    protected CadastralData data = CadastralData.Empty;
    protected RealEstate realEstate = RealEstate.Empty;

    protected string cadastralUID = String.Empty;

    #endregion Fields

    #region Constructors and parsers

    protected void Page_Load(object sender, EventArgs e) {
      Initialize();
    }

    #endregion Constructors and parsers

    #region Private methods

    private async void Initialize() {
      cadastralUID = Request.QueryString["cadastralUID"];

      var connector = new CadastralConnector();

      data = await connector.VerifyRealEstateRegistered(cadastralUID);

      if (!String.IsNullOrWhiteSpace(Request.QueryString["realEstateUID"])) {
        realEstate = RealEstate.TryParseWithUID(Request.QueryString["realEstateUID"]);
      }
    }


    protected string DistrictName {
      get {
        return String.Empty;
      }
    }


    protected string CustomerOfficeName() {
      if (ExecutionServer.LicenseName == "Tlaxcala") {
        return "Dirección de Notarías y Registros Públicos";
      } else {
        return "Dirección de Catastro y Registro Público";
      }
    }


    protected string GetDocumentLogo() {
      if (DISPLAY_VEDA_ELECTORAL_UI) {
        return "../themes/default/customer/government.seal.veda.png";
      }
      return "../themes/default/customer/government.seal.png";
    }


    protected string GetPaymentOrderFooter() {
      if (ExecutionServer.LicenseName == "Tlaxcala") {
        return @"* Esta ORDEN DE PAGO deberá <b>ENTREGARSE en la <u>Caja de la Secretaría de Finanzas</u></b> al momento de efectuar el pago.";
      } else {
        return @"* Esta ORDEN DE PAGO deberá <b>ENTREGARSE en la <u>Caja Recaudadora</u></b> más cercana a su domicilio al efectuar el pago correspondiente. ";
      }
    }


    #endregion Private methods

  } // class CadastralCard

} // namespace Empiria.Land.WebApp
