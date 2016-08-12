<%@ Page Language="C#" EnableViewState="true" AutoEventWireup="true" Inherits="Empiria.Land.WebApp.PropertyEditor" CodeFile="property.editor.aspx.cs" %>
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
<body style="background-color:#fafafa; top:0; margin:0; margin-top:-14px; margin-left:-6px;">
<form name="aspnetForm" method="post" id="aspnetForm" runat="server">
  <div id="divContent">
    <table id="tabStripItemView_0" style="display:inline;">
    <tr>
      <td class="subTitle">Identificación del predio</td>
    </tr>
    <tr>
      <td>
        <table class="editionTable">
          <tr>
            <td>Folio real:</td>
            <td>
              <input type="text" class="textBox" id='txtTractNumber' name='txtTractNumber' style="width:132px" readonly='readonly' runat='server' title="" />
              Historia
            </td>
            <td>Clave catastral:</td>
            <td class="lastCell">
              <input type="text" class="textBox" id='txtCadastralNumber' name='txtCadastralNumber' style="width:200px" maxlength="20" runat='server' title="" />
              <img src="../themes/default/buttons/search.gif" alt="" title="Ejecuta la búsqueda" style="margin-left:-4px" onclick="doOperation('searchCadastralNumber')" />
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
            <td>Fracción de:</td>
            <td>
              <input type="text" class="textBox" id='txtPartitionOf' name='txtPartitionOf' style="width:132px" readonly='readonly' runat='server' title="" />
              Historia
            </td>
            <td>Núm Fracción:</td>
            <td>
              <input type="text" class="textBox" id='txtPartitionNo' name='txtPartitionNo' style="width:132px" runat='server' title="" />
            </td>
          </tr>
          <tr>
            <td style="vertical-align:text-top">Observaciones:</td>
            <td class="lastCell" colspan="3">
              <textarea id="txtObservations" name="txtObservations" cols="320" rows="2"
                        style="width:514px" class="textArea" runat="server"></textarea>
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
            <td>Distrito:</td>
            <td class="lastCell">
              <select id="cboCadastralOffice" name="cboCadastralOffice" class="selectBox" style="width:196px" onchange="return updateUserInterface(this);" runat='server'>
              </select>
              &nbsp;Municipio:
              <select id='cboMunicipality' name='cboMunicipality' class='selectBox' style='width:284px' onchange="return updateUserInterface(this);" runat='server'>
                <option value="">( Seleccionar )</option>
              </select>
            </td>
          </tr>
          <tr>
            <td style="vertical-align:text-top">Ubicado en:</td>
            <td class="lastCell">
              <textarea id="txtUbication" name="txtUbication" cols="320" rows="2" style="width:542px" class="textArea" runat="server"></textarea>
            </td>
          </tr>
        </table>
      </td>
    </tr>

    <tr>
      <td class="subTitle">Superficie y medidas y colindancias</td>
    </tr>

    <tr>
      <td>
        <table class="editionTable">
        <tr>
          <td>Superficie:</td>
          <td class="lastCell">
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
              <option value="-1">No aplica</option>
              <option value="-2">No consta</option>
              <option value="621" title="m2">M2</option>
              <option value="626" title="m2">M2 aprox</option>
            </select>
            Indiviso:
            <input type="text" class="textBox" id='txtCommonArea' name='txtCommonArea' style="width:40px;" maxlength="7" onkeypress="return positiveKeyFilter(this);" title="" runat='server' />
            <select id="cboCommonAreaUnit" name="cboCommonAreaUnit" class="selectBox" style="width:44px;margin-left:-6px" title="" runat='server'>
              <option value="">(?)</option>
              <option value="-1">NA</option>
              <option value="-2">NC</option>
              <option value="622" title="%">%</option>
            </select>
          </td>
        </tr>

        <tr>
          <td style="vertical-align:text-top">Medidas<br />y<br />colindancias:</td>
          <td class="lastCell">
              <textarea id="txtMetesAndBounds" name="txtMetesAndBounds" cols="320" rows="10"
                        style="width:542px" class="textArea" runat="server"></textarea>
          </td>
        </tr>

        <tr>
          <td>&nbsp;</td>
          <td class="lastCell">
               Estado:
               <input type="text" class="textBox" id='txtStatus' name='txtStatus'
                      style="width:62px" readonly='readonly' runat='server' title="" />

               <input type="button" value="Toda la información está completa" class="button"
                      tabindex="-1" style="width:180px;height:28px" onclick="doOperation('saveProperty')" />
                            <br />

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

  function doOperation(command) {
    var success = false;

    if (gbSended) {
      return;
    }
    switch (command) {
      case 'saveProperty':
        return saveProperty();
      case 'searchCadastralNumber':
        alert("La búsqueda de claves catastrales no está disponible en este momento.");
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

  function saveProperty() {
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
      sendPageCommand("saveProperty");
    }
  }

  function checkUnknownPropertyFields() {
    var sMsg = "";

    if (getElement("txtCadastralNumber").value.length == 0) {
      sMsg += " \tClave catastral.\n";
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
      sMsg = "Los siguientes elementos de información serán guardados con el valor 'No consta', " +
             "lo cual significa que no aparecen en la inscripción.\n\n" +
             sMsg + "\n¿Coloco todos los campos de la lista con el valor 'No consta'?";
      return confirm(sMsg);
    }
    return true;
  }

  function setUnknownPropertyFields() {
    if (getElement("txtCadastralNumber").value.length == 0) {
      getElement("txtCadastralNumber").value = "No consta";
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

  function resetMunicipalitiesCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getCadastralOfficeMunicipalitiesComboCmd";
    url += "&cadastralOfficeId=" + getElement("cboCadastralOffice").value;

    invokeAjaxComboItemsLoader(url, getElement("cboMunicipality"));
  }

  function updateUserInterface(oControl) {
    if (oControl == null) {
      return;
    }
    if (oControl == getElement("cboCadastralOffice")) {
      resetMunicipalitiesCombo();
    }
  }

  addEvent(document, 'keypress', upperCaseKeyFilter);

  </script>
</html>
