﻿<%@ Page Language="C#" EnableViewState="true" AutoEventWireup="true" Inherits="Empiria.Land.WebApp.RealEstateEditor" CodeFile="real.estate.editor.aspx.cs" %>
<%@ OutputCache Location="None" NoStore="true" %>
<%@ Register tagprefix="uc" tagname="AlertBox" src="../user.controls/alert.box.ascx" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es-mx">
<head runat="server">
  <title></title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta http-equiv="Expires" content="-1" />
  <meta http-equiv="Pragma" content="no-cache" />
  <meta name="MS.LOCALE" content="ES-MX" />
  <link href="../themes/default/css/secondary.master.page.css" type="text/css" rel="stylesheet" />
  <link href="../themes/default/css/editor.css" type="text/css" rel="stylesheet" />
    <link href="../themes/default/css/modal.css" type="text/css" rel="stylesheet" />
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
      <td class="subTitle">Folio real, vinculación con catastro e información del predio padre</td>
    </tr>
    <tr>
      <td>
        <table class="editionTable">
          <tr>
            <td>Folio real:</td>
            <td class="lastCell">
              <input type="text" class="textBox" id='txtPropertyUID' name='txtPropertyUID' style="width:320px;height:18px;font-size:10pt" readonly='readonly' runat='server' title="" />
              <img src="../themes/default/buttons/document.sm.gif" alt="" title="Despliega la historia catastral del predio"
                   style="margin-left:-4px" onclick="doOperation('displayResourceHistory')" />Historia registral
            </td>
          </tr>
          <tr>
            <td>Clave catastral:</td>
            <td class="lastCell">
              <input type="text" class="textBox" id='txtCadastralKey' name='txtCadastralKey' style="width:320px;height:18px;font-size:9pt" maxlength="40" runat='server' title="" />
              <img src="../themes/default/buttons/search.gif" alt="" title="Busca la clave en el sistema de catastro para después hacer la vinculación entre folio real y clave catastral"
                   style="margin-left:-4px" onclick="doOperation('searchCadastralNumber')" />Vincular con catastro
             &#160;&#160;
              <img src="../themes/default/buttons/document.sm.gif" alt="" title="Visualiza la cédula catastral del predio"
                   style="margin-left:-4px" onclick="doOperation('showCadastralCertificate')" />Cédula catastral
            </td>
          </tr>

          <tr>
            <td>Fracción:</td>
            <td class="lastCell">
              <input type="text" class="textBox" id='txtPartitionNo' name='txtPartitionNo' style="width:116px"
                     readonly='readonly' runat='server' title="" />
              Del predio:
              <input type="text" class="textBox" id='txtPartitionOf' name='txtPartitionOf' readonly='readonly'
                     style="width:132px" runat='server' title="" />
              <img src="../themes/default/buttons/document.sm.gif" alt="" title="Muestra la historia del predio padre"
                   style="margin-left:-4px" onclick="doOperation('displayParentResource')" />Ver datos del predio padre
            </td>
          </tr>
          <tr>
            <td style="vertical-align:text-top">Observaciones:</td>
            <td class="lastCell">
              <textarea id="txtNotes" name="txtNotes" cols="320" rows="3"
                        style="width:492px" class="textArea" runat="server"></textarea>
            </td>
          </tr>

          <% if (base.IsInEditionMode()) { %>
          <tr>
            <td>&#160;</td>
            <td class="lastCell">
                 <input id="btnEditRealEstate" type="button" value="Editar este predio" class="button"
                        tabindex="-1" style="width:104px;height:28px" onclick="doOperation('openForEdition')" />
                &#160;&#160;&#160;
                 <input id="btnCancelEdition" type="button" value="Descartar cambios" class="button"
                        tabindex="-1" style="width:124px;height:28px" onclick="doOperation('cancelEdition')" />
                &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;
                &#160;&#160;&#160;&#160;&#160;&#160;
                 <input id="btnSaveRealEstate" type="button" value="Guardar los cambios" class="button"
                        tabindex="-1" style="width:120px;height:28px" onclick="doOperation('saveRealEstate')" />
                &#160;&#160;&#160;&#160;&#160;&#160;
            </td>
          </tr>
          <% } %>
         </table>
      </td>
    </tr>
    <tr>
      <td class="subTitle">Tipo, denominación y ubicación del predio</td>
    </tr>
    <tr>
      <td>
        <table class="editionTable">	
          <tr>
            <td>Tipo de predio:</td>
            <td>
              <select id="cboRealEstateKind" name="cboRealEstateKind" class="selectBox" style="width:142px" runat='server'>
              </select>
            </td>
            <td>Denominado:</td>
            <td class="lastCell">
              <input type="text" class="textBox" id='txtCommonName' name='txtCommonName' style="width:270px" runat='server' />
            </td>
          </tr>
          <tr>
            <td>Distrito:</td>
            <td>
              <select id="cboRecordingOffice" name="cboRecordingOffice" class="selectBox" style="width:142px" onchange="return updateUserInterface(this);" runat='server'>
              </select>
            </td>
            <td>Municipio:</td>
            <td class="lastCell">
              <select id='cboMunicipality' name='cboMunicipality' class='selectBox' style='width:276px' onchange="return updateUserInterface(this);" runat='server'>
                <option value="">( Seleccionar )</option>
              </select>
            </td>
          </tr>
          <tr>
            <td style="vertical-align:text-top">Ubicado en:</td>
            <td class="lastCell" colspan="3">
              <textarea id="txtLocationReference" name="txtLocation" cols="320" rows="2" style="width:492px" class="textArea" runat="server"></textarea>
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
              <input type="text" class="textBox" id='txtLotSize' name='txtLotSize' style="width:80px"
                     maxlength="16" onkeypress="return positiveKeyFilter(window.event, true);" runat='server' title="" />
              <select id="cboLotSizeUnit" name="cboLotSizeUnit" class="selectBox" style="width:200px" runat='server' title="">
                <option value="">( Unidad de medida )</option>
                <option value="-2">No consta</option>
                <option value="621" title="m2">Metros cuadrados</option>
                <option value="626" title="m2">Metros cuadrados (aproximados)</option>
                <option value="624" title="ha">Hectáreas</option>
                <option value="627" title="ha">Hectáreas (aproximadas)</option>
              </select>
            </td>
          </tr>
          <tr>
            <td style="vertical-align:text-top">Medidas<br />y<br />colindancias:</td>
            <td class="lastCell">
                <textarea id="txtMetesAndBounds" name="txtMetesAndBounds" cols="320" rows="8"
                          style="width:502px" class="textArea" runat="server"></textarea>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
</form>
   <!-- The Modal -->
              <!-- Modal content -->
              <uc:AlertBox id="alerbox" runat="server"/>
              <!-- end The Modal -->
</body>
<script type="text/javascript">

  function doOperation(command) {
    var success = false;

    if (gbSended) {
      return;
    }
    switch (command) {
      case 'openForEdition':
        return openForEdition();
      case 'saveRealEstate':
        return saveRealEstate();
      case 'searchCadastralNumber':
        showAlert("La búsqueda de claves catastrales no está disponible en este momento.");
        return;
      case 'cancelEdition':
        return cancelEdition();
      default:
        showAlert("La operación '" + command + "' no ha sido definida en el programa.");
        return;
    }
    if (success) {
      sendPageCommand(command);
      gbSended = true;
    }
  }

  function openForEdition() {
    <% if (!base.RecordingActAllowsEdition()) { %>
    var sMsg = 'La información de este predio ya fue registrada en un acto anterior, ';
    sMsg += 'y este acto jurídico NO permite modificar la información del predio.<br /><br />';
      sMsg += 'Si la información del predio cambió desde el último acto jurídico registrado ';
      sMsg += 'entonces se puede agregar antes de este acto, un acto jurídico de ';
      sMsg += '\'Actualización de los datos del predio\' o alguno otro similar.';
      showAlert(sMsg);
      return;
    <% } %>
    disableEditionFields(false);
  }

  function cancelEdition() {
    var sMsg = "Descartar cambios en la edición del predio.<br /><br />";
    sMsg += "La siguiente operación descartará los cambios efectuados en la información del predio.<br /><br />";
    sMsg += "¿Descarto los cambios efectuados en el predio?";
    /*if (confirm(sMsg)) {
      setUnknownPropertyFields();
      sendPageCommand("cancelEdition");
    }*/
    z = showConfirm(sMsg, '', executeOp);
    function executeOp() {
      setUnknownPropertyFields();
      sendPageCommand("cancelEdition");
    }
  }

  function saveRealEstate() {
    if (!validateProperty()) {
      return;
    }
    /*if (!checkUnknownPropertyFields()) {
      return;
    }*/
    var cMsg = checkUnknownPropertyFields();
    y = showConfirm(cMsg, '', executeOpU);
    function executeOpU() {
      var sMsg = "Guardar la información del predio como completa.  \n\n<br /><br />";
      sMsg += "La siguiente operación guardará la información del predio: \n\n<br /><br /> ";
      sMsg += "con folio electrónico " + getElement("txtPropertyUID").value + "\n\n<br /><br />";
      sMsg += "¿Toda la información del predio está completa?";
      /*if (confirm(sMsg)) {
        setUnknownPropertyFields();
        sendPageCommand("saveRealEstate");
      }*/
      z = showConfirm(sMsg, '', executeOp);
      function executeOp() {
        setUnknownPropertyFields();
        sendPageCommand("saveRealEstate");
      } 
    }    

  }

  function checkUnknownPropertyFields() {
    var sMsg = "";

    if (getElement("txtCadastralKey").value.length == 0) {
      sMsg += " \tClave catastral.<br />";
    }
    if (getElement("txtLotSize").value.length == 0) {
      sMsg += " \tSuperficie total.<br />";
    }
    if (getElement("txtMetesAndBounds").value.length == 0) {
      sMsg += " \tMedidas y colindancias.<br />";
    }
    /*if (sMsg.length != 0) {
      sMsg = "Los siguientes elementos de información serán guardados con el valor 'No consta', " +
             "lo cual significa que no aparecen en la inscripción.<br /><br />" +
        sMsg + "<br />¿Coloco todos los campos de la lista con el valor 'No consta'?";
      return confirm(sMsg);
    }*/
    if (sMsg.length != 0) {
      sMsg = "Los siguientes elementos de información serán guardados con el valor 'No consta', " +
        "lo cual significa que no aparecen en la inscripción.<br /><br />" +
        sMsg + "<br />¿Coloco todos los campos de la lista con el valor 'No consta'?";
      return sMsg;
    }
    return true;
  }

  function setUnknownPropertyFields() {
    if (getElement("txtLotSize").value.length == 0) {
      getElement("txtLotSize").value = "0.00";
    }
  }

  function validateProperty() {
    if (getElement("cboRealEstateKind").value.length == 0) {
      showAlert("Necesito se seleccione de la lista el tipo de predio.");
      return false;
    }
    if (getElement("cboMunicipality").value.length == 0) {
      showAlert("Requiero se seleccione de la lista el municipio\ndonde se encuentra ubicado el predio.");
      return false;
    }
    if (getElement("cboLotSizeUnit").value.length == 0) {
      showAlert("Necesito conocer la unidad de medida de la superficie total del predio.");
      return false;
    }
    if (getElement("txtLotSize").value.length == 0 &#38;&#38; getElement("cboLotSizeUnit").value > 0) {
      showAlert("Necesito conocer la superficie total del predio.");
      return false;
    }
    if (getElement("txtLotSize").value.length != 0 &#38;&#38; getElement("cboLotSizeUnit").value == "-2") {
      showAlert("La superficie total está marcada como 'No consta' pero el valor de la misma sí fue proporcionado.");
      return false;
    }
    if (!isNumeric(getElement("txtLotSize")) &#38;&#38; getElement("cboLotSizeUnit").value > 0) {
      showAlert("No reconozco la superficie total del predio.");
      return false;
    }
    return true;
  }

  function disableEditionFields(disabled) {
    disableControls(getElement("tabStripItemView_0"), disabled);

    <% if (base.IsInEditionMode()) { %>
    getElement("btnEditRealEstate").disabled = !disabled;
    getElement("btnSaveRealEstate").disabled = disabled;
    <% } %>

    getElement("txtPropertyUID").readOnly = true;
    getElement("txtPartitionOf").readOnly = true;

    <% if (!base.AllowsPartitionEdition()) { %>
      getElement("txtPartitionNo").readOnly = true;
    <% } else { %>
      getElement("txtPartitionNo").readOnly = false;
    <% } %>
  }


  function resetMunicipalitiesCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getCadastralOfficeMunicipalitiesComboCmd";
    url += "&#38;cadastralOfficeId=" + getElement("cboRecordingOffice").value;

    invokeAjaxComboItemsLoader(url, getElement("cboMunicipality"));
  }

  function updateUserInterface(oControl) {
    if (oControl == null) {
      return;
    }
    if (oControl == getElement("cboRecordingOffice")) {
      resetMunicipalitiesCombo();
    }
  }

  addEvent(document, 'keypress', upperCaseKeyFilter);
  disableEditionFields(true);

  </script>
</html>
