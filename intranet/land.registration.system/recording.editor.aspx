<%@ Page Language="C#" EnableViewState="true" AutoEventWireup="true" Inherits="Empiria.Land.WebApp.RecordingEditor" CodeFile="recording.editor.aspx.cs" %>
<%@ OutputCache Location="None" NoStore="true" %>
<%@ Register tagprefix="empiriaControl" tagname="LRSRecordingPartyEditorControl" src="../land.registration.system.controls/recording.party.editor.control.ascx" %>
<%@ Register tagprefix="empiriaControl" tagname="LRSRecordingPartyViewerControl" src="../land.registration.system.controls/recording.party.viewer.control.ascx" %>
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
  <script type="text/javascript" src="../scripts/empiria.calendar.js"></script>	
</head>
<body style="background-color:#fafafa; top:0; margin:0; margin-top:-14px; margin-left:-6px;">
<form name="aspnetForm" method="post" id="aspnetForm" runat="server">
<div id="divContentAlwaysVisible">
<table id="tabStripItemView_0" style="display:inline;">
  <tr>
    <td class="subTitle">Documento a inscribir</td>
  </tr>
  <tr id="divDocumentData">
    <td>
      Categoría del documento:
      <select id="cboRecordingType" name="cboRecordingType" class="selectBox" style="width:168px" title=""
                  onchange="return updateUserInterface(this);" runat="server">
        <option value="">( Seleccionar )</option>
        <option value="2410" title="oNotaryPublicDeed">Escritura pública</option>
        <option value="2414" title="oNotaryOfficialLetter">Oficio de notaría</option>
        <option value="2412" title="oJudgeOfficialLetter">Documento de juzgado</option>
        <option value="2413" title="oPrivateContract">Documento de terceros</option>
        <option value="2411" title="oEjidalSystemTitle">Título de propiedad</option>
      </select>
      <!--
        <option value="2413" title="oPrivateContract">Contrato privado</option>
        <option value="2408" title="oUnknownDocumentType">No determinado</option>
      -->
      Núm de hojas <b>del instrumento</b>:
      <select id="cboSheetsCount" name="cboSheetsCount" class="selectBox" style="width:46px" title=""
                  onchange="return updateUserInterface(this);" runat="server">
        <option value="">( ? )</option>
        <option value="1">01</option><option value="2">02</option><option value="3">03</option><option value="4">04</option><option value="5">05</option>
        <option value="6">06</option><option value="7">07</option><option value="8">08</option><option value="9">09</option><option value="10">10</option>
        <option value="11">11</option><option value="12">12</option><option value="13">13</option><option value="14">14</option><option value="15">15</option>
        <option value="16">16</option><option value="17">17</option><option value="18">18</option><option value="19">19</option><option value="20">20</option>
        <option value="21">21</option><option value="22">22</option><option value="23">23</option><option value="24">24</option><option value="25">25</option>
        <option value="26">26</option><option value="27">27</option><option value="28">28</option><option value="29">29</option><option value="30">30</option>
        <option value="31">31</option><option value="32">32</option><option value="33">33</option><option value="34">34</option><option value="35">35</option>
        <option value="36">36</option><option value="37">37</option><option value="38">38</option><option value="39">39</option><option value="40">40</option>
        <option value="41">41</option><option value="42">42</option><option value="43">43</option><option value="44">44</option><option value="45">45</option>
        <option value="46">46</option><option value="47">47</option><option value="48">48</option><option value="49">49</option><option value="50">50</option>
        <option value="51">51</option><option value="52">52</option><option value="53">53</option><option value="54">54</option><option value="55">55</option>
        <option value="56">56</option><option value="57">57</option><option value="58">58</option><option value="59">59</option><option value="60">60</option>
        <option value="61">61</option><option value="62">62</option><option value="63">63</option><option value="64">64</option><option value="65">65</option>
        <option value="66">66</option><option value="67">67</option><option value="68">68</option><option value="69">69</option><option value="70">70</option>
        <option value="71">71</option><option value="72">72</option><option value="73">73</option><option value="74">74</option><option value="75">75</option>
        <option value="76">76</option><option value="77">77</option><option value="78">78</option><option value="79">79</option><option value="80">80</option>
        <option value="81">81</option><option value="82">82</option><option value="83">83</option><option value="84">84</option><option value="85">85</option>
        <option value="86">86</option><option value="87">87</option><option value="88">88</option><option value="89">89</option><option value="90">90</option>
        <option value="91">91</option><option value="92">92</option><option value="93">93</option><option value="94">94</option><option value="95">95</option>
        <option value="96">96</option><option value="97">97</option><option value="98">98</option><option value="99">99</option><option value="100">100</option>
      </select>
      <b style="font-size:10pt"><%=transaction.Document.UID%></b>
      <br />
      <span id="spanRecordingDocumentEditor" runat="server"></span>
      <table class="editionTable">
        <tr>
          <td>Descripción:<br /><br /><br /><br /><br /><br /><br /><br /><br />&nbsp;</td>
          <td colspan="2" class="lastCell">
            <textarea id="txtObservations" name="txtObservations" class="textArea" style="width:698px" cols="348" rows="10" runat="server"></textarea>
          </td>
        </tr>
        <tr id="rowEditButtons" style="display:inline">
          <td>&nbsp;</td>
          <td class="lastCell" colspan="2">
            <input id='cmdEditDocument' type="button" value="Editar documento" class="button" style="width:128px;height:28px;display:none" onclick='doOperation("editDocument")' />
            &nbsp; &nbsp; &nbsp;
            <input id='cmdSaveDocument' type="button" value="Guardar los cambios" class="button" style="width:112px;height:28px;display:none" onclick='doOperation("saveDocument")' title='Guarda el documento' />
            &nbsp; &nbsp; &nbsp;
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

            <input id='cmdGenerateImagingControlID' type="button" value="Generar número de control" class="button" style="width:148px;height:28px;top:8px;display:none" onclick='doOperation("generateImagingControlID")' title='Generar número de control' />
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            <input id='cmdShowImagingControlSlip' type="button" value="Imprimir carátula" class="button" style="width:112px;height:28px;top:8px;display:none" onclick='doOperation("showImagingControlSlip")' title='Imprimir la carátula' />
            &nbsp; &nbsp;
            <input id='cmdShowRecordingSeal' type="button" value="Sello registral" class="button" style="width:112px;height:28px;top:8px;display:none" onclick='doOperation("viewGlobalRecordingSeal")' title='Visualiza el sello que va en la escritura que se entrega al interesado' />
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            <input id='cmdCloseDocument' type="button" value="Cerrar documento" class="button" style="width:122px;height:28px;top:8px;display:none" onclick='doOperation("closeDocument")' title='Cierra el documento protegiéndolo ante cambios no autorizados.' />
            <input id='cmdOpenDocument' type="button" value="Abrir documento" class="button" style="width:122px;height:28px;top:8px;display:none" onclick='doOperation("openDocument")' title='Abre este documento para editarlo.' />
          </td>
          <td >
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td class="subTitle">Actos jurídicos contenidos en el documento</td>
  </tr>
  <tr>
    <td>
      <table class="editionTable">
        <tr>
          <td class="lastCell">
            <div style="overflow:auto;max-height:480px;width:860px;">
              <table class="details" style="width:97%">
                <tr class="detailsHeader">
                  <td>#</td>
                  <td style='width:160px'>Acto jurídico</td>
                  <td style='width:240px'>Predio / Recurso</td>
                  <td style='width:360px'>Antecedente registrado en</td>
                  <td>&nbsp;</td>
                </tr>
                <%=GetRecordingActsGrid()%>
                <tr class='totalsRow' style='display:<%=base.IsReadyForEdition() && base.RecordingActs.Count == 0 ? "inline" : "none"%>'>
                  <td>&nbsp;</td>
                  <td colspan='4'>
                    Todavía no se han agregado actos jurídicos al documento.
                  </td>
                </tr>
              </table>
            </div>
          </td>
        </tr>
        <tr>
          <td class="totalsRow lastCell" style='width:860px;display:<%=base.IsReadyToAppendRecordingActs() && base.RecordingActs.Count > 0 ? "inline" : "none"%>'>
            <div style="width:50%;float:left">
                <a href="javascript:doOperation('showRecordingActEditor')">
                <img src="../themes/default/buttons/edit.gif" alt="" title="" style="margin-right:8px" />Registrar otro acto jurídico</a>
            </div>
            <div style="width:50%;text-align:right;">
              <a href="javascript:doOperation('showSearchRecordingsView')">
              <img src="../themes/default/bullets/agenda_sm.gif" alt="" title="" style="margin-right:8px" />Consultar la información registral</a>&nbsp; &nbsp; &nbsp;
            </div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td id="divRecordingActEditor" style='left:16px;display:<%=base.IsReadyToAppendRecordingActs() && base.RecordingActs.Count == 0 ? "inline" : "none"%>'>
    <span id="spanRecordingActEditor" runat="server"></span>

    </td>
  </tr>
</table>
</div>
</form>
<div><span id="span" runat="server"></span></div>
<iframe id="ifraCalendar" style="z-index:99;left:0;visibility:hidden;position:relative;top:0"
    marginheight="0" marginwidth="0" frameborder="0" scrolling="no" src="../user.controls/calendar.aspx" width="100%">
</iframe>
</body>
<script type="text/javascript">

  var gResourceEditorWindow = null;
  var gRecordingSealsAndSlipsWindow = null;

  function doOperation(command) {
    var success = false;

    if (gbSended) {
      return;
    }
    switch (command) {
      case 'showRecordingActEditor':
        return showRecordingActEditor();
      case 'deleteRecordingAct':
        return deleteRecordingAct(arguments[1]);
      case 'deleteBookRecording':
        alert(arguments[1]);
        return deleteBookRecording(arguments[1]);

      case 'editDocument':
        return editDocument();

      case 'saveDocument':
        return saveDocument();

      case 'closeDocument':
        return closeDocument();

      case 'openDocument':
        return openDocument();

      case 'editResource':
        return editResource(arguments[1], arguments[2]);

      case 'viewRecordingSeal':
        viewRecordingSeal(arguments[1]);
        return;
      case 'viewGlobalRecordingSeal':
        viewGlobalRecordingSeal();
        return;
      case 'showSearchRecordingsView':
        showSearchRecordingsView();
        return;
      case 'generateImagingControlID':
        generateImagingControlID();
        return;
      case 'showImagingControlSlip':
        showImagingControlSlip();
        return;
      case 'displayRecordingBookImageSet':
        displayRecordingBookImageSet(arguments[1]);
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

  function closeDocument() {
    <% if (!base.CanCloseDocument()) { %>
      alert("No es posible cerrar el documento  ya que no está abierto para registro en libros, " +
            "o no cuenta con los permisos necesarios para efectuar esta operación.");
      return false;
    <% } %>
    if (!validateIfCanBeClosed()) {
      return false;
    }
    var sMsg = "Cerrar documento\n\n";
    if (confirm("¿Cierro este documento y lo protejo ante cambios no autorizados?")) {
      sendPageCommand('closeDocument');
      return true;
    }
  }

  function validateIfCanBeClosed() {
    var ajaxURL = "../ajax/land.registration.system.data.aspx";
    ajaxURL += "?commandName=validateIfDocumentCanBeClosedCmd";
    ajaxURL += "&documentId=<%=base.transaction.Document.Id%>";

    return invokeAjaxValidator(ajaxURL);
  }

  function openDocument() {
    <% if (!base.CanOpenDocument()) { %>
      alert("No es posible abrir el documento ya que no cuenta con los permisos necesarios para efectuar esta operación.");
      return false;
    <% } %>
    if (!validateIfCanBeOpened()) {
      return false;
    }
    var sMsg = "Abrir documento\n\n";
    if (confirm("¿Abro este documento para editarlo o agregarle o modificarle actos jurídicos?")) {
      sendPageCommand('openDocument');
      return true;
    }
  }

    function validateIfCanBeOpened() {
    var ajaxURL = "../ajax/land.registration.system.data.aspx";
    ajaxURL += "?commandName=validateIfDocumentCanBeOpenedCmd";
    ajaxURL += "&documentId=<%=base.transaction.Document.Id%>";

    return invokeAjaxValidator(ajaxURL);
  }

  function displayRecordingBookImageSet(selectBoxControlName) {
    var recordingBookId = getElement(selectBoxControlName).value;

    if (!recordingBookId || recordingBookId.length == 0) {
      alert('Se requiere seleccionar un volumen registral de la lista.');
      return;
    }
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getRecordingBookImageSetId";
    url += "&recordingBookId=" + recordingBookId;

    var imageSetId = invokeAjaxGetJsonObject(url);

    if (+imageSetId > 0) {
      gRecordingSealsAndSlipsWindow = openInWindow(gRecordingSealsAndSlipsWindow,
                                                   "./image.set.viewer.aspx?id=" + imageSetId, false);
    } else {
      alert("El volumen seleccionado no ha sido digitalizado.");
    }
  }

  function generateImagingControlID() {
    sendPageCommand('generateImagingControlID');
  }

  function showImagingControlSlip() {
    var url = "./document.imaging.control.slip.aspx?id=<%=transaction.Document.Id%>";

    gRecordingSealsAndSlipsWindow = openInWindow(gRecordingSealsAndSlipsWindow, url, false);
  }

  function showRecordingActEditor() {
    if (divRecordingActEditor.style.display == 'none') {
      divRecordingActEditor.style.display = 'inline';
    } else {
      divRecordingActEditor.style.display = 'none';
    }
  }

  function editDocument() {
    <% if (!IsReadyForEdition()) { %>
      alert("No es posible editar el documento ya que no está abierto para registro en libros, " +
            "o no cuenta con los permisos necesarios para efectuar esta operación.");
      return false;
    <% } %>
    protectRecordingEditor(false);
    if (getElement('cmdEditDocument').value == "Descartar los cambios") {
      if (confirm("¿Descarto los cambios efectuados en el documento?")) {
        sendPageCommand('refreshDocument');
        return true;
      }
    } else {
      getElement('cmdEditDocument').value = "Descartar los cambios";
      getElement('cmdSaveDocument').style.display = 'inline';
      getElement('cmdCloseDocument').style.display = 'none';
      getElement('cmdOpenDocument').style.display = 'none';
      getElement("cmdShowRecordingSeal").style.display = 'none';
    }

  }


  function deleteRecordingAct(recordingActId) {
    <% if (!IsReadyForEdition()) { %>
      alert("No es posible eliminar la partida debido a que el documento no está abierto para registro en libros, " +
            "o no cuenta con los permisos necesarios para efectuar esta operación.");
      return false;
    <% } %>
    if (confirm("¿Elimino el acto jurídico seleccionado?")) {
      sendPageCommand('deleteRecordingAct', 'id=' + recordingActId);
      return true;
    }
  }

  function deleteBookRecording(recordingId) {
    <% if (!IsReadyForEdition()) { %>
      alert("No es posible eliminar la partida debido a que el documento no está abierto para registro en libros, " +
            "o no cuenta con los permisos necesarios para efectuar esta operación.");
      return false;
    <% } %>
    if (confirm("¿Elimino el registro de la partida seleccionada?")) {
      sendPageCommand('deleteBookRecording', 'id=' + recordingId);
      return true;
    }
  }

  function protectRecordingEditor(disabledFlag) {
    <%=oRecordingDocumentEditor.ClientID%>_disabledControl(disabledFlag);
    disableControls(getElement("divDocumentData"), disabledFlag);
    disableControls(getElement("rowEditButtons"), false);
  }

  function editResource(resourceId, recordingActId) {
    if (resourceId == null || resourceId.length == 0) {
      alert("Requiero se seleccione el predio a consultar.");
      return;
    }
    if (recordingActId == null || recordingActId.length == 0) {
      recordingActId = -1;
    }
    var url = "../land.registration.system/by.resource.analyzer.aspx?" +
              "resourceId=" + resourceId + "&recordingActId=" + recordingActId;

    gResourceEditorWindow = openInWindow(gResourceEditorWindow, url, true);
  }

  function saveDocument() {
    <% if (transaction.IsEmptyInstance) { %>
    alert("Este control no está ligado a un trámite válido.");
    return;
    <% } %>
    <% if (!IsReadyForEdition()) { %>
    alert("No es posible modificar este documento debido a que no está en un estado válido para ello, o bien, " +
          "no cuenta con los permisos necesarios para efectuar esta operación.");
    return false;
    <% } %>
    if (getElement('cboRecordingType').value.length == 0) {
      alert("Requiero se proporcione el tipo de documento.");
      return false;
    }
    if (getElement('cboSheetsCount').value.length == 0) {
      alert("Necesito conocer el número de hojas que tiene el documento, incluyendo la hoja donde irán los sellos.");
      return false;
    }
    if (!<%=oRecordingDocumentEditor.ClientID%>_validate('<%=transaction.PresentationTime.ToString("dd/MMM/yyyy")%>')) {
      return false;
    }

    sendPageCommand('saveDocument');
    return true;
  }

  function showSearchRecordingsView() {
    createNewWindow("<%=base.GetLegacyDataViewerUrl()%>");
  }

  function viewGlobalRecordingSeal() {
    <% if (transaction.IsEmptyInstance || transaction.Document.IsEmptyInstance) { %>
    alert("Primero requiero se ingresen los datos de la escritura o documento que se va a inscribir.");
    return;
    <% } %>
    var url = "../land.registration.system/recording.seal.aspx?transactionId=<%=transaction.Id%>&id=-1";

    gRecordingSealsAndSlipsWindow = openInWindow(gRecordingSealsAndSlipsWindow, url, false);
  }

  function viewRecordingSeal(recordingId) {
    var url = "../land.registration.system/recording.seal.aspx?transactionId=<%=transaction.Id%>&id=" + recordingId;

    gRecordingSealsAndSlipsWindow = openInWindow(gRecordingSealsAndSlipsWindow, url, false);
  }

  function updateUserInterface(oControl) {
    if (oControl == null) {
      return;
    }
    if (oControl == getElement("cboRecordingType")) {
      <%=oRecordingDocumentEditor.ClientID%>_updateUserInterface(getComboSelectedOption("cboRecordingType").title);
      return;
    }
  }

  function window_onload() {
    <%=base.OnLoadScript%>
    <% if (!IsReadyForEdition()) { %>
    protectRecordingEditor(true);
    <% } else { %>
    protectRecordingEditor(true);
    getElement('cmdEditDocument').style.display = 'inline';
    <% } %>


    <% if (base.IsReadyForGenerateImagingControlID()) { %>
    getElement("cmdGenerateImagingControlID").style.display = "inline";
    <% } %>
    <% if (this.transaction.Document.ImagingControlID.Length != 0) { %>
    getElement("cmdShowImagingControlSlip").style.display = "inline";
    <% } %>
    <% if (!base.transaction.Document.IsEmptyDocument) { %>
      getElement("cmdShowRecordingSeal").style.display = "inline";
    <% } %>
    <% if (base.CanCloseDocument()) { %>
      getElement('cmdCloseDocument').style.display = 'inline';
    <% } else if (base.CanOpenDocument()) { %>
    getElement('cmdOpenDocument').style.display = 'inline';
    <% } %>
  }

  function window_onunload() {
    closeWindow(gResourceEditorWindow);
    closeWindow(gRecordingSealsAndSlipsWindow);
  }

  addEvent(window, 'load', window_onload);
  addEvent(window, 'unload', window_onunload);

</script>
</html>
