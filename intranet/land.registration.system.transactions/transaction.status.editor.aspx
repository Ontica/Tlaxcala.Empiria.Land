<%@ Page Language="C#" AutoEventWireup="true" Inherits="Empiria.Land.WebApp.TransactionStatusEditor" Codebehind="transaction.status.editor.aspx.cs" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>Estado del trámite</title>
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

    <table id="tabStripItemView_0" style="display:inline;width:100%">
      <tr>
        <td class="subTitle">Historia del trámite</td>
      </tr>
      <tr>
        <td>
          <div style="overflow:auto;width:100%;">
            <table class="details" style="width:97%">
              <tr class="detailsHeader">
                <td>Tipo de movimiento</td>
                <td>Responsable</td>
                <td>Recibido</td>
                <td>Terminado</td>
                <td>Entregado</td>
                <td>Trabajo</td>
                <td>Estado</td>
                <td style='width:40%'>Observaciones</td>
              </tr>
              <%=GetTransactionTrack()%>
            </table>
          </div>
          <br />
          <br />
          <% if (transaction.Workflow.CurrentStatus == Empiria.Land.Registration.Transactions.LRSTransactionStatus.Deleted) { %>
          <input id="cmdUndelete" class="button" type="button" value="Reactivar" onclick="doOperation('undelete')" style="height:28px;width:110px" runat="server" />
          <% } %>

          <% if (base.IsTransactionReadyForTakeInDeliveryDesk()) { %>

            <input id="cmdTakeTransaction" class="button" type="button" value="Recibir documentos del trámite para su entrega o devolución"
                   onclick="doOperation('takeTransactionInDeliveryDesk')" style="height:28px;width:380px" runat="server" />


          <% }  else if (base.IsTransactionReadyForDelivery()) { %>

             <input id="cmdDeliverTransaction" class="button" type="button" value="Entregar este trámite al interesado"
                    onclick="doOperation('deliverTransaction')" style="height:28px;width:180px" runat="server" />

          <%  } else if (base.IsTransactionReadyForReturn()) { %>

             <input id="cmdReturnTransaction" class="button" type="button" value="Devolver este trámite al interesado"
                    onclick="doOperation('returnTransaction')" style="height:28px;width:180px" runat="server" />

          <%  } else if (base.IsTransactionReadyForReentry()) { %>

             <input class="button" type="button" value="Reingresar este trámite"
                    onclick="doOperation('reentryTransaction')" style="height:28px;width:180px" runat="server" />

          <%  } %>

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
      case "takeTransactionInDeliveryDesk":
        takeTransactionInDeliveryDesk();
        return;

      case "deliverTransaction":
        deliverTransaction();
        return;

      case "returnTransaction":
        returnTransaction();
        return;

      case 'reentryTransaction':
        return reentryTransaction();

      default:
        alert("La operación '" + command + "' no ha sido definida en el programa.");
        return;
    }
    if (success) {
      sendPageCommand(command);
      gbSended = true;
    }
  }


  function takeTransactionInDeliveryDesk() {
    var sMsg = "Recibir documentación en ventanilla de entregas.\n\n";

    sMsg += "¿Está recibiendo la documentación de este trámite para su entrega o devolución al interesado?";

    if (confirm(sMsg)) {
      sendPageCommand("takeTransactionInDeliveryDesk", "notes=");
    }

  }


  function deliverTransaction() {
    var sMsg = "Entregar el trámite al interesado.\n\n";

    sMsg += "Por favor, recuerde informarle al interesado revise con cuidado sus sellos registrales y documentos.\n\n";

    sMsg += "¿Se va a entregar este trámite al interesado?";

    if (confirm(sMsg)) {
      sendPageCommand("deliverTransaction", "notes=");
    }
  }


  function returnTransaction() {
    var sMsg = "Devolver el trámite al interesado.\n\n";

    sMsg += "¿Se va a devolver este trámite al interesado?";

    if (confirm(sMsg)) {
      sendPageCommand("returnTransaction", "notes=");
    }
  }


  function reentryTransaction() {
    var sMsg = "Reingreso de trámites.\n\n";

    sMsg += "Esta operación reinigresará este trámite y lo enviará al distrito o mesa de trabajo correspondiente.\n\n";
    sMsg += "¿Reingreso este trámite";
    if (confirm(sMsg)) {
      sendPageCommand("reentryTransaction");
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
