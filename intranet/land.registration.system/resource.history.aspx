<%@ Page Language="C#" EnableViewState="true" AutoEventWireup="true" Inherits="Empiria.Land.WebApp.ResourceHistory" CodeFile="resource.history.aspx.cs" %>
<%@ Register tagprefix="empiriaControl" tagname="ModalWindow" src="../land.registration.system.controls/modal.window.ascx" %>
<%@ OutputCache Location="None" NoStore="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es-mx">
<head runat="server">
  <title></title>
  <meta http-equiv="Expires" content="-1" />
  <meta http-equiv="Pragma" content="no-cache" />
  <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
  <link href="../themes/default/css/secondary.master.page.css" type="text/css" rel="stylesheet" />
  <link href="../themes/default/css/editor.css" type="text/css" rel="stylesheet" />
  <script type="text/javascript" src="../scripts/empiria.ajax.js"></script>
  <script type="text/javascript" src="../scripts/empiria.general.js"></script>
  <script type="text/javascript" src="../scripts/empiria.secondary.master.page.js"></script>
</head>
<body style="background-color:#fafafa; top:0; margin:0; margin-top:-14px; margin-left:-6px;">
<form name="aspnetForm" method="post" id="aspnetForm" runat="server">
<div id="divContentAlwaysVisible">
<table id="tabStripItemView_0" style="display:inline;">
  <tr>
    <td>
      <table class="editionTable">
        <tr>
          <td class="lastCell">
            <div style="overflow:auto;max-height:880px;">
              <%=GetHistoryGrid()%>
            </div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</div>
<empiriaControl:ModalWindow id="oModalWindow" runat="server" width="820px" height="600px" />
</form>
</body>
<script type="text/javascript">

  function doOperation(command) {
    var success = false;

    if (gbSended) {
      return;
    }
    switch (command) {
      case 'onSelectDocument':
        onSelectDocument(arguments[1], arguments[2]);
        return;
      case 'onSelectCertificate':
        onSelectCertificate(arguments[1]);
        return;
      case 'onSelectRecordingAct':
        onSelectRecordingAct(arguments[1], arguments[2]);
        return;
      case 'onSelectImageSet':
        onSelectImageSet(arguments[1]);
        return;
      case 'displayResourcePopupWindow':
        displayResourcePopupWindow(arguments[1]);
        return;
      default:
        alert("La operación '" + command + "' no ha sido definida en el programa.");
        return;
    }
    if (success) {
      sendPageCommand(command);
      gbSended = true;
    }
  }

  function onSelectImageSet(imageSetId) {
    window.parent.execScript("doOperation('onSelectImageSet', " + imageSetId + ")");
  }

  function onSelectDocument(documentId, recordingActId) {
    window.parent.execScript("doOperation('onSelectDocument', " + documentId + ", " + recordingActId + ")");
  }

  function onSelectCertificate(certificateId) {
    window.parent.execScript("doOperation('onSelectCertificate', " + certificateId + ")");
  }

  function onSelectRecordingAct(documentId, recordingActId) {
    window.parent.execScript("doOperation('onSelectRecordingAct', " + documentId + ", " + recordingActId + ")");
  }

  function displayResourcePopupWindow(resourceId) {
    var html = getResourceHistoryGridHtml(resourceId);

    <%=oModalWindow.ClientID%>_show("Historia del predio", html);
  }

  function getResourceHistoryGridHtml(resourceId) {
    var url = "../ajax/land.ui.controls.aspx";
    url += "?commandName=getResourceHistoryGridCmd";
    url += "&selectedDocumentId=<%=base.selectedRecordingAct.Document.Id%>&resourceId=" + resourceId;

    return invokeAjaxMethod(false, url, null);
  }

  function window_onload() {
    <%=base.OnLoadScript%>
  }

  addEvent(window, 'load', window_onload);

</script>
</html>
