<%@ Page Language="C#" AutoEventWireup="true" Inherits="Empiria.Web.UI.FSM.TransactionReport" CodeFile="transaction.report.aspx.cs" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es-mx">
<head id="Head1" runat="server">
  <title>Relación de documentos para firma</title>
  <meta http-equiv="Expires" content="-1" />
  <meta http-equiv="Pragma" content="no-cache" />
	<link href="../themes/default/css/to.printer.css" type="text/css" rel="stylesheet" />
</head>
<body topmargin="0">
	<form id="frmEditor" method="post" runat="server">
		<table style="" cellspacing="0" cellpadding="0" width="100%">
      <tr valign="top">
	      <td nowrap="nowrap" width="100%">
		      <table style="WIDTH: 100%" cellspacing="0" cellpadding="2">
			      <tr>
				      <td valign="top">
					      <table height="100%">
						      <tr>
							      <td>
								      <img src="../themes/default/customer/customer.full.logo.png" alt="" title="" />
							      </td>
						      </tr>
					      </table>
				      </td>
              <td valign="top" width="80%" style="white-space:nowrap" height="100%;">
			          <table height="100%" width="100%">
						      <tr>
							      <td align="center">
								      <h1>Relación de documentos para firma</h1>
							      </td>
						      </tr>
						      <tr>
							      <td align="center">
								      <h2 style="height:58px; white-space:normal"><u>Dirección de Notarías y Registros Públicos</u></h2>
							      </td>
						      </tr>
                </table>
              </td>
				      <td valign="top" height="100%" style="white-space:nowrap">
					      <table height="100%" width="100%">
						      <tr>
							      <td valign="bottom" align="right" nowrap="nowrap">
								      <b><%=DateTime.Now.ToString("dd/MMM/yyyy HH:mm")%>
							      </td>
						      </tr>
						      <tr>
							      <td align="right"></td>
						      </tr>
						      <tr>
							      <td valign="bottom" align="right">
                      <b style="font-size:12px"></b>
							      </td>
						      </tr>
				          <tr>
							      <td valign="bottom" align="right">
                      
							      </td>
						      </tr>											
					      </table>
				      </td>
			      </tr>
		      </table>
	      </td>
      </tr>
      <tr><td style="font-size:10pt; font-weight:bold">Trámites por entregar<br /></td></tr>
			<tr>
				<td nowrap="nowrap" style="width:100%;height:10px">
			    <table style="width:100%" cellpadding="4px" cellspacing="0px">
				    <tr class="borderHeaderRow">
				      <td style="white-space:nowrap">#</td>
				      <td style="white-space:nowrap">Trámite</td>
              <td style="white-space:nowrap">Tipo</td>
              <td style="white-space:nowrap">Interesado</td>
				      <td style="white-space:nowrap">Recibo</td>
				      <td style="white-space:nowrap" align="right">Importe</td>
				      <td style="white-space:nowrap">Presentación</td>
				      <td style="white-space:nowrap">Elaboración</td>
              <td width="70%">Observaciones</td>
				    </tr>
            <%=GetOKTransactions()%>
           </table>
         </td>
      </tr>
      <% if (hasReturnItems) { %>
      <tr><td style="font-size:10pt; font-weight:bold"><br />Trámites por devolver a los interesados<br /></td></tr>
			<tr>
				<td nowrap="nowrap" style="width:100%;height:10px">
			    <table style="width:100%;" cellpadding="4px" cellspacing="0px;">
				    <tr class="borderHeaderRow">
				      <td style="white-space:nowrap">#</td>
				      <td style="white-space:nowrap">Trámite</td>
              <td style="white-space:nowrap">Tipo</td>
              <td style="white-space:nowrap">Interesado</td>
				      <td style="white-space:nowrap">Recibo</td>
				      <td style="white-space:nowrap" align="right">Importe</td>
				      <td style="white-space:nowrap">Presentación</td>
				      <td style="white-space:nowrap">Elaboración</td>
              <td width="70%">Observaciones</td>
				    </tr>
            <%=GetReturnTransactions()%>
           </table>
         </td>
      </tr>
      <% } %>
    </table>
	</form>
	</body>
</html>
