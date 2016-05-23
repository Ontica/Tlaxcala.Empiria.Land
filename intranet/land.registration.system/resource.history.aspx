<%@ Page Language="C#" EnableViewState="true" AutoEventWireup="true" Inherits="Empiria.Land.WebApp.ResourceHistory" CodeFile="resource.history.aspx.cs" %>
<%@ OutputCache Location="None" NoStore="true" %>
<%@ Register tagprefix="empiriaControl" tagname="RecordingActAttributesEditorControl" src="../land.registration.system.controls/recording.act.attributes.editor.control.ascx" %>
<%@ Register tagprefix="empiriaControl" tagname="LRSRecordingPartyEditorControl" src="../land.registration.system.controls/recording.party.editor.control.ascx" %>
<%@ Register tagprefix="empiriaControl" tagname="LRSRecordingPartyViewerControl" src="../land.registration.system.controls/recording.party.viewer.control.ascx" %>
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
  <script type="text/javascript" src="../scripts/empiria.validation.js"></script>
  <script type="text/javascript" src="../scripts/empiria.calendar.js"></script>
</head>
<body style="background-color:#fafafa; top:0; margin:0; margin-top:-14px; margin-left:-6px;">
<form name="aspnetForm" method="post" id="aspnetForm" runat="server">
<div id="divContentAlwaysVisible">
<table id="tabStripItemView_0" style="display:inline;">
  <tr>
    <td class="subTitle">Historia del predio <%=resource.UID%></td>
  </tr>
  <tr>
    <td>
      <table class="editionTable">
        <tr>
          <td class="lastCell">
            <div style="overflow:auto;max-height:880px;">
              <table class="details" style="width:95%">
                <tr class="detailsHeader">
                  <td>Presentado el</td>
                  <td style='width:160px'>Acto jurídico</td>
                  <td style='white-space:nowrap'>Antecedente / Fracción</td>
                  <td style='width:200px'>Registrado en</td>
                  <td style='width:160px'>Registró</td>
                </tr>
                <%=GetHistoryGrid()%>
              </table>
            </div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</div>
</form>
<div><span id="span" runat="server"></span></div>
<iframe id="ifraCalendar" style="z-index:99;left:0;visibility:hidden;position:relative;top:0"
    marginheight="0" marginwidth="0" frameborder="0" scrolling="no" src="../user.controls/calendar.aspx" width="100%">
</iframe>
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
      case 'onSelectRecordingAct':
        onSelectRecordingAct(arguments[1], arguments[2]);
        return;
       case 'closeWindow':
        window.parent.execScript("doOperation('refreshRecording')");
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

  function onSelectDocument(documentId, recordingActId) {
    window.parent.execScript("doOperation('onSelectDocument', " + documentId + ", " + recordingActId + ")");
  }

  function onSelectRecordingAct(documentId, recordingActId) {
    window.parent.execScript("doOperation('onSelectRecordingAct', " + documentId + ", " + recordingActId + ")");
  }

  function window_onload() {
    <%=base.OnLoadScript%>
  }

  addEvent(window, 'load', window_onload);

</script>
</html>
