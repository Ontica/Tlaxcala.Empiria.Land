<%@ Page Language="C#" EnableViewState="true" AutoEventWireup="true" Inherits="Empiria.Land.WebApp.RecordingActEditor" CodeFile="recording.act.editor.aspx.cs" %>
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
<body style="background-color:#fafafa; top:0px; margin:0px; margin-top:-14px; margin-left:-6px;">
<form name="aspnetForm" method="post" id="aspnetForm" runat="server">
<div id="divContent">
<table id="tabStripItemView_0" style="display:inline;">
  <tr>
    <td class="subTitle">Información del acto jurídico</td>
  </tr>
  <tr>
    <td>
      <table id="tblRecordingActEditor" class="editionTable">
        <tr>
          <td>Acto jurídico:</td>
          <td class="lastCell" colspan="5">
            <input id="txtRecordingActName" type="text" class="textBox" maxlength="4" style="width:280px;margin-right:0px" readonly="readonly" runat="server" />
            &nbsp; &nbsp;
            Aplica a:
            <select id="cboProperty" class="selectBox" style="width:154px" title="" runat="server">
            </select>
          </td>
        </tr>
        <tr>
          <td class='lastCell' colspan='6'>
           <empiriaControl:RecordingActAttributesEditorControl ID="oRecordingActAttributes" runat="server" Visible="true" />
          </td>
        </tr>
        <tr>
          <td style="vertical-align:text-top">Observaciones:</td>
          <td class="lastCell" colspan="5">
            <textarea id="txtObservations" cols="320" rows="2" style="width:500px" class="textArea" runat="server"></textarea>
          </td>
        </tr>
        <tr>
          <td>Estado del acto:</td>
          <td class="lastCell" colspan="5">
            <select id="cboStatus" class="selectBox" style="width:122px;margin-top:-8px;" title="" onchange="return updateUserInterface(this);" runat="server">
              <option value="">( Seleccionar )</option>
              <option value="L">No legible</option>
              <option value="P">Pendiente</option>
              <option value="I">En proceso</option>
              <option value="R">Registrado</option>
            </select>
            <img src="../themes/default/textures/pixel.gif" height="1px" width="60px" alt="" />
            <input id="btnEditRecordingAct" type="button" value="Editar este acto jurídico" class="button" tabindex="-1" style="width:140px" onclick="doOperation('onclick_btnEditRecordingAct')" />
            <img src="../themes/default/textures/pixel.gif" height="1px" width="48px" alt="" />
            <input id="btnExitSaveRecordingAct" type="button" value="Salir de este editor" class="button" tabindex="-1" style="width:110px" onclick="doOperation('onclick_btnExitSaveRecordingAct')" />
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td class="subTitle">Personas físicas y morales involucradas en el acto jurídico</td>
  </tr>
  <tr>
    <td>
      <table class="editionTable">
      <tr>
        <td colspan="8" class="lastCell">
          <div style="overflow:auto;width:620px;">
            <table class="details" style="width:99%">
              <tr class="detailsHeader">
                <td width="90%">Nombre</td>
                <td>F. Nac / RFC</td>
                <td>Participa como</td>
                <td>Titularidad</td>
                <td>&nbsp;</td>
              </tr>
              <%=GetRecordingActPartiesGrid()%>
              <% if (base.recordingAct.Status != Empiria.Land.Registration.RecordableObjectStatus.Registered) { %>
              <tr class="selectedItem">
                <td><a href="javascript:doOperation('showRecordingActPartyEditor')">Agregar una persona u organización a este acto jurídico</a></td>
                <td colspan="5" align="right"><a href="javascript:doOperation('saveRecordingActAsComplete')">Toda la información está completa</a></td>
              </tr>
              <% } %>
            </table>
          </div>
        </td>
      </tr>
     </table>
    </td>
  </tr>
  <tr>
    <td>
      <empiriaControl:LRSRecordingPartyEditorControl ID="oPartyEditorControl" runat="server" />
    </td>
  </tr>
  <empiriaControl:LRSRecordingPartyViewerControl ID="oAntecedentParties" runat="server" />
</table>
</div>
</form>
<iframe id="ifraCalendar" style="z-index:99;left:0px;visibility:hidden;position:relative;top:0px"
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
      case 'showRecordingActPartyEditor':
        return <%=oPartyEditorControl.ClientID%>_display();
      case 'appendParty':
        return appendParty();
      case 'selectParty':
        sendPageCommand("selectParty", "partyId=" + arguments[1]);
        return;
      case 'saveParty':
        sendPageCommand("saveParty", "partyId=" + arguments[1]);
        return;
      case 'deleteParty':
        if (confirm("¿Elimino la persona u organización seleccionada de este acto jurídico?")) {
          sendPageCommand("deleteParty", "partyId=" + arguments[1]);
        }
        return;
      case 'onclick_btnEditRecordingAct':
        return onclick_btnEditRecordingAct();
      case 'onclick_btnExitSaveRecordingAct':
        return onclick_btnExitSaveRecordingAct();
      case 'saveRecordingAct':
        return saveRecordingAct();
      case 'saveRecordingActAsComplete':
        return saveRecordingActAsComplete();
      case 'savePropertyAsNoLegible':
        return savePropertyAsNoLegible();
      case 'savePropertyAsPending':
        return savePropertyAsPending();
      case 'savePropertyAsComplete':
        return savePropertyAsComplete();
      case 'setNoNumberLabel':
        getElement("txtExternalNumber").value = "Sin número";
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

  function saveRecordingAct() {
    if (!validateRecordingAct()) {
      return;
    }
    if (!checkUnknownRecordingActFields()) {
      return;
    } else {
      setUnknownRecordingActFields();
    }
    var sMsg = "Guardar la información del acto jurídico.\n\n";
    sMsg += "La siguiente operación guardará la información del siguiente acto jurídico:\n\n";
    sMsg += "Tipo:\t<%=recordingAct.RecordingActType.DisplayName%>\n";
    sMsg += "Estado:\t" + getComboOptionText(getElement("cboStatus")) + "\n\n";
    sMsg += "¿Toda la información está correcta?";
    if (confirm(sMsg)) {
      sendPageCommand("saveRecordingAct");
    }
    return false;
  }

  function saveRecordingActAsComplete() {
    var ajaxURL = "../ajax/land.registration.system.data.aspx";
    ajaxURL += "?commandName=validateRecordingActAsCompleteCmd";
    ajaxURL += "&recordingActId=<%=recordingAct.Id%>";

    if (!invokeAjaxValidator(ajaxURL)) {
      return;
    }
    var sMsg = "Cerrar el acto jurídico.\n\n";
    sMsg += "Esta operación marcará el acto jurídico como registrado,\n";
    sMsg += "por lo que debe revisarse que toda la información del\n";
    sMsg += "mismo esté correcta y sea completa.\n\n";

    sMsg += "¿Marco este acto jurídico como completado?";

    if (confirm(sMsg)) {
      sendPageCommand("saveRecordingActAsComplete");
      return;
    }
  }

  function validateRecordingAct() {
    if (getElement('cboStatus').value.length == 0) {
      alert("Requiero se proporcione el estado del acto jurídico.");
      return false;
    }
    return <%=oRecordingActAttributes.ClientID%>_validate();
  }

  function checkUnknownRecordingActFields() {
    return true;
  }

  function setUnknownRecordingActFields() {

  }

  function onclick_btnEditRecordingAct() {
    if (gbRecordingActEditorDisabled) {
      disableRecordingActEditor(false);
    } else {
      window.location.reload(false);
      return false;
    }
  }

  function onclick_btnExitSaveRecordingAct() {
    if (gbRecordingActEditorDisabled) {
      window.parent.execScript("doOperation('refreshRecording')");
      return;
    } else {
      return doOperation("saveRecordingAct");
    }
  }

  function disableRecordingActEditor(disabled) {
    disableControls(getElement("tblRecordingActEditor"), disabled);
    getElement("btnEditRecordingAct").disabled = false;
    getElement("btnExitSaveRecordingAct").disabled = false;
    gbRecordingActEditorDisabled = disabled;

    if (disabled) {
      getElement("btnEditRecordingAct").value = "Editar este acto jurídico";
      getElement("btnExitSaveRecordingAct").value = "Salir de este editor";
    } else {
      getElement("btnEditRecordingAct").value = "Descartar los cambios";
      getElement("btnExitSaveRecordingAct").value = "Guardar los cambios";
      if (getElement("cboStatus").value == 'R') {
        getElement("cboStatus").value = 'I';
      }
    }
    getElement("cboProperty").disabled = false;
  }

  function appendParty() {
    if (<%=oPartyEditorControl.ClientID%>_validate()) {
      sendPageCommand("appendParty");
    }
  }

  function updateUserInterface(oControl) {
    if (oControl == null) {
      return;
    }
    if (oControl == getElement("cboStatus")) {
      if (getElement("cboStatus").value == "R") {
        getElement("cboStatus").value = "";
      }
    }
  }

  var gbRecordingActEditorDisabled = true;
  disableRecordingActEditor(true);

  </script>
</html>
