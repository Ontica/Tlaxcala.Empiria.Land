<%@ Control Language="C#" AutoEventWireup="false" Inherits="Empiria.Land.WebApp.RecordingActEditorControl" CodeFile="recording.act.editor.control.ascx.cs" %>
<table class="editionTable">
  <tr id="divRecordingActTypeSelectorTitle"><td class="actionsSeparator">(1) Seleccionar el tipo de acto jurídico</td></tr>
  <tr>
    <td>
      <table class="editionTable">
        <tr id="divRecordingActTypeSelector">
          <td>Tipo de acto:</td>
          <td>
            <select id="cboRecordingActTypeCategory" class="selectBox"
                    style="width:200px" title="" onchange="return updateUI(this);">
            </select>
          </td>
          <td>
            <select id="cboRecordingActType" class="selectBox" style="width:316px" title=""
                    onchange="return updateUI(this);">
              <option value="">( Primero seleccionar el tipo de acto jurídico )</option>
            </select>
            <input type="button" value="Agregar el acto jurídico" class="button" style="width:125px;height:28px;vertical-align:middle"
                   onclick='doRecordingActEditorOperation("appendRecordingAct")' />
          </td>
          <td class="lastCell">&nbsp;</td>
        </tr>
        <tr id="divPropertyTypeSelector">
          <td style="vertical-align:baseline">Sobre:</td>
          <td style="vertical-align:top">
            <select id="cboRecordingTaskType" class="selectBox" style="width:200px" onchange="return updateUI(this);">
              <option value="">( Seleccionar )</option>
            </select>
          </td>
          <td>
            <span id="divPrecedentActSection" style="display:none">
              Buscar antecedente:
              <input id="txtLookupResource" type="text" class="textBox" maxlength="19" style="width:184px" />
              <img src="../themes/default/buttons/search.gif" alt="" title="Ejecuta la búsqueda" style="margin-left:-8px"
                    onclick="doRecordingActEditorOperation('lookupResource')" />
              <label><input type="checkbox" id="chkSelectPredecentInPhysicalBooks" onclick="return showPrecedentRecordingSection()"; />Seleccionar el antecedente vía libro/partida</label>
              <br />
            </span>
            <table id="divPhysicalRecordingSelector" class="editionTable" style="display:none;width:200px" >
              <tr>
                <td>Distrito:</td>
                <td>
                  <select id="cboPrecedentRecordingSection" class="selectBox" style="width:196px" title=""
                          onchange="return updateUI(this);">
                  </select>
                </td>
              </tr>
              <tr>
                <td>Volumen:</td>
                <td>
                    <select id="cboPrecedentRecordingBook" class="selectBox" style="width:300px" title=""
                            onchange="return updateUI(this);">
                      <option value="">( Primero seleccionar Distrito y sección )</option>
                    </select>
                </td>
              </tr>
              <tr>
                <td>Partida:<br />&nbsp;</td>
                <td>
                    <select id="cboPrecedentRecording" class="selectBox" style="width:98px" title=""
                            onchange="return updateUI(this);">
                        <option value="">¿Libro?</option>
                    </select>
                      <span id="divPropertySelectorSection" style="display:none">
                        Antecedente: &nbsp; &nbsp;
                          <select id="cboPrecedentProperty" class="selectBox" style="width:300px" title="" onchange="return updateUI(this);">
                            <option value="">¿Inscripción?</option>
                          </select>
                        </span>
                        <span id="divRecordingQuickAddSection" style="display:none">
                          Partida donde está registrado el antecedente:
                          <input id="txtQuickAddRecordingNumber" type="text" class="textBox" style="width:52px;margin-right:0"
                                  onkeypress="return recordingNumberKeyFilter(this);" title="" maxlength="9" />
                          <select id="cboQuickAddBisRecordingTag" class="selectBox" style="width:60px" title="">
                            <option value=""></option>
                            <option value="-Bis">-Bis</option>
                            <option value="-Bis1">-Bis1</option>
                            <option value="-Bis2">-Bis2</option>
                          </select>
                        </span>
                    <br />&nbsp;
                </td>
            </table>
            <br />
            <span id="divResourceName" style="display:none">
              Nombre:
              <input id="txtResourceName" type="text" class="textBox" style="width:344px;margin-right:0" maxlength="255" />
              <br/>
            </span>

            <span id="divCadastralInfo" style="display:none">
              Clave catastral:
              <input id="txtCadastralKey" type="text" class="textBox" style="width:230px;margin-right:0" maxlength="38" />
              &nbsp;
              <input type="button" value="Vincular" class="button" style="width:68px;height:24px;vertical-align:middle"
                   onclick='doRecordingActEditorOperation("getCadastralInfo")' />
              <br/>
            </span>
          </td>
          <td class="lastCell">&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
  <tr id="divPartitionSectionTitle" style="display:none">
    <td class="actionsSeparator">(2) Información sobre la fracción que se va a crear a partir del antecedente
    </td>
  </tr>
  <tr id="divPartitionSectionContent" style="display:none">
    <td>
        <table class="editionTable">
          <tr>
            <td>Tipo de fracción:</td>
            <td>
              <select id="cboPropertyPartitionType" class="selectBox" style="width:146px" title=""
                      onchange="return updateUI(this);">
                <option value="">( Seleccionar )</option>
                <option value="Bodega">Bodega</option>
                <option value="Casa">Casa</option>
                <option value="Departamento">Departamento</option>
                <option value="Estacionamiento">Estacionamiento</option>
                <option value="Fracción">Fracción</option>
                <option value="Local comercial">Local comercial</option>
                <option value="Lote">Lote</option>
              </select>
            </td>
            <td>Número:</td>
            <td><input id="txtPartitionNo" type="text" class="textBox" style="width:66px;margin-right:0" maxlength="10" /></td>
            <td class="lastCell">
              <label><input id="chkNoNumberPartition" type="checkbox" onclick="updatePartitionControls();" />Sin número</label>
              <label><input id="chkGeneratePartitionRank" type="checkbox" onclick="updatePartitionControls()" />Generar un rango</label>
            </td>
          </tr>
          <tr id="divRepeatPartitionUntilRow" style="display:none">
            <td colspan="2">&nbsp;</td>
            <td>Número final:</td>
            <td><input id="txtRepeatPartitionUntil" type="text" class="textBox" style="width:66px;margin-right:0" maxlength="4" /></td>
            <td class="lastCell">&nbsp;</td>
          </tr>
        </table>
    </td>
  </tr>
  <tr id="divTargetPrecedentActSectionTitle" style="display:none">
    <td class="actionsSeparator">(2) Seleccionar el acto jurídico a cancelar o modificar</td>
  </tr>
  <tr id="divTargetPrecedentActTable" style="display:none">
    <td>
      <table class="editionTable">
        <tr>
          <td class="lastCell">
            <div style="overflow:auto;width:780px;">
              <table class="details"style="width:99%">
                <tr class="detailsHeader">
                  <td>#</td>
                  <td>Acto jurídico</td>
                  <td>Documento</td>
                  <td>Presentación</td>
                  <td>Registrado en</td>
                  <td>Estado</td>
                </tr>
                <tr id='tblTargetPrecedentActsTable' class='totalsRow' style='display:inline'>
                  <td>&nbsp;</td>
                  <td colspan='5'>
                    <select id="cboTemporalId" class="selectBox" style="width:600px" title="">
                      <option value="">( Actos jurídicos del predio )</option>
                    </select>
                  </td>
                </tr>
                <tr class="totalsRow" style="display:none">
                  <td>&nbsp;</td>
                  <td colspan="5">
                    <a href="javascript:doRecordingActEditorOperation('showTargetActEditor')">
                    <img src="../themes/default/buttons/edit.gif" alt="" title="" style="margin-right:8px" />El acto jurídico a cancelar o modificar no aparece en la lista</a>
                  </td>
                </tr>
              </table>
            </div>
          </td>
        </tr>
      </table>
      </td>
    </tr>
    <tr id="divTargetPrecedentActSection" style="display:none">
    <td>
      <table class="editionTable">
        <tr>
          <td>Que aplica a:</td>
          <td>
            <select id="cboTargetAct" class="selectBox" style="width:202px" title="" onchange="return updateUI(this);">
              <option value="">( Acto a cancelar o modificar )</option>
              <option value="2250">Crédito hipotecario</option>
              <option value="2729">Embargo</option>
              <option value="2256">Fianza</option>
            </select>
          </td>
          <td>
            Inscrito(a) en:
            <select id="cboTargetActSection" class="selectBox" style="width:267px" title=""
                    onchange="return updateUI(this);">
              <option value="">( Seleccionar acto jurídico a cancelar o modificar ) </option>
            </select>
          </td>
          <td class="lastCell">&nbsp;</td>
        </tr>
        <tr id="divTargetActBookAndRecording" style="display:none">
          <td colspan="2"></td>
          <td>Volumen:
            <select id="cboTargetActPhysicalBook" class="selectBox" style="width:291px" title=""
                    onchange="return updateUI(this);">
            </select>
            Partida:
            <select id="cboTargetActRecording" class="selectBox" style="width:98px" title=""
                    onchange="return updateUI(this);">
            </select>
            <img src="../themes/default/buttons/search.gif" alt="" title="Ejecuta la búsqueda" style="margin-left:-8px"
                  onclick="doRecordingActEditorOperation('showPrecedentRecording')" />
            <span id="divTargetActRecordingQuickAddSection" style="display:inline">
            <br />
            Partida donde fue registrado el acto:
            <input id="txtTargetActPhysicalRecordingNo" type="text" class="textBox" style="width:52px;margin-right:0"
                   onkeypress="return recordingNumberKeyFilter(this);" maxlength="9" />
            <select id="cboTargetActBisRecordingTag" class="selectBox" style="width:60px" title="">
              <option value=""></option>
              <option value="-Bis">-Bis</option>
              <option value="-Bis1">-Bis1</option>
              <option value="-Bis2">-Bis2</option>
            </select>
            <- CUIDADO: <u>No</u> se refiere al número de fracción
            </span>
          </td>
          <td class="lastCell">&nbsp;</td>
          </tr>
        </table>
      </td>
  </tr>
</table>
<script type="text/javascript">
  /* <![CDATA[ */

  function doRecordingActEditorOperation(command) {
    var success = false;

    if (gbSended) {
      return;
    }
    switch (command) {
      case 'appendRecordingAct':
        return appendRecordingAct();
      case 'lookupResource':
        return lookupResource();
      case 'getCadastralInfo':
        return getCadastralInfo();
      case 'showPrecedentRecording':
        return showPrecedentRecording();
      case 'showPrecedentProperty':
        return showPrecedentProperty();
      case 'showTargetActEditor':
        return showTargetActEditor();
      default:
        alert("La operación '" + command + "' todavía no ha sido definida en el editor de actos jurídicos.");
        return;
    }
    if (success) {
      sendPageCommand(command);
      gbSended = true;
    }
  }

  var olookupResource = null;
  function lookupResource() {
    if (getElement("txtLookupResource").value.length == 0) {
      alert("Requiero se proporcione el folio real o número de documento para hacer la búsqueda");
      return;
    }

    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=lookupResource";
    url += "&resourceUID=" + getElement("txtLookupResource").value;

    olookupResource = invokeAjaxGetJsonObject(url);

    if (olookupResource.Id == -1) {
      _selectedResource = null;
      alert("No existe ningún predio con el folio proporcionado.");
      return false;
    } else {
      _selectedResource = olookupResource.Id;
      alert("Predio encontrado.");
      getElement("divPhysicalRecordingSelector").style.display = 'none';
      showTargetRecordingActSections();
      return true;
    }
  }

  function updatePartitionControls() {
    if (getElement("chkNoNumberPartition").checked) {
      getElement("txtPartitionNo").value = "";
      getElement("txtPartitionNo").disabled = true;
      getElement("chkGeneratePartitionRank").checked = false;
      getElement("chkGeneratePartitionRank").disabled = true;
      getElement("txtRepeatPartitionUntil").value = "";
    } else {
      getElement("txtPartitionNo").disabled = false;
      getElement("chkGeneratePartitionRank").disabled = false;
    }
    if (getElement("chkGeneratePartitionRank").checked) {
      getElement("divRepeatPartitionUntilRow").style.display = "inline";
    } else {
      getElement("divRepeatPartitionUntilRow").style.display = "none";
    }
  }

  function getCadastralInfo() {
    var cadastralKey = getElement('txtCadastralKey').value;

    if (cadastralKey == '') {
      alert("Requiero se proporcione la clave catastral del predio.");
      return;
    } else {
      alert("Desafortunadamente no tenemos conexión con el sistema de catastro.");
    }
  }

  function appendRecordingAct() {
    if (!assertAppendRecordingActIsPossible()) {
      return false;
    }
    if (!validateRecordingAct()) {
      return false;
    }
    if (!validateRecordingActSemantics()) {
      return false;
    }

    var qs = getRecordingActQueryString();
    qs = qs.replace(/&/g, "|");
    if (!showConfirmFormCreateRecordingAct()) {
      return false;
    }
    sendPageCommand("appendRecordingAct", qs);
  }

  function assertAppendRecordingActIsPossible() {
    <% if (base.Transaction.IsEmptyInstance) { %>
    alert("Este control no está ligado a un trámite válido.");
    return false;
    <% } %>
    <% if (base.Transaction.Document.IsEmptyInstance) { %>
    alert("Primero requiero se ingresen los datos de la escritura o documento que se va a inscribir.");
    return false;
    <% } %>
    <% if (!base.IsReadyForEdition()) { %>
    alert("No es posible inscribir en libros debido a que el trámite no está en un estado válido para ello, o bien, no cuenta con los permisos necesarios para efectuar esta operación.");
    return false;
    <% } %>
    return true;
  }

  var oCurrentRecordingRule = null;

  function setRecordingRule() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getRecordingActRuleCmd";
    url += "&recordingActTypeId=" + getElement("cboRecordingActType").value;

    oCurrentRecordingRule = invokeAjaxGetJsonObject(url);

    if (oCurrentRecordingRule.IsCancelation) {
      updateTargetRecordingActCombos();
    }
  }

  function updateTargetRecordingActCombos() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getTargetRecordingActTypesCmd";
    url += "&recordingActTypeId=" + getElement("cboRecordingActType").value;

    invokeAjaxComboItemsLoader(url, getElement('cboTargetAct'));

    resetTargetActSectionCombo();
  }

  function updateUI(oControl) {
    if (oControl == null) {
      return;
    }
    if (oControl == getElement("cboRecordingActTypeCategory")) {
      if (!assertAppendRecordingActIsPossible()) {
        getElement("cboRecordingActTypeCategory").value = '';
        return;
      }
      resetRecordingActTypesCombo();
      setRecordingRule();
    } else if (oControl == getElement("cboRecordingActType")) {
      setRecordingRule();
      resetPropertyTypeSelectorCombo();
      showTargetRecordingActSections();
    } else if (oControl == getElement("cboRecordingTaskType")) {
      showPrecedentRecordingSection();
    } else if (oControl == getElement("cboPrecedentRecordingSection")) {
      resetPrecedentDomainBooksCombo();
    } else if (oControl == getElement("cboPrecedentRecordingBook")) {
      resetPrecedentRecordingsCombo();
    } else if (oControl == getElement("cboPrecedentRecording")) {
      showPrecedentPropertiesSection();
      updateSelectedResource();
      showTargetRecordingActSections();
    } else if (oControl == getElement("cboPrecedentProperty")) {
      updateSelectedResource();
      showTargetRecordingActSections();
    } else if (oControl == getElement("cboTargetAct")) {
      resetTargetActSectionCombo();
      showTargetRecordingActSections();
    } else if (oControl == getElement("cboTargetActSection")) {
      resetTargetActPhysicalBooksCombo();
      showTargetRecordingActSections();
    } else if (oControl == getElement("cboTargetActPhysicalBook")) {
      resetTargetActRecordingsCombo();
    } else if (oControl == getElement("cboTargetActRecording")) {
      resetTargetActsGrid();
    }
  }

  function resetTargetActSectionCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getTargetActSectionsStringArrayCmd";
    if (getElement("cboTargetAct").value.length != 0) {
      url += "&recordingActTypeId=" + getElement('cboTargetAct').value;
    } else {
      url += "&recordingActTypeId=-1";
    }
    invokeAjaxComboItemsLoader(url, getElement('cboTargetActSection'));

    resetTargetActPhysicalBooksCombo();
  }

  function isSelectedTargetActSection() {
    return getElement('cboTargetActSection').value != '' &&
           getElement('cboTargetActSection').value != 'annotation';
  }

  function resetTargetActPhysicalBooksCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getDomainBooksStringArrayCmd";
    if (isSelectedTargetActSection()) {
      url += "&sectionFilter=" + getElement('cboTargetActSection').value;
    }
    invokeAjaxComboItemsLoader(url, getElement('cboTargetActPhysicalBook'));

    resetTargetActRecordingsCombo();
  }

  function resetTargetActRecordingsCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getRecordingNumbersStringArrayCmd";
    if (getElement("cboTargetActPhysicalBook").value.length != 0) {
      url += "&recordingBookId=" + getElement("cboTargetActPhysicalBook").value;
    } else {
      url += "&recordingBookId=0";
    }
    invokeAjaxComboItemsLoader(url, getElement("cboTargetActRecording"));
    resetTargetActsGrid();
  }

  function resetTargetActsGrid() {
    //alert("resetTargetActsGrid");
  }

  function showPrecedentPropertiesSection() {
    var selectedValue = getElement('cboPrecedentRecording').value;
    if (selectedValue != "-1") {
      resetPrecedentPropertiesCombo();
      getElement('divRecordingQuickAddSection').style.display = 'none';
      getElement('divPropertySelectorSection').style.display = 'inline';
    } else {
      getElement('divRecordingQuickAddSection').style.display = 'inline';
      getElement('divPropertySelectorSection').style.display = 'none';
    }
  }

  function resetRecordingActTypesCategoriesCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getRecordingActTypesEditingCategoriesCmd";
    invokeAjaxComboItemsLoader(url, getElement('cboRecordingActTypeCategory'));
  }

  function resetPrecedentRecordingSectionCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getDomainTraslativeSectionsCmd";

    invokeAjaxComboItemsLoader(url, getElement('cboPrecedentRecordingSection'));
  }

  function resetPrecedentDomainBooksCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getDomainBooksStringArrayCmd";
    if (getElement("cboPrecedentRecordingSection").value.length != 0) {
      url += "&sectionFilter=" + getElement('cboPrecedentRecordingSection').value;
    }
    invokeAjaxComboItemsLoader(url, getElement('cboPrecedentRecordingBook'));
    resetPrecedentRecordingsCombo();
  }

  function resetPrecedentRecordingsCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getRecordingNumbersStringArrayCmd";
    if (getElement("cboPrecedentRecordingBook").value.length != 0) {
      url += "&recordingBookId=" + getElement("cboPrecedentRecordingBook").value;
    } else {
      url += "&recordingBookId=0";
    }
    if (getElement("cboRecordingActType").value.length != 0) {
      url += "&recordingActTypeId=" + getElement("cboRecordingActType").value;
    }
    invokeAjaxComboItemsLoader(url, getElement("cboPrecedentRecording"));
    showPrecedentPropertiesSection();
    updateSelectedResource();
    showTargetRecordingActSections();
  }

  function resetPropertyTypeSelectorCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getPropertyTypeSelectorComboCmd";
    url += "&recordingActTypeId=" + getElement("cboRecordingActType").value;

    invokeAjaxComboItemsLoader(url, getElement("cboRecordingTaskType"));
    showPrecedentRecordingSection();
  }

  function resetPrecedentPropertiesCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getRecordingPropertiesArrayCmd";
    if (getElement("cboPrecedentRecording").value.length != 0) {
      url += "&recordingId=" + getElement("cboPrecedentRecording").value;
    } else {
      url += "&recordingId=0";
    }
    if (getElement("cboRecordingActType").value.length != 0) {
      url += "&recordingActTypeId=" + getElement("cboRecordingActType").value;
    }
    invokeAjaxComboItemsLoader(url, getElement("cboPrecedentProperty"));
  }

  function resetRecordingActTypesCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getRecordingTypesStringArrayCmd";
    url += "&recordingActTypeCategoryId=" + getElement('cboRecordingActTypeCategory').value;

    invokeAjaxComboItemsLoader(url, getElement("cboRecordingActType"));
    resetPropertyTypeSelectorCombo();
  }

  function validateRecordingActSemantics() {
    var ajaxURL = "../ajax/land.registration.system.data.aspx";
    ajaxURL += "?commandName=validateDocumentRecordingActCmd";
    ajaxURL += "&" + getRecordingActQueryString();

    return invokeAjaxValidator(ajaxURL);
  }

  function isCreateResourceTask() {
    return getElement("cboRecordingTaskType").value == "createProperty";
  }

  function showPrecedentRecordingSection() {
    getElement("divPhysicalRecordingSelector").style.display = "none";
    getElement("divPrecedentActSection").style.display = "none";
    getElement("divPartitionSectionTitle").style.display = "none";
    getElement("divPartitionSectionContent").style.display = "none";
    getElement("divResourceName").style.display = "none";
    getElement("divCadastralInfo").style.display = "none";
    switch (getElement("cboRecordingTaskType").value) {
      case "selectProperty":                      // Already registered
        getElement("divPhysicalRecordingSelector").style.display = getElement('chkSelectPredecentInPhysicalBooks').checked ? "inline" : "none";
        getElement("divPrecedentActSection").style.display = "inline";
        getElement("divResourceName").style.display = oCurrentRecordingRule.AskForResourceName ? "inline" : "none";
        break;
      case "createProperty":                    // New properties
        getElement("divResourceName").style.display = oCurrentRecordingRule.AskForResourceName ? "inline" : "none";
        getElement("divCadastralInfo").style.display = oCurrentRecordingRule.AskForResourceName ? "none" : "inline";
        break;
      case "createPartition":                     // Already registered and create partition
        getElement("divPhysicalRecordingSelector").style.display = getElement('chkSelectPredecentInPhysicalBooks').checked ? "inline" : "none";
        getElement("divPrecedentActSection").style.display = "inline";
        getElement("divPartitionSectionTitle").style.display = "inline";
        getElement("divPartitionSectionContent").style.display = "inline";
        getElement("divResourceName").style.display = oCurrentRecordingRule.AskForResourceName ? "inline" : "none";
        getElement("divCadastralInfo").style.display = "inline";
        break;
      case "actNotApplyToProperty":             // Recording act doesn't apply to properties
        break;
      case "actAppliesToOtherRecordingAct":    // Recording act applies to another recording act
        getElement("divPhysicalRecordingSelector").style.display = getElement('chkSelectPredecentInPhysicalBooks').checked ? "inline" : "none";
        getElement("divPrecedentActSection").style.display = "inline";
        break;
      case "actAppliesOnlyToSection":         // Recording act only needs a district
        getElement("divResourceName").style.display = oCurrentRecordingRule.AskForResourceName ? "inline" : "none";
        break;
      default:
        break;
    }
    showTargetRecordingActSections();
  }

  // Represents the resource that was selected using the search box. Returns null if no resource was selected.
  var _selectedResource = null;
  function getSelectedResource() {
    return _selectedResource;
  }

  function updateSelectedResource() {
    var isResourceSelected = (!createAntecedentResource() && getElement("cboPrecedentProperty").value != '');

    if (!isResourceSelected) {
      _selectedResource = null;
    } else if (isResourceSelected && _selectedResource == null) {
      _selectedResource = getElement("cboPrecedentProperty").value;
    } else if (isResourceSelected && _selectedResource != null) {
      // TODO: && was changed
      _selectedResource = getElement("cboPrecedentProperty").value;
    }
  }

  function updateTargetPrecedentActsTable() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getTargetPrecedentActsTableCmd";
    url += "&recordingActTypeId=" + getElement("cboRecordingActType").value;
    url += "&resourceId=" + getSelectedResource();

    invokeAjaxComboItemsLoader(url, getElement("cboTemporalId"));

    //var html = invokeAjaxMethod(false, url, null);
    //getElement('tblTargetPrecedentActsTable').innerHTML = html;
  }

  // Represents the resource that was selected using the search box. Returns null if no resource was selected.
  function createAntecedentResource() {
    return (getElement("cboPrecedentRecording").value == "-1");
  }

  function showTargetActEditor() {
    getElement("divTargetPrecedentActSectionTitle").style.display = "inline";
    getElement("divTargetPrecedentActTable").style.display = "inline";
    getElement("divTargetPrecedentActSection").style.display = "inline";
  }

  function showTargetRecordingActSections() {
    var selectedResource = getSelectedResource();
    var createResource = createAntecedentResource();

    var applyTargetRecording = (getElement("cboRecordingTaskType").value == "actAppliesToOtherRecordingAct" &&
                               (selectedResource != null || createResource));


    if (!applyTargetRecording) {
      getElement("divTargetPrecedentActSectionTitle").style.display = "none";
      getElement("divTargetPrecedentActTable").style.display = "none";
      getElement("divTargetPrecedentActSection").style.display = "none";
      return;
    }

    if (createResource) {   // Allows to add the recording act to cancel or modify
      getElement("divTargetPrecedentActSectionTitle").style.display = "inline";
      getElement("divTargetPrecedentActTable").style.display = "none";
      getElement("divTargetPrecedentActSection").style.display = "inline";
    } else {                // Show a table to select the recording act to cancel or modify
      updateTargetPrecedentActsTable();
      getElement("divTargetPrecedentActSectionTitle").style.display = "inline";
      getElement("divTargetPrecedentActTable").style.display = "inline";
      getElement("divTargetPrecedentActSection").style.display = "inline";
    }
    if (isSelectedTargetActSection()) {
      getElement("divTargetActBookAndRecording").style.display = "inline";
    } else {
      getElement("divTargetActBookAndRecording").style.display = "none";
    }
  }

  function showPrecedentRecording() {
    var bookId = getElement('cboPrecedentRecordingBook').value;
    var recordingId = getElement('cboPrecedentRecording').value;

    if (bookId.length == 0 || bookId == "-1") {
      alert("Primero necesito se seleccione un libro de la lista de arriba.");
      return;
    }
    if (recordingId.length == 0 || recordingId == "-1") {
      alert("Necesito se seleccione una partida de la lista.");
      return;
    }
    var url = "../land.registration.system/recording.book.analyzer.aspx?bookId=" + bookId +
              "&id=" + recordingId;

    createNewWindow(url);
  }

  function showPrecedentProperty() {
    var propertyId = getElement("cboPrecedentProperty").value;
    if (propertyId.length == 0 || propertyId == "-1" || propertyId == "0") {
      alert("Necesito se seleccione un predio de la lista.");
      return;
    }
    var url = "../land.registration.system/property.editor.aspx?propertyId=" + propertyId +
              "&recordingActId=-1&recordingId=" + getElement('cboPrecedentRecording').value;
    createNewWindow(url);
  }

  function showConfirmFormCreateRecordingAct() {
    var sMsg = "Agregar el acto jurídico al documento:\n\n";

    sMsg += 'Documento:\t<%=base.Transaction.Document.UID%>\n';
    sMsg += 'Trámite:\t\t<%=base.Transaction.UID%>\n';
    sMsg += 'Interesado(s):\t<%=Empiria.EmpiriaString.FormatForScripting(base.Transaction.RequestedBy)%>\n\n';

    sMsg += "Acto jurídico que se registrará:\n\n";
    sMsg += "Acto jurídico:\t" + getComboOptionText(getElement('cboRecordingActType')) + "\n";
    if (isCreateResourceTask()) {
      sMsg += "Predio:\t\t" + "Predio sin antecedente registral" + "\n";
      sMsg += "Clave catastral:\t" + getElement('txtCadastralKey').value + "\n\n";
    } else if (getElement('cboPrecedentRecording').value.length == 0) {
      sMsg += getPartitionText();
      sMsg += "Predio:\t\t" + getSelectedResourceText() + "\n\n";

    } else if (getElement('cboPrecedentRecording').value.length != 0 &&
               getElement('cboPrecedentRecording').value != "-1") {
      alert(getElement('cboPrecedentRecording').value);
      sMsg += getPartitionText();
      sMsg += "Predio:\t\t" + getSelectedResourceText() + "\n";
      sMsg += "Antecedente en:\t" + "Partida " + getPhysicalRecordingNumber() + "\n";
      sMsg += "\t\t" + getComboOptionText(getElement('cboPrecedentRecordingBook')) + "\n\n";
    } else {
      sMsg += getPartitionText();
      sMsg += "Antecedente:\t" + "Crear folio real en partida " + getPhysicalRecordingNumber() + "\n";
      sMsg += "\t\t" + getComboOptionText(getElement('cboPrecedentRecordingBook')) + "\n\n";
    }
    if (getElement('cboRecordingTaskType').value == 'actAppliesToOtherRecordingAct') {
      sMsg += "Acto jurídico a cancelar o modificar:\n\n";
      if (getElement('cboTemporalId').value != '') {
        sMsg += "Acto involucrado:\t" + getComboOptionText(getElement('cboTemporalId')) + "\n";
      } else {
        sMsg += "Acto involucrado:\t" + getComboOptionText(getElement('cboTargetAct')) + "\n";
        sMsg += "Registrado en:\t" + getTargetActPhysicalRecordingText() + "\n\n";
      }
    }

    sMsg += "¿Registro este acto jurídico en el documento";
    if (getElement('cboRecordingTaskType').value == 'createPartition') {
      sMsg += " y lo aplico a UNA NUEVA FRACCIÓN del antecedente";
    }
    sMsg += "?";
    return confirm(sMsg);
  }

  function getPhysicalRecordingNumber() {
    if (getElement('cboPrecedentRecording').value != "-1") {
      return getComboOptionText(getElement('cboPrecedentRecording'));
    } else {
      return getElement('txtQuickAddRecordingNumber').value + getComboOptionText(getElement('cboQuickAddBisRecordingTag'));
    }
  }

  function getPartitionText() {
    var sMsg = '';
    if (getElement('cboRecordingTaskType').value != 'createPartition') {
      return '';
    }
    sMsg += "\t\tSobre " + getElement('cboPropertyPartitionType').value;
    if (getElement('chkNoNumberPartition').checked) {
      sMsg += " sin número";
    } else {
      sMsg += " No. " + getElement('txtPartitionNo').value;
    }
    if (getElement('chkGeneratePartitionRank').checked) {
      sMsg += " al No. " + getElement('txtRepeatPartitionUntil').value + "\n";
      sMsg += "\t\tlos cuales son NUEVAS FRACCIONES del\n";
    } else {
      sMsg += "\n\t\tel cual es UNA NUEVA FRACCIÓN del\n";
    }
    return sMsg;
  }

  function getSelectedResourceText() {
    if (getSelectedResource() != null) {
      if (getElement('cboPrecedentProperty').value != '') {
        return getComboOptionText(getElement('cboPrecedentProperty'));
      } else {
        return getElement('txtLookupResource').value;
      }
    }
    return "Predio no reconocido";
  }

  function getTargetActPhysicalRecordingText() {
    if (getElement('cboTargetActSection').value == "annotation") {
      return "Al margen de la partida";
    }
    return getComboOptionText(getElement('cboTargetActPhysicalBook')) + "\n" +
                              "\t\tpartida " + getElement('txtTargetActPhysicalRecordingNo').value +
                              getComboOptionText(getElement('cboTargetActBisRecordingTag'));
  }

  function validateRecordingAct() {
    var recordingAct = getComboOptionText(getElement('cboRecordingActType'));

    if (getElement('cboRecordingActTypeCategory').value.length == 0) {
      alert("Necesito se seleccione de la lista la categoría del acto jurídico que va a agregarse al documento.");
      getElement('cboRecordingActTypeCategory').focus();
      return false;
    }
    if (getElement('cboRecordingActType').value == "") {
      alert("Requiero se seleccione de la lista el acto jurídico que va a agregarse al documento.");
      getElement('cboRecordingActType').focus();
      return false;
    }
    <%  if (base.Transaction.Status == Empiria.Land.Registration.Transactions.TransactionStatus.Elaboration) { %>
    if (getElement('cboRecordingActType').value != "2201") {
        alert("En elaboración de certificados sólo es posible agregar el acto 'Asignación de folio real'.");
        getElement('cboRecordingActType').focus();
        return false;
      }
    <% } %>
    if (getElement('cboRecordingTaskType').value.length == 0) {
      alert("Requiero se proporcione la información del predio o recurso sobre el que se aplicará el acto jurídico " + recordingAct + ".");
      getElement('cboRecordingTaskType').focus();
      return false;
    }
    if (oCurrentRecordingRule.AskForResourceName &&
        getElement('txtResourceName').value.length == 0) {
      alert("Necesito se proporcione el nombre de la asociación o sociedad civil.");
      getElement('txtResourceName').focus();
      return false;
    }

    switch (getElement('cboRecordingTaskType').value) {
      case 'selectProperty':
        if (!validateResourceIsSelected()) {
          return false;
        }
        break;
      case 'createPartition':
        if (!validateResourceIsSelected()) {
          return false;
        }
        if (!validatePartition()) {
          return false;
        }
        break;
      case 'actAppliesToOtherRecordingAct':
        if (!validateResourceIsSelected()) {
          return false;
        }
        if (!validateTargetAct()) {
          return false;
        }
        break;
      default:
        break;
    }
    return true;
  }

  function validatePartition() {
    if (getElement('cboPropertyPartitionType').value.length == 0) {
      alert("Necesito conocer el tipo de fracción que se desea crear.");
      getElement('cboPropertyPartitionType').focus();
      return false;
    }
    if (!getElement('chkNoNumberPartition').checked &&
         getElement('txtPartitionNo').value.length == 0) {
      alert("Necesito conocer el número de " + getElement('cboPropertyPartitionType').value + ".");
      getElement('txtPartitionNo').focus();
      return false;
    }
    if (getElement('chkGeneratePartitionRank').checked &&
        getElement('txtRepeatPartitionUntil').value.length == 0) {
      alert("Necesito conocer el número de " + getElement('cboPropertyPartitionType').value +
            " donde termina el rango que se desea generar.");
      getElement('txtRepeatPartitionUntil').focus();
      return false;
    }
    return true;
  }

  function validateTargetAct() {
    if (targetSelectedFromActsGrid()) {
      return true;
    }
    // Validate data for target act creation
    if (getElement('cboTargetAct').value.length == 0) {
      alert("Necesito se seleccione el acto jurídico a cancelar o modificar.");
      getElement('cboTargetAct').focus();
      return false;
    }
    // Validate data for target act creation
    if (getElement('cboTargetActSection').value.length == 0) {
      alert("Necesito se seleccione el distrito y sección del volumen donde está inscrito el acto jurídico que se va a cancelar o modificar.");
      getElement('cboTargetActSection').focus();
      return false;
    }
    if (getElement('cboTargetActSection').value == "annotation") {
      getElement('cboTargetActPhysicalBook').value = '';
      getElement('cboTargetActRecording').value = '';
      getElement('txtTargetActPhysicalRecordingNo').value = '';
      return true;
    }
    if (getElement('cboTargetActPhysicalBook').value.length == 0) {
      alert("Necesito se seleccione el volumen donde se encuentra inscrito el acto jurídico que se va a cancelar o modificar.");
      getElement('cboTargetActPhysicalBook').focus();
      return false;
    }
    if (getElement('cboTargetActRecording').value.length == 0) {
      alert("Necesito se seleccione la partida donde se encuentra inscrito el acto jurídico que se va a cancelar o modificar.");
      getElement('cboTargetActRecording').focus();
      return false;
    }
    if (getElement('cboTargetActRecording').value == "-1") {    // create physical recording
      if (getElement('txtTargetActPhysicalRecordingNo').value.length == 0) {
        alert("Necesito se capture el número de partida donde está inscrito que se va a cancelar o modificar.");
        getElement('txtTargetActPhysicalRecordingNo').focus();
        return false;
      }
      if (!isValidRecordingNumber(getElement('txtTargetActPhysicalRecordingNo').value)) {
        alert("El número de partida donde está inscrito el acto que se va a cancelar o modificar " +
              "tiene un formato que no reconozco.\nEjemplos de formatos válidos son: 123 o 234 o 123/4 o 34/345.");
        getElement('txtTargetActPhysicalRecordingNo').focus();
        return false;
      }
    }
    return true;
  }

  function isValidRecordingNumber(recordingNumber) {
    if (isNumericValue(recordingNumber)) {
      return true;
    }
    var pattern = "^[0-9]+\/[0-9]+$";
    var regex = new RegExp(pattern);

    return regex.test(recordingNumber);
  }

  function recordingNumberKeyFilter(oEvent) {
    var keyCode = getKeyCode(oEvent);

    if (isNumericKeyCode(keyCode) || keyCode == 47) {
      return true;
    } else {
      return false;
    }
  }

  function targetSelectedFromActsGrid() {
    if (getElement('cboTemporalId').value != '') {
      //alert('La cancelación de actos ya inscritos con el sistema no está disponible.');
      //return false;
      return true;
    }
    return false;
  }

  function validateResourceIsSelected() {
    if (getSelectedResource() != null) {
      return true;
    }
    var recordingAct = getComboOptionText(getElement('cboRecordingActType'));

    if (getElement('cboPrecedentRecordingSection').value.length == 0) {
      alert("Necesito conocer el distrito o sección donde se encuentra el antecedente registral del predio.");
      getElement('cboPrecedentRecordingSection').focus();
      return false;
    }
    if (getElement('cboPrecedentRecordingBook').value.length == 0) {
      alert("Requiero se seleccione el libro registral donde está inscrito el predio sobre el que se aplicará el acto jurídico " + recordingAct + ".");
      getElement('cboPrecedentRecordingBook').focus();
      return false;
    }
    if (getElement('cboPrecedentRecording').value.length == 0) {
      alert("Necesito se seleccione de la lista el número de partida donde está registrado el antecedente del predio.");
      getElement('cboPrecedentRecording').focus();
      return false;
    }
    if (getElement('cboPrecedentRecording').value == "-1" &&
        getElement('txtQuickAddRecordingNumber').value.length == 0) {
      alert("Necesito se capture el número de partida que se va a agregar y que corresponde al antecedente registral del predio sobre el que se aplicará el acto jurídico.");
      getElement('txtQuickAddRecordingNumber').focus();
      return false;
    }
    if (getElement('cboPrecedentRecording').value == "-1" &&
        getElement('txtQuickAddRecordingNumber').value.length != 0 &&
        !isValidRecordingNumber(getElement('txtQuickAddRecordingNumber').value)) {
      alert("El número de partida tiene un formato que no reconozco.\nDebería ser un número.");
      getElement('txtQuickAddRecordingNumber').focus();
      return false;
    }
    if (getElement('cboPrecedentRecording').value.length != 0 &&
        getElement('cboPrecedentRecording').value != "-1" &&
        getElement('cboPrecedentProperty').value.length == 0) {
      alert("Necesito se seleccione de la lista el folio del predio al que aplicará el acto jurídico " + recordingAct + ".");
      getElement('cboPrecedentProperty').focus();
      return false;
    }
    return true;
  }

  function getRecordingActQueryString() {
    var qs = "transactionId=<%=base.Transaction.Id%>";
    qs += "&documentId=<%=base.Document.Id%>\n";
    qs += "&recordingActTypeId=" + getElement('cboRecordingActType').value;
    qs += "&recordingTaskType=" + getElement('cboRecordingTaskType').value;
    qs += "&cadastralKey=" + getElement('txtCadastralKey').value;
    qs += "&precedentRecordingBookId=" + getElement('cboPrecedentRecordingBook').value;
    qs += "&precedentRecordingId=" + getElement('cboPrecedentRecording').value;
    qs += "&quickAddRecordingNumber=" + getElement('txtQuickAddRecordingNumber').value +
                                        getElement('cboQuickAddBisRecordingTag').value;
    if (getSelectedResource() != null) {
      qs += "&precedentPropertyId=" + getSelectedResource();
    } else {
      qs += "&precedentPropertyId=" + getElement('cboPrecedentProperty').value;
    }
    qs += "&resourceName=" + getElement('txtResourceName').value;

    // Partition data
    if (getElement('cboRecordingTaskType').value == "createPartition") {
      qs += "&partitionType=" + getElement('cboPropertyPartitionType').value;
      qs += "&partitionNo=" + (getElement('chkNoNumberPartition').checked ?
                                          'sin número' : getElement('txtPartitionNo').value);
      qs += "&partitionRepeatUntilNo=" + (getElement('chkGeneratePartitionRank').checked ?
                                                     getElement('txtRepeatPartitionUntil').value : "");
    }

    // target act values
    qs += "&targetRecordingActId=" + getElement('cboTemporalId').value;

    qs += "&targetActTypeId=" + getElement('cboTargetAct').value;
    qs += "&targetActPhysicalBookId=" + getElement('cboTargetActPhysicalBook').value;
    qs += "&targetActRecordingId=" + getElement('cboTargetActRecording').value;
    qs += "&targetRecordingNumber=" + getElement('txtTargetActPhysicalRecordingNo').value +
                                      getElement('cboTargetActBisRecordingTag').value;

    return qs;
  }

  function initializeRecordingActEditor() {
    resetRecordingActTypesCategoriesCombo();
    resetPrecedentRecordingSectionCombo();
  }

  initializeRecordingActEditor();

  addEvent(getElement('txtLookupResource'), 'keypress', upperCaseKeyFilter);
  addEvent(getElement('txtResourceName'), 'keypress', upperCaseKeyFilter);
  addEvent(getElement('txtCadastralKey'), 'keypress', upperCaseKeyFilter);
  addEvent(getElement('txtPartitionNo'), 'keypress', upperCaseKeyFilter);
  addEvent(getElement('txtRepeatPartitionUntil'), 'keypress', upperCaseKeyFilter);

  /* ]]> */
</script>
