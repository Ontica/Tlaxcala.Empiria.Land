<%@ Page Language="C#" AutoEventWireup="true" Inherits="Empiria.Land.WebApp.CertificateViewer" Codebehind="certificate.aspx.cs" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <title>Certificado</title>
  <meta http-equiv="Expires" content="-1" />
  <meta http-equiv="Pragma" content="no-cache" />
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <link href="../themes/default/css/official.document.css" type="text/css" rel="stylesheet" />
  </head>
  <body>
    <% if (base.Certificate.UseESign) { %>
    <table>
       <tr>
        <td style='vertical-align:top'>
          <img class="logo" src="<%=GetLogoSource()%>" alt="" title="" />
        </td>
       <td align="center" width="95%">
	      <h3>DIRECCIÓN DE NOTARÍAS Y REGISTROS PÚBLICOS</h3>
        <h4>GOBIERNO DEL ESTADO DE TLAXCALA</h4>
        <h2>
          <% if (!base.Certificate.IsClosed) { %>
            <span style='color:red;'>* ESTE CERTIFICADO NO HA SIDO CERRADO *</span><br />
          <% } else if (base.Certificate.Unsigned()) { %>
            <span style='color:red;'>* INVÁLIDO SIN FIRMA ELECTRÓNICA *</span><br />
          <% } else if (!base.Certificate.Transaction.Workflow.DeliveredOrReturned &&
                        this.Certificate.Transaction.Workflow.CurrentStatus != Empiria.Land.Registration.Transactions.LRSTransactionStatus.Archived) { %>
            <span style='color:red;'>* ESTE CERTIFICADO NO HA SIDO ENTREGADO*</span><br />
          <% } %>
          CERTIFICADO DE <%=base.Certificate.CertificateType.DisplayName.ToUpperInvariant()%>
        </h2>
        <h5><%=base.Certificate.UID%></h5>
        </td>
        <td style="vertical-align:top;padding-left:20px">
          <img style="margin-left:-22pt" class="logo" src="../themes/default/customer/government.seal.right.jpg" alt="" title="" />
        </td>
       </tr>
    </table>
    <br />
    <div class="certificate-text">
      &nbsp; &nbsp; &nbsp; &nbsp;El ciudadano <strong><%=base.GetSignedByName()%></strong>,
      <%=base.GetSignedByJobTitle()%> del Estado de Tlaxcala,
      <strong>C E R T I F I C A:</strong>
      <%=GetCertificateText()%>
      <p>
        SE EXPIDE EL PRESENTE CERTIFICADO DE <%=base.Certificate.CertificateType.DisplayName.ToUpperInvariant()%>
        A SOLICITUD DEL INTERESADO A QUIEN SE ENTREGA PARA LOS USOS LEGALES A QUE DIERE LUGAR.<br/>
        EN TLAXCALA DE XICOHTÉNCATL A <strong><%=base.GetIssueDate()%></strong>, DOY FE.
      </p>
      <p style='text-align:center'>
        <span style="font-size:8pt;">
          <%=base.GetDigitalSignatureMessage()%>
        </span>
	      <br/>
        <%=base.GetDigitalSignature()%>
        <br/>
        <span><b><%=base.GetSignedByName()%></b></span>
        <br/>
        <span><%=base.GetSignedByJobTitle()%></span>
      </p>
    </div>

    <div class="footNotes">

      <table class='table-transaction-data'>
      <tr>
        <td style="width:100px;vertical-align:top">
        <img style="margin-left:-12pt;margin-top:-12pt" alt="" title="" src="<%=base.QRCodeSource()%>" />
        <div style="margin-top:-12pt;font-size:7pt;">
          Valide este certificado<br />
          <b><%=base.Certificate.UID%></b>
        </div>
      </td>
      <td style="width:90%;vertical-align:top">
        <b>Código de verificación:</b>
        <br />
        <%=base.GetQRCodeSecurityHash()%>
        <br />
        <strong>Sello digital:</strong><br />
        <%=base.GetDigitalSeal()%>
        <br />
        <strong>Firma electrónica avanzada:</strong>
        <br />
        <%=base.GetDigitalSignature()%>
        <br/>
        <table class='table-transaction-data;' style="width:100%;">
        <tr>
          <td>
             <strong>Elaboró/cotejó:</strong>
          </td>
          <td>
             <strong>Imprimió</strong>
          </td>
          <td>
             <strong>Trámite/Recibido el:</strong>
          </td>
          <td>
             <strong>Línea de captura:</strong>
          </td>
        </tr>
        <tr>
           <td>
              <strong>*<%=base.Certificate.IssuedBy.Nickname%></strong>
           </td>
           <td>
              <%=GetCurrentUserInitials()%><br/>
              <%=DateTime.Now.ToString("dd/MMM/yy HH:mm") %>
           </td>
           <td>
              <%=base.Certificate.Transaction.UID%><br />
              <%=base.Certificate.Transaction.PresentationTime.ToString("dd/MMM/yyyy HH:mm")%>
           </td>
          <td>
            <%=base.GetPaymentReceipt()%>
          </td>
          </tr>
        </table>
        <div style="font-size:7pt;margin-top:4pt;text-align:left;white-space:nowrap">
          Verifique la <u>autenticidad</u> de este certificado y el estado de su predio. Para ello lea los códigos QR con su<br />
          celular o dispositivo móvil, o visite nuestro sitio <b>http://registropublico.tlaxcala.gob.mx</b>.
        </div>
      </td>
      <td style="vertical-align:top;display:<%=base.DisplayQRCodeStyle()%>">
        <img style="margin-left:-12pt;margin-top:-12pt" alt="" title="" src="<%=base.ResourceQRCodeSource()%>" />
        <div style="margin-top:-12pt;font-size:7pt;white-space:nowrap">
          Consultar folio real/predio<br />
          <b><%=base.Certificate.Property.UID%></b>
        </div>
      </td>
    </tr>
    </table>
    </div>
    <% } else { %>
      <%=GetCertificateText()%>
    <% } %>
  </body>
</html>
