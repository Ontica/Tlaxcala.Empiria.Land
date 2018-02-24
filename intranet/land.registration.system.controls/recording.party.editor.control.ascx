<%@ Control Language="C#" AutoEventWireup="false" Inherits="Empiria.Land.WebApp.RecordingPartyEditorControl" Codebehind="recording.party.editor.control.ascx.cs" %>
<table id="tblPartySeacher" class="editionTable" style="margin-top:-12px;display:none;" runat="server">
  <tr>
    <td>
      <table class="editionTable">
        <tr>
          <td style="width:125px">Buscar:</td>
          <td class="lastCell">
            <input id='txtSearchParty' type="text" class="textBox" style="width:212px;margin-right:0;" maxlength="64" onkeypress="this_onSearchTextBoxKeyFilter(this)" runat="server" />
            &nbsp;
            <img src="../themes/default/buttons/search.gif" alt="" title="Ejecuta la búsqueda" style="margin-left:-4px" onclick="this_searchParties()" />
            <select id="cboPartyType" class="selectBox" style="width:118px" title="" onchange="return this_updateUserInterface(this);" runat="server">
              <option value="0">( Todas )</option>
              <option value="2435">Personas</option>
              <option value="2436">Organizaciones</option>
              <option value="2438">» Empresas/Asoc</option>
              <option value="2437">» Sector público</option>
              <option value="2439">» Inst. Financiera</option>
            </select>
            Filtrar:
            <!--onchange="return this_updateUserInterface(this);" !-->
            <select id="cboPartyFilter" class="selectBox" style="width:138px" title="" runat="server">
              <option value="ByKeywords">Según búsqueda</option>
              <option value="ResourceRelated">Relativas al predio</option>
              <option value="LastRecorded">Últimas registradas</option>
            </select>
          </td>
        </tr>
        <tr>
          <td>Seleccionar:</td>
          <td class="lastCell">
            <select id="cboParty" class="selectBox" style="width:474px" title="" onchange="return this_updateUserInterface(this);" runat="server">
              <option value="">( No se ha efectuado ninguna búsqueda de personas u organizaciones )</option>
            </select>
            <input id="cmdEditParty" type="button" value="Editar" disabled="disabled" class="button" tabindex="-1" style="width:64px; vertical-align:middle " onclick="return this_setPartyControlsForEdition(true)" />
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table id="tblHumanPartyEditor" class="editionTable" style="display:none;margin-top:-12px" runat='server'>
  <tr>
    <td>Nombre completo:</td>
    <td class="lastCell" colspan="5">
      <input id='txtPersonFullName' type="text" class="textBox" style="width: 438px;margin-right:0;" maxlength="255" runat='server' />
    </td>
  </tr>
  <tr>
    <td>Identificación</td>
    <td class="lastCell" colspan="5">
      <select id="cboIDNumberType" class="selectBox" style="width:80px" title="" onchange="return this_updateUserInterface(this);" runat="server">
        <option value="">( ? )</option>
        <option value="CURP">CURP</option>
        <option value="RFC">RFC</option>
        <option value="IFE">IFE</option>
        <option value="Pasaporte">Pasaporte</option>
        <option value="None">Ninguna</option>
      </select>
      <input id='txtIDNumber' type="text" class="textBox" style="width: 144px;margin-right:0;" maxlength="20" runat='server' />
    </td>
  </tr>
  <tr>
    <td>Otra información:<br />&nbsp;</td>
    <td class="lastCell">
      <textarea id="txtPersonNotes" cols="310" rows="2" style="width:490px" class="textArea" runat="server"></textarea>
    </td>
  </tr>
</table>
<table id="tblOrganizationPartyEditor" class="editionTable" style="display:none;margin-top:-12px" runat='server'>
  <tr>
    <td>Nombre o razón social:<br />&nbsp;</td>
    <td class="lastCell">
      <textarea id="txtOrgName" cols="320" rows="2" style="width:490px" class="textArea" runat="server"></textarea>
    </td>
  </tr>
  <tr>
    <td>RFC:</td>
    <td class="lastCell">
      <input id='txtOrgTaxIDNumber' type="text" class="textBox" style="width: 110px;margin-right:0;" maxlength="15" runat='server' />
    </td>
  </tr>
  <tr>
    <td>Otra información:<br />&nbsp;</td>
    <td class="lastCell">
      <textarea id="txtOrgNotes" cols="310" rows="2" style="width:490px" class="textArea" runat="server"></textarea>
    </td>
  </tr>
</table>
<table id="tblPartyRoleEditor" class="editionTable" style="display:none;margin-top:-12px" runat='server'>
  <tr>
    <td style="vertical-align:text-top"><br />Participa como:</td>
    <td class="lastCell" colspan="5" style="white-space:nowrap">
      <table>
        <tr>
          <td style="vertical-align:text-top">
            <select id="cboRole" class="selectBox" style="width:126px;margin-top:6px" title="" onchange="return this_updateUserInterface(this);" runat="server">
            </select>
          </td>
          <td>
            <div id="divNullRole" style="display:inline;">
              Primero seleccionar un rol de la lista de la izquierda
            </div>
            <div id="divDomainRole" style="display:none;">
              Sobre:
              <select id="cboOwnershipPartUnit" class="selectBox" style="width:94px" title="" onchange="return this_updateUserInterface(this);" runat='server'>
                <option value="">( U de M )</option>
                <option value="Unit.Full" title="Todo">Todo</option>
                <option value="Unit.Undivided" title="Pro-indiviso">Pro-indiviso</option>
                <option value="Unit.Percentage" title="Porcentaje">Porcentaje</option>
                <option value="AreaUnit.SquareMeters" title="Metros cuadrados">M2</option>
                <option value="AreaUnit.Hectarea" title="Hectáreas">Hectáreas</option>
              </select>
              Cantidad:
              <input id='txtOwnershipPartAmount' class="textBox" style="width:58px;" onkeypress="return positiveKeyFilter(this);" title="" runat='server' />
            </div>
            <div id="divUsufructuaryRole" style="display:none;">
              De la nuda de:&nbsp;
              <select id="cboUsufructuaryOf" class="selectBox" style="width:296px" onchange="return this_updateUserInterface(this);" runat="server">
                <option value="">( Seleccionar al nudo propietario )</option>
              </select>
              <div id="lstUsufructuaryOf" style="display:none;">
                <table>
                  <%=GetMultiselectListItems(cboUsufructuaryOf, "chkUsufructuaryOf")%>
                </table>
              </div>
              <br />
              Tipo usufructo:
              <select id="cboUsufruct" class="selectBox" style="width:80px" onchange="return this_updateUserInterface(this);" runat="server">
                <option value="">( Tipo )</option>
                <option value="LifeTime">Vitalicio</option>
                <option value="Tiempo">Plazo</option>
                <option value="Date">Fecha</option>
                <option value="Payment">Al liquidar</option>
                <option value="Undefined">No consta</option>
                <option value="Condition">Otro</option>
              </select>
              Parte:
              <input id='txtUsufructPartAmount' class="textBox" style="width:68px;" onkeypress="return positiveKeyFilter(this);" title='' runat="server" />
              <select id="cboUsufructPartUnit" class="selectBox" style="width:87px" title='' onchange="return this_updateUserInterface(this);" runat='server'>
                <option value="">( U de M )</option>
                <option value="Unit.Full" title="Todo">Todo</option>
                <option value="Unit.Undivided" title="Proindiviso">Proindiviso</option>
                <option value="Unit.Percentage" title="Porcentaje">Porcentaje</option>
                <option value="AreaUnit.SquareMeters" title="Metros cuadrados">M2</option>
                <option value="AreaUnit.Hectarea" title="Hectáreas">Hectáreas</option>
              </select>
              <br />
              <div id="divUsufructCondition" style="display:none">
                Finalización:  &nbsp;&nbsp;&nbsp;&nbsp;
                <input id='txtUsufructEndCondition' class="textBox" onblur="this_formatUsufructEndCondition();" style="width:290px;" title="" runat="server" />
                <select id="cboUsufructTimeUnit" class="selectBox" style="width:108px;display:none" title="" runat="server">
                  <option value="Años">Años</option>
                  <option value="Meses">Meses</option>
                </select>
                <img id='imgUsufructEndDate' src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('<%=txtUsufructEndCondition.ClientID%>'), getElement('imgUsufructEndDate'));" style="margin-left:-6px;display:none;" title="Despliega el calendario" alt="" />
              </div>
            </div>
            <div id="divSecondaryRole" style="display:none;">
              <span>De:</span>
              <select id="cboFirstPartyInRole" class="selectBox" style="width:370px" title="" onchange="return this_updateUserInterface(this);" runat="server">
                <option value="">( Seleccionar persona u organización )</option>
              </select><br />
              <div id="lstFirstPartyInRole" style="display:none;">
                <table>
                  <%=GetMultiselectListItems(cboFirstPartyInRole, "chkFirstPartyInRole")%>
                </table>
              </div>
            </div>
          </td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>
            <input id='txtNotes' class="textBox" style="width:315px;" title="" runat="server" />
            <input type="button" value="Agregar" class="button" tabindex="-1" style="width:54px; vertical-align:middle" onclick="doOperation('appendParty')" />
            <input id="hdnMultiPartiesInRole" type="hidden" runat="server" />
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<script type="text/javascript">
/* <![CDATA[ */

  function this_setPartyControlsForEdition(clickSource) {
    <% if (base.isLoaded) { %>
      var disabledFlag = true;
    <% } else { %>
      var disabledFlag = false;
    <% } %>

    var sMsg = "";
    if (clickSource && disabledFlag) {
      if (this_isPersonPartySelected()) {
        if (!<%=this.ClientID%>_validatePersonParty()) {
          return false;
        }
        sMsg = "Esta operación modificará todos los actos jurídicos donde la persona\n";
        sMsg += "esté referenciada.\n\n";
        sMsg += "¿Guardo los cambios efectuados a la información de la persona?\n";
      } else {
        if (!<%=this.ClientID%>_validateOrganizationParty()) {
          return false;
        }
        sMsg = "Esta operación modificará todos los actos jurídicos donde\n";
        sMsg += "esta organización esté referenciada.\n\n";
        sMsg += "¿Guardo los cambios efectuados a la información de la organización?\n";
      }
      if (confirm(sMsg)) {
        doOperation('saveParty', getElement('<%=cboParty.ClientID%>').value);
        return true;
      } else {
        return false;
      }
    }
    if (disabledFlag) {
      getElement('cmdEditParty').value = "Editar";
    } else {
      getElement('cmdEditParty').value = "Guardar";
    }
    disabledPartyControls(disabledFlag);
  }

  function disabledPartyControls(disabledFlag) {
    getElement('<%=txtPersonFullName.ClientID%>').readOnly = disabledFlag;
    getElement('<%=txtIDNumber.ClientID%>').readOnly = disabledFlag;
    getElement('<%=cboIDNumberType.ClientID%>').disabled = disabledFlag;
    getElement('<%=txtPersonNotes.ClientID%>').readOnly = disabledFlag;

    getElement('<%=txtOrgName.ClientID%>').readOnly = disabledFlag;
    getElement('<%=txtOrgTaxIDNumber.ClientID%>').readOnly = disabledFlag;
    getElement('<%=txtOrgNotes.ClientID%>').readOnly = disabledFlag;
  }

  function this_searchParties() {
    var keywords = getElement('<%=txtSearchParty.ClientID%>').value;

    if (getElement('<%=cboPartyFilter.ClientID%>').value == 'ByKeywords') {
      if (keywords.length == 0) {
        alert("No se ha proprocionado ningún nombre para efectuar la búsqueda.");
        return false;
      }
      if (keywords.length < 5) {
        alert("La longitud del nombre a buscar es demasiado corta.");
        return false;
      }
    }
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=searchRecordingActPartiesCmd";
    url += "&recordingActId=<%=base.RecordingAct.Id.ToString()%>";
    url += "&partyTypeId=" + getElement('<%=cboPartyType.ClientID%>').value;
    url += "&filterType=" + getElement('<%=cboPartyFilter.ClientID%>').value;
    url += "&keywords=" + getElement('<%=txtSearchParty.ClientID%>').value;

    invokeAjaxComboItemsLoader(url, getElement('<%=cboParty.ClientID%>'));
    this_displayEditor();
  }

  function this_updatePersonEditor() {
    if (getElement('<%=cboIDNumberType.ClientID%>').value == 'None') {
      getElement('<%=txtIDNumber.ClientID%>').value = '';
      getElement('<%=txtIDNumber.ClientID%>').disabled = true;
    } else {
      getElement('<%=txtIDNumber.ClientID%>').disabled = false;
    }
  }

  function this_updateRoleUserInterface() {
    var roleType = this_selectedRoleType();
    switch (roleType) {
      case 'DomainRole':
        getElement('divNullRole').style.display = 'none';
        getElement('divDomainRole').style.display = 'inline';
        getElement('divUsufructuaryRole').style.display = 'none';
        getElement('divSecondaryRole').style.display = 'none';
        return;
      case 'UsufructuaryRole':
        getElement('divNullRole').style.display = 'none';
        getElement('divDomainRole').style.display = 'none';
        getElement('divUsufructuaryRole').style.display = 'inline';
        getElement('divSecondaryRole').style.display = 'none';
        return;
      case 'SecondaryRole':
        getElement('divNullRole').style.display = 'none';
        getElement('divDomainRole').style.display = 'none';
        getElement('divUsufructuaryRole').style.display = 'none';
        getElement('divSecondaryRole').style.display = 'inline';
        return;
      case 'NullRole':
        getElement('divNullRole').style.display = 'inline';
        getElement('divDomainRole').style.display = 'none';
        getElement('divUsufructuaryRole').style.display = 'none';
        getElement('divSecondaryRole').style.display = 'none';
        return;
      default:
        alert("No reconozco la naturaleza del rol seleccionado.");
        return false;
    }
  }

  function this_updateUserInterface(oControl) {
    if (oControl == null) {
      return;
    }
    if (oControl == getElement('<%=cboParty.ClientID%>')) {
      this_displayEditor();
    } else if (oControl == getElement('<%=cboIDNumberType.ClientID%>')) {
      this_updatePersonEditor();
    } else if (oControl == getElement('<%=cboPartyType.ClientID%>')) {
      this_searchParties();
    } else if (oControl == getElement('<%=cboPartyFilter.ClientID%>')) {
      this_searchParties();
    } else if (oControl == getElement('<%=cboRole.ClientID%>')) {
      this_updateRoleUserInterface();
    } else if (oControl == getElement('<%=cboOwnershipPartUnit.ClientID%>')) {
      this_updateDomainRoleUserInterface();
    } else if (oControl == getElement('<%=cboFirstPartyInRole.ClientID%>')) {
      this_displayMultiselectItems(oControl, lstFirstPartyInRole);
    } else if (oControl == getElement('<%=cboUsufructuaryOf.ClientID%>')) {
      this_displayMultiselectItems(oControl, lstUsufructuaryOf);
    }
  }

  function this_displayMultiselectItems(oComboControl, oMultiSelectControl) {
    if (oComboControl.value == "multiselect") {
      oMultiSelectControl.style.display = "inline";
    } else {
      oMultiSelectControl.style.display = "none";
    }
  }

  function this_updateDomainRoleUserInterface() {
    var domainPartUnit = getElement('<%=cboOwnershipPartUnit.ClientID%>').value;

    if (domainPartUnit == "Unit.Full" || domainPartUnit == "Unit.Undivided" || domainPartUnit == '') {
      getElement('<%=txtOwnershipPartAmount.ClientID%>').value = "";
      getElement('<%=txtOwnershipPartAmount.ClientID%>').disabled = true;
    } else {
      getElement('<%=txtOwnershipPartAmount.ClientID%>').disabled = false;
    }
  }

  function this_selectedRoleType() {
    var selectedRole = getElement('<%=cboRole.ClientID%>').value;

    if (selectedRole == '') {
      return "NullRole";
    } else if (selectedRole >= '1230') {
      return "SecondaryRole";
    } else {
      return "DomainRole";
    }
  }

  function <%=this.ClientID%>_validatePersonParty() {
    if (getElement('<%=txtPersonFullName.ClientID%>').value.length == 0) {
      alert("Requiero se proporcione el nombre completo de la persona.");
      return false;
    }
    if (getElement('<%=cboIDNumberType.ClientID%>').value.length == 0) {
      alert("Necesito se seleccione el tipo de identificación de la persona.");
      return false;
    }
    if (getElement('<%=cboIDNumberType.ClientID%>').value != 'None') {
      if (getElement('<%=txtIDNumber.ClientID%>').value.length == 0) {
        alert("Necesito se proporcione el número de identificación.");
        return false;
      }
    }
    return true;
  }

  function <%=this.ClientID%>_validateOrganizationParty() {
    if (getElement('<%=txtOrgName.ClientID%>').value.length == 0) {
      alert("Requiero se proporcione el nombre o razón social de la organización.");
      return false;
    }
    return true;
  }

  function <%=this.ClientID%>_validate() {
    if (getElement('<%=cboParty.ClientID%>').value == "appendParty") {
      if (this_isPersonPartySelected()) {
        if (!<%=this.ClientID%>_validatePersonParty()) {
          return false;
        }
      } else {
        if (!<%=this.ClientID%>_validateOrganizationParty()) {
          return false;
        }
      }
    }

    var roleType = this_selectedRoleType();
    switch (roleType) {
      case "NullRole":
        alert("Requiero conocer el rol que juega la persona dentro de este acto jurídico.");
        return false;
      case 'DomainRole':
        return this_domainRole_validate();
      //case 'UsufructuaryRole':
      //  return this_usufructuraryRole_validate();
      case 'SecondaryRole':
        return this_secondaryRole_validate();
      default:
        alert("No reconozco la naturaleza del rol seleccionado.");
        return false;
    }
  }

  function this_secondaryRole_validate() {
    if (getElement('<%=cboFirstPartyInRole.ClientID%>').value.length == 0) {
      alert("Requiero conocer a la persona de la que es " + getComboOptionText(getElement('<%=cboRole.ClientID%>')) + " " + this_getPersonName());
      return false;
    }
    if (getElement('<%=cboFirstPartyInRole.ClientID%>').value == "multiselect") {
      var selected = getAllSelectedCheckboxesValues("chkFirstPartyInRole");
      if (selected.length == 0) {
        alert("Necesito se seleccione al menos una persona u organización de la lista de selección múltiple.");
        return false;
      }
      var selectedItemsArray = selected.split('|');
      var selectedItemsText = "";
      for (var i = 0; i < selectedItemsArray.length; i++) {
        selectedItemsText += getInnerText("chkFirstPartyInRole_text_" + selectedItemsArray[i]) + "\n";
      }
      var sMsg = "Agregar " + getComboOptionText(getElement('<%=cboRole.ClientID%>')) + ".\n\n";
      sMsg += "Esta operación agregará dentro de este acto jurídico a " + this_getPersonName();
      sMsg += " como " + getComboOptionText(getElement('<%=cboRole.ClientID%>')) + " de:\n\n";
      sMsg += selectedItemsText + "\n";
      sMsg += "¿Ejecuto la operación?";
    } else {
      var sMsg = "Agregar " + getComboOptionText(getElement('<%=cboRole.ClientID%>')) + ".\n\n";
      sMsg += "Esta operación agregará dentro de este acto jurídico a " + this_getPersonName();
      sMsg += " como " + getComboOptionText(getElement('<%=cboRole.ClientID%>')) + " de:\n\n";
      sMsg += getComboOptionText(getElement('<%=cboFirstPartyInRole.ClientID%>')) + "\n\n";
      sMsg += "¿Ejecuto la operación?";
    }
    if (confirm(sMsg)) {
      getElement('<%=hdnMultiPartiesInRole.ClientID%>').value = selected;
      return true;
    }
    return false;
  }

  function this_usufructuraryRole_validate() {
    var usufructPartUnit = getElement('<%=cboUsufructPartUnit.ClientID%>').value;
    var usufructPart = getElement('<%=txtUsufructPartAmount.ClientID%>').value;
    var selected = "";
    if (getElement('<%=cboUsufructuaryOf.ClientID%>').value.length == 0) {
      alert("Requiero se seleccione la persona u organización que es nudo propietario del predio.");
      return false;
    }
    if (getElement('<%=cboUsufructuaryOf.ClientID%>').value == "multiselect") {
      selected = getAllSelectedCheckboxesValues("chkUsufructuaryOf");
      if (selected.length == 0) {
        alert("Necesito se seleccione al menos a un nudo propietario del predio de la lista de selección múltiple.");
        return false;
      }
    }
    if (getElement('<%=cboUsufruct.ClientID%>').value.length == 0) {
      alert("Requiero conocer el tipo de usufructo sobre el predio");
      return false;
    }
    if (usufructPartUnit.length == 0) {
      alert("Requiero conocer la unidad de medida del usufructo sobre el predio.");
      return false;
    }
    if (usufructPartUnit != "Unit.Full" && usufructPartUnit != "Unit.Undivided" && usufructPart.length == 0) {
      alert("Requiero conocer la parte del predio (o predios) de la que es usufructurario " + this_getPersonName()) + ".";
      return false;
    }
    if (getElement('<%=cboUsufructuaryOf.ClientID%>').value == "multiselect") {
      var selectedItemsArray = selected.split('|');
      var selectedItemsText = "";
      for (var i = 0; i < selectedItemsArray.length; i++) {
        selectedItemsText += getInnerText("chkFirstPartyInRole_text_" + selectedItemsArray[i]) + "\n";
      }
      var sMsg = "Agregar usufructuarios del predio.\n\n";
      sMsg += "Esta operación agregará dentro de este acto jurídico a " + this_getPersonName();
      sMsg += " como usufructuario de la nuda propiedad de:\n\n";
      sMsg += selectedItemsText + "\n";
      sMsg += "¿Agego a los usufructuarios del predio?";
    } else {
      var sMsg = "Agregar al usufructuario del predio.\n\n";
      sMsg += "Esta operación agregará dentro de este acto jurídico a " + this_getPersonName();
      sMsg += " como usufructuario de la nuda propiedad de:\n\n";
      sMsg += getComboOptionText(getElement('<%=cboUsufructuaryOf.ClientID%>')) + "\n\n";
      sMsg += "¿Agego al usufructuario seleccionado?";
    }
    if (confirm(sMsg)) {
      getElement('<%=hdnMultiPartiesInRole.ClientID%>').value = selected;
      return true;
    }
    return false;
  }

  function this_domainRole_validate() {
    var domainPartUnit = getElement('<%=cboOwnershipPartUnit.ClientID%>').value;
    var domainPart = getElement('<%=txtOwnershipPartAmount.ClientID%>').value;

    if (getElement('<%=cboOwnershipPartUnit.ClientID%>').value.length == 0) {
      alert("Requiero conocer la unidad de medida de la propiedad o dominio de " + this_getPersonName());
      return false;
    }
    if (domainPartUnit != "Unit.Full" && domainPartUnit != "Unit.Undivided" && domainPart.length == 0) {
      alert("Requiero conocer la parte de la que es propietario o tiene el dominio " + this_getPersonName());
      return false;
    }
    if (confirm("¿Agrego a " + this_getPersonName() + " a este acto jurídico?")) {
      return true;
    }
    return false;
  }

  function this_getPersonName() {
    if (getElement('<%=cboParty.ClientID%>').value.length == 0 ||
        getElement('<%=cboParty.ClientID%>').value == "appendParty") {
      return getElement('<%=txtPersonFullName.ClientID%>').value;
    } else {
      return getComboOptionText(getElement('<%=cboParty.ClientID%>'));
    }
  }

  function <%=this.ClientID%>_display() {
    var showFlag = false;
    if (arguments.length == 1) {
      showFlag = arguments[0];
    } else {
      showFlag = (<%=tblPartySeacher.ClientID%>.style.display == 'none');
    }

    if (showFlag) {
      <%=tblPartySeacher.ClientID%>.style.display = "inline";
      getElement('<%=txtSearchParty.ClientID%>').focus();
    } else {
      <%=tblPartySeacher.ClientID%>.style.display = "none";
    }
  }

  function this_isPersonPartySelected() {
    return (getElement('<%=cboPartyType.ClientID%>').value == '2435');
  }

  function this_displayEditor() {
    if (getElement('<%=cboParty.ClientID%>').value.length == 0) {
      this_cleanEditor();
      <%=tblPartySeacher.ClientID%>.style.display = "inline";
      <%=tblHumanPartyEditor.ClientID%>.style.display = "none";
      <%=tblOrganizationPartyEditor.ClientID%>.style.display = "none";
      <%=tblPartyRoleEditor.ClientID%>.style.display = "none";
    }
    if (getElement('<%=cboParty.ClientID%>').value == "appendParty") {
      this_cleanEditor();
      <%=tblPartySeacher.ClientID%>.style.display = "inline";
      if (this_isPersonPartySelected()) {
        <%=tblHumanPartyEditor.ClientID%>.style.display = "inline";
        <%=tblOrganizationPartyEditor.ClientID%>.style.display = "none";
      } else {
        <%=tblHumanPartyEditor.ClientID%>.style.display = "none";
        <%=tblOrganizationPartyEditor.ClientID%>.style.display = "inline";
      }
      <%=tblPartyRoleEditor.ClientID%>.style.display = "inline";
      disabledPartyControls(false);
    } else if (getElement('<%=cboParty.ClientID%>').value.length != 0) {
      doOperation('selectParty', getElement('<%=cboParty.ClientID%>').value);
      disabledPartyControls(true);
    }
  }

  function this_cleanEditor() {
    getElement('<%=txtPersonFullName.ClientID%>').value = '';
    getElement('<%=cboIDNumberType.ClientID%>').value = '';
    getElement('<%=txtIDNumber.ClientID%>').value = '';


    getElement('<%=txtOrgName.ClientID%>').value = '';
    getElement('<%=txtOrgTaxIDNumber.ClientID%>').value = '';
  }

  function this_onSearchTextBoxKeyFilter() {
    var oEvent = window.event;
    var keyCode = getKeyCode();

    if (keyCode == 60 || keyCode == 62) {
      return false;
    } else if ((keyCode == 13) && (getEventSource(oEvent).value != '')) {
      this_searchParties();
      return true;
    } else {
      return true;
    }
  }

  addEvent(getElement('<%=txtSearchParty.ClientID%>'), 'keypress', upperCaseKeyFilter);
  addEvent(getElement('<%=txtIDNumber.ClientID%>'), 'keypress', upperCaseKeyFilter);
  addEvent(getElement('<%=txtPersonFullName.ClientID%>'), 'keypress', upperCaseKeyFilter);
  addEvent(getElement('<%=txtOrgName.ClientID%>'), 'keypress', upperCaseKeyFilter);
  addEvent(getElement('<%=txtOrgTaxIDNumber.ClientID%>'), 'keypress', upperCaseKeyFilter);

  <% if (base.isLoaded) { %>
    <%=tblPartySeacher.ClientID%>.style.display = "inline";
    if (this_isPersonPartySelected()) {
      <%=tblHumanPartyEditor.ClientID%>.style.display = "inline";
      <%=tblOrganizationPartyEditor.ClientID%>.style.display = "none";
    } else {
      <%=tblHumanPartyEditor.ClientID%>.style.display = "none";
      <%=tblOrganizationPartyEditor.ClientID%>.style.display = "inline";
    }
    this_setPartyControlsForEdition(false);
    <%=tblPartyRoleEditor.ClientID%>.style.display = "inline";
  <% } %>

/* ]]> */
</script>
