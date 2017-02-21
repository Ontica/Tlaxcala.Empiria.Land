using System;

using CityS.WS;

using Empiria.Land.Certification;
using Empiria.Land.Registration.Transactions;

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

    public int SendCertificate(Certificate certificate, byte[] outputFile) {
      var wsClient = new RppCertificateEmissionWSClient();

      var authenticationBean = this.GetAuthenticationBean();
      var certificateBean = this.GetCertificateBean(certificate, outputFile);

      return wsClient.receiveCertificate(authenticationBean, certificateBean);
    }

    public int SendAvisoPreventivo(Certificate certificate, byte[] outputFile) {
      var wsClient = new RppCertificateEmissionWSClient();

      var authenticationBean = this.GetAuthenticationBean();
      var certificateBean = this.GetAvisoPreventivoBean(certificate, outputFile);

      return wsClient.receiveCertificate(authenticationBean, certificateBean);
    }

    public int SendOficioDevolucion(LRSTransaction transaction, byte[] outputFile) {
      var wsClient = new RppCertificateEmissionWSClient();

      var authenticationBean = this.GetAuthenticationBean();
      var returnDocumentBean = this.GetReturnDocumentBean(transaction, outputFile);

      return wsClient.receiveCertificate(authenticationBean, returnDocumentBean);
    }

    public bool CanSendDocument(string tramiteCitys) {
      var wsClient = new RppCertificateEmissionWSClient();

      var authenticationBean = this.GetAuthenticationBean();

      return wsClient.canSendDocument(authenticationBean, tramiteCitys);
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

      returnData.reference = transaction.ExtensionData.ExternalTransaction.ExternalTransactionNo;
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
