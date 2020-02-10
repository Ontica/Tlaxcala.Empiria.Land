<%@ Page Language="C#" AutoEventWireup="true" Inherits="Empiria.Land.WebApp.ExternalTransactionHandler" Codebehind="external.transaction.handler.aspx.cs" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>Devolución de trámites</title>
  <meta http-equiv="Expires" content="-1" />
  <meta http-equiv="Pragma" content="no-cache" />
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <link href="../themes/default/css/secondary.master.page.css" type="text/css" rel="stylesheet" />
  <link href="../themes/default/css/editor.css" type="text/css" rel="stylesheet" />
  <script type="text/javascript" src="../scripts/empiria.ajax.js"></script>
  <script type="text/javascript" src="../scripts/empiria.general.js"></script>
  <script type="text/javascript" src="../scripts/empiria.secondary.master.page.js"></script>
  <script type="text/javascript" src="../scripts/empiria.validation.js"></script>
</head>
<body style="background-color:#fafafa; top:0; margin:0; margin-top:-14px; margin-left:-6px;">
  <form name="aspnetForm" method="post" id="aspnetForm" runat="server">
  <div id="divContentAlwaysVisible">

    <table id="tabStripItemView_0" style="display:inline;">
      <tr>
        <td>
          <%=htmlForm%>
        </td>
      </tr>
    </table>

  </div>
  </form>
</body>

<script type="text/javascript">

  function doOperation(command) {
    var success = false;

    if (gbSended) {
      return;
    }
    switch (command) {

      default:
        alert("La operación '" + command + "' no ha sido definida en el programa.");
        return;
    }
    if (success) {
      sendPageCommand(command);
      gbSended = true;
    }
  }

  function refresh() {
    window.location.reload();
  }

  function updateUserInterface(oControl) {
    if (oControl == null) {
      return;
    }
  }

  function window_onload() {
    <%=base.OnLoadScript%>
  }

  function window_onunload() {

  }

  addEvent(window, 'load', window_onload);
  addEvent(window, 'unload', window_onunload);

</script>
</html>
