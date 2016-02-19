<%@ Control Language="C#" AutoEventWireup="false" Inherits="Empiria.Land.WebApp.RecordingPartyEditorControl" CodeFile="recording.party.editor.control.ascx.cs" %>
<table id="tblPartySeacher" class="editionTable" style="margin-top:-12px;display:none;" runat="server">
  <tr>
    <td>
      <table class="editionTable">
        <tr>
          <td style="width:125px">Buscar:</td>
          <td class="lastCell">
            <input id='txtSearchParty' type="text" class="textBox" style="width:212px;margin-right:0px;" maxlength="64" onkeypress="this_onSearchTextBoxKeyFilter(this)" runat="server" />
            &nbsp;
            <img src="../themes/default/buttons/search.gif" alt="" title="Ejecuta la búsqueda" style="margin-left:-4px" onclick="this_searchParties()" />
            <select id="cboPartyType" class="selectBox" style="width:118px" title="" onchange="return this_updateUserInterface(this);" runat="server">
              <option value="0">( Todas )</option>
              <option value="2433">Personas</option>
              <option value="2436">Organizaciones</option>
              <option value="2438">» Empresas/Asoc</option>
              <option value="2437">» Sector público</option>
              <option value="2439">» Inst. Financiera</option>
            </select>
            Traer:
            <select id="cboPartyFilter" class="selectBox" style="width:138px" title="" onchange="return this_updateUserInterface(this);" runat="server">
              <option value="ByKeywords">Según búsqueda</option>
              <option value="OnInscription">De esta inscripción</option>
              <option value="OnRecordingBook">De este libro</option>
            </select>
          </td>
        </tr>
        <tr>
          <td>Seleccionar:</td>
          <td class="lastCell">
            <select id="cboParty" class="selectBox" style="width:474px" title="" onchange="return this_updateUserInterface(this);" runat="server">
              <option value="">( No se ha efectuado ninguna búsqueda de personas u organizaciones )</option>
            </select>
            <input id="cmdEditParty" type="button" value="Editar" class="button" tabindex="-1" style="width:64px; vertical-align:middle " onclick="return this_setPartyControlsForEdition(true)" />
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table id="tblHumanPartyEditor" class="editionTable" style="display:none;margin-top:-12px" runat='server'>
  <tr>
    <td>Nombre(s):</td>
    <td class="lastCell" colspan="5">
      <input id='txtFirstName' type="text" class="textBox" style="width: 200px;margin-right:0px;" maxlength="64" runat='server' />
      &nbsp;&nbsp;&nbsp;Apellido paterno:&nbsp;
      <input id='txtFirstFamilyName' type="text" class="textBox" style="width:202px;margin-right:0px;" maxlength="64" runat='server' />
    </td>
  </tr>
  <tr>
    <td>Apellido materno:</td>
    <td class="lastCell" colspan="5">
      <input id='txtSecondFamilyName' type="text" class="textBox" style="width: 200px;margin-right:0px;" maxlength="64" runat='server' />
      &nbsp; &nbsp;Apellido conyugal:
      <input id='txtMaritalFamilyName' type="text" class="textBox" style="width: 200px;margin-right:0px;" maxlength="64" runat='server' />
    </td>
  </tr>
  <tr>
    <td>Conocido(a) como:</td>
    <td class="lastCell" colspan="5">
      <input id='txtNicknames' type="text" class="textBox" style="width: 507px;margin-right:0px;" maxlength="64" runat='server' />
    </td>
  </tr>
  <tr>
    <td>Ocupación:</td>
    <td class="lastCell" colspan="5">
      <select id="cboOccupation" class="selectBox" style="width:142px" title="" runat="server">
      </select>
      Edo civil:
      <select id="cboMarriageStatus" class="selectBox" style="width:80px" title="" runat="server">
      </select>
     Sexo:
      <select id="cboGender" class="selectBox" style="width:40px" runat='server'>
        <option value="" title="">?</option>
        <option value="F">F</option>
        <option value="M">M</option>
        <option value="U">N/D</option>
      </select>
      Fecha Nac:
      <input id='txtBornDate' type="text" class="textBox" style="width:64px;" onblur="formatAsDate(this)" title="" runat="server" />
      <img id='imgBornDate' src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('<%=txtBornDate.ClientID%>'), getElement('imgBornDate'));" style="margin-left:-6px" title="Despliega el calendario" alt="" />
    </td>
  </tr>
  <tr>
    <td>Originario(a) de:</td>
    <td class="lastCell" colspan="5">
      <input id='txtSearchBornLocation' type="text" class="textBox" style="width:110px;" title="" />
      <img src="../themes/default/buttons/search.gif" alt="" title="Ejecuta la búsqueda" style="margin-left:-4px" onclick="this_searchBornLocations()" />
      <select id="cboBornLocation" class="selectBox" style="width:365px" title="" runat="server">
      </select>
    </td>
  </tr>
  <tr>
    <td>Lugar de residencia:</td>
    <td class="lastCell" colspan="5">
      <input id='txtSearchAddressPlace' type="text" class="textBox" style="width:110px;" title="" />
      <img src="../themes/default/buttons/search.gif" alt="" title="Ejecuta la búsqueda" style="margin-left:-4px" onclick="this_searchAddressPlace()" />
      <select id="cboAddressPlace" class="selectBox" style="width:365px" title="" runat="server">
      </select>
    </td>
  </tr>
  <tr>
    <td style="vertical-align:text-top">Domicilio:</td>
    <td colspan="5">
      <textarea id="txtAddress" cols="320" rows="2" style="width:508px" class="textArea" runat="server"></textarea>
    </td>
  </tr>
  <tr>
    <td>CURP:</td>
    <td class="lastCell separator" colspan="5">
      <input id='txtCURPNumber' type="text" class="textBox" style="width: 142px;margin-right:0px;" maxlength="20" runat='server' />
      &nbsp; &nbsp; RFC:
      <input id='txtTaxIDNumber' type="text" class="textBox" style="width: 110px;margin-right:0px;" maxlength="16" runat='server' />
      &nbsp; &nbsp; &nbsp; &nbsp;IFE:
      <input id='txtIFENumber' type="text" class="textBox" style="width: 154px;margin-right:0px;" maxlength="29" runat='server' />
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
    <td>Conocida(o) como:</td>
    <td class="lastCell">
      <input id='txtOrgNicknames' type="text" class="textBox" style="width: 340px;margin-right:0px;" maxlength="64" runat='server' />
      &nbsp;RFC:
      <input id='txtOrgTaxIDNumber' type="text" class="textBox" style="width: 110px;margin-right:0px;" maxlength="15" runat='server' />
    </td>
  </tr>
  <tr>
    <td>Datos de registro:<br />&nbsp;</td>
    <td class="lastCell">
      <textarea id="txtOrgRegistryText" cols="310" rows="2" style="width:490px" class="textArea" runat="server"></textarea>
    </td>
  </tr>
  <tr>
    <td>Fecha de registro:</td>
    <td class="lastCell separator">
      <input id='txtOrgRegistryDate' type="text" class="textBox" style="width:64px;" onblur="formatAsDate(this)" title="" runat="server" />
      <img id='imgOrgRegistryDate' src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('<%=txtOrgRegistryDate.ClientID%>'), getElement('imgOrgRegistryDate'));" style="margin-left:-6px" title="Despliega el calendario" alt="" />
      <img src="../themes/default/textures/pixel.gif" height="1px" width="124px" alt="" />
      Lugar de registro:
      <select id="cboOrgRegistryLocation" class="selectBox" style="width:165px" title="" onchange="return updateUserInterface();" runat="server">
        <option value=''>( Seleccionar )</option>
        <option value='-2'>No consta</option>
        <option value='501'>Aguascalientes</option>
        <option value='502'>Baja California</option>
        <option value='503'>Baja California Sur</option>
        <option value='504'>Campeche</option>
        <option value='505'>Chiapas</option>
        <option value='506'>Chihuahua</option>
        <option value='507'>Coahuila</option>
        <option value='508'>Colima</option>
        <option value='509'>Distrito Federal</option>
        <option value='510'>Durango</option>
        <option value='511'>Guanajuato</option>
        <option value='512'>Guerrero</option>
        <option value='513'>Hidalgo</option>
        <option value='514'>Jalisco</option>
        <option value='515'>México</option>
        <option value='516'>Michoacán</option>
        <option value='517'>Morelos</option>
        <option value='518'>Nayarit</option>
        <option value='519'>Nuevo León</option>
        <option value='520'>Oaxaca</option>
        <option value='521'>Puebla</option>
        <option value='522'>Querétaro</option>
        <option value='523'>Quintana Roo</option>
        <option value='524'>San Luis Potosí</option>
        <option value='525'>Sinaloa</option>
        <option value='526'>Sonora</option>
        <option value='527'>Tabasco</option>
        <option value='528'>Tamaulipas</option>
        <option value='529'>Tlaxcala</option>
        <option value='530'>Veracruz</option>
        <option value='531'>Yucatán</option>
        <option value='532'>Zacatecas</option>
      </select>
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
              Titularidad:
              <select id="cboOwnership" class="selectBox" style="width:122px" title="" onchange="return this_updateUserInterface(this);" runat="server">
                <option value="">( Seleccionar )</option>
                <option value="Owner">Universal</option>
                <option value="Coowner">Compartida</option>
                <option value="Bare">Nuda</option>
              </select>
              Parte:
              <input id='txtOwnershipPartAmount' class="textBox" style="width:58px;" onkeypress="return positiveKeyFilter(this);" title="" runat='server' />
              <select id="cboOwnershipPartUnit" class="selectBox" style="width:87px" disabled='disabled' title="" onchange="return this_updateUserInterface(this);" runat='server'>
                <option value="">( U de M )</option>
                <option value="Unit.Full" title="Todo">Todo</option>
                <option value="Unit.Undivided" title="Proindiviso">Proindiviso</option>
                <option value="Unit.Percentage" title="Porcentaje">Porcentaje</option>
                <option value="AreaUnit.SquareMeters" title="Metros cuadrados">M2</option>
                <option value="AreaUnit.Hectarea" title="Hectáreas">Hectáreas</option>
              </select>
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
            <div id="divAdditionalRole" style="display:none;">
              Más:
              <select id="cboAdditionalRole" class="selectBox" style="width:365px" title="" runat="server">

              </select><br />
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
    var disabledFlag = !getElement('<%=txtFirstName.ClientID%>').readOnly;
    var sMsg = "";
    if (clickSource && disabledFlag) {
      if (this_isPersonPartySelected()) {
        if (!<%=this.ClientID%>_validatePersonParty()) {
          return false;
        }
        <% if (base.IsPartyInRecordingAct) { %>
          if (!<%=this.ClientID%>_validatePersonPartyOnRecordingAct()) {
            return false;
          }
        <% } %>
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

    getElement('<%=txtFirstName.ClientID%>').readOnly = disabledFlag;
    getElement('<%=txtFirstFamilyName.ClientID%>').readOnly = disabledFlag;
    getElement('<%=txtSecondFamilyName.ClientID%>').readOnly = disabledFlag;
    getElement('<%=txtMaritalFamilyName.ClientID%>').readOnly = disabledFlag;
    getElement('<%=txtNicknames.ClientID%>').readOnly = disabledFlag;
    getElement('<%=cboGender.ClientID%>').disabled = disabledFlag;
    getElement('<%=txtBornDate.ClientID%>').readOnly = disabledFlag;
    getElement('txtSearchBornLocation').readOnly = disabledFlag;
    getElement('<%=cboBornLocation.ClientID%>').disabled = disabledFlag;
    getElement('<%=txtCURPNumber.ClientID%>').readOnly = disabledFlag;
    getElement('<%=txtTaxIDNumber.ClientID%>').readOnly = disabledFlag;
    getElement('<%=txtIFENumber.ClientID%>').readOnly = disabledFlag;


//    getElement('<%=cboOccupation.ClientID%>').disabled = !disabledFlag;
//    getElement('<%=cboMarriageStatus.ClientID%>').disabled = !disabledFlag;
//    getElement('txtSearchAddressPlace').readOnly = !disabledFlag;
//    getElement('<%=cboAddressPlace.ClientID%>').disabled = !disabledFlag;
//    getElement('<%=txtAddress.ClientID%>').readOnly = !disabledFlag;


    getElement('<%=txtOrgName.ClientID%>').readOnly = disabledFlag;
    getElement('<%=txtOrgNicknames.ClientID%>').readOnly = disabledFlag;
    getElement('<%=txtOrgTaxIDNumber.ClientID%>').readOnly = disabledFlag;
    getElement('<%=txtOrgRegistryText.ClientID%>').readOnly = disabledFlag;
    getElement('<%=txtOrgRegistryDate.ClientID%>').readOnly = disabledFlag;
    getElement('<%=cboOrgRegistryLocation.ClientID%>').disabled = disabledFlag;
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

  function this_searchAddressPlace() {
    var url = "../ajax/geographic.data.aspx";
    url += "?commandName=getRegionsStringArrayCmd";
    url += "&header=( Seleccionar lugar de residencia )";
    url += "&keywords=" + getElement("txtSearchAddressPlace").value;

    invokeAjaxComboItemsLoader(url, getElement("<%=cboAddressPlace.ClientID%>"));
  }

  function this_searchBornLocations() {
    var url = "../ajax/geographic.data.aspx";
    url += "?commandName=getRegionsStringArrayCmd";
    url += "&header=( Seleccionar lugar de nacimiento )";
    url += "&keywords=" + getElement("txtSearchBornLocation").value;

    invokeAjaxComboItemsLoader(url, getElement("<%=cboBornLocation.ClientID%>"));
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
    } else if (oControl == getElement('<%=cboPartyType.ClientID%>')) {
      this_searchParties();
    } else if (oControl == getElement('<%=cboPartyFilter.ClientID%>')) {
      this_searchParties();
    } else if (oControl == getElement('<%=cboRole.ClientID%>')) {
      this_updateRoleUserInterface();
    } else if (oControl == getElement('<%=cboOwnership.ClientID%>')) {
      this_updateDomainRoleUserInterface();
    } else if (oControl == getElement('<%=cboOwnershipPartUnit.ClientID%>')) {
      this_updateDomainRoleUserInterface();
    } else if (oControl == getElement('<%=cboUsufruct.ClientID%>')) {
      this_updateUsufructRoleUserInterface();
    } else if (oControl == getElement('<%=cboUsufructPartUnit.ClientID%>')) {
      this_updateUsufructPartUnitUserInterface();
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

    if (getElement('<%=cboAdditionalRole.ClientID%>').options.length != 0) {
      getElement("divAdditionalRole").style.display = "inline";
    } else {
      getElement("divAdditionalRole").style.display = "none";
    }
  }

  function this_updateDomainRoleUserInterface() {
    var domainType = getElement('<%=cboOwnership.ClientID%>').value;
    var domainPartUnit = getElement('<%=cboOwnershipPartUnit.ClientID%>').value;
    switch (domainType) {
      case "Owner":
        getElement('<%=cboOwnershipPartUnit.ClientID%>').value = "Unit.Full";
        getElement('<%=cboOwnershipPartUnit.ClientID%>').disabled = true;
        getElement('<%=txtOwnershipPartAmount.ClientID%>').value = "";
        getElement('<%=txtOwnershipPartAmount.ClientID%>').disabled = true;
        return;
      case "Coowner":
        if (domainPartUnit == "Unit.Full") {
          getElement('<%=cboOwnershipPartUnit.ClientID%>').value = "";
        }
        getElement('<%=cboOwnershipPartUnit.ClientID%>').disabled = false;
        getElement('<%=txtOwnershipPartAmount.ClientID%>').disabled = false;
        break;
      case "Bare":
        getElement('<%=cboOwnershipPartUnit.ClientID%>').disabled = false;
        break;
    }
    if (domainPartUnit == "Unit.Full" || domainPartUnit == "Unit.Undivided" || domainPartUnit == '') {
      getElement('<%=txtOwnershipPartAmount.ClientID%>').value = "";
      getElement('<%=txtOwnershipPartAmount.ClientID%>').disabled = true;
    } else {
      getElement('<%=txtOwnershipPartAmount.ClientID%>').disabled = false;
    }
  }

  function this_updateUsufructRoleUserInterface() {
    switch (getElement('<%=cboUsufruct.ClientID%>').value) {
      case 'LifeTime':
        getElement('divUsufructCondition').style.display = 'none';
        getElement('<%=cboUsufructTimeUnit.ClientID%>').style.display = 'none';
        getElement('imgUsufructEndDate').style.display = 'none';
        getElement('<%=txtUsufructEndCondition.ClientID%>').value = '';
        break;
      case 'Time':
        getElement('divUsufructCondition').style.display = 'inline';
        getElement('<%=cboUsufructTimeUnit.ClientID%>').style.display = 'inline';
        getElement('imgUsufructEndDate').style.display = 'none';
        getElement('<%=txtUsufructEndCondition.ClientID%>').style.width = '74px';
        getElement('<%=txtUsufructEndCondition.ClientID%>').value = '';
        break;
      case 'Date':
        getElement('divUsufructCondition').style.display = 'inline';
        getElement('<%=cboUsufructTimeUnit.ClientID%>').style.display = 'none';
        getElement('imgUsufructEndDate').style.display = 'inline';
        getElement('<%=txtUsufructEndCondition.ClientID%>').style.width = '74px';
        getElement('<%=txtUsufructEndCondition.ClientID%>').value = '';
        break;
      case 'Payment':
        getElement('divUsufructCondition').style.display = 'none';
        getElement('<%=cboUsufructTimeUnit.ClientID%>').style.display = 'none';
        getElement('imgUsufructEndDate').style.display = 'none';
        getElement('<%=txtUsufructEndCondition.ClientID%>').value = '';
        break;
      case 'Condition':
        getElement('divUsufructCondition').style.display = 'inline';
        getElement('<%=cboUsufructTimeUnit.ClientID%>').style.display = 'none';
        getElement('imgUsufructEndDate').style.display = 'none';
        getElement('<%=txtUsufructEndCondition.ClientID%>').style.width = '290px';
        getElement('<%=txtUsufructEndCondition.ClientID%>').value = '';
        break;
    }
  }

  function this_updateUsufructPartUnitUserInterface() {
    var usufructPartUnit = getElement('<%=cboUsufructPartUnit.ClientID%>').value;
    if (usufructPartUnit == "Unit.Full" || usufructPartUnit == "Unit.Undivided" || usufructPartUnit == '') {
      getElement('<%=txtUsufructPartAmount.ClientID%>').value = "";
      getElement('<%=txtUsufructPartAmount.ClientID%>').disabled = true;
    } else {
      getElement('<%=txtUsufructPartAmount.ClientID%>').disabled = false;
    }
  }

  function this_formatUsufructEndCondition() {
    if (getElement('<%=txtUsufructEndCondition.ClientID%>').value.length == 0) {
      return;
    }
    if (getElement('<%=cboUsufruct.ClientID%>').value == 'Date') {
      formatAsDate(getElement('<%=txtUsufructEndCondition.ClientID%>'));
    }
  }

  function this_selectedRoleType() {
    var selectedRole = getElement('<%=cboRole.ClientID%>').value;

    if (selectedRole == '') {
      return "NullRole";
    } else if (selectedRole == '1202') {
      return "UsufructuaryRole";
    } else if (selectedRole >= '1230') {
      return "SecondaryRole";
    } else {
      return "DomainRole";
    }
  }

  function <%=this.ClientID%>_validatePersonParty() {
    if (getElement('<%=txtFirstFamilyName.ClientID%>').value.length == 0) {
      alert("Requiero se proporcione el apellido paterno de la persona.");
      return false;
    }
    if (getElement('<%=txtFirstName.ClientID%>').value.length == 0) {
      alert("Requiero se proporcione el nombre o nombres de la persona.");
      return false;
    }
    if (getElement('<%=cboGender.ClientID%>').value.length == 0) {
      alert("Requiero se proporcione el sexo de la persona.");
      return false;
    }
    if (getElement('<%=txtBornDate.ClientID%>').value.length == 0) {
      if (!confirm("No se proporcionó la fecha de nacimiento de la persona.\n\n¿La fecha de nacimiento no consta?")) {
        return false;
      }
    } else if (!isDate(getElement('<%=txtBornDate.ClientID%>'))) {
      alert("No reconozco la fecha de nacimiento de la persona.");
      return false;
    }
    if (getElement('<%=cboBornLocation.ClientID%>').value.length == 0) {
      alert("Requiero se seleccione el lugar de nacimiento de la persona.");
      return false;
    }
    return true;
  }

  function <%=this.ClientID%>_validatePersonPartyOnRecordingAct() {
    if (getElement('<%=cboOccupation.ClientID%>').value.length == 0) {
      alert("Requiero se seleccione la ocupación de la persona.");
      return false;
    }
    if (getElement('<%=cboMarriageStatus.ClientID%>').value.length == 0) {
      alert("Requiero se seleccione el estado civil de la persona.");
      return false;
    }
    if (getElement('<%=cboAddressPlace.ClientID%>').value.length == 0) {
      alert("Requiero se seleccione el lugar de residencia de la persona.");
      return false;
    }
    if (getElement('<%=txtAddress.ClientID%>').value.length == 0) {
      if (!confirm("No se proporcionó el domicilio de la persona.\n\n¿El domicilio no consta?")) {
        return false;
      } else {
        getElement('<%=txtAddress.ClientID%>').value = "No consta";
      }
    }
    return true;
  }

  function <%=this.ClientID%>_validateOrganizationParty() {
    if (getElement('<%=txtOrgName.ClientID%>').value.length == 0) {
      alert("Requiero se proporcione el nombre o razón social de la organización.");
      return false;
    }
    if (getElement('<%=txtOrgRegistryText.ClientID%>').value.length == 0) {
      if (!confirm("No se proporcionaron los datos del registro de la organización.\n\n¿La información de registro de la organización no consta?")) {
        return false;
      }
    }
    if (getElement('<%=txtOrgRegistryDate.ClientID%>').value.length == 0) {
      if (!confirm("No se proporcionó la fecha de registro de la organización.\n\n¿La fecha de registro no consta?")) {
        return false;
      }
    } else {
      if (!isDate(getElement('<%=txtOrgRegistryDate.ClientID%>'))) {
        alert("No reconozco la fecha de registro de la organización.");
        return false;
      }
    }
    if (getElement('<%=cboOrgRegistryLocation.ClientID%>').value.length == 0) {
      alert("Requiero se seleccione el lugar de registro de la organización.");
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
        if (!<%=this.ClientID%>_validatePersonPartyOnRecordingAct()) {
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
      case 'UsufructuaryRole':
        return this_usufructuraryRole_validate();
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
    var domainType = getElement('<%=cboOwnership.ClientID%>').value;
    var domainPartUnit = getElement('<%=cboOwnershipPartUnit.ClientID%>').value;
    var domainPart = getElement('<%=txtOwnershipPartAmount.ClientID%>').value;

    if (domainType.length == 0) {
      alert("Requiero conocer el dominio que sobre el predio o predios tendrá " + this_getPersonName());
      return false;
    }
    if (getElement('<%=cboOwnershipPartUnit.ClientID%>').value.length == 0) {
      alert("Requiero conocer la unidad de medida de la parte de la que es " + getComboOptionText(getElement('<%=cboOwnership.ClientID%>')) + " " + this_getPersonName());
      return false;
    }
    if (domainPartUnit != "Unit.Full" && domainPartUnit != "Unit.Undivided" && domainPart.length == 0) {
      alert("Requiero conocer la parte de la que es " + getComboOptionText(getElement('<%=cboOwnership.ClientID%>')) + " " + this_getPersonName());
      return false;
    }
    if (confirm("¿Agrego a " + this_getPersonName() + " como " +
                getComboOptionText(getElement('<%=cboOwnership.ClientID%>')) + " en este acto jurídico?")) {
      getElement('<%=cboOwnershipPartUnit.ClientID%>').disabled = false;
      return true;
    }
    return false;
  }

  function this_getPersonName() {
    if (getElement('<%=cboParty.ClientID%>').value.length == 0 || getElement('<%=cboParty.ClientID%>').value == "appendParty") {
      return getElement('<%=txtFirstName.ClientID%>').value + " " +
             getElement('<%=txtFirstFamilyName.ClientID%>').value + " " +
             getElement('<%=txtSecondFamilyName.ClientID%>').value;
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
    return (getElement('<%=cboPartyType.ClientID%>').value == '2433');
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
    } else if (getElement('<%=cboParty.ClientID%>').value.length != 0) {
      doOperation('selectParty', getElement('<%=cboParty.ClientID%>').value);
    }
  }

  function this_cleanEditor() {
    getElement('<%=txtFirstName.ClientID%>').value = '';
    getElement('<%=txtFirstFamilyName.ClientID%>').value = '';
    getElement('<%=txtSecondFamilyName.ClientID%>').value = '';
    getElement('<%=txtMaritalFamilyName.ClientID%>').value = '';
    getElement('<%=txtNicknames.ClientID%>').value = '';
    getElement('<%=cboOccupation.ClientID%>').value = '';
    getElement('<%=cboMarriageStatus.ClientID%>').value = '';
    getElement('<%=cboGender.ClientID%>').value = '';
    getElement('<%=txtBornDate.ClientID%>').value = '';
    getElement('txtSearchBornLocation').value = '';
    getElement('<%=cboBornLocation.ClientID%>').value = '';
    getElement('txtSearchAddressPlace').value = '';
    getElement('<%=cboAddressPlace.ClientID%>').value = '';
    getElement('<%=txtAddress.ClientID%>').value = '';
    getElement('<%=txtCURPNumber.ClientID%>').value = '';
    getElement('<%=txtTaxIDNumber.ClientID%>').value = '';
    getElement('<%=txtIFENumber.ClientID%>').value = '';

    getElement('<%=txtOrgName.ClientID%>').value = '';
    getElement('<%=txtOrgNicknames.ClientID%>').value = '';
    getElement('<%=txtOrgTaxIDNumber.ClientID%>').value = '';
    getElement('<%=txtOrgRegistryText.ClientID%>').value = '';
    getElement('<%=txtOrgRegistryDate.ClientID%>').value = '';
    getElement('<%=cboOrgRegistryLocation.ClientID%>').value = '';
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

  addEvent(getElement('<%=txtCURPNumber.ClientID%>'), 'keypress', upperCaseKeyFilter);
  addEvent(getElement('<%=txtTaxIDNumber.ClientID%>'), 'keypress', upperCaseKeyFilter);
  addEvent(getElement('<%=txtIFENumber.ClientID%>'), 'keypress', upperCaseKeyFilter);

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
