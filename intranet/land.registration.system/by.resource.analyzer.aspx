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
  </div>
  <div id="divCanvas">
    <div id="divHeader" style="height:90px">
      <span id="spanPageTitle" class="appTitle">
        &nbsp;
      </span>
      <span id="spanPageRightTitle" class="rightItem appTitle" style="margin-right:8px">
        &nbsp;
      </span>
    </div> <!--divHeader!-->
    <div id="divBody">
      <div id="divContent">
        <table cellpadding="0" cellspacing="0">
          <tr>
            <td id="divImageViewer" valign='top' style="position:relative;">
              <div id="divImageContainer" style="overflow:auto;width:500px;height:540px;top:0;">
                  <object id="documentViewer" type="text/html" style="width:100%; height:100%;">
                    <p>visor de documentos</p>
                  </object>
                </div>
            </td>
            <td><img src="../themes/default/textures/pixel.gif" height="1px" width="12px" alt="" /></td>
            <td id="divDocumentViewer" valign="top" style="width:740px;">
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
      case 'onSelectImageSet':
        onSelectImageSet(arguments[1]);
        return;
      case 'onShowImageInFullScreen':
        onShowImageInFullScreen();
        return;

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

  function onShowImageInFullScreen() {
    alert("onShowImageInFullScreen");
  }

  function onSelectImageSet(imageSetId) {
    displayImageSet(imageSetId);
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

  function displayImageSet(imageSetId) {
    var newURL = "./image.set.viewer.aspx?id=" + imageSetId;

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
    getElement('ifraDocumentEditor').src = '<%=TabStripSource(TabStrip.DocumentEditor)%>';
    getElement('ifraPropertyEditor').src = '<%=TabStripSource(TabStrip.ResourceEditor)%>';
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

  function setPageTitle() {
    <% if (base.IsRecordingActSelected) { %>
    getElement("spanPageTitle").innerHTML = "Documento: <%=recordingAct.Document.UID%><br/>"+
                                            "Acto jurídico: <%=recordingAct.DisplayName%> [<%=recordingAct.Index + 1%>]";
    getElement("spanPageRightTitle").innerText = "Predio: <%=resource.UID%>";
    <% } else { %>
    getElement("spanPageTitle").innerHTML = "Consulta del acervo registral"
    getElement("spanPageRightTitle").innerText = "";
    <% } %>
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

    if (height > 40) {
      divBody.style.height = height;
      divContent.style.height = height - 18;
      divImageContainer.style.height = height - 40;
    }
    if (width > 28) {
      divContent.style.width = width - 28;
    }
    if (((width - 740) - 38) > 740) {
      divImageContainer.style.width = (width - 740) - 38;
    } else {
      divImageContainer.style.width = 520;
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

    var newHeight = oBody.scrollHeight + oBody.clientHeight;

    if (newHeight <= 700) {
      oFrame.style.height = 700;
    } else {
      oFrame.style.height = newHeight;
    }
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
