<%@ Page Language="C#" AutoEventWireup="true" Inherits="Empiria.Land.WebApp.RecordingSeal" Codebehind="recording.seal.aspx.cs" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <title>&#160;</title>
  <meta http-equiv="Expires" content="-1" />
  <meta http-equiv="Pragma" content="no-cache" />
  <link href="../themes/default/css/official.document.css" type="text/css" rel="stylesheet" />
  </head>
  <body>
    <table>
      <tr>
        <td style="vertical-align:top">
          <br />
          <img style="margin-left:-22pt" class="logo" src="../themes/default/customer/government.seal.png" alt="" title="" />
        </td>
        <td style="vertical-align:top;text-align:center;width:95%">
	        <h3>DIRECCIÓN DE NOTARÍAS Y REGISTROS PÚBLICOS</h3>
          <h4>GOBIERNO DEL ESTADO DE TLAXCALA</h4>
          <% if (!document.IsClosed) { %>
          <h2 class="warning" style="padding-top:0">ESTE DOCUMENTO NO HA SIDO CERRADO</h2>
          <% } else if (!document.IsHistoricDocument) { %>
          <h2 style="padding-top:0">SELLO REGISTRAL</h2>
          <% } else { %>
          <h2 style="padding-top:0">SELLO REGISTRAL DE PARTIDA HISTÓRICA</h2>
          <% } %>
          <h5><%=document.UID%></h5>
          <% if (transaction.IsReentry) { %>
            <h5><b>(Reingreso)</b></h5>
          <% } %>
        </td>
      </tr>
    </table>

    <table>
      <tr>
        <td style="vertical-align:top">
          <img style="margin-left:8pt" alt="" title="" src="../user.controls/barcode.aspx?data=<%=document.UID%>&#38;vertical=true&#38;show-text=true&#38;height=32" />
        </td>
        <td>
          <div class="document-text">
              <p>
                <%=GetPrelationText()%>
              </p>
              <p>
                <%=base.GetRecordingActsText()%>
              </p>
              <p style="text-align:justify;font-size:9pt">
                <%=GetDocumentDescriptionText()%>
              </p>
              <p>
                <%=GetPaymentText()%>
              </p>
              <p>
                <%=GetRecordingPlaceAndDate()%>
              </p>
            </div>
        </td>
      </tr>
    </table>
    <div class="footNotes">
      <table >
        <% if (!document.IsClosed) { %>
        <tr>
          <td colspan="3" style="text-align:center;font-size:10pt" >
            <br /><br />
            <b class="warning">*** ESTE DOCUMENTO AUN NO HA SIDO CERRADO. ***</b>
            <br />&#160;
          </td>
        </tr>
        <% } else if (!document.IsHistoricDocument) { %>
        <tr>
          <td colspan="3" style="text-align:center;font-size:11pt" >
            <br /><br /><br />
            <b><%=GetRecordingSignerName()%></b>
            <br />
            <%=GetRecordingSignerPosition()%>
            <br />&#160;
          </td>
          <td style="text-wrap:none">&#160;&#160;&#160;&#160;&#160;</td>
        </tr>
        <% } %>
        <tr>
          <td style="vertical-align:top;width:100px">
            <img style="margin-left:-12pt;margin-top:-12pt" alt="" title="" src="../user.controls/qrcode.aspx?size=120&#38;data=http://registropublico.tlaxcala.gob.mx/consultas/?type=document%26uid=<%=document.UID%>%26hash=<%=document.QRCodeSecurityHash()%>" />
            <div style="margin-top:-12pt;font-size:7pt;white-space:nowrap">
              Valide este documento<br />
              <b><%=document.UID%></b>
            </div>
          </td>
          <td style="vertical-align:top;width:90%;white-space:nowrap">
            <b>Código de verificación:</b>
            <br />
           &#160;&#160;<%=base.document.QRCodeSecurityHash()%>
            <br />
            <b>Sello digital:</b>
            <br />
            <% if (!document.IsClosed) { %>
            <span class="warning">** ESTE DOCUMENTO NO ES OFICIAL **</span>
            <% } else { %>
           &#160;&#160;<%=base.GetDigitalSeal().Substring(0, 64)%>
            <% } %>
            <br />
            <b>Firma digital:</b>
            <br />
           &#160;&#160;Documento firmado de forma autógrafa.
            <br />
            <b>Registró:</b> <%=GetRecordingOfficialsInitials()%>
            <br />
            <div style="font-size:7pt;margin-top:4pt;text-align:left;">
              Verifique la <u>autenticidad</u> de este documento y el estado de su predio. Para ello lea los códigos QR con su<br />
              celular o dispositivo móvil, o visite nuestro sitio <b>http://registropublico.tlaxcala.gob.mx</b>.
            </div>
          </td>
          <td style="vertical-align:top">
            <% if (!base.UniqueInvolvedResource.IsEmptyInstance && document.IsClosed) { %>
            <img style="margin-right:-12pt;margin-left:-12pt;margin-top:-12pt" alt="" title="" src="../user.controls/qrcode.aspx?size=120&#38;data=http://registropublico.tlaxcala.gob.mx/consultas/?type=resource%26uid=<%=base.UniqueInvolvedResource.UID%>%26hash=<%=base.UniqueInvolvedResource.QRCodeSecurityHash()%>" />
            <div style="margin-top:-12pt;font-size:7pt;white-space:nowrap">
              Consultar folio real/predio<br />
              <b><%=base.UniqueInvolvedResource.UID%></b>
            </div>
            <% } %>
          </td>
        </tr>
      </table>

    </div>

  </body>
</html>
