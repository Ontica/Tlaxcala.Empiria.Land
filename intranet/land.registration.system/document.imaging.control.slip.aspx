<%@ Page Language="C#" AutoEventWireup="true" Inherits="Empiria.Land.WebApp.DocumentImagingControlSlip" CodeFile="document.imaging.control.slip.aspx.cs" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <title>&#160;</title>
  <meta http-equiv="Expires" content="-1" />
  <meta http-equiv="Pragma" content="no-cache" />
  <link href="../themes/default/css/official.document.css" type="text/css" rel="stylesheet" />
  </head>
  <body style="margin: 5pt 5pt 5pt 5pt;">
    <table>
      <tr>
        <td rowspan="2" style="vertical-align:top">
          <img class="logo" src="../themes/default/customer/government.seal.png" style="padding-left:30pt;height:84pt" alt="" title="" />
        </td>
        <td style="vertical-align:top;text-align:left;width:60%">
	        <h3>DIRECCIÓN DE NOTARÍAS Y REGISTROS PÚBLICOS</h3>
          <h4>GOBIERNO DEL ESTADO DE TLAXCALA</h4>
        </td>
        <td style="text-align:right;vertical-align:top;width:40%">
          <img alt="" title="" src="../user.controls/barcode.aspx?data=<%=transaction.UID%>" />
          <br />
          Trámite: <%=transaction.UID%> <%=transaction.IsReentry ? "&#160; <b>(REINGRESO)</b>" : "" %>
        </td>
      </tr>
      <tr>
        <td><h2 style="padding-top:0;text-align:left">CONTROL DEL ACERVO DOCUMENTAL</h2></td>
        <td>
            <% if (!base.UniqueInvolvedResource.IsEmptyInstance) { %>
            <img alt="" title="" src="../user.controls/barcode.aspx?data=<%=base.UniqueInvolvedResource.UID%>" />
            <br />
            <span><b>FOLIO REAL:</b><%=base.UniqueInvolvedResource.UID%></span>
            <% } %>
        </td>
      </tr>
    </table>
    <br />
    <div style="margin-left:30pt">
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
    <div style="position: absolute; bottom:5pt;left:30pt;border-top: 1px solid black;padding-top:10pt">
      <table style="width:90%;">
        <tr>
          <td>
            <img alt="" title="" src="../user.controls/barcode.aspx?data=<%=document.UID%>" />
            <br />
            <b><%=document.UID%></b>
            <br />
            Número de documento <%=transaction.IsReentry ? "<b>(REINGRESO)</b>" : "" %>
          </td>
          <td style="text-align:center">
            <span style="font-size:22pt"><%=document.AuthorizationTime.ToString("dd/MMM/yyyy")%></span>
            <br />
            Fecha de registro <%=transaction.IsReentry ? "del <b>REINGRESO</b>" : "" %>
          </td>
          <td style="text-align:right;font-size:26px">
            <img alt="" title="" src="../user.controls/barcode.aspx?data=<%=document.ImagingControlID%>" />
            <br />
            <b><%=document.ImagingControlID%></b>
          </td>
        </tr>
      </table>
    </div>
  </body>
</html>
