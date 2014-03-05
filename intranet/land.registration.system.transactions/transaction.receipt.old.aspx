<%@ Page Language="C#" AutoEventWireup="true" Inherits="Empiria.Web.UI.FSM.TransactionReceiptOLD" Codebehind="transaction.receipt.old.aspx.cs" %>
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
		      <table style="WIDTH: 100%" cellspacing="0" cellpadding="2">
			      <tr>
				      <td valign="top">
					      <table>
						      <tr>
							      <td>
                      <br />
								      <img src="../themes/default/customer/customer.full.logo.png" alt="" title="" height="80px" />
							      </td>
						      </tr>
					      </table>
				      </td>
              <td valign="top" width="80%" style="white-space:nowrap">
			          <table width="100%">
						      <tr>
							      <td align="center">
								      <h1>Dirección de Notarías y Registros Públicos</h1>
							      </td>
						      </tr>
						      <tr>
							      <td align="center">
								      <h2 style="height:30px; white-space:normal; font-size:20pt">BOLETA DE RECEPCIÓN</h2>
							      </td>
						      </tr>
                </table>
              </td>
				      <td valign="top" style="white-space:nowrap">
					      <table width="100%">
						      <tr>
							      <td valign="bottom" align="right">
								      <h3><%=transaction.Key%></h3>
							      </td>
						      </tr>
						      <tr>
							      <td align="right"><img alt="" title="" src="../user.controls/barcode.aspx?data=<%=transaction.Key%>" /><br /></td>
						      </tr>
					      </table>
				      </td>
			      </tr>
		      </table>
	      </td>
      </tr>
      <tr>
        <td style="border-top: 7px solid #3a3a3a;padding-top:8pt;padding-bottom:8pt">
			    <table style="width:100%;white-space:nowrap" cellpadding="4px" cellspacing="0px">
            <tr>
              <td style="white-space:nowrap">Nombre del interesado:</td><td style='white-space:normal;width:70%'><b><%=transaction.RequestedBy%></b></td>
              <td style="white-space:nowrap">Distrito/Mesa de origen:</td><td><b><%=transaction.RecorderOffice.Alias%></b></td>
              <td width="10%">&nbsp;</td>
            </tr>
            <tr>
              <td style="white-space:nowrap">Tipo de trámite:</td><td><b><%=transaction.TransactionType.Name%></b></td>
              <td style="white-space:nowrap">Tipo de documento:</td><td style="white-space:nowrap"><b><%=transaction.DocumentType.Name%></b></td>
              <td width="10%">&nbsp;</td>
            </tr>
            <tr>
              <td style="white-space:nowrap">Número de instrumento:</td><td><b><%=transaction.DocumentNumber%></b></td>
              <td style="white-space:nowrap">Hora de presentación:</td><td style="white-space:nowrap"><b><%=transaction.PresentationTime.ToString("dd/MMM/yyyy HH:mm")%></b></td>
              <td width="10%">&nbsp;</td>
            </tr>
          </table>
        </td>
      </tr>
			<tr>
				<td nowrap="nowrap" style="width:100%;height:10px">
			    <table style="width:100%" cellpadding="4px" cellspacing="0px">
				    <tr class="borderHeaderRow" style="">
				      <td style="white-space:nowrap">#</td>
				      <td style="white-space:nowrap;width:30%">Acto jurídico</td>
              <td style="white-space:nowrap">Fundamento</td>
				      <td style="white-space:nowrap">Recibo</td>
				      <td style="white-space:nowrap" align='right'>Valor operac</td>
              <td align='right'>Derechos reg</td>
              <td align='right'>Cotejo</td>
              <td align='right'>Otros</td>
              <td align='right'>Subtotal</td>
              <td align='right'>Descuento</td>
              <td align='right'>Total</td>
				    </tr>
            <%=GetRecordingActs()%>
           </table>
         </td>
      </tr>
      <tr>
        <td>
          <table style="width:100%" cellpadding="4px" cellspacing="0px">
            <tr>
              <td style="border-top: 4px solid #3a3a3a">
                <b>Cadena original:</b><br /><%=GetDigitalString()%>
                <br /><br />
                <b>Sello electrónico:</b><br /><%=GetDigitalSign()%>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td align="center" style="border-top: 1px solid #3a3a3a">
          <br /><br /><br /><br /><br />
          <b><%=transaction.ReceivedBy.FullName%></b><br />
            Recibió<br />&nbsp;
        </td>
      </tr>
      <tr>
        <td style="border-top: 1px dotted #3a3a3a">
        * Este comprobante deberá ser presentado en la ventanilla de entregas al recoger su documento o certificado.<br />
        <br /><br />
        </td>
      </tr>
    </table>
	</form>
	</body>
</html>