<%@ Control Language="C#" AutoEventWireup="false" Inherits="Empiria.Web.UI.LRS.LRSRecordingActSelectorControl" CodeFile="recording.act.selector.control.ascx.cs" %>
<table id="<%=this.ClientID%>_tblRecordingActEditor" class="editionTable" style="display:none;">
  <tr>
    <td>Categoría:</td>
    <td colspan="6">
      <select id="cboRecordingActTypeCategory" name="cboRecordingActTypeCategory" class="selectBox" style="width:302px" title="" runat='server'>
      </select>
      &nbsp;Predio:&nbsp;
      <select id="cboProperty" class="selectBox" style="width:172px" title="" runat='server'>
        <option value="0">Nuevo predio</option>
        <option value="-1">Predio ya inscrito</option>
      </select>
    </td>
    <td class="lastCell">&nbsp;</td>
  </tr>
  <tr>
    <td>Acto jurídico:</td>
    <td colspan="6">
      <select id="cboRecordingActType" class="selectBox" style="width:528px" title="" onchange="return <%=this.ClientID%>_updateUserInterface(this);">
        <option value="">( Primero seleccionar la categoría del acto jurídico )</option>
      </select>
    </td>
  </tr>
  <tr id="<%=this.ClientID%>_divRegisteredPropertiesSection" style="display:none">
    <td>Libro registral:<br /><br />&nbsp;</td>
    <td colspan="6">
      <select id="cboAnotherRecorderOffice" class="selectBox" style="width:174px" title="" runat='server'>
      </select>
      <select id="cboAnotherRecordingBook" class="selectBox" style="width:345px" title="" runat='server'>
      </select>
      <br /><br />
      Inscripción:
      <select id="cboAnotherRecording" class="selectBox" style="width:116px" title="" runat='server'>
      </select>
      <img src="../themes/default/buttons/search.gif" alt="" title="Ejecuta la búsqueda" style="margin-left:-8px" onclick="<%=this.ClientID%>_doOperation('showRecording')" />
      &nbsp; &nbsp; &nbsp; &nbsp;Folio del predio:&nbsp;
      <select id="cboAnotherProperty" class="selectBox" style="width:202px" title="" runat='server'>
      </select>
      <img src="../themes/default/buttons/search.gif" alt="" title="Ejecuta la búsqueda" style="margin-left:-8px" onclick="<%=this.ClientID%>_doOperation('showRecording')" />
    </td>
    <td class="lastCell">&nbsp;</td>
  </tr>
  <tr>
    <td>Importe del avalúo:&nbsp;</td>
    <td colspan="6" class="lastCell">
      <input id="txtAppraisalAmount" type="text" class="textBox" style="width:90px;"
              onkeypress="return positiveKeyFilter(this);" onblur='this_formatAsNumber(this);'
              title="" maxlength="18" runat="server" />
      <select id="cboAppraisalCurrency" class="selectBox" style="width:52px;margin-left:-6px" runat="server">
        <option value="600" title="Pesos mexicanos">MXN</option>
        <option value="602" title="Unidades de inversión">UDIS</option>
      </select>
      &nbsp; &nbsp; &nbsp;&nbsp;
      Importe de la operación:
      <input id="txtOperationAmount" type="text" class="textBox" style="width:90px;" onblur='this_formatAsNumber(this, 4);'
                onkeypress="return positiveKeyFilter(this);" title="" maxlength="18" runat="server" />
      <select id="cboOperationCurrency" class="selectBox" style="width:52px;margin-left:-6px" runat="server">
        <option value="600" title="Pesos mexicanos">MXN</option>
        <option value="602" title="Unidades de inversión">UDIS</option>
        <option value="603" title="Salarios mínimos">SM</option>
        <option value="601" title="Dólares americanos">USD</option>
      </select>
      <input type="button" value="Igualar" class="button" tabindex="-1" style="width:60px;vertical-align:middle"
             onclick="javascript:equateValues('<%=txtAppraisalAmount.ClientID%>', '<%=txtOperationAmount.ClientID%>');equateValues('<%=cboAppraisalCurrency.ClientID%>', '<%=cboOperationCurrency.ClientID%>')" />
    </td>
  </tr>
  <tr style="height:35px;vertical-align:bottom">
    <td>&nbsp;</td>
    <td class="lastCell" colspan="6">
      <img src="../themes/default/textures/pixel.gif" height="1px" width="350px" alt="" />
      <input type="button" value="Agregar el acto jurídico a la lista" class="button" style="height:28px;width:174px" onclick="<%=this.ClientID%>_doOperation('appendRecordingAct')" />
    </td>
  </tr>
</table>
<script type="text/javascript">
/* <![CDATA[ */

  var <%=this.ClientID%>_gbSended = false;

  function <%=this.ClientID%>_doOperation(command) {
   if (<%=this.ClientID%>_gbSended) {
      return;
    }
    switch (command) {
      case 'showRecording':
        return <%=this.ClientID%>_showRecording();
      case 'appendRecordingAct':
        return <%=this.ClientID%>_appendRecordingAct();
      default:
        alert("La operación '" + command + "' no ha sido definida en el programa.");
        return;
    }
  }

  function this_formatAsNumber(oControl) {
    if (oControl.value.length == 0) {
      return;
    }
    if (arguments[1] != null) {
      oControl.value = formatAsNumber(oControl.value, arguments[1]);
    } else {
      oControl.value = formatAsNumber(oControl.value);
    }
  }

  function <%=this.ClientID%>_showRecording() {
    var recordingBookId = getElement('<%=cboAnotherRecordingBook.ClientID%>').value;
    var recordingId = getElement('<%=cboAnotherRecording.ClientID%>').value;

    if (recordingBookId.length == 0) {
      alert("Requiero se seleccione el libro registral que se desea consultar.");
      return;
    }
    var url = "recording.book.analyzer.aspx?"
    url += "bookId=" + recordingBookId + "&id=" + recordingId;

    createNewWindow(url);
  }

  function <%=this.ClientID%>_appendRecordingAct() {
    if (getElement('cboRecordingActType').value == '') {
      alert("Necesito se seleccione de la lista el tipo de acto jurídico.");
      return false;
    }
    if (getElement('<%=cboProperty.ClientID%>').value == '') {
      alert("Necesito se seleccione de la lista el predio sobre el que aplicará el acto jurídico.");
      return false;
    }
    if (getElement('<%=cboProperty.ClientID%>').value == '-1' && getElement('<%=cboAnotherProperty.ClientID%>').value == "") {
      alert("Necesito se seleccione de la lista el predio ya registrado o inscrito sobre el que aplicará el acto jurídico.");
      return false;
    }
   if (getElement('<%=cboAppraisalCurrency.ClientID%>').value.length == 0) {
      alert("Requiero la moneda del importe del avalúo.");
      return false;
    }
    if (Number(getElement('<%=cboAppraisalCurrency.ClientID%>').value) < 0 &&
        getElement('<%=txtAppraisalAmount.ClientID%>').value.length != 0) {
      alert("Se seleccionó 'No consta' como moneda pero el importe del avalúo sí se proporcionó.");
      return false;
    }
    if (Number(getElement('<%=cboAppraisalCurrency.ClientID%>').value) > 0 &&
        getElement('<%=txtAppraisalAmount.ClientID%>').value.length == 0) {
      alert("Requiero el importe del avalúo.");
      return false;
    }
    if (getElement('<%=cboOperationCurrency.ClientID%>').value.length == 0) {
      alert("Requiero la moneda del importe de la operación.");
      return false;
    }
    if (Number(getElement('<%=cboOperationCurrency.ClientID%>').value) < 0 &&
        getElement('<%=txtOperationAmount.ClientID%>').value.length != 0) {
      alert("Se seleccionó 'No consta' como moneda pero el importe de la operación sí se proporcionó.");
      return false;
    }
    if (Number(getElement('<%=cboOperationCurrency.ClientID%>').value) > 0 &&
        getElement('<%=txtOperationAmount.ClientID%>').value.length == 0) {
      alert("Requiero el importe de la operación.");
      return false;
    }

    var sMsg = "Agregar un acto jurídico\n\n";

    sMsg += "Esta operación agregará el siguiente acto jurídico al trámite de inscripción:\n\n";

    sMsg += "Acto jurídico:\t" + getComboOptionText(getElement('cboRecordingActType')) + "\n";
    sMsg += "Predio:\t\t" + getComboOptionText(getElement('<%=cboProperty.ClientID%>')) + "\n";	
    if (getElement('<%=cboProperty.ClientID%>').value == "-1") {
      sMsg += "Folio:\t\t" + getComboOptionText(getElement('<%=cboAnotherProperty.ClientID%>')) + "\n";
    }
    sMsg += "Avalúo:\t\t$" + getElement('<%=txtAppraisalAmount.ClientID%>').value + " " + getComboOptionText(getElement('<%=cboAppraisalCurrency.ClientID%>')) + "\n";	
    sMsg += "Operación:\t$" + getElement('<%=txtOperationAmount.ClientID%>').value + " " + getComboOptionText(getElement('<%=cboOperationCurrency.ClientID%>')) + "\n\n";	

    sMsg += "¿Agrego el acto jurídico a este trámite de inscripción?";
    if (confirm(sMsg)) {
      var pars = "id=" + getElement('cboRecordingActType').value + "|";
      pars += "propertyId=" + <%=this.ClientID%>_getSelectedPropertyId();

      sendPageCommand("appendRecordingAct", pars);
      return true;
    }
    return false;
  }

  function <%=this.ClientID%>_getSelectedPropertyId() {
    if (getElement('<%=cboProperty.ClientID%>').value == "-1") {
      return getElement('<%=cboAnotherProperty.ClientID%>').value;
    } else {
      return getElement('<%=cboProperty.ClientID%>').value;
    }
  }

  function <%=this.ClientID%>_updateUserInterface(oControl) {
    if (oControl == null) {
      return;
    }
    if (oControl == getElement('<%=cboRecordingActTypeCategory.ClientID%>')) {
      <%=this.ClientID%>_resetRecordingsTypesCombo();
    } else if (oControl == getElement('<%=cboProperty.ClientID%>')) {
      <%=this.ClientID%>_showRegisteredPropertiesSection();
    } else if (oControl == getElement('<%=cboAnotherRecorderOffice.ClientID%>')) {
      <%=this.ClientID%>_resetAnotherRecordingBooksCombo();
    } else if (oControl == getElement('<%=cboAnotherRecordingBook.ClientID%>')) {
      <%=this.ClientID%>_resetAnotherRecordingsCombo();
    } else if (oControl == getElement('<%=cboAnotherRecording.ClientID%>')) {
      <%=this.ClientID%>_resetAnotherPropertiesCombo();
    }
  }

 function <%=this.ClientID%>_resetAnotherRecordingBooksCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getRecordingBooksStringArrayCmd";
    if (getElement('<%=cboAnotherRecorderOffice.ClientID%>').value.length != 0) {
      url += "&recorderOfficeId=" + getElement('<%=cboAnotherRecorderOffice.ClientID%>').value;
    } else {
      url += "&recorderOfficeId=0";
    }
    url += "&recordingActTypeCategoryId=1051";

    invokeAjaxComboItemsLoader(url, getElement('<%=cboAnotherRecordingBook.ClientID%>'));

    <%=this.ClientID%>_resetAnotherRecordingsCombo();
  }

  function <%=this.ClientID%>_resetAnotherRecordingsCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getRecordingNumbersStringArrayCmd";
    if (getElement('<%=cboAnotherRecordingBook.ClientID%>').value.length != 0) {
      url += "&recordingBookId=" + getElement('<%=cboAnotherRecordingBook.ClientID%>').value;
    } else {
      url += "&recordingBookId=0";
    }
    invokeAjaxComboItemsLoader(url, getElement('<%=cboAnotherRecording.ClientID%>'));
    <%=this.ClientID%>_resetAnotherPropertiesCombo();
  }

  function <%=this.ClientID%>_resetAnotherPropertiesCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getRecordingPropertiesArrayCmd";
    if (getElement('<%=cboAnotherRecording.ClientID%>').value.length != 0) {
      url += "&recordingId=" + getElement('<%=cboAnotherRecording.ClientID%>').value;
    } else {
      url += "&recordingId=0";
    }
    invokeAjaxComboItemsLoader(url, getElement('<%=cboAnotherProperty.ClientID%>'));
  }

  function <%=this.ClientID%>_showRegisteredPropertiesSection() {
    if (getElement('<%=cboProperty.ClientID%>').value == "-1") {
      getElement("<%=this.ClientID%>_divRegisteredPropertiesSection").style.display = "inline";
    } else {
      getElement("<%=this.ClientID%>_divRegisteredPropertiesSection").style.display = "none";
    }
  }

  function <%=this.ClientID%>_resetRecordingsTypesCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getRecordingTypesStringArrayCmd";
    url += "&recordingActTypeCategoryId=" + getElement("<%=cboRecordingActTypeCategory.ClientID%>").value;
    invokeAjaxComboItemsLoader(url, getElement('cboRecordingActType'));
  }

  function <%=this.ClientID%>_validate() {
    var sMsg = '';
    var oCurrency = getElement('<%=cboProperty.ClientID%>');
    var oPayment = getElement('<%=cboAnotherProperty.ClientID%>');
    var oReceipt = getElement('cboRecordingActType');

    if (oCurrency.value.length == 0) {
      sMsg  = "Validación del pago de derechos.\n\n";
      sMsg += "No se ha seleccionado la moneda del pago de derechos.";
      alert(sMsg);
      return false;
    }
    return true;
  }

/* ]]> */
</script>
