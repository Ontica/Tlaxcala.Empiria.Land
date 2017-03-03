<%@ Page language="c#" Inherits="Empiria.Land.WebApp.LRSSearchData" EnableViewState="true" EnableSessionState="true" CodeFile="search.data.aspx.cs" %>
<%@ OutputCache Location="None" NoStore="true" %>
<%@ Register tagprefix="empiriaControl" tagname="LRSRecordingActSelectorControl" src="../land.registration.system.controls/recording.act.selector.control.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es-mx">
<head id="Head1" runat="server">
<title>      <%=GetTitle()%></title>
<meta http-equiv="Expires" content="-1" /><meta http-equiv="Pragma" content="no-cache" />
<link href="../themes/default/css/secondary.master.page.css" type="text/css" rel="stylesheet" />
<link href="../themes/default/css/editor.css" type="text/css" rel="stylesheet" />
  <script type="text/javascript" src="../scripts/empiria.ajax.js"></script>
  <script type="text/javascript" src="../scripts/empiria.general.js"></script>
  <script type="text/javascript" src="../scripts/empiria.secondary.master.page.js"></script>
  <script type="text/javascript" src="../scripts/empiria.validation.js"></script>
</head>
<body>
<form id="aspnetForm" method="post" runat="server">
<div>
<input type="hidden" name="hdnPageCommand" id="hdnPageCommand" runat="server" />
</div>
<div id="divCanvas">
  <div id="divHeader">
    <span class="appTitle">
      <%=GetTitle()%>
    </span>
    <span class="rightItem">
    </span>
  </div>
  <div id="divBody">
    <div id="divContent">
  <table class="tabStrip">
    <tr>
      <td id="tabStripItem_0" class="tabOn" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);"  onclick="doCommand('onClickTabStripCmd', this);" title="">Información del trámite y conceptos</td>
      <td id="tabStripItem_1" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="doCommand('onClickTabStripCmd', this);" title="">Inscripción de documentos</td>
      <td id="tabStripItem_2" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="doCommand('onClickTabStripCmd', this);" title="">Emisión de certificados</td>
      <td id="tabStripItem_3" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="doCommand('onClickTabStripCmd', this);" title="">Historia del trámite</td>
      <td class="lastCell" colspan="1" rowspan="1"><a id="top" />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</td>
    </tr>
  </table>
  <table id="tabStripItemView_0" class="editionTable" style="display:inline">
    <tr>
      <td class="subTitle">Información del interesado, número de trámite y tipo de documento</td>
    </tr>
    <tr>
    <td>
      <table id="transactionEditor0" class="editionTable">
        <tr>
          <td><b>Interesado:</b></td>
          <td colspan="3">
            <input id='txtRequestedBy' type="text" class="textBox" style="width:478px;" title="" runat="server" />
            <img src="../themes/default/buttons/search.gif" alt="" title="Ejecuta la búsqueda"
                 style="margin-left:-4px" onclick="doOperation('searchParty')" />
            <input type="hidden" id="txtTransactionKey" runat="server" />
          </td>
          <td class="lastCell" valign="top">

          </td>
        </tr>
        <tr>
          <td>Tipo de documento:</td>
          <td colspan="4" class="lastCell">
            <select id="cboDocumentType" class="selectBox" style="width:186px" onchange="return updateUserInterface(this);" runat="server">
              <option value="">( Seleccionar )</option>
            </select>
            No. Instrumento:
            <input id='txtDocumentNumber' type="text" class="textBox" style="width:194px;" title="" maxlength="128" runat="server" />
            <img src="../themes/default/buttons/search.gif" alt="" title="Busca un número de instrumento"
                 style="margin-left:-4px" onclick="doOperation('searchParty')" />
          </td>
        </tr>
        <tr>
          <td>Tramitado por:</td>
          <td colspan="4" class="lastCell">
            <select id="cboManagementAgency" class="selectBox" style="width:286px" runat='server'>
              <option value="-1" title="oPrivateContract">No determinado</option>
            </select>
            Mesa origen:
            <select id="cboRecorderOffice" class="selectBox" style="width:150px" onchange="return updateUserInterface(this);" runat="server">				
              <option value="-1">No determinado</option>
     	        <option value="101">Hidalgo</option>
	            <option value="102">Cuauhtémoc</option>
	            <option value="103">Juárez</option>
	            <option value="104">Lardizábal y Uribe</option>
	            <option value="105">Morelos</option>
	            <option value="106">Ocampo</option>
	            <option value="107">Xicohténcatl</option>
	            <option value="108">Zaragoza</option>
	            <option value=""> </option>
	            <option value="146">Archivo General de Notarías</option>
	            <option value="145">Oficialía de partes</option>
	            <option value="147">Oficina del C. Director</option>
	            <option value="154">Jurídico</option>
              <option value="99">Mesa trámites CITyS</option>
	            <option value=""> </option>
	            <option value="139">Asoc civiles y créditos particulares (Rosario)</option>
              <option value="142">Avisos preventivos (Gregoria)</option>
	            <option value="138">Cert. de hipotecas (Lupita)</option>
	            <option value="135">Certificados (Lety Palacios)</option>
              <option value="137">Comercio (Laura)</option>
              <option value="134">Copias certificadas</option>
              <option value="141">Créditos (Javier Ceballos)</option>
              <option value="140">Embargos (Alejandra)</option>
              <option value="144">Infonavit (Rubén)</option>
              <option value="143">Procede (Tere Roldán)</option>
	            <option value="133">Sección 4ta</option>
	            <option value="136">Sección 5ta</option>
            </select>
         </td>
        </tr>
      </table>
    </td>
  </tr>
<tr>
  <td class="subTitle">Actos jurídicos y conceptos involucrados en el trámite</td>
</tr>
<tr>
  <td class="subTitle">&nbsp;</td>
</tr>
</table>

    <table id="tabStripItemView_1" class="editionTable" style="display:none">
      <tr>
        <td class="lastCell">
          <iframe id="ifraRecordingEditor" style="z-index:99;left:0px;top:0px;"
                  marginheight="0" marginwidth="0" frameborder="0" scrolling="no"
                  src="../workplace/empty.page.aspx" width="90%" height="1500px" visible="true" >
          </iframe>
        </td>
      </tr>
    </table>

        </div>
      </div> <!-- end divBody !-->
      <div id="divBottomToolbar" style="display:none">
      </div> <!-- end divBottomToolbar !-->
    </div> <!-- end divCanvas !-->
  </form>
</body>
  <script type="text/javascript">
  /* <![CDATA[ */

  function doPageCommand(commandName, commandArguments) {
    switch (commandName) {
      default:
        return false;
    }
  }

  function doOperation(command) {
    var success = false;

    if (gbSended) {
      return;
    }
    switch (command) {
      case 'redirectThis':
        success = true;
        break;
      case 'saveTransaction':
        return saveTransaction();
      case 'saveAndReceive':
        return saveAndReceiveTransaction();
      case 'reentryTransaction':
        return reentryTransaction();
      case 'createCopy':
        return createCopy();
      case 'appendRecordingAct':
        return appendRecordingAct();
      case 'deleteRecordingAct':
        return deleteRecordingAct(arguments[1]);
      case 'savePayment':
        return savePayment();
      case 'cancelTransaction':
        success = true;
        break;
      case 'createNew':
        return createNew();
      case 'showRecordingActSelectorControl':
        return showRecordingActSelectorControl();
      case 'printOrderPayment':
        sendPageCommand('printOrderPayment');
        gbSended = true;
        return;
      case 'printTransactionReceipt':
        sendPageCommand('printTransactionReceipt');
        gbSended = true;
        return;
      case 'searchCadastralNumber':
        alert("La búsqueda de claves catastrales no está disponible en este momento.");
        return;
      case 'searchGeographicalItems':
        return searchGeographicalItems();
      case 'setNoNumberLabel':
        getElement("txtExternalNumber").value = "S/N";
        return;
      case 'closeWindow':
            window.parent.eval("doOperation('refreshRecording')");
        return;
      case 'appendGeographicalItem':
        return appendGeographicalItem();
      case 'undelete':
        sendPageCommand("undeleteTransaction");
        return;
      case "showConceptsEditor":
        showConceptsEditor();
        return;
      case "appendPayment":
        appendPayment();
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

  function updateUserInterface(oControl) {
    if (oControl == null) {
      return;
    }
    if (oControl == getElement("cboRecordingActTypeCategory")) {
      resetRecordingsTypesCombo();
    } else if (oControl == getElement("cboRecordingActType")) {
      resetLawArticlesCombo();
    }
  }

  function resetRecordingsTypesCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getRecordingTypesStringArrayCmd";
    url += "&recordingActTypeCategoryId=" + getElement("cboRecordingActTypeCategory").value;
    url += "&filtered=false";

    invokeAjaxComboItemsLoader(url, getElement("cboRecordingActType"));

    resetLawArticlesCombo();
  }

  function resetLawArticlesCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getLawArticlesStringArrayCmd";
    url += "&recordingActTypeId=" + getElement("cboRecordingActType").value;
    invokeAjaxComboItemsLoader(url, getElement("cboLawArticle"));
  }

  function doValidation(command) {
    var sMsg = "";
    var oPayment = getElement('txtReceiptTotal');

    if (isEmpty(getElement('txtRequestedBy'))) {
      alert("Requiero se proporcione el nombre del interesado.");
      return false;
    }
    if (isEmpty(getElement('cboDocumentType'))) {
      alert("Requiero se proporcione el tipo de documento que se desea inscribir.");
      return false;
    }
    if (isEmpty(getElement('cboManagementAgency'))) {
      alert("Requiero conocer la notaría o agencia que tramita.");
      return false;
    }
    return true;
  }

  function window_onload() {
    setWorkplace();
    <%=base.OnloadScript()%>
  }

  function setWorkplace2() {
    resizeWorkplace2();
    setObjectEvents();
    window.defaultStatus = '';
  }

  function resizeWorkplace2() {

  }

  function window_onscroll() {

  }

  function ifraRecordingEditor_onresize() {
    var oFrame = getElement("ifraRecordingEditor");
    var oBody = oFrame.document.body;

    var newHeight = oBody.scrollHeight + oBody.clientHeight;

    oFrame.style.height = oBody.scrollHeight + (oBody.offsetHeight - oBody.clientHeight) + 400;
    oFrame.style.width = oBody.scrollWidth + (oBody.offsetWidth - oBody.clientWidth);
    //alert(oFrame.style.height);
  }

  function window_onresize() {
    ifraRecordingEditor_onresize();
    window_onscroll();
  }

  addEvent(window, 'load', window_onload);
  addEvent(window, 'resize', window_onresize);

  /* ]]> */
  </script>
</html>
