﻿<%@ Page Language="C#" EnableViewState="true" AutoEventWireup="true" Inherits="Empiria.Land.WebApp.ImageSetViewer" Codebehind="image.set.viewer.aspx.cs" %>
<%@ OutputCache Location="None" NoStore="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es-mx">
<head id="Head1" runat="server">
<title></title>
<meta http-equiv="Expires" content="-1" /><meta http-equiv="Pragma" content="no-cache" />
<link href="../themes/default/css/secondary.master.page.css" type="text/css" rel="stylesheet" />
<link href="../themes/default/css/editor.css" type="text/css" rel="stylesheet" />
  <script type="text/javascript" src="../scripts/empiria.ajax.js"></script>
  <script type="text/javascript" src="../scripts/empiria.general.js"></script>
  <script type="text/javascript" src="../scripts/empiria.secondary.master.page.js"></script>
  <script type="text/javascript" src="../scripts/empiria.validation.js"></script>
  <script type="text/javascript">
  /* <![CDATA[ */

  function doPageCommand(commandName, commandArguments) {
    switch (commandName) {
      case 'refreshViewCmd':
        window.location.reload(false);
        //gbSended = true;
        return true;
      case 'changeBehaviorCmd':
        doChangeBehavior();
        gbSended = false;
        return true;
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
      case 'gotoImage':
        gotoImage();
        return;
      case 'zoomImage':
        doZoom();
        return;
      case 'moveToImage':
        moveToImage(arguments[1]);
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

  function gotoImage() {
    if (getElement("txtGoToImage").value.length == 0) {
      alert("Necesito conocer el número de imagen que se desea visualizar.");
      return false;
    }
    if (!isNumeric(getElement("txtGoToImage"))) {
      alert("No reconozco el número de imagen proporcionado.");
      return false;
    }
    if (Number(getElement("txtGoToImage").value) <= 0) {
      alert("El número de imagen que se desea visualizar debe ser mayor a cero.");
      return false;
    }
    if (Number(getElement("txtGoToImage").value) > imageCount()) {
      alert("Sólo existen " + imageCount() + " imágenes.");
      return false;
    }
    var newIndex = Number(getElement("txtGoToImage").value) - 1;

    var ajaxURL = "../ajax/land.registration.system.data.aspx?commandName=getImageSetImageURL";
    ajaxURL += "&imageSetId=<%=imageSet.Id%>";
    ajaxURL += "&index=" + newIndex;

    var result = invokeAjaxMethod(false, ajaxURL, null);

    getElement("imgCurrent").src = ".." + result;
    getElement("hdnCurrentImagePosition").value = newIndex;
    setPageTitle();

    return true;
  }

  function moveToImage(position) {
    var newIndex = 0;
    switch (position) {
      case "first":
        newIndex = 0;
        break;
      case "previous":
        newIndex = Math.max(Number(getElement("hdnCurrentImagePosition").value) - 1, 0);
        break;
      case "next":
        newIndex = Math.min(Number(getElement("hdnCurrentImagePosition").value) + 1, imageCount() - 1);
        break;
      case "last":
        newIndex = imageCount() - 1;
        break;
      default:
        alert("No reconozco la posición de la imagen que se desea desplegar.");
        return;
    }

    var ajaxURL = "../ajax/land.registration.system.data.aspx?commandName=getImageSetImageURL";
    ajaxURL += "&imageSetId=<%=imageSet.Id%>";
    ajaxURL += "&index=" + newIndex;

    var result = invokeAjaxMethod(false, ajaxURL, null);

    getElement("imgCurrent").src = ".." + result;
    getElement("hdnCurrentImagePosition").value = newIndex;
    setPageTitle();
  }

  function doZoom() {
    var oImage = getElement("imgCurrent");

    var width = <%=defaultImageWidth%>;
    var zoomLevel = Number(getElement('cboZoomLevel').value);
    oImage.setAttribute('width', Number(width) * zoomLevel);
  }

  function setPageTitle() {
    var imageXOfY = Number(Number(getElement("hdnCurrentImagePosition").value) + 1) + " de " + imageCount();
    setInnerText(getElement("spanPageTitle"), "<%=pageTitle%>");
    setInnerText(getElement("spanCurrentImage"), "Imagen " + imageXOfY);
  }

  function window_onload() {
    setWorkplace2();
    setPageTitle();
  }

  function setWorkplace2() {
    //hideControlDivisions();
    resizeWorkplace2();
    addEvent(window, 'resize', resizeWorkplace2);
    setObjectEvents();
    window.defaultStatus = ""; //"Sistema Empiria 2023. Copyright(c) 1999-2023. La Vía Óntica SC, Ontica LLC and contributors.";
  }

  function resizeWorkplace2() {
    var divBody = getElement('divBody');
    var divHeader = getElement('divHeader');
    var divContent = getElement('divContent');
    var divImageContainer = getElement('divImageContainer');

    var height = document.documentElement.offsetHeight - divHeader.offsetHeight - 0;
    var width = document.documentElement.offsetWidth;
    if (height > 0) {
      divBody.style.height = height + "px";
      divContent.style.height = height - 18 + "px";
      divImageContainer.style.height = height - 55 + "px";
    }
    divContent.style.width = width - 28 + "px";
    if (((width - 10) - 25) > 80) {
      divImageContainer.style.width = (width - 10) - 25 + "px";
    } else {
      divImageContainer.style.width = 10 + "px";
    }
  }

  function imageCount() {
    return <%=imageSet.FilesCount.ToString()%>;
  }

  function window_onscroll() {
    fixDataTableItems(getElement('divObjectExplorer'));
  }

  addEvent(window, 'load', window_onload);

    //oncontextmenu="return false"

  /* ]]> */
  </script>
</head>
<body>
<form name="aspnetForm" method="post" id="aspnetForm" runat="server">
  <div>
    <input type="hidden" name="hdnPageCommand" id="hdnPageCommand" runat="server" />
    <input type="hidden" name="hdnCurrentImagePosition" id="hdnCurrentImagePosition" runat="server" />
  </div>
  <div id="divCanvas">
    <div id="divHeader">
      <span id="spanPageTitle" class="appTitle">
        &nbsp;
      </span>
      <span id="spanCurrentImage" class="rightItem appTitle" style="margin-right:8px">
        &nbsp;
      </span>
    </div> <!--divHeader!-->
    <div id="divBody">
      <div id="divContent">
        <table cellpadding="0" cellspacing="0">
          <tr>
            <td valign="top">
              <table>
                <tr valign="top">
                  <td nowrap='nowrap'>
                    Ir a la imagen: <input id="txtGoToImage" name="txtGoToImage" type="text" class="textBox" maxlength="3"
                                     style="width:28px;margin-right:0px" onkeypress="return integerKeyFilter(this);" runat="server" /><img
                                     src="../themes/default/buttons/search.gif" alt="" onclick="return doOperation('gotoImage')" title="Ejecuta la búsqueda" /></td>
                  <td width='40%' nowrap='nowrap'>&nbsp;</td>
                  <td><img src='../themes/default/buttons/first.gif' onclick='doOperation("moveToImage", "first");' title='Muestra la primera imagen' alt='' /></td>
                  <td><img src='../themes/default/buttons/previous.gif' onclick='doOperation("moveToImage", "previous");' title='Muestra la imagen anterior' alt='' /></td>
                  <td><img src='../themes/default/buttons/next.gif' onclick='doOperation("moveToImage", "next");' title='Muestra la siguiente imagen' alt='' /></td>
                  <td><img src='../themes/default/buttons/last.gif' onclick='doOperation("moveToImage", "last");' title='Muestra la última imagen' alt='' /></td>
                  <td width='40%' nowrap='nowrap'>&nbsp;</td>
                  <td align="right" style="width:100%">
                    Zoom:
                    <select id="cboZoomLevel" name="cboZoomLevel" class="selectBox" style="width:56px" title="" onchange="return doOperation('zoomImage')" runat="server">
                      <option value="0.50">50%</option>
                      <option value="0.75">75%</option>
                      <option value="1.00">100%</option>
                      <option value="1.25">125%</option>
                      <option value="1.50">150%</option>
                      <option value="1.75">175%</option>
                      <option value="2.00">200%</option>
                      <option value="2.50">250%</option>
                      <option value="3.00">300%</option>
                      <option value="3.50">350%</option>
                      <option value="4.00">400%</option>
                    </select>
                  </td>
                </tr>
              </table>
              <div id="divImageContainer" style="overflow:auto;width:450px;height:540px">
                <img id="imgCurrent" name="imgCurrent" src="<%=GetCurrentImagePath()%>" alt="" width="<%=GetCurrentImageWidth()%>" />
              </div>
            </td>
          </tr>
        </table>
      </div> <!--divContent!-->
    </div> <!-- end divBody !-->
  </div> <!-- end divCanvas !-->
</form>
</body>
</html>
