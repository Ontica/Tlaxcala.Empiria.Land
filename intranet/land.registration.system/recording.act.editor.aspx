<%@ Page Language="C#" EnableViewState="true" AutoEventWireup="true" Inherits="Empiria.Land.WebApp.RecordingActEditor" CodeFile="recording.act.editor.aspx.cs" %>
<%@ OutputCache Location="None" NoStore="true" %>
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
</head>
<body style="background-color:#fafafa; top:0; margin:0; margin-top:-14px; margin-left:-6px;">
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
              <td class="lastCell" colspan="3">
                <input id="txtRecordingActName" type="text" class="textBox" style="width:294px;margin-right:0" readonly="readonly" runat="server" />
               &#160;Folio real:
                <input id="txtProperty" type="text" class="textBox" style="width:132px;margin-right:0" readonly="readonly" runat="server" />
              </td>
            </tr>
            <tr style="display:<%= base.EditOperationAmount ? "inline" : "none" %>">
              <td>
                Monto de la operación:
              </td>
              <td class="lastCell" colspan="3">
                <input id="txtOperationAmount" type="text" class="textBox" style="width:90px;" onblur='this_formatAsNumber(this, 4);'
                       onkeypress="return positiveKeyFilter(this);" title="" maxlength="18" runat="server" />
                <select id="cboOperationCurrency" class="selectBox" style="width:52px;margin-left:-6px" runat="server">
                  <option value="">(?)</option>
                  <option value="600" title="Pesos mexicanos">MXN</option>
                  <option value="602" title="Unidades de inversión">UDIS</option>
                  <option value="603" title="Salarios mínimos">SM</option>
                  <option value="601" title="Dólares americanos">USD</option>
                  <option value="-2" title="No consta">N/C</option>
                </select>
                <% if (base.EditAppraisalAmount) { %>
                Avalúo:
                <input id="txtAppraisalAmount" type="text" class="textBox" style="width:90px;"
                        onkeypress="return positiveKeyFilter(this);" onblur='this_formatAsNumber(this);'
                        title="" maxlength="18" runat="server" />
                <select id="cboAppraisalCurrency" class="selectBox" style="width:52px;margin-left:-6px" runat="server">
                  <option value="">(?)</option>
                  <option value="600" title="Pesos mexicanos">MXN</option>
                  <option value="602" title="Unidades de inversión">UDIS</option>
                  <option value="-2" title="No consta">N/C</option>
                </select>
                <% } %>
              </td>
            </tr>
            <tr>
              <td style="vertical-align:text-top">Observaciones:</td>
              <td class="lastCell" colspan="3">
                <textarea id="txtObservations" cols="320" rows="2" style="width:440px" class="textArea" runat="server"></textarea>
              </td>
            </tr>
            <tr>
              <td>&#160;</td>
              <td class="lastCell" colspan="5">
                <input id="btnEditRecordingAct" type="button" value="Editar este acto jurídico" class="button" tabindex="-1" style="width:140px" onclick="doOperation('onclick_btnEditRecordingAct')" />
                <img src="../themes/default/textures/pixel.gif" height="1px" width="98px" alt="" />
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
                <div style="overflow-y:auto;width:620px;">
                  <table class="details" style="width:99%">
                    <tr class="detailsHeader">
                      <td width="85%">Nombre</td>
                      <td>Identificación</td>
                      <td>Participa como</td>
                      <td>Titularidad</td>
                      <td>&#160;</td>
                    </tr>
                    <%=GetRecordingActPartiesGrid()%>
                    <% if (base.IsReadyForEdition()) { %>
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
      <% if (oAntecedentParties.Visible) { %>
      <tr>
        <td class="subTitle">Propietarios anteriores del predio</td>
      </tr>
      <% } %>
      <empiriaControl:LRSRecordingPartyViewerControl ID="oAntecedentParties" runat="server" />
      </table>

  </div> <!-- divContent !-->

</form>
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
            window.parent.eval("doOperation('refreshRecording')");
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
    <% if (base.EditOperationAmount) { %>
    if (getElement('cboOperationCurrency').value.length == 0) {
      alert("Requiero la moneda del importe de la operación.");
      return false;
    }
    if (Number(getElement('cboOperationCurrency').value) < 0 &&
        getElement('<%=txtOperationAmount.ClientID%>').value.length != 0) {
      alert("Se seleccionó 'No consta' como moneda pero el importe de la operación sí se proporcionó.");
      return false;
    }
    if (Number(getElement('cboOperationCurrency').value) > 0 &&
        getElement('txtOperationAmount').value.length == 0) {
      alert("Requiero el importe de la operación.");
      return false;
    }
    <% } %>
    <% if (base.EditAppraisalAmount) { %>
    if (getElement('cboAppraisalCurrency').value.length == 0) {
      alert("Requiero la moneda del importe del avalúo.");
      return false;
    }
    if (Number(getElement('cboAppraisalCurrency').value) < 0 &&
        getElement('txtAppraisalAmount').value.length != 0) {
      alert("Se seleccionó 'No consta' como moneda pero el importe del avalúo sí se proporcionó.");
      return false;
    }
    if (Number(getElement('cboAppraisalCurrency').value) > 0 &&
        getElement('txtAppraisalAmount').value.length == 0) {
      alert("Requiero el importe del avalúo.");
      return false;
    }
    <% } %>
    return true;
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
        window.parent.eval("doOperation('refreshRecording')");
      return;
    } else {
      return doOperation("saveRecordingAct");
    }
  }

  function disableRecordingActEditor(disabled) {
    disableControls(getElement("tblRecordingActEditor"), disabled);
    gbRecordingActEditorDisabled = disabled;

    <% if (base.IsReadyForEdition()) { %>
    getElement("btnEditRecordingAct").disabled = false;
    getElement("btnExitSaveRecordingAct").disabled = false;
    <% } %>
    if (disabled) {
      getElement("btnEditRecordingAct").value = "Editar este acto jurídico";
      getElement("btnExitSaveRecordingAct").value = "Salir de este editor";
    } else {
      getElement("btnEditRecordingAct").value = "Descartar los cambios";
      getElement("btnExitSaveRecordingAct").value = "Guardar los cambios";
    }
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
  }

  var gbRecordingActEditorDisabled = true;
  disableRecordingActEditor(true);

  </script>
</html>
