<%@ Page Language="C#" EnableViewState="true" AutoEventWireup="true" Inherits="Empiria.Land.WebApp.ByResourceAnalyzer" CodeFile="by.resource.analyzer.aspx.cs" %>
<%@ OutputCache Location="None" NoStore="true" %>
<%@ Import Namespace="Empiria.Land.Registration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es-mx">
<head id="Head1" runat="server">
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
<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.js"></script>
  <script type="text/javascript">
    function loadContent() {
      var url = "../recording.seal.aspx?transactionId=371443&id=-1";

     // url = "./xml.bill.aspx";

     // url = "./xml.bill.aspx";
     // url = "../themes/default/images/test.pdf";

     // url = "../themes/default/images/woman.nophoto.jpg";

     // $("#divImageContainer").load(url);

    }

</script>
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

                  <object id="documentViewer" type="text/html" data="./recording.seal.aspx?transactionId=-1&id=<%=recordingAct.Document.Id%>" style="width:100%; height:100%">
                    <p>backup content</p>
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
                    Ir a la imagen: <input id="txtGoToImage" name="txtGoToImage" type="text" class="textBox" maxlength="4" style="width:35px;margin-right:0px" onkeypress="return integerKeyFilter(this);" runat="server" />
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
            <td id="divDocumentViewer" valign="top" style="width:690px;">
              <table class="tabStrip">
                <tr>
                  <td id="tabStripItem_0" class="tabOn" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);"  onclick="doCommand('onClickTabStripCmd', this);" title="">Información del acto jurídico</td>
                  <td id="tabStripItem_1" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);"  onclick="doCommand('onClickTabStripCmd', this);" title="">Información del predio</td>
                  <td id="tabStripItem_2" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="doCommand('onClickTabStripCmd', this);" title="">Historia del predio</td>
                  <td id="tabStripItem_3" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="doCommand('onClickTabStripCmd', this);" title="">Acervo registral</td>
                  <td class="lastCell"><a id="top" /></td>
                </tr>
              </table>

             <table id="tabStripItemView_0" class="editionTable" style="display:inline;">
              <tr>
                <td class="lastCell">
                  <iframe id="ifraRecordingActEditor" style="z-index:99;left:0;top:0;" width="670px"
                          marginheight="0" marginwidth="0" frameborder="0" scrolling="no" visible="true"
                          src="./recording.act.editor.aspx?propertyId=<%=resource.Id%>&id=<%=recordingAct.Id%>">
                  </iframe>
                </td>
              </tr>
            </table> <!-- tabStripItemView_0 !-->

            <table id="tabStripItemView_1" class="editionTable" style="display:none;">
              <tr>
                <td class="lastCell">
                  <iframe id="ifraPropertyEditor" style="z-index:99;left:0;top:0;" width="670px"
                          marginheight="0" marginwidth="0" frameborder="0" scrolling="no" visible="true"
                          src="./property.editor.aspx?propertyId=<%=resource.Id%>&recordingActId=<%=recordingAct.Id%>">
                  </iframe>
                </td>
              </tr>
            </table>  <!-- tabStripItemView_1 !-->

            <table id="tabStripItemView_2" class="editionTable" style="display:none;">
              <tr>
                <td class="lastCell">
                  <iframe id="ifraPropertyHistory" style="z-index:99;left:0;top:0;" width="670px"
                          marginheight="0" marginwidth="0" frameborder="0" scrolling="no" visible="true"
                          src="./resource.history.aspx?resourceId=<%=resource.Id%>&id=<%=recordingAct.Id%>">
                  </iframe>
                </td>
              </tr>
            </table> <!-- tabStripItemView_2 !-->

            <table id="tabStripItemView_3" class="editionTable" style="display:none;">
              <tr>
                <td class="lastCell">
                  <iframe id="ifraPropertyStructure" style="z-index:99;left:0;top:0;" width="670px"
                          marginheight="0" marginwidth="0" frameborder="0" scrolling="no" visible="true"
                          src="./global.search.aspx?resourceId=<%=resource.Id%>&id=<%=recordingAct.Id%>">
                  </iframe>
                </td>
              </tr>
            </table> <!-- tabStripItemView_3 !-->

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
        var newURL = "./recording.seal.aspx?transactionId=-1&id=" + arguments[1];

        getElement("documentViewer").setAttribute('data', newURL);
        var clone = getElement("documentViewer").cloneNode(true);
        var parent = getElement("documentViewer").parentNode;
        parent.removeChild(getElement("documentViewer"));
        parent.appendChild(clone);

        //var newObject = '<object id="documentViewer" type="text/html" data="' + newURL + ' style="width:100%; height:100%"></object>';


        //getElement("documentViewer").style.display = "none";
        //getElement("documentViewer").style.display = "block";
        //alert(newURL);
        //alert("hello");
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
    var oImage = getElement("imgCurrent");

    var width = 1336;
    var height = 994;
    var zoomLevel = Number(getElement('cboZoomLevel').value);
    oImage.setAttribute('width', Number(width) * zoomLevel);
    oImage.setAttribute('height', Number(height) * zoomLevel);
  }

  function setPageTitle() {
    var s = String();
    setInnerText(getElement("spanPageTitle"), "Documento: <%=recordingAct.Document.UID%>");
    setInnerText(getElement("spanCurrentImage"), "Predio: <%=resource.UID%>");
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
    if (((width - 700) - 38) > 700) {
      divImageContainer.style.width = (width - 700) - 38;
    } else {
      divImageContainer.style.width = 672;
    }
  }

  function window_onresize() {
    resizeAllFrames();
    window_onscroll();
  }

  function resizeAllFrames() {
    resizeFrame(null, getElement("ifraPropertyEditor"));
    resizeFrame(null, getElement("ifraRecordingActEditor"));
    resizeFrame(null, getElement("ifraPropertyHistory"));
    resizeFrame(null, getElement("ifraPropertyStructure"));
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

    if (newHeight <= 800) {
      oFrame.style.height = 800;
    } else {
      oFrame.style.height = newHeight;
    }
    //oFrame.style.width = oBody.scrollWidth + (oBody.offsetWidth - oBody.clientWidth);
  }

  addEvent(window, 'load', window_onload);
  addEvent(window, 'resize', window_onresize);
  addEvent(getElement('divContent'), 'scroll', window_onscroll);

  addEvent(getElement("ifraPropertyEditor"), 'resize', resizeFrame);
  addEvent(getElement("ifraRecordingActEditor"), 'resize', resizeFrame);
  addEvent(getElement("ifraPropertyHistory"), 'resize', resizeFrame);
  addEvent(getElement("ifraPropertyStructure"), 'resize', resizeFrame);


  loadContent();

  /* ]]> */
  </script>
</html>
