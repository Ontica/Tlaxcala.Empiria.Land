<%@ Page Language="C#" EnableViewState="true" AutoEventWireup="true" Inherits="Empiria.Web.UI.LRS.RecordingEditor" CodeFile="recording.editor.aspx.cs" %>
<%@ OutputCache Location="None" NoStore="true" %>
<%@ Register tagprefix="empiriaControl" tagname="RecordingActAttributesEditorControl" src="../land.registration.system.controls/recording.act.attributes.editor.control.ascx" %>
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
<body style="background-color:#fafafa; top:0px; margin:0px; margin-top:-14px; margin-left:-6px;">
<form name="aspnetForm" method="post" id="aspnetForm" runat="server">
<div id="divContentAlwaysVisible">
<table id="tabStripItemView_0" style="display:inline;">
  <tr>
    <td class="subTitle">Documento a inscribir</td>
  </tr>
  <tr id="divDocumentData">
    <td>
      Categoría del documento:
      <select id="cboRecordingType" name="cboRecordingType" class="selectBox" style="width:136px" title="" onchange="return updateUserInterface(this);" runat="server">
        <option value="">( Seleccionar )</option>
        <option value="2410" title="oNotaryRecording">Escritura pública</option>
        <option value="2411" title="oTitleRecording">Título de propiedad</option>
        <option value="2412" title="oJudicialRecording">Orden/Resolución</option>
        <option value="2413" title="oPrivateRecording">Contrato</option>
        <option value="2409" title="">No determinado</option>
      </select>
      &nbsp;
      Núm de hojas <b>del instrumento</b>:
      <select id="cboSheetsCount" name="cboSheetsCount" class="selectBox" style="width:46px" title="" onchange="return updateUserInterface(this);" runat="server">
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
      &nbsp;
      Margen sello:
      <select id="cboSealPosition" name="cboSealPosition" class="selectBox" style="width:52px" title="" onchange="return updateUserInterface(this);" runat="server">
        <option value="">( cms )</option>
        <option value="5.0">5.0</option>
        <option value="10.0">10.0</option>
        <option value="15.0">15.0</option>
        <option value="17.5">17.5</option>
        <option value="20.0">20.0</option>
        <option value="21.0">21.0</option>
        <option value="21.0">22.0</option>
      </select>
      <b style="font-size:10pt"><%=transaction.Document.UniqueCode%></b>
      <br />
      <span id="spanRecordingDocumentEditor" runat="server"></span>
      <table class="editionTable">
        <tr>
          <td>Observaciones:<br /><br /><br /><br /></td>
          <td colspan="2" class="lastCell">
            <textarea id="txtObservations" name="txtObservations" class="textArea" style="width:558px" cols="320" rows="4" runat="server"></textarea>
          </td>
        </tr>
        <tr id="rowEditButtons" style="display:inline">
          <td>&nbsp;</td>
          <td class="lastCell" colspan="2">
            <input id='btnSaveRecording' type="button" value="Guardar los cambios" class="button" style="width:112px;height:28px" onclick='doOperation("saveDocument")' title='Guarda el documento' />
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            <input id='cmdPrintRecordingCover' type="button" value="Imprimir carátula" class="button" style="width:112px;height:28px;top:8px" onclick='doOperation("doPrintRecordingCover")' title='Imprimir la carátula' />
            &nbsp; &nbsp;
            <input id='cmdPrintFinalSeal' type="button" value="Imprimir sello interesado" class="button" style="width:132px;height:28px;top:8px" onclick='doOperation("viewGlobalRecordingSeal")' title='Imprime el sello que va en la escritura que se entrega al interesado' />
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
          <td colspan="8" class="lastCell">
            <div style="overflow:auto;width:860px;">
              <table class="details"style="width:99%">
                <tr class="detailsHeader">
                  <td>#</td>
                  <td>Volumen</td>
                  <td>Partida</td>
                  <td>Acto jurídico</td>
                  <td>Estado acto</td>
                  <td>Predio / Recurso</td>
                  <td>Estado predio</td>
                  <td>¿Qué desea hacer?</td>
                </tr>
                <%=RecordingActsGrid()%>
              </table>
            </div>
          </td>
        </tr>
        <tr>
          <td>Tipo de acto:</td>
          <td colspan="5">
            <select id="cboRecordingActTypeCategory" name="cboRecordingActTypeCategory" class="selectBox" 
                    style="width:192px" title="" onchange="return updateUserInterface(this);" runat='server'>
            </select>
            <select id="cboRecordingActType" name="cboRecordingActType" class="selectBox" style="width:306px" title="" 
                    onchange="return updateUserInterface(this);">
              <option value="">( Primero seleccionar el tipo de acto jurídico )</option>
            </select>
            <input type="button" value="Agregar acto" class="button" style="width:78px" onclick='doOperation("appendRecordingAct")' />    
          </td>
          <td class="lastCell">&nbsp;</td>
        </tr>
        <tr id="divPropertyTypeSelector" style="display:none">
          <td>Sobre el predio:</td>
          <td colspan="5">
            <select id="cboPropertyTypeSelector" class="selectBox" style="width:192px" title="" onchange="return updateUserInterface(this);">
              <option value="">( Seleccionar acto )</option>
            </select>
            <span id="divNewPropertyRecorderOfficeSection" style="display:none">
              Distrito donde se encuentra:
              <select id="cboNewPropertyRecorderOffice" name="cboNewPropertyRecorderOffice" class="selectBox" style="width:164px" title="" onchange="return updateUserInterface(this);" runat='server'>
                <option value="">( Seleccionar ) </option>
                <option value="101">Hidalgo</option>
                <option value="102">Cuauhtémoc</option>
                <option value="103">Juárez</option>
                <option value="104">Lardizábal y Uribe</option>
                <option value="105">Morelos</option>
                <option value="106">Ocampo</option>
                <option value="107">Xicohténcatl</option>
                <option value="108">Zaragoza</option>
              </select>
            </span>
            <span id="divPrecedentActSection" style="display:none">
              Antecedente en:
              <select id="cboPrecedentRecordingSection" class="selectBox" style="width:222px" title="" 
                      onchange="return updateUserInterface(this);" runat='server'>
              </select>
              <a href='javascript:doOperation("refreshPrecedentRecordingCombos")' class="button">Actualizar datos</a>
            </span>
          </td>
          <td class="lastCell">&nbsp;</td>
        </tr>
        <tr id="divPrecedentRecordingSection" style="display:none">
          <td>Volumen:<br /><br />&nbsp;</td>
          <td colspan="6">
            <select id="cboPrecedentRecordingBook" class="selectBox" style="width:460px" title="" 
                    onchange="return updateUserInterface(this);" runat='server'>
            </select>
            <br />
            Partida:
            <select id="cboPrecedentRecording" class="selectBox" style="width:98px" title="" 
                    onchange="return updateUserInterface(this);" runat='server'>
            </select>
            <img src="../themes/default/buttons/search.gif" alt="" title="Ejecuta la búsqueda" style="margin-left:-8px" 
                 onclick="doOperation('showPrecedentRecording')" />
            <span id="divPropertySelectorSection" style="display:inline">
              &nbsp;Folio del predio:&nbsp;
              <select id="cboPrecedentProperty" class="selectBox" style="width:182px" title="" runat='server'>
              </select>
              <img src="../themes/default/buttons/search.gif" alt="" title="Ejecuta la búsqueda" style="margin-left:-8px" 
                   onclick="doOperation('showPrecedentProperty')" />
            </span>
            <span id="divRecordingQuickAddSection" style="display:none">
            &nbsp;Partida donde está registrado el predio:
            <input id="txtQuickAddRecordingNumber" type="text" class="textBox" style="width:35px;margin-right:0px" 
                   onkeypress="return integerKeyFilter(this);" title="" maxlength="5" runat="server" />
            <select id="cboQuickAddBisRecordingTag" class="selectBox" style="width:52px" title="" runat='server'>
              <option value=""></option>
              <option value="-Bis">-Bis</option>
              <option value="-01">-01</option>
              <option value="-02">-02</option>
              <option value="-03">-03</option>
              <option value="-04">-04</option>
              <option value="-05">-05</option>
              <option value="-06">-06</option>
            </select>
            Fracción:
            <input id="txtPropertyPart" name="txtPropertyPart" type="text" class="textBox" 
                   style="width:35px;margin-right:0px" onkeypress="return integerKeyFilter(this);" 
                   title="" maxlength="4" runat="server" />
            </span>
          </td>
          <td class="lastCell">&nbsp;</td>
        </tr>
        <tr id="divTargetPrecedentActSection" style="display:none">
          <td>Que aplica a:</td>
          <td colspan="5">
            <span id="divTargetPrecedentActLabel"></span>
            <select id="cboTargetAct" name="cboTargetAct" class="selectBox" style="width:436px" title="" onchange="return updateUserInterface();">
              <option value="">( Seleccionar el acto a cancelar o modificar )</option>
            </select>
            <img src="../themes/default/buttons/search.gif" alt="" title="Ejecuta la búsqueda" style="margin-left:-8px" onclick="doOperation('showPrecedentRecordingAct')" />
          </td>
          <td class="lastCell">&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
  <% %>
</table>
</div>
</form>
<iframe id="ifraCalendar" style="z-index:99;left:0px;visibility:hidden;position:relative;top:0px" 
    marginheight="0" marginwidth="0" frameborder="0" scrolling="no" src="../user.controls/calendar.aspx" width="100%">
</iframe>
</body>
<script type="text/javascript">

  function doOperation(command) {
    var success = false;

    if (gbSended) {
      return;
    }
    switch (command) {
      case 'deleteRecordingAct':
        return deleteRecordingAct(arguments[1]);
      case 'deleteBookRecording':
        alert(arguments[1]);
        return deleteBookRecording(arguments[1]);
      case 'saveDocument':
        return saveDocument();
      case 'showPrecedentRecording':
        return showPrecedentRecording();
      case 'showPrecedentProperty':
        return showPrecedentProperty();
      case 'appendRecordingAct':
        return appendRecordingAct();
      case 'editRecordingAct':
        return editRecordingAct(arguments[1], arguments[2]);
      case 'editProperty':
        return editProperty(arguments[1], arguments[2], arguments[3]);
      case 'viewRecordingSeal':
        viewRecordingSeal(arguments[1]);
        return;
      case 'viewGlobalRecordingSeal':
        viewGlobalRecordingSeal();
        return;
      case 'closeWindow':
        window.parent.execScript("doOperation('refreshRecording')");
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

  function deleteRecordingAct(recordingActId) {
    <% if (!IsReadyForEdition()) { %>
      alert("No es posible eliminar la partida debido a que el documento no está abierto para registro en libros, o no cuenta con los permisos necesarios para efectuar esta operación.");
      return false;
    <% } %>
    if (confirm("¿Elimino el acto jurídico seleccionado?")) {
      sendPageCommand('deleteRecordingAct', 'id=' + recordingActId);
      return true;
    }
  }

  function deleteBookRecording(recordingId) {
    <% if (!IsReadyForEdition()) { %>
      alert("No es posible eliminar la partida debido a que el documento no está abierto para registro en libros, o no cuenta con los permisos necesarios para efectuar esta operación.");
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
  }

  function editProperty(bookId, recordingId, propertyId) {
    var url = "../land.registration.system/recording.book.analyzer.aspx?bookId=" +
            bookId + "&id=" + recordingId + "&gotoPropertyId=" + propertyId;

    createNewWindow(url);
  }

  function editRecordingAct(bookId, recordingId) {
    var url = "../land.registration.system/recording.book.analyzer.aspx?bookId=" +
              bookId + "&id=" + recordingId;

    createNewWindow(url);
  }

  function getRecordingActQueryString() {
    var qs = "transactionId=<%=transaction.Id%>";    
    qs += "&documentId=<%=transaction.Document.Id%>\n";
    qs += "&recordingActTypeCategoryId=" + getElement('cboRecordingActTypeCategory').value;
    qs += "&recordingActTypeId=" + getElement('cboRecordingActType').value;
    qs += "&propertyType=" + getElement('cboPropertyTypeSelector').value;
    qs += "&recorderOfficeId=" + getElement('cboNewPropertyRecorderOffice').value;
    qs += "&precedentRecordingBookId=" + getElement('cboPrecedentRecordingBook').value;
    qs += "&precedentRecordingId=" + getElement('cboPrecedentRecording').value;
    qs += "&quickAddRecordingNumber=" + getElement('txtQuickAddRecordingNumber').value;
    qs += "&quickAddBisRecordingSuffixTag=" + getElement('cboQuickAddBisRecordingTag').value;
    qs += "&precedentPropertyId=" + getElement('cboPrecedentProperty').value;
    qs += "&targetRecordingActId=" + getElement('cboTargetAct').value;

    return qs;
  }

  function appendRecordingAct() {
    if (!assertBookRecording()) {
      return false;
    }
    if (!validateRecordingAct()) {
      return false;
    }
    if (!validateRecordingActSemantics()) {
      return false;
    }

    var qs = getRecordingActQueryString();
    qs = qs.replace(/&/g, "|");
    //alert(qs);
    if (!showConfirmFormCreateRecordingAct()) {
      return false;
    }
    sendPageCommand("appendRecordingAct", qs);
  }

  function showConfirmFormCreateRecordingAct() {
    var sMsg = "Agregar un acto jurídico al documento:\n\n";

    sMsg += 'Documento:\t<%=transaction.Document.UniqueCode%>\n';
    sMsg += 'Trámite:\t\t<%=transaction.UniqueCode%>\n';
    sMsg += 'Interesado(s):\t<%=Empiria.EmpiriaString.FormatForScripting(transaction.RequestedBy)%>\n\n';
   
    sMsg += "Acto jurídico que se agegará:\n\n";
    sMsg += "Acto jurídico:\t" + getComboOptionText(getElement('cboRecordingActType')) + "\n";
    if (getElement('cboPrecedentRecording').value.length == 0) {
      sMsg += "Predio:\t\t" + "Predio sin antecedente registral" + "\n";
      sMsg += "Distrito:\t\t" + getComboOptionText(getElement('cboNewPropertyRecorderOffice')) + "\n\n";
    } else if (getElement('cboPrecedentRecording').value != "-1") {
      sMsg += "Predio:\t\t" + getComboOptionText(getElement('cboPrecedentProperty')) + "\n";
      sMsg += "Ubicación:\t" + "No disponible\n";
      sMsg += "Superficie:\t\t" + "No disponible\n";
      sMsg += "Antecedente en:\t" + "Partida " + getComboOptionText(getElement('cboPrecedentRecording')) + "\n";
      sMsg += "\t\t" + getComboOptionText(getElement('cboPrecedentRecordingBook')) + "\n\n";
    } else {
      sMsg += "Antecedente:\t" + "Registrar antecedente en partida " + getElement('txtQuickAddRecordingNumber').value + 
              getComboOptionText(getElement('cboQuickAddBisRecordingTag')) + "\n";
      sMsg += "\t\t" + getComboOptionText(getElement('cboPrecedentRecordingBook')) + "\n\n";
    }
    sMsg += "¿Agrego este acto jurídico al documento?";
    return confirm(sMsg);
  }

  function validateRecordingAct() {
    var recordingAct = getComboOptionText(getElement('cboRecordingActType'));

    if (getElement('cboRecordingActTypeCategory').value.length == 0) {
      alert("Necesito se seleccione de la lista la categoría del acto jurídico que va a agregarse al documento.");
      getElement('cboRecordingActTypeCategory').focus();
      return false;
    }
    if (getElement('cboRecordingActType').value == "") {
      alert("Requiero se seleccione de la lista el acto jurídico que va a agregarse al documento.");
      getElement('cboRecordingActType').focus();
      return false;
    }
    if (getElement('cboPropertyTypeSelector').value.length == 0) {
      alert("Requiero se proporcione la información del predio sobre el que se aplicará el acto jurídico " + recordingAct + ".");
      getElement('cboPropertyTypeSelector').focus();
      return false;
    }
    if (getElement('cboPropertyTypeSelector').value == 'actAppliesOnlyToSection') {
      if (getElement('cboNewPropertyRecorderOffice').value.length == 0) {
        alert("Necesito conocer el distrito donde se inscribirá el acto jurídico " + recordingAct + ".");
        getElement('cboNewPropertyRecorderOffice').focus();
        return false;
      }      
    }
    if (getElement('cboPropertyTypeSelector').value == 'createProperty' &&
        getElement('cboNewPropertyRecorderOffice').value.length == 0) {
      alert("Necesito conocer el distrito judicial al que pertenece el predio que va a registrarse por primera vez (no tiene antecedente registral).");
      getElement('cboNewPropertyRecorderOffice').focus();
      return false;
    }
    if (getElement('cboPropertyTypeSelector').value == 'selectProperty') {    // Select precedent property
      if (getElement('cboPrecedentRecordingSection').value.length == 0) {
        alert("Necesito conocer el distrito o sección donde se encuentra el antecedente registral del predio.");
        getElement('cboPrecedentRecordingSection').focus();
        return false;
      }
      if (getElement('cboPrecedentRecordingBook').value.length == 0) {
        alert("Requiero se seleccione el libro registral donde está inscrito el predio sobre el que aplicará el acto jurídico " + recordingAct + ".");
        getElement('cboPrecedentRecordingBook').focus();
        return false;
      }
      if (getElement('cboPrecedentRecording').value.length == 0) {
        alert("Necesito se seleccione de la lista el número de partida donde está registrado el antecedente del predio.");
        getElement('cboPrecedentRecording').focus();
        return false;
      }
      if (getElement('cboPrecedentRecording').value == "-1" &&
          getElement('txtQuickAddRecordingNumber').value.length == 0) {
        alert("Necesito se capture el número de partida que se va a agregar y que corresponde al antecedente registral del predio sobre el que se aplicará el acto jurídico.");
        getElement('txtQuickAddRecordingNumber').focus();
        return false;
      }
      if (getElement('cboPrecedentRecording').value == "-1" &&
          getElement('txtQuickAddRecordingNumber').value.length != 0 && 
          !isNumeric(getElement('txtQuickAddRecordingNumber'))) {
        alert("El número de partida tiene un formato que no reconozco.\nDebería ser un número.");
        getElement('txtQuickAddRecordingNumber').focus();
        return false;
      }
      if (getElement('cboPrecedentRecording').value.length != 0 &&
          getElement('cboPrecedentRecording').value != "-1" && 
          getElement('cboPrecedentProperty').value.length == 0) {
        alert("Necesito se seleccione de la lista el folio del predio al que aplicará el acto jurídico " + recordingAct + ".");
        getElement('cboPrecedentProperty').focus();
        return false;
      }
    }
    return true;
  }

  function assertBookRecording() {
    <% if (transaction.IsEmptyInstance) { %>
      alert("Este control no está ligado a un trámite válido.");
      return false;
    <% } %>
    <% if (!IsReadyForEdition()) { %>
      alert("No es posible inscribir en libros debido a que el trámite no está en un estado válido para ello, o bien, no cuenta con los permisos necesarios para efectuar esta operación.");
      return false;
    <% } %>
    <% if (transaction.Document.IsEmptyInstance) { %>
      alert("Primero requiero se ingresen los datos de la escritura o documento que se va a inscribir.");
      return false;
    <% } %>
    return true;
  }

  function saveDocument() {
    <% if (transaction.IsEmptyInstance) { %>
    alert("Este control no está ligado a un trámite válido.");
    return;
    <% } %>
    <% if (!IsReadyForEdition()) { %>
    alert("No es posible modificar este documento debido a que no está en un estado válido para ello, o bien, no cuenta con los permisos necesarios para efectuar esta operación.");
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
    if (getElement('cboSealPosition').value.length == 0) {
      alert("Necesito conocer el margen superior donde se colocará el sello.");
      return false;
    }
    if (!<%=oRecordingDocumentEditor.ClientID%>_validate('<%=transaction.PresentationTime.ToString("dd/MMM/yyyy")%>')) {
      return false;
    }
    sendPageCommand('saveDocument');
    return true;
  }

  function viewGlobalRecordingSeal() {
    <% if (transaction.IsEmptyInstance || transaction.Document.IsEmptyInstance) { %>
    alert("Primero requiero se ingresen los datos de la escritura o documento que se va a inscribir.");
    return;
    <% } %>
    var url = "../land.registration.system/recording.seal.aspx?transactionId=<%=transaction.Id%>&id=-1";
    createNewWindow(url);
  }

  function viewRecordingSeal(recordingId) {
    var url = "../land.registration.system/recording.seal.aspx?transactionId=<%=transaction.Id%>&id=" + recordingId;

    createNewWindow(url);
  }
  
  function showPrecedentRecording() {
    var bookId = getElement('cboPrecedentRecordingBook').value;
    var recordingId = getElement('cboPrecedentRecording').value;

    if (bookId.length == 0 || bookId == "-1") {
      alert("Primero necesito se seleccione un libro de la lista de arriba.");
      return;
    }
    if (recordingId.length == 0 || recordingId == "-1") {
      alert("Necesito se seleccione una partida de la lista.");
      return;
    }
    var url = "../land.registration.system/recording.book.analyzer.aspx?bookId=" + bookId +
              "&id=" + recordingId;

    createNewWindow(url);
  }
  
  function showPrecedentProperty() {
    var propertyId = getElement("cboPrecedentProperty").value;
    if (propertyId.length == 0 || propertyId == "-1" || propertyId == "0") {
      alert("Necesito se seleccione un predio de la lista.");
      return;
    }
    var url = "../land.registration.system/property.editor.aspx?propertyId=" + propertyId +
              "&recordingActId=-1&recordingId=" + getElement('cboPrecedentRecording').value;
    createNewWindow(url);
  }

  function updateUserInterface(oControl) {
    if (oControl == null) {
      return;
    }
    if (oControl == getElement("cboRecordingType")) {
      <%=oRecordingDocumentEditor.ClientID%>_updateUserInterface(getComboSelectedOption("cboRecordingType").title);
      return;
    }
    if (oControl == getElement("cboRecordingActTypeCategory")) {
      if (!assertBookRecording()) {
        getElement("cboRecordingActTypeCategory").value = '';
        return;
      }
      resetRecordingActTypesCombo();
    } else if (oControl == getElement("cboRecordingActType")) {
      resetPropertyTypeSelectorCombo();
    } else if (oControl == getElement("cboPropertyTypeSelector")) {
      showPrecedentRecordingSection();
    } else if (oControl == getElement("cboPrecedentRecordingSection")) {
      resetPrecedentDomainBooksCombo();
    } else if (oControl == getElement("cboPrecedentRecordingBook")) {
      resetPrecedentRecordingsCombo();
    } else if (oControl == getElement("cboPrecedentRecording")) {
      showPrecedentPropertiesSection();
    }
  }

  function showPrecedentPropertiesSection() {
    var selectedValue = getElement('cboPrecedentRecording').value;

    if (selectedValue != "-1") {
      resetPrecedentPropertiesCombo();
      getElement('divRecordingQuickAddSection').style.display = 'none';
      getElement('divPropertySelectorSection').style.display = 'inline';     
    } else {
      getElement('divRecordingQuickAddSection').style.display = 'inline';
      getElement('divPropertySelectorSection').style.display = 'none';
    }
  }

  function resetPrecedentDomainBooksCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getDomainBooksStringArrayCmd";
    if (getElement("cboPrecedentRecordingSection").value.length != 0) {
      url += "&sectionFilter=" + getElement("cboPrecedentRecordingSection").value;
    }
    invokeAjaxComboItemsLoader(url, getElement("cboPrecedentRecordingBook"));

    resetPrecedentRecordingsCombo();
  }

  function resetPrecedentRecordingsCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getRecordingNumbersStringArrayCmd";
    if (getElement("cboPrecedentRecordingBook").value.length != 0) {
      url += "&recordingBookId=" + getElement("cboPrecedentRecordingBook").value;
    } else {
      url += "&recordingBookId=0";
    }
    if (getElement("cboRecordingActType").value.length != 0) {
      url += "&recordingActTypeId=" + getElement("cboRecordingActType").value;
    }
    invokeAjaxComboItemsLoader(url, getElement("cboPrecedentRecording"));
    showPrecedentPropertiesSection();
  }

  function resetPropertyTypeSelectorCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getPropertyTypeSelectorComboCmd";
    url += "&recordingActTypeId=" + getElement("cboRecordingActType").value;
    url += "&transactionId=<%=transaction.Id%>";

    invokeAjaxComboItemsLoader(url, getElement("cboPropertyTypeSelector"));
    showPrecedentRecordingSection();
  }

  function resetPrecedentPropertiesCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getRecordingPropertiesArrayCmd";
    if (getElement("cboPrecedentRecording").value.length != 0) {
      url += "&recordingId=" + getElement("cboPrecedentRecording").value;
    } else {
      url += "&recordingId=0";
    }
    if (getElement("cboRecordingActType").value.length != 0) {
      url += "&recordingActTypeId=" + getElement("cboRecordingActType").value;
    }
    invokeAjaxComboItemsLoader(url, getElement("cboPrecedentProperty"));
  }

  function resetRecordingActTypesCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getRecordingTypesStringArrayCmd";
    url += "&recordingActTypeCategoryId=" + getElement("cboRecordingActTypeCategory").value;

    invokeAjaxComboItemsLoader(url, getElement("cboRecordingActType"));
    resetPropertyTypeSelectorCombo();
  }

  function validateRecordingActSemantics() {
    var ajaxURL = "../ajax/land.registration.system.data.aspx";
    ajaxURL += "?commandName=validateDocumentRecordingActCmd";
    ajaxURL += "&" + getRecordingActQueryString();

    return invokeAjaxValidator(ajaxURL);
  }

  function showPrecedentRecordingSection() {
    if (getElement("cboPropertyTypeSelector").value == "selectProperty") {          // Already registered
      getElement("divPropertyTypeSelector").style.display = "inline";
      getElement("divPrecedentActSection").style.display = "inline";
      getElement("divPrecedentRecordingSection").style.display = "inline";
      getElement("divNewPropertyRecorderOfficeSection").style.display = "none";
      getElement("divTargetPrecedentActSection").style.display = "none";      
    } else if (getElement("cboPropertyTypeSelector").value == "createProperty") {   // New properties
      getElement("divPropertyTypeSelector").style.display = "inline";
      getElement("divPrecedentActSection").style.display = "none";
      getElement("divPrecedentRecordingSection").style.display = "none";
      getElement("divNewPropertyRecorderOfficeSection").style.display = "inline";
      getElement("divTargetPrecedentActSection").style.display = "none";
    } else if (getElement("cboPropertyTypeSelector").value == "searchProperty") {   // Search by property number

    } else if (getElement("cboPropertyTypeSelector").value == "actNotApplyToProperty") {   // Recording act don't apply to properties
      getElement("divPropertyTypeSelector").style.display = "none";
      getElement("divPrecedentActSection").style.display = "none";
      getElement("divPrecedentRecordingSection").style.display = "none";
      getElement("divNewPropertyRecorderOfficeSection").style.display = "none";
      getElement("divTargetPrecedentActSection").style.display = "none";
    } else if (getElement("cboPropertyTypeSelector").value == "actAppliesToOtherRecordingAct") {   // Recording act applies to other recording act
      getElement("divPropertyTypeSelector").style.display = "inline";
      getElement("divPrecedentActSection").style.display = "inline";
      getElement("divPrecedentRecordingSection").style.display = "inline";
      getElement("divNewPropertyRecorderOfficeSection").style.display = "none";
      getElement("divTargetPrecedentActSection").style.display = "inline";
    } else if (getElement("cboPropertyTypeSelector").value == "actAppliesOnlyToSection") {   // Recording act only needs a district 
      getElement("divPropertyTypeSelector").style.display = "inline";
      getElement("divPrecedentActSection").style.display = "none";
      getElement("divPrecedentRecordingSection").style.display = "none";
      getElement("divNewPropertyRecorderOfficeSection").style.display = "inline";
      getElement("divTargetPrecedentActSection").style.display = "none";
    } else {
      getElement("divPropertyTypeSelector").style.display = "inline";
      getElement("divPrecedentActSection").style.display = "none";
      getElement("divPrecedentRecordingSection").style.display = "none";
      getElement("divNewPropertyRecorderOfficeSection").style.display = "none";
      getElement("divTargetPrecedentActSection").style.display = "none";
    }
  }

  function window_onload() {
    <%=base.OnLoadScript%>
    <% if (!IsReadyForEdition()) { %>
    protectRecordingEditor(true);
    <% } %>
    getElement("cmdPrintRecordingCover").disabled = true;
    getElement("cmdPrintFinalSeal").disabled = true;
    <% if (IsReadyForPrintRecordingCover()) { %>
    getElement("cmdPrintRecordingCover").disabled = false;
    <% } %>
    <% if (IsReadyForPrintFinalSeal()) { %>
    getElement("cmdPrintFinalSeal").disabled = false;
    <% } %>
  }

  addEvent(window, 'load', window_onload);
  
</script>
</html>
