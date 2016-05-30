<%@ Page Language="C#" EnableViewState="true" AutoEventWireup="true" Inherits="Empiria.Land.WebApp.ByResourceAnalyzer" CodeFile="by.resource.analyzer.aspx.cs" %>
<%@ OutputCache Location="None" NoStore="true" %>
<%@ Import Namespace="Empiria.Land.Registration" %>
<%@ Import Namespace="Empiria.Land.WebApp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es-mx">
<head id="Head1" runat="server">
<title>Editor de documentos</title>
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
<body>
<form name="aspnetForm" method="post" id="aspnetForm" runat="server">
  <div>
    <input type="hidden" name="hdnPageCommand" id="hdnPageCommand" runat="server" />
    <input type="hidden" name="hdnCurrentImagePosition" id="hdnCurrentImagePosition" runat="server" />
  </div>
  <div id="divCanvas">
    <div id="divHeader" style="height:90px">
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
            <td id="divImageViewer" valign='top' style="position:relative;<%=base.DisplayImages() == false ? "display:none;" : String.Empty%>">
              <div id="divImageContainer" style="overflow:auto;width:520px;height:540px;top:0;">
                <%--<div id="divDocument" style="max-width:780px;align-items:center"></div>--%>

<!--            <img id="imgCurrent" name="imgCurrent" src="<%=GetCurrentImagePath()%>" alt="" width="<%=GetCurrentImageWidth()%>" height="<%=GetCurrentImageHeight()%>" style="top:0;" /> !-->

           <!-- <object id="imgCurrent" width="<%=GetCurrentImageWidth()%>" height="<%=GetCurrentImageHeight()%>" data="../themes/default/images/test.pdf"></object> !-->
             <!--   <iframe marginheight="0" marginwidth="0" id="imgCurrent" width="<%=GetCurrentImageWidth()%>" height="<%=GetCurrentImageHeight()%>" src="../recording.seal.aspx?transactionId=371443&id=-1"></iframe> !-->

<%--                  <object type="application/pdf" data="../themes/default/images/test.pdf" style="width:100%; height:100%">
                    <p>backup content</p>
                  </object>--%>

                  <object id="documentViewer" type="text/html" style="width:100%; height:100%;">
                    <p>visor de documentos</p>
                  </object>

                </div>
              <table>
                <tr>
                  <td nowrap='nowrap'>Ver:</td>
                  <td nowrap='nowrap'>
                    <select id="cboRecordingBookSelector" class="selectBox" style="width:124px" onchange="showRecordingImages(this.value);" title="" runat="server">										
                    </select>
                  </td>
                  <td nowrap='nowrap'>
                    Ir a la imagen: <input id="txtGoToImage" name="txtGoToImage" type="text" class="textBox" maxlength="4" style="width:35px;margin-right:0" onkeypress="return integerKeyFilter(this);" runat="server" />
                  </td>
                  <td nowrap='nowrap'><img src="../themes/default/buttons/search.gif" alt="" onclick="return doOperation('gotoImage')" title="Ejecuta la búsqueda" /></td>
                  <td width='40%'>&nbsp;</td>
                  <td><img src='../themes/default/buttons/first.gif' onclick='doOperation("moveToImage", "first");' title='Muestra la primera imagen' alt='' /></td>
                  <td><img src='../themes/default/buttons/previous.gif' onclick='doOperation("moveToImage", "previous");' title='Muestra la imagen anterior' alt='' /></td>
                  <td><img src='../themes/default/buttons/next.gif' onclick='doOperation("moveToImage", "next");' title='Muestra la siguiente imagen' alt='' /></td>
                  <td><img src='../themes/default/buttons/last.gif' onclick='doOperation("moveToImage", "last");' title='Muestra la última imagen' alt='' /></td>
                  <td width='10px' nowrap='nowrap'>&nbsp;</td>
                  <td align="right" style="width:40%" nowrap='nowrap'>
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
            </td>
            <td><img src="../themes/default/textures/pixel.gif" height="1px" width="12px" alt="" /></td>
            <td id="divDocumentViewer" valign="top" style="width:720px;">
              <table class="tabStrip">
                <tr>
                  <td id="tabStripItem_0" class="<%=TabStripClass(TabStrip.DocumentEditor)%>" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="doCommand('onClickTabStripCmd', this);" title="">Editar documento</td>
                  <td id="tabStripItem_1" class="<%=TabStripClass(TabStrip.RecordingActEditor)%>" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);"  onclick="doCommand('onClickTabStripCmd', this);" title="">Acto jurídico</td>
                  <td id="tabStripItem_2" class="<%=TabStripClass(TabStrip.ResourceEditor)%>" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);"  onclick="doCommand('onClickTabStripCmd', this);" title="">Predio</td>
                  <td id="tabStripItem_3" class="<%=TabStripClass(TabStrip.ResourceHistory)%>" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="doCommand('onClickTabStripCmd', this);" title="">Historia del predio</td>
                  <td id="tabStripItem_4" class="<%=TabStripClass(TabStrip.GlobalSearch)%>" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="doCommand('onClickTabStripCmd', this);" title="">Consultar el acervo</td>
                  <td class="lastCell">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <a id="top" /></td>
                </tr>
              </table>

            <table id="tabStripItemView_0" class="editionTable" style="<%=TabStripDisplayView(TabStrip.DocumentEditor)%>">
              <tr>
                <td class="lastCell">
                  <iframe id="ifraDocumentEditor" style="z-index:99;left:0;top:0;" width="720px"
                          marginheight="0" marginwidth="0" frameborder="0" scrolling="no" visible="true" >
                  </iframe>
                </td>
              </tr>
            </table> <!-- tabStripItemView_0 !-->

             <table id="tabStripItemView_1" class="editionTable" style="<%=TabStripDisplayView(TabStrip.RecordingActEditor)%>">
              <tr>
                <td class="lastCell">
                  <iframe id="ifraRecordingActEditor" style="z-index:99;left:0;top:0;" width="720px"
                          marginheight="0" marginwidth="0" frameborder="0" scrolling="no" visible="true" >
                  </iframe>
                </td>
              </tr>
            </table> <!-- tabStripItemView_1 !-->

            <table id="tabStripItemView_2" class="editionTable" style="<%=TabStripDisplayView(TabStrip.ResourceEditor)%>">
              <tr>
                <td class="lastCell">
                  <iframe id="ifraPropertyEditor" style="z-index:99;left:0;top:0;" width="720px"
                          marginheight="0" marginwidth="0" frameborder="0" scrolling="no" visible="true">
                  </iframe>
                </td>
              </tr>
            </table>  <!-- tabStripItemView_2 !-->

            <table id="tabStripItemView_3" class="editionTable" style="<%=TabStripDisplayView(TabStrip.ResourceHistory)%>">
              <tr>
                <td class="lastCell">
                  <iframe id="ifraPropertyHistory" style="z-index:99;left:0;top:0;" width="720px"
                          marginheight="0" marginwidth="0" frameborder="0" scrolling="no" visible="true">
                  </iframe>
                </td>
              </tr>
            </table> <!-- tabStripItemView_3 !-->

            <table id="tabStripItemView_4" class="editionTable" style="<%=TabStripDisplayView(TabStrip.GlobalSearch)%>">
              <tr>
                <td class="lastCell">
                  <iframe id="ifraSearchInfo" style="z-index:99;left:0;top:0;" width="720px"
                          marginheight="0" marginwidth="0" frameborder="0" scrolling="no" visible="true">
                  </iframe>
                </td>
              </tr>
            </table> <!-- tabStripItemView_4 !-->

            </td>
          </tr>
        </table>
      </div> <!--divContent!-->
    </div> <!-- end divBody !-->
  </div> <!-- end divCanvas !-->
</form>
</body>
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
      case 'onSelectDocument':
        onSelectDocument(arguments[1]);
        return;
      case 'onSelectRecordingAct':
        onSelectRecordingAct(arguments[1], arguments[2]);
        return;
      case 'onSelectCertificate':
        onSelectCertificate(arguments[1]);
        return;

      case 'gotoImage':
        gotoImage();
        return;
      case 'moveToImage':
        moveToImage(arguments[1]);
        return;
      case 'zoomImage':
        return doZoom();
      case 'refresh':
        sendPageCommand(command);
        return;
      case 'refreshRecordingViewer':
        refreshRecordingViewer();
        return;
      case 'refreshRecording':
        window.location.reload(false);
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

  function onSelectDocument(documentId) {
    displayDocumentImage(documentId);
  }

  function onSelectRecordingAct(documentId, recordingActId) {
    window.document.location.href = "by.resource.analyzer.aspx?resourceId=-1&recordingActId=" + recordingActId;
  }

  function onSelectCertificate(certificateId) {
    var newURL = "./certificate.aspx?certificateId=" + certificateId;

    var clone = getElement("documentViewer").cloneNode(true);
    clone.setAttribute('data', newURL);

    var parent = getElement("documentViewer").parentNode;

    parent.removeChild(getElement("documentViewer"));
    parent.appendChild(clone);
  }

  function displayDocumentImage(documentId) {
    var newURL = "./recording.seal.aspx?transactionId=-1&id=" + documentId;

    var clone = getElement("documentViewer").cloneNode(true);
    clone.setAttribute('data', newURL);

    var parent = getElement("documentViewer").parentNode;

    parent.removeChild(getElement("documentViewer"));
    parent.appendChild(clone);
  }

  function loadContent() {

    <% if (base.IsRecordingActSelected) { %>
      doOperation('onSelectDocument', '<%=recordingAct.Document.Id%>');
    <% } %>

    getElement('ifraPropertyHistory').src = '<%=TabStripSource(TabStrip.ResourceHistory)%>';
    getElement('ifraSearchInfo').src = '<%=TabStripSource(TabStrip.GlobalSearch)%>';
    getElement('ifraRecordingActEditor').src = '<%=TabStripSource(TabStrip.RecordingActEditor)%>';
    // getElement('ifraDocumentEditor').src = '<%=TabStripSource(TabStrip.DocumentEditor)%>';
    // getElement('ifraPropertyEditor').src = '<%=TabStripSource(TabStrip.ResourceEditor)%>';
  }



  function showRecordingImages(recordingId) {
    getElement("cboRecordingBookSelector").value = recordingId;
    if (getElement("cboRecordingBookSelector").selectedIndex == 0) {
      getElement("hdnCurrentImagePosition").value = <%=currentImagePosition%>;
      if (existsElement("cboImageOperation")) {
        getElement("cboImageOperation").disabled = false;
      }
    } else if (getElement("cboRecordingBookSelector").value.length != 0) {
      getElement("hdnCurrentImagePosition").value = -1;
      if (existsElement("cboImageOperation")) {
        getElement("cboImageOperation").disabled = true;
      }
    } else if (getElement("cboRecordingBookSelector").value.length == 0) {
      return;
    }
    moveToImage("refresh");
  }

  function updateUserInterface(oControl) {
    if (oControl == null) {
      return;
    }
    if (oControl == getElement("cboRecordingActTypeCategory")) {
      resetRecordingsTypesCombo();
    } else if (oControl == getElement("cboAnnotationCategory")) {
      resetAnnotationsTypesCombo();
      resetAnnotationsBooksCombo();
      resetAnnotationsOfficialsCombo();
    } else if (oControl == getElement("cboProperty")) {
      showRegisteredPropertiesSection();
    }
  }

  function moveToImage(position) {
    return;

    var ajaxURL = "../ajax/land.registration.system.data.aspx?commandName=getDirectoryImageURL";
    var newPosition = 0;
    switch (position) {
      case "first":
        ajaxURL += "&position=" + position;
        newPosition = 0;
        break;
      case "previous":
        ajaxURL += "&position=" + position;
        newPosition = Math.max(Number(getElement("hdnCurrentImagePosition").value) - 1, 0);
        break;
      case "next":
        ajaxURL += "&position=" + position;
        newPosition = Math.min(Number(getElement("hdnCurrentImagePosition").value) + 1, getImageCount() - 1);
        break;
      case "last":
        ajaxURL += "&position=" + position;
        newPosition = getImageCount() - 1;
        break;
      case "refresh":
        ajaxURL += "&position=" + position;
        newPosition = getRecordingStartImageIndex() - 1;
        break;
      default:
        alert("No reconozco la posición de la imagen que se desea desplegar.");
        return;
    }
    ajaxURL += "&currentPosition=" + getElement("hdnCurrentImagePosition").value;

    var result = invokeAjaxMethod(false, ajaxURL, null);
    getElement("imgCurrent").src = result;
    getElement("hdnCurrentImagePosition").value = newPosition;
    setPageTitle();
  }

  function doZoom() {
    return;

    var oImage = getElement("imgCurrent");

    var width = 1336;
    var height = 994;
    var zoomLevel = Number(getElement('cboZoomLevel').value);
    oImage.setAttribute('width', Number(width) * zoomLevel);
    oImage.setAttribute('height', Number(height) * zoomLevel);
  }

  function setPageTitle() {
    <% if (base.IsRecordingActSelected) { %>
    getElement("spanPageTitle").innerHTML = "Documento: <%=recordingAct.Document.UID%><br/>"+
                                            "Acto jurídico: <%=recordingAct.DisplayName%> [<%=recordingAct.Index + 1%>]";
    getElement("spanCurrentImage").innerText = "Predio: <%=resource.UID%>";
    <% } else { %>
    getElement("spanPageTitle").innerHTML = "Consulta del acervo registral"
    getElement("spanCurrentImage").innerText = "";
    <% } %>
  }

  function getCurrentImage() {
    return Number(Number(getElement("hdnCurrentImagePosition").value) + 1);
  }

  function getImageCount() {
    return 0;

    var ajaxURL = "../ajax/land.registration.system.data.aspx?commandName=getRecordingBookImageCountCmd";

    if (getElement('cboRecordingBookSelector').value.substring(0,1) == "&") {
      ajaxURL += getElement('cboRecordingBookSelector').value;
    } else {
      ajaxURL += "&imagingItemId=" + getElement('cboRecordingBookSelector').value;
    }

    var result = invokeAjaxMethod(false, ajaxURL, null);

    return Number(result);
  }

  function getRecordingStartImageIndex() {
    if (getElement('cboRecordingBookSelector').value.length == 0) {
      return 1;
    }
    if (getElement('cboRecordingBookSelector').value.substring(0, 1) == "&") {
      return 1;
    } else {
      var ajaxURL = "../ajax/land.registration.system.data.aspx?commandName=getRecordingStartImageIndexCmd";
      ajaxURL += "&recordingId=" + getElement('cboRecordingBookSelector').value;

      var result = invokeAjaxMethod(false, ajaxURL, null);

      return Number(result);
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
      alert("El número de imagen que se desea visualizar debe ser positivo.");
      return false;
    }
    var imageCount = getImageCount();
    if (Number(getElement("txtGoToImage").value) > imageCount) {
      alert("El libro seleccionado sólo contiene " + imageCount + " imágenes.");
      return false;
    }

    var ajaxURL = "../ajax/land.registration.system.data.aspx?commandName=getDirectoryImageURL";
    var newPosition = Number(getElement("txtGoToImage").value) -  1;
    ajaxURL += "&position=" + newPosition;
    ajaxURL += "&imagingItemId=-1";
    ajaxURL += "&currentPosition=" + getElement("hdnCurrentImagePosition").value;
    var result = invokeAjaxMethod(false, ajaxURL, null);
    getElement("imgCurrent").src = result;
    getElement("hdnCurrentImagePosition").value = newPosition;
    setPageTitle();

    return true;
  }

  function window_onload() {
    setWorkplace2();
    setPageTitle();
    resizeAllFrames();
    loadContent();
  }

  function setWorkplace2() {
    resizeWorkplace2();
    addEvent(window, 'resize', resizeWorkplace2);
    setObjectEvents();
    window.defaultStatus = '';
  }

  function resizeWorkplace2() {
    var divBody = getElement('divBody');
    var divHeader = getElement('divHeader');
    var divContent = getElement('divContent');
    var divImageContainer = getElement('divImageContainer');

    var height = document.documentElement.offsetHeight - divHeader.offsetHeight - 0;
    var width = document.documentElement.offsetWidth;

    if (height > 78) {
      divBody.style.height = height;
      divContent.style.height = height - 18;
      divImageContainer.style.height = height - 78;
    }
    if (width > 28) {
      divContent.style.width = width - 28;
    }
    if (((width - 720) - 38) > 720) {
      divImageContainer.style.width = (width - 720) - 38;
    } else {
      divImageContainer.style.width = 560;
    }
  }

  function window_onresize() {
    resizeAllFrames();
    window_onscroll();
  }

  function resizeAllFrames() {
    resizeFrame(null, getElement("ifraDocumentEditor"));
    resizeFrame(null, getElement("ifraPropertyEditor"));
    resizeFrame(null, getElement("ifraRecordingActEditor"));
    resizeFrame(null, getElement("ifraPropertyHistory"));
    resizeFrame(null, getElement("ifraSearchInfo"));

  }

  function window_onscroll() {
    var documentHeight = getElement("divDocumentViewer").offsetHeight;
    var scrollHeight = getElement("divContent").scrollTop;
    //var oBody = getElement("divDocumentViewer");
    //getElement('divImageViewer').style.top = Math.min(scrollHeight, documentHeight - scrollHeight) + "px";

    var newHeight = Math.min(documentHeight - scrollHeight, scrollHeight);

    if (newHeight <= 0) {
      getElement('divImageViewer').style.top = 0;
    } else {
      getElement('divImageViewer').style.top = newHeight;
    }
  }

  function resizeFrame(e) {
    var oFrame = null;

    if (arguments.length == 2) {
      oFrame = arguments[1];
    } else {
      oFrame = window.event.srcElement;
    }

    var oBody = oFrame.document.body;

    //var newHeight = oBody.scrollHeight + (oBody.offsetHeight - oBody.clientHeight);
    var newHeight = oBody.scrollHeight + oBody.clientHeight;

    if (newHeight <= 700) {
      oFrame.style.height = 700;
    } else {
      oFrame.style.height = newHeight;
    }
    //oFrame.style.width = oBody.scrollWidth + (oBody.offsetWidth - oBody.clientWidth);
  }

  addEvent(window, 'load', window_onload);
  addEvent(window, 'resize', window_onresize);
  addEvent(getElement('divContent'), 'scroll', window_onscroll);

  addEvent(getElement("ifraDocumentEditor"), 'resize', resizeFrame);
  addEvent(getElement("ifraPropertyEditor"), 'resize', resizeFrame);
  addEvent(getElement("ifraRecordingActEditor"), 'resize', resizeFrame);
  addEvent(getElement("ifraPropertyHistory"), 'resize', resizeFrame);
  addEvent(getElement("ifraSearchInfo"), 'resize', resizeFrame);

  /* ]]> */
  </script>
</html>
