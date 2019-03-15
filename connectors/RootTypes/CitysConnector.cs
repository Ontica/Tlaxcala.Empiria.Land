/* Empiria Land **********************************************************************************************
*                                                                                                            *
*  Solution  : Empiria Land                                System   : Land System Connectors                 *
*  Namespace : Empiria.Land.Connectors                     Assembly : Empiria.Land.Connectors.dll            *
*  Type      : CitysConnector                              Pattern  : System Interface                       *
*  Version   : 3.0                                         License  : Please read license.txt file           *
*                                                                                                            *
*  Summary   : Citys System web service interface used to interact with Empiria Land.                        *
*                                                                                                            *
********************************* Copyright (c) 2016-2017. La Vía Óntica SC, Ontica LLC and contributors.  **/
using System;
using System.Threading.Tasks;

using Empiria.Land.Certification;
using Empiria.Land.Registration.Transactions;

using Empiria.Land.Connectors.CitysWS;

namespace Empiria.Land.Connectors {

  public class CitysConnector {

    private enum CitysCertificateType {
      NoInscripcion = 2,
      Inscripcion = 2,
      Propiedad = 4,
      Gravamen = 7,
      LibertadGravamen = 7,
      AvisoPreventivo = 7,
      OficioDevolucion = 6,
    }

    #region Public methods

    public async Task<int> SendCertificate(Certificate certificate, byte[] outputFile) {
      var wsClient = new RppCertificateEmissionWSClient();

      var authenticationBean = this.GetAuthenticationBean();
      var certificateBean = this.GetCertificateBean(certificate, outputFile);

      return await wsClient.receiveCertificateAsync(authenticationBean, certificateBean)
                           .ConfigureAwait(false);
    }


    public async Task<int> SendAvisoPreventivo(Certificate certificate, byte[] outputFile) {
      var wsClient = new RppCertificateEmissionWSClient();

      var authenticationBean = this.GetAuthenticationBean();
      var certificateBean = this.GetAvisoPreventivoBean(certificate, outputFile);

      return await wsClient.receiveCertificateAsync(authenticationBean, certificateBean)
                           .ConfigureAwait(false);
    }


    public async Task<int> SendOficioDevolucion(LRSTransaction transaction, byte[] outputFile) {
      var wsClient = new RppCertificateEmissionWSClient();

      var authenticationBean = this.GetAuthenticationBean();
      var returnDocumentBean = this.GetReturnDocumentBean(transaction, outputFile);

      return await wsClient.receiveCertificateAsync(authenticationBean, returnDocumentBean)
                           .ConfigureAwait(false);

    }


    public async Task<bool> CanSendDocument(string tramiteCitys) {
      var wsClient = new RppCertificateEmissionWSClient();

      var authenticationBean = this.GetAuthenticationBean();

      return await wsClient.canSendDocumentAsync(authenticationBean, tramiteCitys)
                            .ConfigureAwait(false);
    }


    #endregion Public methods

    #region Private methods

    private rppCertificateEmissionCertificateBean GetAvisoPreventivoBean(Certificate certificate,
                                                                         byte[] outputFile) {
      var returnData = new rppCertificateEmissionCertificateBean();

      var transaction = certificate.Transaction;

      returnData.reference = transaction.ExternalTransaction.ExternalTransactionNo;
      returnData.certificateType = (int) CitysCertificateType.AvisoPreventivo;
      returnData.folioReal = certificate.Property.UID;
      returnData.certificate = outputFile;

      return returnData;
    }


    private rppCertificateEmissionCertificateBean GetCertificateBean(Certificate certificate,
                                                                     byte[] outputFile) {
      var returnData = new rppCertificateEmissionCertificateBean();

      var transaction = certificate.Transaction;

      returnData.reference = transaction.ExternalTransaction.ExternalTransactionNo;
      returnData.certificateType = (int) ConvertToCitysCertificateType(certificate.CertificateType);
      returnData.folioReal = certificate.Property.UID;
      returnData.certificate = outputFile;

      return returnData;
    }

    private rppCertificateEmissionCertificateBean GetReturnDocumentBean(LRSTransaction transaction, byte[] outputFile) {
      var returnData = new rppCertificateEmissionCertificateBean();

      returnData.reference = transaction.ExternalTransaction.ExternalTransactionNo;
      returnData.certificateType = (int) CitysCertificateType.OficioDevolucion;
      returnData.folioReal = transaction.BaseResource.UID;
      returnData.certificate = outputFile;

      returnData.motive = "Se devuelve por estar incorrecto el nombre de propietario.";

      return returnData;
    }

    private CitysCertificateType ConvertToCitysCertificateType(CertificateType certificateType) {
      switch (certificateType.Name) {
        case "ObjectType.LandCertificate.LibertadGravamen":
          return CitysCertificateType.AvisoPreventivo;

        case "ObjectType.LandCertificate.Gravamen":
          return CitysCertificateType.Gravamen;

        case "ObjectType.LandCertificate.Inscripción":
          return CitysCertificateType.Inscripcion;


        case "ObjectType.LandCertificate.Propiedad":
          return CitysCertificateType.Propiedad;

        default:
          throw Assertion.AssertNoReachThisCode("Invalid CITYS CertificateType.");
      }
    }

    private authBean GetAuthenticationBean() {
      var authentication = new authBean();

      authentication.user = "rppceuser";
      authentication.password = "rppce-{2015}";

      return authentication;
    }

    #endregion Private methods

  }  // CitysConnector

}  // namespace Empiria.Land.Connectors
