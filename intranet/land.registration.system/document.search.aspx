<%@ Page Language="C#" EnableViewState="true" AutoEventWireup="true" Inherits="Empiria.Land.WebApp.DocumentSearch" CodeFile="document.search.aspx.cs" %>
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
<div id="divContentAlwaysVisible">
<table id="tabStripItemView_0" style="display:inline;">
  <tr>
    <td class="subTitle">¿Qué desea encontrar dentro del acervo histórico?</td>
  </tr>
  <!-- #region Search box !-->
  <tr>
    <td>
      <table class="editionTable">
        <tr>
          <td>Buscar:</td>
          <td colspan="4" class="lastCell">
            <select id="cboSearchBy" name="cboSearchBy" class="selectBox" style="width:134px" runat='server'>
              <option value="resource">Folios reales</option>
            </select>
            <!--
              <option value="document">Documentos</option>
              <option value="certificates">Certificados</option>
              <option value=""></option>
              <option value="recordingBook">Libros registrales</option>
              <option value="party">Índice de personas</option>
              <option value=""></option>
              <option value="transaction">Trámites</option>
              <option value="imagingControl">No. control acervo</option>
            -->
            <input id='txtSearchBox' name='txtSearchBox' type="text" onkeypress="return alphaNumericKeyFilter(event, true, searchDataCallback);"
                   class="textBox" style="width:240px" runat='server' title="" />
            <img src="../themes/default/buttons/search.gif" alt="" title="Ejecuta la búsqueda"
                 style="margin-left:-8px" onclick="doOperation('searchData')" />
          </td>
        </tr>
      </table>

    </td>
  </tr>
  <!-- #endregion Search box !-->

  <!-- #region Search results !-->
  <tr>
    <td>
      <table class="editionTable">
        <tr>
          <td class="lastCell">
            <div style="overflow:auto;max-height:260px;">
              <table class="details" style="width:95%">
                <%=GetSearchResultsGrid()%>
              </table>
            </div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <!-- #endregion Search results !-->

  <tr>
    <td>
      <table class="editionTable">
        <tr>
          <td class="lastCell">
            <div id='selectedItemViewer' style="overflow:auto;max-height:420px;">

            </div>
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
      case 'searchData':
        success = searchData();
        break;
      case 'onSelectResource':
        onSelectResource(arguments[1]);
        return;
      case 'onSelectDocument':
        onSelectDocument(arguments[1], arguments[2]);
        return;
      case 'onSelectRecordingAct':
        onSelectRecordingAct(arguments[1], arguments[2]);
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

  function searchData() {
    if (getElement('txtSearchBox').value.length != 0) {
      return true;
    } else {
      alert("Necesito se proporcione un texto para la búsqueda.");
      return false;
    }
  }

  function searchDataCallback() {
    doOperation('searchData');
  }

  function onSelectResource(resourceId) {
    displayResourceHistoryGrid(resourceId);

    //window.parent.execScript("doOperation('onSelectRecordingAct', " + documentId + ", " + recordingActId + ")");

  }

  function onSelectDocument(documentId, recordingActId) {
    window.parent.execScript("doOperation('onSelectDocument', " + documentId + ", " + recordingActId + ")");
  }

  function onSelectRecordingAct(documentId, recordingActId) {
    window.parent.execScript("doOperation('onSelectRecordingAct', " + documentId + ", " + recordingActId + ")");
  }

  // #region HTML Content loaders

  function displayResourceHistoryGrid(resourceId) {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getResourceHistoryGridCmd";
    url += "&resourceId=" + resourceId;

    var resourceHisoryGridHTML = invokeAjaxMethod(false, url, null);

    resourceHisoryGridHTML =
      "<table id='selectedItemViewer' class='details' style='width:95%'>" +
          resourceHisoryGridHTML +
      "</table>";

    getElement('selectedItemViewer').innerHTML = resourceHisoryGridHTML;
  }

  // #endregion HTML Content loaders

  function window_onload() {
    <%=base.OnLoadScript%>
    setFocus(getElement('txtSearchBox'));
    getElement('txtSearchBox').select();
  }

  addEvent(window, 'load', window_onload);

</script>
</html>
