<%@ Page Language="C#" AutoEventWireup="true" Inherits="Empiria.Web.UI.FSM.RecordingSeal" CodeFile="recording.seal.aspx.cs" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es-mx">
<head id="Head1" runat="server">
  <title>&nbsp;</title>
  <meta http-equiv="Expires" content="-1" />
  <meta http-equiv="Pragma" content="no-cache" />
  <link href="../themes/default/css/to.printer.css" type="text/css" rel="stylesheet" />
  <style type="text/css">
    body {
      font-size: 11pt;
      font-family: Arial, Heveltica, sans-serif;
      <%=GetLeftMargin()%>
    }
    table {
      font-size: 11pt;
      font-family: Arial, Heveltica, sans-serif;
    }
  </style>
  </head>
  <body topmargin="0" >
    <form id="frmEditor" method="post" runat="server">
      <table cellspacing="0" cellpadding="0" width="100%">
        <tr valign="top">
          <td colspan="2" align="center">
            <table width="75%">
              <tr>
                <td align="left" valign="bottom"><img src="../themes/default/customer/seal.logo.left.png" height="68pt" style="margin-bottom:16pt" alt="" title="" /></td>
                <td><img src="../themes/default/bullets/pixel.gif" height="<%=GetUpperMarginPoints()%>pt" width="98%" alt="" title="" /></td>
                <td align="right" valign="bottom"><img src="../themes/default/customer/seal.logo.right.png" height="68pt" style="margin-bottom:16pt" alt="" title="" /></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr valign="top">
          <td colspan="2">
            <%=GetPrelationText()%>
            <br /><br />
            <span>
              <%=GetRecordingsText()%>
            </span>
            <br /><br />
            <p align="justify" style="font-size:small">
              <%=GetDocumentText()%>
            </p>
            <%=GetPaymentText()%>
            <br /><br />
            <%=GetRecordingPlaceAndDate()%>
            <br />&nbsp;
          </td>
        </tr>
        <tr>
          <td align="center" colspan="2">	
            <br /><br /><br /><br /><br /><br />
            <b><%=GetRecordingSignerName()%></b>
            <br />
            <%=GetRecordingSignerPosition()%>
            <br />&nbsp;
          </td>
        </tr>
        <tr valign="top" style="font-size:8pt">
          <td style="white-space:nowrap"><b>Sello digital:  &nbsp; &nbsp;</b><br />&nbsp;</td>
          <td><%=Empiria.EmpiriaString.DivideLongString(GetDigitalSeal(), 92, "&#8203;")%></td>
        </tr>
        <tr valign="top" style="font-size:8pt">
          <td style="font-size:8pt;vertical-align:middle;white-space:nowrap"><%=GetRecordingOfficialsInitials()%></td>
          <td align="right">
            <img alt="" title="" src="../user.controls/barcode.aspx?data=<%=transaction.Document.UID%>" />
            <br />
            <span><%=transaction.Document.UID%></span>
          </td>
        </tr>
      </table>
    </form>
  </body>
</html>
