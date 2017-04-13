<%@ Page Language="C#" AutoEventWireup="true" Inherits="Empiria.Land.WebApp.CertificateViewer" CodeFile="certificate.aspx.cs" %>
<!DOCTYPE html [<!ENTITY nbsp "&#160;">]>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <title>Certificado</title>
  <meta http-equiv="Expires" content="-1" />
  <meta http-equiv="Pragma" content="no-cache" />
   <meta charset="UTF-8"> 
  <link href="../themes/default/css/official.document.css" type="text/css" rel="stylesheet" />
  </head>
  <body>
    <%=GetCertificateText()%>
  </body>
</html>
