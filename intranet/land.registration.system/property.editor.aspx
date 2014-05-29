<%@ Page Language="C#" EnableViewState="true" AutoEventWireup="true" Inherits="Empiria.Web.UI.LRS.PropertyEditor" CodeFile="property.editor.aspx.cs" %>
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
  <script type="text/javascript" src="../scripts/empiria.validation.js"></script>
</head>
<body style="background-color:#fafafa; top:0px; margin:0px; margin-top:-14px; margin-left:-6px ">
<form name="aspnetForm" method="post" id="aspnetForm" runat="server">
<div id="divContent">
<table id="tabStripItemView_0" style="overflow:visible;display:inline;width:90%;height:98%;">
  <tr>
    <td class="subTitle">Identificación del predio</td>
  </tr>
  <tr>
    <td>
      <table class="editionTable">
      <tr>
        <td>Clave catastral:</td>
        <td>
          <input type="text" class="textBox" id='txtCadastralNumber' name='txtCadastralNumber' style="width:140px" maxlength="20" runat='server' title="" />
          <img src="../themes/default/buttons/search.gif" alt="" title="Ejecuta la búsqueda" style="margin-left:-4px" onclick="doOperation('searchCadastralNumber')" />
        </td>
        <td>Folio único:</td>
        <td class="lastCell">
          <input type="text" class="textBox" id='txtTractNumber' name='txtTractNumber' style="width:132px" readonly='readonly' runat='server' title="" />
          Estado:
          <input type="text" class="textBox" id='txtStatus' name='txtStatus' style="width:62px" readonly='readonly' runat='server' title="" />
        </td>
      </tr>
      <tr>
        <td>Tipo de predio:</td>
        <td>
          <select id="cboPropertyType" name="cboPropertyType" class="selectBox" style="width:200px" runat='server'>
            <option value="">( Seleccionar )</option>
          </select>
        </td>
        <td>Denominado:</td>
        <td class="lastCell">
          <input type="text" class="textBox" id='txtPropertyCommonName' name='txtPropertyCommonName' style="width:220px" runat='server' />
        </td>
      </tr>
      <tr>
        <td>Antecedente:<br />&nbsp;</td>
        <td class="lastCell" colspan="3">
          <textarea id="txtAntecendent" name="txtAntecendent" cols="310" rows="2" style="width:520px" class="textArea" runat="server"></textarea>
        </td>
      </tr>
      <tr>
        <td>Observaciones:<br />&nbsp;</td>
        <td class="lastCell" colspan="3">
          <textarea id="txtObservations" name="txtObservations" cols="310" rows="2" style="width:520px" class="textArea" runat="server"></textarea>
        </td>
      </tr>
      </table>
    </td>
  </tr>
   
  <tr>
    <td class="subTitle">Ubicación del predio</td>
  </tr>
  <tr>
    <td>
      <table class="editionTable">		  
      <tr>
        <td>Buscar/Agregar:</td>
        <td class="lastCell" colspan="5">
          <select id="cboSearchFields" name="cboSearchFields" class="selectBox" style="width:180px" runat='server'>
            <option value="0" title="">( Todos los campos )</option>
            <option value="310" title="settlements">Asentamientos</option>
            <option value="305" title="streetAndRoads" >Vialidades</option>
            <option value="309" title="postalcodes">Códigos postales</option>
          </select>
          <input type="text" class="textBox" id='txtSearchText' name='txtSearchText' style="width:240px" onkeypress="return onSearchTextBoxKeyFilter(window.event);" runat='server'/>
          <img src="../themes/default/buttons/search.gif" alt="" title="Ejecuta la búsqueda" style="margin-left:-4px" onclick="doOperation('searchGeographicalItems')" />
          &nbsp;<input type="button" value="Agregar" class="button" style="vertical-align:middle;width:54px;" tabindex="-1" onclick="doOperation('appendGeographicalItem')" />          
        </td>
      </tr>
      
      <tr>
        <td>Distrito:</td>
        <td class="lastCell" colspan="5">
          <select id="cboCadastralOffice" name="cboCadastralOffice" class="selectBox" style="width:180px" onchange="return updateUserInterface(this);" runat='server'>
          </select>
          Municipio:
          <select id='cboMunicipality' name='cboMunicipality' class='selectBox' style='width:284px' onchange="return updateUserInterface(this);" runat='server'>
            <option value="">( Seleccionar )</option>
          </select>
        </td> 
      </tr>

      <tr>
        <td>Asentamiento:</td>
        <td colspan="5" class="lastCell">
          <select id="cboSettlementType" name="cboSettlementType" class="selectBox" style="width:180px" onchange="return updateUserInterface(this);" runat='server' >
            <option value="">( Todos los asentamientos )</option>
            <option value="311">No determinado</option>
            <option value="313">Barrio</option>
            <option value="316">Ciudad</option>
            <option value="312">Colonia</option>
            <option value="318">Comunidad</option>
            <option value="315">Ejido</option>
            <option value="314">Fraccionamiento</option>
            <option value="324">Privada</option>
            <option value="322">Localidad</option>
            <option value="317">Población/Poblado</option>
            <option value="319">Rancho</option>
            <option value="320">Ranchería</option>
            <option value="321">Unidad habitacional</option>
          </select>
          <select id="cboSettlement" name="cboSettlement" class="selectBox" style="width:334px" onchange="return updateUserInterface(this);" runat='server' >
            <option value="">( Seleccionar )</option>
          </select>
        </td>
      </tr>

      <tr>
        <td>Calle/Avenida:</td>
        <td class="lastCell" colspan="5">
          <select id="cboStreetRoadType" name="cboStreetRoadType" class="selectBox" style="width:90px" onchange="return updateUserInterface(this);" runat='server'>
            <option value="">( Todos )</option>
            <option value="326">Calle</option>
            <option value="335">Calzada</option>
            <option value="327">Camino</option>
            <option value="328">Avenida</option>
            <option value="334">Boulevard</option>
            <option value="329">Carretera</option>
            <option value="333">Andador</option>
            <option value="330">Cerrada</option>
            <option value="331">Callejón</option>
            <option value="332">Privada</option>
          </select>
          <select id="cboStreetRoad" name="cboStreetRoad" class="selectBox" style="width:304px" runat='server'>
            <option value="">( Seleccionar ) </option>
          </select>
          C.P:
          <select id="cboPostalCode" name="cboPostalCode" class="selectBox" style="width:86px" runat='server'>
            <option value="">( ? )</option>
            <option value="">No consta</option>
          </select>
        </td>
      </tr>
      <tr>
        <td>Referencia ubic:</td>
        <td class="lastCell" colspan="5">
          <input type="text" class="textBox" id='txtUbication' name='txtUbication' style="width:520px" runat='server'/>
        </td>
      </tr>
      <tr>
        <td>Núm. exterior:</td>
        <td class="lastCell" colspan="5">
          <input type="text" class="textBox" id='txtExternalNumber' name='txtExternalNumber' style="width:36px;margin-right:0px;" title="Número exterior" maxlength="12" runat='server' />
          <input type="button" value="S/N" class="button" tabindex="-1" style="vertical-align:middle;width:25px;" onclick="doOperation('setNoNumberLabel');" />
          Int:
          <input type="text" class="textBox" id='txtInternalNumber' name='txtInternalNumber' style="width:74px" maxlength="36" title="Número interior: Condominio, Casa, Piso, Departamento, etc." runat='server'/>
          Fracc:
          <input type="text" class="textBox" id='txtFractionTag' name='txtFractionTag' style="width:22px" onkeypress="return integerKeyFilter(this);" maxlength="4" title="Fracción" runat='server' />
          Lote:
          <input type="text" class="textBox" id='txtBatchTag' name='txtBatchTag' style="width:22px" onkeypress="return integerKeyFilter(this);" maxlength="4" runat='server' />
          Mnz:
          <input type="text" class="textBox" id='txtBlockTag' name='txtBlockTag' style="width:18px" onkeypress="return integerKeyFilter(this);" maxlength="4" title="Manzana" runat='server' />
          Sec/Zn:
          <input type="text" class="textBox" id='txtSectionTag' name='txtSectionTag' style="width:18px" onkeypress="return notSpaceKeyFilter(this);" maxlength="4" title="Sección o zona" runat='server' />
          Cuartel:
          <input type="text" class="textBox" id='txtSuperSectionTag' name='txtSuperSectionTag' style="width: 18px" onkeypress="return integerKeyFilter(this);" maxlength="4" runat='server' />
        </td>
      </tr>
    </table>
    </td>
  </tr>
   
  <tr>
    <td class="subTitle">Superficie, indiviso y medidas y colindancias</td>
  </tr>
  
  <tr>
    <td>
      <table class="editionTable">
      <tr>  
        <td>Superficie:</td>
        <td class="lastCell" colspan="5">
          <input type="text" class="textBox" id='txtTotalArea' name='txtTotalArea' style="width:68px" maxlength="16" onkeypress="return positiveKeyFilter(this);" runat='server' title="" />
          <select id="cboTotalAreaUnit" name="cboTotalAreaUnit" class="selectBox" style="width:80px" runat='server' title="">
            <option value="">( ? )</option>
            <option value="-2">No consta</option>
            <option value="621" title="m2">M2</option>
            <option value="626" title="m2">M2 aprox</option>
            <option value="624" title="ha">Hectáreas</option>
            <option value="627" title="ha">Hec aprox</option>
            <option value="625" title="va">Varas</option>
          </select>
          Sup construida:
          <input type="text" class="textBox" id='txtFloorArea' name='txtFloorArea' style="width:46px;" maxlength="6" onkeypress="return positiveKeyFilter(this);" runat='server' title="" />
          <select id="cboFloorAreaUnit" name="cboFloorAreaUnit" class="selectBox" style="width:80px;margin-left:-6px" runat='server' title="">
            <option value="">( ? )</option>
            <option value="-2">No consta</option>
            <option value="621" title="m2">M2</option>
            <option value="626" title="m2">M2 aprox</option>
          </select>
          Indiviso:
          <input type="text" class="textBox" id='txtCommonArea' name='txtCommonArea' style="width:40px;" maxlength="7" onkeypress="return positiveKeyFilter(this);" title="" runat='server' />
          <select id="cboCommonAreaUnit" name="cboCommonAreaUnit" class="selectBox" style="width:44px;margin-left:-6px" title="" runat='server'>
            <option value="">(?)</option>
            <option value="-2">NC</option>
            <option value="622" title="%">%</option>
          </select>
        </td>
      </tr>

      <tr>
        <td style="vertical-align:text-top">Medidas<br />y<br />colindancias:</td>
        <td class="lastCell" colspan="5">
            <textarea id="txtMetesAndBounds" name="txtMetesAndBounds" cols="320" rows="9" style="width:542px" class="textArea" runat="server"></textarea>
        </td>
      </tr>

      <tr>
        <td class="separator" colspan="6">
        &nbsp;
        </td>
      </tr>
      <tr>
        <td class="lastCell"  colspan="6">
          <table>
            <tr>
              <td nowrap='nowrap'><input type="button" value="Guardar como no legible" class="button" tabindex="-1" style="width:132px" onclick="doOperation('savePropertyAsNoLegible')" /></td>
              <td width='10px' nowrap='nowrap'>&nbsp;</td>
              <td nowrap='nowrap'><input type="button" value="Guardar como pendiente" class="button" tabindex="-1" style="width:132px" onclick="doOperation('savePropertyAsPending')" /></td>
              <td width='10px' nowrap='nowrap'>&nbsp;</td>
              <td nowrap='nowrap'><input type="button" value="Toda la información está completa" class="button" tabindex="-1" style="width:180px" onclick="doOperation('savePropertyAsComplete')" /></td>
              <td width='54px' nowrap='nowrap'>&nbsp;</td>
              <td nowrap='nowrap'><input type="button" value="Salir" class="button" tabindex="-1" style="width:60px" onclick="doOperation('closeWindow')" /></td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  </td>
</tr>
</table>
</div>
</form>
</body>
<script type="text/javascript">

  addEvent(document, 'keypress', upperCaseKeyFilter);
  addEvent(getElement('<%=txtCadastralNumber.ClientID%>'), 'keypress', upperCaseKeyFilter);

  function doOperation(command) {
    var success = false;

    if (gbSended) {
      return;
    }
    switch (command) {
      case 'savePropertyAsNoLegible':
        return savePropertyAsNoLegible();
      case 'savePropertyAsPending':
        return savePropertyAsPending();
      case 'savePropertyAsComplete':
        return savePropertyAsComplete();
      case 'searchCadastralNumber':
        alert("La búsqueda de claves catastrales no está disponible en este momento.");
        return;
      case 'searchGeographicalItems':
        return searchGeographicalItems();
      case 'setNoNumberLabel':
        getElement("txtExternalNumber").value = "S/N";
        return;
      case 'closeWindow':
        window.parent.execScript("doOperation('refreshRecording')");
        return;
      case 'appendGeographicalItem':
        alert("Esta funcionalidad está temporalmente fuera de servicio.")
        return appendGeographicalItem();
      default:
        alert("La operación '" + command + "' no ha sido definida en el programa.");
        return;
    }
    if (success) {
      sendPageCommand(command);
      gbSended = true;
    }
  }

  function savePropertyAsNoLegible() {
    var sMsg = "¿Guardo la información de este predio como no legible, para\nreemplazar la imagen del documento y revisar el predio posteriormente?";

    if (confirm(sMsg)) {
      sendPageCommand("savePropertyAsNoLegible");
    }
  }

  function savePropertyAsPending() {
    var sMsg = "¿Guardo la información de este predio como pendiente,\ncon el fin de que sea revisado posteriormente?";

    if (confirm(sMsg)) {
      sendPageCommand("savePropertyAsPending");
    }
  }

  function savePropertyAsComplete() {
    if (!validateProperty()) {
      return;
    }
    if (!checkUnknownPropertyFields()) {
      return;
    }
    var sMsg = "Guardar la información del predio como completa.\n\n";
    sMsg += "La siguiente operación guardará la información del predio ";
    sMsg += "con folio electrónico " + getElement("txtTractNumber").value + ".\n\n";
    sMsg += "¿Toda la información del predio está completa?";
    if (confirm(sMsg)) {
      setUnknownPropertyFields();
      sendPageCommand("savePropertyAsComplete");
    }
  }

  function checkUnknownPropertyFields() {
    var sMsg = "";

    if (getElement("txtCadastralNumber").value.length == 0) {
      sMsg += " \tClave catastral.\n";
    }
    if (getElement("cboSettlement").value.length == 0) {
      sMsg += " \tAsentamiento.\n";
    }
    if (getElement("cboStreetRoad").value.length == 0) {
      sMsg += " \tCalle o avenida donde se ubica.\n";
    }
    if (getElement("cboPostalCode").value.length == 0) {
      sMsg += " \tCódigo postal.\n";
    }
    if (getElement("txtExternalNumber").value.length == 0) {
      sMsg += " \tNúmero exterior.\n";
    }
    if (getElement("txtTotalArea").value.length == 0) {
      sMsg += " \tSuperficie total.\n";
    }
    if (getElement("txtFloorArea").value.length == 0) {
      sMsg += " \tSuperficie construida.\n";
    }
    if (getElement("txtCommonArea").value.length == 0) {
      sMsg += " \tIndiviso o área común.\n";
    }
    if (getElement("txtMetesAndBounds").value.length == 0) {
      sMsg += " \tMedidas y colindancias.\n";
    }
    if (sMsg.length != 0) {
      sMsg = "Los siguientes elementos de información serán guardados con el valor 'No consta', lo cual significa que no aparecen en la inscripción.\n\n" +
             sMsg + "\n¿Coloco todos los campos de la lista con el valor 'No consta'?";
      return confirm(sMsg);
    }
    return true;
  }

  function setUnknownPropertyFields() {
    if (getElement("txtCadastralNumber").value.length == 0) {
      getElement("txtCadastralNumber").value = "No consta";
    }
    if (getElement("cboSettlement").value.length == 0) {
      getElement("cboSettlement").value = "-2";
    }
    if (getElement("cboStreetRoad").value.length == 0) {
      getElement("cboStreetRoad").value = "-2";
    }
    if (getElement("cboPostalCode").value.length == 0) {
      getElement("cboPostalCode").value = "-2";
    }
    if (getElement("txtExternalNumber").value.length == 0) {
      getElement("txtExternalNumber").value = "No consta";
    }
    if (getElement("txtTotalArea").value.length == 0) {
      getElement("txtTotalArea").value = "0.00";
    }
    if (getElement("txtFloorArea").value.length == 0) {
      getElement("txtFloorArea").value = "0.00";
    }
    if (getElement("txtCommonArea").value.length == 0) {
      getElement("txtCommonArea").value = "0.00";
    }
    if (getElement("txtMetesAndBounds").value.length == 0) {
      getElement("txtMetesAndBounds").value = "No consta";
    }
  }

  function validateProperty() {
    if (getElement("cboPropertyType").value.length == 0) {
      alert("Necesito se seleccione de la lista el tipo de predio.");
      return false;
    }
    if (getElement("cboMunicipality").value.length == 0) {
      alert("Requiero se seleccione de la lista el municipio\ndonde se encuentra ubicado el predio.");
      return false;
    }
    if (getElement("cboSettlement").value.length == 0) {
      alert("Requiero se seleccione de la lista el asentamiento en donde se encuentra ubicado el predio.");
      return false;
    }
    if (getElement("cboTotalAreaUnit").value.length == 0) {
      alert("Necesito conocer la unidad de medida de la superficie total del predio.");
      return false;
    }
    if (getElement("txtTotalArea").value.length == 0 && getElement("cboTotalAreaUnit").value > 0) {
      alert("Necesito conocer la superficie total del predio.");
      return false;
    }
    if (getElement("txtTotalArea").value.length != 0 && getElement("cboTotalAreaUnit").value == "-2") {
      alert("La superficie total está marcada como 'No consta' pero el valor de la misma sí fue proporcionado.");
      return false;
    }
    if (!isNumeric(getElement("txtTotalArea")) && getElement("cboTotalAreaUnit").value > 0) {
      alert("No reconozco la superficie total del predio.");
      return false;
    }
    if (getElement("cboFloorAreaUnit").value.length == 0) {
      alert("Requiero se seleccione de la lista la unidad de medida de la superficie construida.");
      return false;
    }
    if (getElement("txtFloorArea").value.length == 0 && getElement("cboFloorAreaUnit").value > 0) {
      alert("Necesito conocer la superficie construida del predio.");
      return false;
    }
    if (getElement("txtFloorArea").value.length != 0 && getElement("cboFloorAreaUnit").value == "-2") {
      alert("La superficie construida está marcada como 'No consta' pero el valor de la misma sí fue proporcionado.");
      return false;
    }
    if (!isNumeric(getElement("txtFloorArea")) && getElement("cboFloorAreaUnit").value > 0) {
      alert("No reconozco la superficie construida del predio.");
      return false;
    }
    if (getElement("cboCommonAreaUnit").value.length == 0) {
      alert("Requiero se seleccione de la lista la unidad de medida del indiviso.");
      return false;
    }
    if (getElement("txtCommonArea").value.length == 0 && getElement("cboCommonAreaUnit").value > 0) {
      alert("Necesito conocer la superficie del indiviso del predio.");
      return false;
    }
    if (getElement("txtCommonArea").value.length != 0 && getElement("cboCommonAreaUnit").value == "-2") {
      alert("El indiviso está marcado como 'No consta' pero el valor del mismo sí fue proporcionado.");
      return false;
    }
    if (!isNumeric(getElement("txtCommonArea")) && getElement("cboCommonAreaUnit").value > 0) {
      alert("No reconozco la superficie del indiviso del predio.");
      return false;
    }
    if (isNumeric(getElement("txtCommonArea")) && (getElement("cboCommonAreaUnit").value > 0) && 
        Number(getElement("txtCommonArea").value) > 100) {
      alert("El indiviso no puede ser mayor a cien por ciento.");
      return false;
    }
    return true;
  }

  function appendGeographicalItem() {
    if (getElement("cboSearchFields").value == 0) {
      alert("Necesito se seleccione de la lista de la izquierda (Buscar/Agregar),\nel tipo del elemento geográfico que se desea agregar.");
      return;
    }
    if (getElement("cboMunicipality").value.length == 0) {
      alert("Requiero se seleccione el municipio en donde se ubica\nel elemento que se desea agregar.");
      return;
    }
    switch (getComboSelectedOption("cboSearchFields").title) {
      case "streetAndRoads":
        appendStreetRoad();
        return;
      case "settlements":
        appendSettlement();
        return;
      case "postalcodes":
        appendPostalCode();
        return;
    }
  }

  function appendStreetRoad() {
    if (getElement("cboSettlement").value.length == 0 || Number(getElement("cboSettlement").value) <= 0) {
      alert("Requiero se seleccione el asentamiento en donde se\nencuentra la vialidad que se desea agregar.");
      return;
    }
    if (getElement("cboStreetRoadType").value.length == 0) {
      alert("Requiero se seleccione de la lista 'Calle/Avenida', el tipo de\nvialidad que se desea agregar.");
      return;
    }
    if (getElement("txtSearchText").value.length == 0) {
      alert("Necesito se proporcione en la caja de texto de la izquierda,\nel nombre de la vialidad que se desea agregar.");
      return;
    }

    var sMsg = "Agregar una nueva vialidad.\n\n";
    sMsg += "Esta operación agregará una nueva vialidad al sistema de\n";
    sMsg += "información geográfica:\n\n";
    sMsg += "Municipio:\t" + getComboOptionText(getElement("cboMunicipality")) + "\n";
    sMsg += "Asentamiento:\t" + getComboOptionText(getElement("cboSettlement")) + "\n";
    sMsg += "Tipo de vialidad:\t" + getComboOptionText(getElement("cboStreetRoadType")) + "\n";
    sMsg += "Nombre:\t\t" + getElement("txtSearchText").value + "\n\n";
    sMsg += "¿Agrego esta vialidad al sistema de información geográfica?";

    if (confirm(sMsg)) {
      sendPageCommand("appendStreetRoad");
    }
  }

  function appendSettlement() {
    var sMsg = "";
    if (getElement("cboSettlementType").value.length == 0) {
      alert("Requiero se seleccione de la lista el tipo de\nasentamiento que se desea agregar.");
      return;
    }
    if (getElement("txtSearchText").value.length == 0) {
      alert("Necesito se proporcione en la caja de texto de la izquierda,\nel nombre del asentamiento que se desea agregar.");
      return;
    }
    
    var settlementId = getSettlementId(getElement("cboSettlementType").value, getElement("cboMunicipality").value, 
                                       getElement("txtSearchText").value);
    if (settlementId.length != 0) {
      sMsg = "Ya existe un asentamiento del tipo " + getComboOptionText(getElement("cboSettlementType"));
      sMsg += " en el municipio de " + getComboOptionText(getElement("cboMunicipality"));
      sMsg += " con el nombre proprocionado.\n\n¿Lo selecciono automáticamente de la lista?"; 
      if (confirm(sMsg)) {
        getElement("cboSettlement").value = settlementId;
      }
      return;
    }
//    var settlements = searchSettlements(getElement("cboMunicipality").value, getElement("txtSearchText").value);
//    if (settlements.length != 0) {
//      if (confirmSelectSettlement(settlements)) {
//        return;
//      }
//    }

    sMsg = "Agregar un asentamiento del tipo " + getComboOptionText(getElement('cboSettlementType')) + ".\n\n";
    sMsg += "Esta operación agregará un nuevo asentamiento al sistema de\n";
    sMsg += "información geográfica:\n\n";
    sMsg += "Municipio:\t" + getComboOptionText(getElement("cboMunicipality")) + "\n";
    sMsg += "Tipo:\t\t" + getComboOptionText(getElement("cboSettlementType")) + "\n";
    sMsg += "Nombre:\t\t" + getElement("txtSearchText").value + "\n\n";
    sMsg += "¿Agrego este asentamiento al sistema de información geográfica?";

    if (confirm(sMsg)) {
      sendPageCommand("appendSettlement");
    }
  }

  function confirmSelectSettlement(settlementsTable) {
    return confirm(settlementsTable);
  }

  function getSettlementId(settlementTypeId, municipalityId, name) {
    var ajaxURL = "../ajax/geographic.data.aspx";
    ajaxURL += "?commandName=getSettlementIdCmd";
    ajaxURL += "&settlementTypeId=" + settlementTypeId;
    ajaxURL += "&municipalityId=" + municipalityId;
    ajaxURL += "&name=" + name;

    return invokeAjaxMethod(false, ajaxURL, null);
  }

  function searchSettlements(municipalityId, name) {
    var ajaxURL = "../ajax/geographic.data.aspx";
    ajaxURL += "?commandName=searchSettlementsCmd";
    ajaxURL += "&municipalityId=" + municipalityId;
    ajaxURL += "&name=" + name;

    return invokeAjaxMethod(false, ajaxURL, null);
  }

  function appendPostalCode() {
    if (getElement("cboSettlement").value.length == 0 || Number(getElement("cboSettlement").value) <= 0) {
      alert("Requiero se seleccione el asentamiento en donde se\nencuentra el código postal que se desea agregar.");
      return;
    }
    if (getElement("txtSearchText").value.length == 0) {
      alert("Necesito se proporcione en la caja de texto de la izquierda,\nel código postal que se desea agregar.");
      return;
    }
    if (getElement("txtSearchText").value.length != 5 || !isNumeric(getElement("txtSearchText"))) {
      alert("El código postal proporcionado tiene un formato que no reconozco.");
      return;
    }
    var sMsg = "Agregar un código postal.\n\n";
    sMsg += "Esta operación agregará un nuevo código postal al sistema de\n";
    sMsg += "información geográfica:\n\n";
    sMsg += "Municipio:\t" + getComboOptionText(getElement("cboMunicipality")) + "\n";
    sMsg += "Asentamiento:\t" + getComboOptionText(getElement("cboSettlement")) + "\n";
    sMsg += "Código postal:\t" + getElement("txtSearchText").value + "\n\n";
    sMsg += "¿Agrego este código postal al sistema de información geográfica?";

    if (confirm(sMsg)) {
      sendPageCommand("appendPostalCode");
    }
  }

  function searchGeographicalItems() {
    alert("La búsqueda de elementos geográficos será liberada próximamente.");
  }

  function resetMunicipalitiesCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getCadastralOfficeMunicipalitiesComboCmd";
    url += "&cadastralOfficeId=" + getElement("cboCadastralOffice").value;

    invokeAjaxComboItemsLoader(url, getElement("cboMunicipality"));
  }

  function resetSettlementsCombo() {
    var url = "../ajax/geographic.data.aspx";
    url += "?commandName=getSettlementsStringArrayCmd";
    url += "&municipalityId=" + getElement("cboMunicipality").value;
    url += "&settlementTypeId=" + getElement("cboSettlementType").value;

    invokeAjaxComboItemsLoader(url, getElement("cboSettlement"));
  }

  function resetStreetsRoadsCombo() {
    var url = "../ajax/geographic.data.aspx";
    url += "?commandName=getStreetRoadsStringArrayCmd";
    url += "&municipalityId=" + getElement("cboMunicipality").value;
    url += "&settlementId=" + getElement("cboSettlement").value;
    url += "&pathTypeId=" + getElement("cboStreetRoadType").value;

    invokeAjaxComboItemsLoader(url, getElement("cboStreetRoad"));
  }

  function resetPostalCodesCombo() {
    var url = "../ajax/geographic.data.aspx";
    url += "?commandName=getPostalCodesStringArrayCmd";
    url += "&municipalityId=" + getElement("cboMunicipality").value;
    url += "&settlementId=" + getElement("cboSettlement").value;

    invokeAjaxComboItemsLoader(url, getElement("cboPostalCode"));
  }

  function updateUserInterface(oControl) {
    if (oControl == null) {
      return;
    }
    if (oControl == getElement("cboCadastralOffice")) {
      resetMunicipalitiesCombo();
      resetSettlementsCombo();
      resetStreetsRoadsCombo();
      resetPostalCodesCombo();
    } else if (oControl == getElement("cboMunicipality")) {
      resetSettlementsCombo();
      resetStreetsRoadsCombo();
      resetPostalCodesCombo();
    } else if (oControl == getElement("cboSettlementType")) {
      resetSettlementsCombo();
      resetStreetsRoadsCombo();
      resetPostalCodesCombo();
    } else if (oControl == getElement("cboSettlement")) {
      resetStreetsRoadsCombo();
      resetPostalCodesCombo();
    } else if (oControl == getElement("cboStreetRoadType")) {
      resetStreetsRoadsCombo();
    }
  }

  function onSearchTextBoxKeyFilter(oEvent) {
    var keyCode = getKeyCode(oEvent);

    if (keyCode == 60 || keyCode == 62) {
      return false;
    } else if ((keyCode == 13) && (getEventSource(oEvent).value != '')) {
      doOperation('searchGeographicalItems');
      return true;
    } else {
      return true;
    }
  }

  </script>
</html>
