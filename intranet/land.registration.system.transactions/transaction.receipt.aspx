<%@ Page Language="C#" AutoEventWireup="true" Inherits="Empiria.Land.WebApp.TransactionReceipt" Codebehind="transaction.receipt.aspx.cs" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es-mx">
<head id="Head1" runat="server">
  <title>Boleta de recepción de trámite</title>
  <meta http-equiv="Expires" content="-1" />
  <meta http-equiv="Pragma" content="no-cache" />
	<link href="../themes/default/css/to.printer.css" type="text/css" rel="stylesheet" />
</head>
<body topmargin="0">
	<form id="frmEditor" method="post" runat="server">
		<table cellspacing="0" cellpadding="0" width="100%">
      <tr valign="top">
	      <td nowrap="nowrap" width="100%">
		      <table style="width: 100%" cellspacing="0" cellpadding="2">
			      <tr>
				      <td valign="top">
					      <table>
						      <tr>
							      <td>
								      <img src="<%=GetDocumentLogo()%>" alt="" title="" width="180px"/>
							      </td>
						      </tr>
					      </table>
				      </td>
              <td valign="top" width="80%" style="white-space:nowrap">
			          <table width="100%" cellpadding="0" cellspacing="0">
						      <tr>
							      <td align="center">
								      <h1><%=CustomerOfficeName()%></h1>
							      </td>
						      </tr>
                  <% if (base.DistrictName.Length != 0) { %>
						      <tr>
							      <td align="center" style="line-height:22pt">
								      <h2 style="height:30px; white-space:normal; font-size:9pt"><%=base.DistrictName%></h2>
							      </td>
						      </tr>
                  <% } %>
						      <tr>
							      <td align="center" style="line-height:22pt">
								      <h2 style="height:30px; white-space:normal; font-size:16pt">COMPROBANTE DE RECEPCIÓN</h2>
							      </td>
						      </tr>
                </table>
              </td>
              <td valign="top">
                <table>
                  <tr>
                    <td style="padding-right:20px;">
                      <img class="logo" src="../themes/default/customer/government.seal.right.jpg" alt="" title="" />
                    </td>
                  </tr>
                </table>
              </td>
				      <td valign="top" style="white-space:nowrap">
					      <table width="100%">
						      <tr>
							      <td valign="bottom" align="right">
								      <h3><%=transaction.UID%></h3>
							      </td>
						      </tr>
						      <tr>
							      <td align="right">
                      <img style="margin-left:8pt" alt="" title="" src="../user.controls/barcode.aspx?data=<%=transaction.UID%>" />
							      </td>
						      </tr>
					      </table>
				      </td>
			      </tr>
		      </table>
	      </td>
      </tr>
      <tr>
        <td style="border-top: 3px solid #3a3a3a;padding-top:8pt;padding-bottom:4pt">
			    <table style="width:100%;white-space:nowrap" cellpadding="3px" cellspacing="0px">
            <tr>
              <td valign="top" style="white-space:nowrap">Interesado:</td><td style='white-space:normal;border-bottom: 1px solid' colspan="3"><b style='font-size:9pt'><%=transaction.RequestedBy%></b></td>
							<td style="white-space:nowrap">Distrito:</td><td><b><%=transaction.RecorderOffice.Alias%></b></td>
            </tr>
            <tr>
              <td style="white-space:nowrap">Notaría/Gestor:</td><td style="white-space:nowrap;width:30%"><b><%=transaction.Agency.Alias%></b></td>
							<td style="white-space:nowrap">Tipo de trámite:</td><td style="white-space:nowrap;width:30%"><b><%=transaction.TransactionType.Name%></b></td>
              <td style="white-space:nowrap">Importe:</td><td style="white-space:nowrap;width:30%"><b><%=transaction.Items.TotalFee.Total.ToString("C2")%></b>&nbsp; (R: <b><%=transaction.Payments.ReceiptNumbers%>)</b></td>
            </tr>
            <tr>
							<td style="white-space:nowrap">Hora de presentación:</td><td style="white-space:nowrap"><b><%=transaction.PresentationTime.ToString("dd/MMM/yyyy HH:mm:ss")%></b></td>
							<td style="white-space:nowrap">Instrumento:</td><td><b><%=transaction.DocumentDescriptor%></b></td>
              <td style="white-space:nowrap">Recibió:</td><td style="white-space:nowrap"><b><%=transaction.ReceivedBy.Alias%></b></td>
            </tr>
            <tr style='display:<%=transaction.ExtensionData.RequesterNotes.Length != 0 ? "inline" : "none" %>'>
              <td valign="top" style="white-space:nowrap">Observaciones:</td>
              <td colspan="6" style='white-space:normal;'><%=transaction.ExtensionData.RequesterNotes%></td>
            </tr>
          </table>
        </td>
      </tr>
			<tr>
				<td nowrap="nowrap" style="width:100%;height:10px;padding-bottom:10pt">
			    <table style="width:100%" cellpadding="4px" cellspacing="0px">
				    <tr class="borderHeaderRow" style="padding-bottom:8pt">
              <%=GetHeader()%>
				    </tr>
            <%=GetItems()%>
           </table>
         </td>
      </tr>
      <tr>
        <td style="font-size:8pt">
          <table style="width:100%" cellpadding="4px" cellspacing="0px">
            <tr>
              <td valign="top" style="width:100px">
                <img style="margin-left:-12pt;margin-top:-12pt" alt="" title=""
                     src="../user.controls/qrcode.aspx?size=120&data=<%=SEARCH_SERVICES_SERVER_BASE_ADDRESS%>/?type=transaction%26uid=<%=transaction.UID%>%26hash=<%=transaction.QRCodeSecurityHash()%>" />
                <div style="margin-top:-12pt;font-size:7pt;white-space:nowrap">
                  Consulte este trámite<br />
                  <b><%=base.transaction.UID%></b>
                </div>
              </td>
              <td valign="top" style="font-size:8pt">
                <% if (!base.transaction.PaymentOrderData.IsEmptyInstance) { %>
                <b>Línea de captura del pago:</b>
                <br />
                <span style="font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;font-size:12pt"><%=base.transaction.PaymentOrderData.RouteNumber%></span>
                <br />
                <% } %>
                <b>Sello electrónico:</b>
                <br />
                <%=transaction.GetDigitalSign()%>
                <br />
                <br />
                <b>Recibió:</b> <%=transaction.ReceivedBy.FullName%>  &nbsp; | &nbsp; <b>Imprimió:</b> <%=GetCurrentUserInitials()%>, <%=DateTime.Now.ToString("dd/MMM/yyyy HH:mm") %>
                <div style="font-size:7pt;margin-top:8pt;">
                  Consulte el <b>estado</b> de su trámite leyendo el código QR con su celular o dispositivo móvil,
                  o visite nuestro sitio web <b>registropublico.tlaxcala.gob.mx</b>, donde también podrá consultar
                  documentos, certificados y el estado de los predios mediante el folio real; y podrá suscribirse a
                  nuestro servicio gratuito de ALERTA REGISTRAL.
                  <br /><br />
                  <% if (transaction.ExtensionData.SendTo.Address != "") { %>
                    Le enviaremos información sobre este trámite a su cuenta de correo: <b><%=transaction.ExtensionData.SendTo.Address%></b>
                    <br />
                    Conserve este comprobante. Pero <u>NO necesitará regresar al RPP</u> en caso de que este trámite pueda ENTREGÁRSELE DE FORMA ELECTRÓNICA.
                  <%  } else { %>
                    Este comprobante deberá <b>PRESENTARSE en la <u>Ventanilla de Entregas</u></b> al recoger su documento o certificado.
                    <br />
                    Si en trámites futuros nos proporciona su correo electrónico, podemos enviarle sus documentos VIA ELECTRÓNICA. Así no necesitará regresar a recogerlos.
                  <% } %>
                </div>
              </td>
              <td valign="top">
                <% if (!base.transaction.BaseResource.IsEmptyInstance) { %>
                <img alt="" title="" src="../user.controls/barcode.aspx?data=<%=base.transaction.BaseResource.UID%>" />
                <div><b>FOLIO REAL:</b><%=base.transaction.BaseResource.UID%></div>
                <% } %>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
	</form>
	</body>
</html>
