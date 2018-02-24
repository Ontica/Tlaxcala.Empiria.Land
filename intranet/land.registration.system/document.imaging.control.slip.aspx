<%@ Page Language="C#" AutoEventWireup="true" Inherits="Empiria.Land.WebApp.DocumentImagingControlSlip" Codebehind="document.imaging.control.slip.aspx.cs" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <title>Carátula de control del acervo: <%=document.ImagingControlID%></title>
  <meta http-equiv="Expires" content="-1" />
  <meta http-equiv="Pragma" content="no-cache" />
  <link href="../themes/default/css/official.document.css" type="text/css" rel="stylesheet" />
  </head>
  <body style="padding-left:50pt">
    <table style="width:98%;">
      <tr>
        <td style="vertical-align:top">
          <img src="../themes/default/customer/government.seal.png" alt="" title="" />
        </td>
        <td style="text-align:right;vertical-align:top;width:40%">
          <img alt="" title="" src="../user.controls/barcode.aspx?data=<%=transaction.UID%>" />
          <br />
          Trámite: <%=transaction.UID%> <%=transaction.IsReentry ? "&#160; <b>(REINGRESO)</b>" : "" %>
        </td>
      </tr>
      <tr>
        <td style="vertical-align:top;text-align:left;margin-top:-30pt">
	        <h3>DIRECCIÓN DE NOTARÍAS Y REGISTROS PÚBLICOS</h3>
          <h4>GOBIERNO DEL ESTADO DE TLAXCALA</h4>
          <h2 style="padding-top:0;text-align:left">CONTROL DEL ACERVO DOCUMENTAL</h2>
        </td>
        <td style="text-align:right;vertical-align:bottom;width:40%">
          <% if (!base.UniqueInvolvedResource.IsEmptyInstance) { %>
          <img alt="" title="" src="../user.controls/barcode.aspx?data=<%=base.UniqueInvolvedResource.UID%>" />
          <br />
          <span><b>FOLIO REAL:</b><%=base.UniqueInvolvedResource.UID%></span>
          <% } %>
        </td>
      </tr>
    </table>
    <br />
    <div>
     <table style="width:95%;">
        <tr>
          <td style='vertical-align:top'>Interesado:<br /></td>
          <td style='width:90%' colspan="3"><b><%=transaction.RequestedBy%></b></td>
        </tr>
        <tr>
          <td>Presentación:</td>
          <td><b><%=document.PresentationTime.ToString("dd/MMM/yyyy HH:mm")%></b></td>
          <td style="text-align:right">Boleta de pago:</td>
          <td><b><%=transaction.Payments.ReceiptNumbers%></b></td>
        </tr>
        <tr>
          <td colspan="4" style="border-top: 2px solid black;text-align:justify;font-size:10pt;">
            <b>Actos jurídicos:</b>
            <br />
            <%=GetRecordingActsDescriptionText()%>
            <br /><br />
          </td>
        </tr>
        <tr>
          <td colspan="4" style="border-top: 2px solid black;text-align:justify;font-size:10pt;">
            <b>Descripción:</b>
            <br />
            <%=GetDocumentDescriptionText()%>
            <br /><br />
          </td>
       </tr>
     </table>
    </div>
    <div>
      <table style="width:99%;position:absolute; width:98%;bottom:5pt;border-top: 1px solid black;padding-top:10pt">
        <tr>
          <td style="white-space:nowrap;vertical-align:top;">
            <img alt="" title="" src="../user.controls/barcode.aspx?data=<%=document.UID%>" />
            <br />
            <b><%=document.UID%></b>
            <br />
            Número de documento <%=transaction.IsReentry ? "<b>(REINGRESO)</b>" : "" %>
          </td>
          <td style="text-align:center;white-space:nowrap">
            <span style="font-size:18pt"><%=document.AuthorizationTime.ToString("dd/MMM/yyyy")%></span>
            <br />
            Fecha de registro <%=transaction.IsReentry ? "del <b>REINGRESO</b>" : "" %>
          </td>
          <td style="text-align:right;white-space:nowrap;padding-right:40pt;">
            <img alt="" title="" src="../user.controls/barcode.aspx?data=<%=document.ImagingControlID%>" />
            <br />
            <b style="font-size:18pt"><%=document.ImagingControlID%></b>
            <br />
            Control documental
          </td>
        </tr>
      </table>
    </div>
  </body>
</html>
