<%@ Page Language="C#" EnableViewState="true" AutoEventWireup="true" Inherits="Empiria.Web.UI.LRS.RecordingBookAnalyzer" CodeFile="recording.book.analyzer.aspx.cs" %>
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
  <script type="text/javascript" src="../scripts/empiria.calendar.js"></script>	
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
            <td id="divImageViewer" valign='top' style="position:relative;<%=!base.DisplayImages() ? "display:none;" : String.Empty%>">
              <div id="divImageContainer" style="overflow:auto;width:520px;height:540px;top:0px;">
                <img id="imgCurrent" name="imgCurrent" src="<%=GetCurrentImagePath()%>" alt="" width="<%=GetCurrentImageWidth()%>" height="<%=GetCurrentImageHeight()%>" style="top:0px;" />
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
                  <td nowrap='nowrap'>
                    <% if (User.CanExecute("BatchCapture.Supervisor")) { %>
                    <select id="cboImageOperation" name="cboImageOperation" class="selectBox" style="width:100px" title="" runat="server">
                      <option value="selectRecordingActOperation">(Operación)</option>
                      <option value="insertEmptyImageBefore">Insertar</option>
                      <option value="deleteImage">Eliminar</option>
                      <option value="refreshImages">Reprocesar</option>
                    </select>
                    <img src='../themes/default/buttons/ellipsis.gif' onclick='doOperation(getElement("cboImageOperation").value);' title='Ejecuta la operación seleccionada' alt='' />
                    <% } %>
                  </td>
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
            <td id="divDocumentViewer" valign="top" style="width:670px;">
              <table class="tabStrip">
                <tr>
                  <td id="tabStripItem_0" class="tabOn" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);"  onclick="doCommand('onClickTabStripCmd', this);" title="">Analizar inscripciones</td>
                  <td id="tabStripItem_1" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="doCommand('onClickTabStripCmd', this);" title="">Editor de información</td>																
                  <td id="tabStripItem_2" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="doCommand('onClickTabStripCmd', this);" title="">Inscripciones registradas</td>									
                  <td class="lastCell"><a id="top" /></td>
                </tr>
              </table>

            <table id="tabStripItemView_0" class="editionTable" style="display:inline;">
              <tr>
                <td class="subTitle">Identificación, prelación y derechos de inscripción</td>
              </tr>
              <tr>
                <td>
                  <table id='tblRecording' class="editionTable">
                  <tr>
                    <td colspan="4">Libro:
                      <input type="text" class="textBox" readonly="readonly" style="width:368px"  title="" value="<%=recordingBook.FullName%>" />
                      &nbsp;Tipo de inscripción:
                    </td>
                    <td>
                      <select id="cboRecordingType" name="cboRecordingType" class="selectBox" style="width:136px" title="" onchange="return updateUserInterface(this);" runat="server">
                        <option value="">( Seleccionar )</option>
                        <option value="2410" title="oNotaryRecording">Escritura pública</option>
                        <option value="2411" title="oTitleRecording">Título de propiedad</option>
                        <option value="2412" title="oJudicialRecording">Orden/Resolución</option>
                        <option value="2413" title="oPrivateRecording">Contrato</option>
                        <option value="2409" title="">No determinado</option>
                      </select>
                    </td>
                    <td class="lastCell">&nbsp;</td>
                  </tr>
                  <tr>
                    <td>Número de inscripción:</td>
                    <td>
                      <input id="txtRecordingNumber" type="text" class="textBox" style="width:35px;margin-right:0px" onkeypress="return integerKeyFilter(this);" title="" maxlength="5" runat="server" />
                      <select id="cboBisRecordingNumber" class="selectBox" style="width:52px" title="" runat='server'>
                        <option value=""></option>
                        <option value="-Bis">-Bis</option>
                        <option value="-01">-01</option>
                        <option value="-02">-02</option>
                        <option value="-03">-03</option>
                        <option value="-04">-04</option>
                        <option value="-05">-05</option>
                        <option value="-06">-06</option>
                      </select>
                      &nbsp; &nbsp; &nbsp;Inscrita de la imagen:
                    </td>
                    <td>
                      <input id="txtImageStartIndex" type="text" class="textBox" style="width:40px"
                             onkeypress="return integerKeyFilter(this);" title="" maxlength="4"  runat="server" /><img src="../themes/default/buttons/select_page.gif" 
                             onclick="pickCurrentImage('txtImageStartIndex')" title="Selecciona el número de imagen que se está desplegando" alt="" />
                    </td>
                    <td>a la imagen:</td>
                    <td>
                      <input id="txtImageEndIndex" type="text" class="textBox" style="width:40px" 
                             onkeypress="return integerKeyFilter(this);" title="" maxlength="4"  runat="server" /><img src="../themes/default/buttons/select_page.gif" 
                      onclick="pickCurrentImage('txtImageEndIndex')" title="Selecciona el número de imagen que se está desplegando" alt="" />											
                    </td>
                    <td class="lastCell">&nbsp;</td>
                  </tr>            
                  <tr>
                    <td>Fecha de presentación:</td>
                    <td>
                      <input id='txtPresentationDate' name='txtPresentationDate' type="text" class="textBox" style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
                      <img id='imgPresentationDate' src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('txtPresentationDate'), getElement('imgPresentationDate'));" title="Despliega el calendario" alt="" />
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Hora de presentación:</td>
                    <td><input id="txtPresentationTime" name="txtPresentationTime" type="text" class="textBox" style="width:40px;margin-right:2px" maxlength="5" title="" onkeypress='return hourKeyFilter(this);' runat="server" />Hrs&nbsp;</td>
                    <td>F. Autorización:</td>
                    <td>
                      <input id='txtAuthorizationDate' name='txtAuthorizationDate' type="text" class="textBox" style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
                      <img id='imgAuthorizationDate' src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('txtAuthorizationDate'), getElement('imgAuthorizationDate'));" title="Despliega el calendario" alt="" />
                    </td>
                    <td class="lastCell">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="lastCell" colspan="6">
<table id="oRecordingPaymentTable" class="editionTable" style="display:inline;">
  <tr>
    <td>Total pago derechos: &nbsp;&nbsp;$</td>
    <td>
    <input id="txtRecordingPayment" name="txtRecordingPayment" type="text" class="textBox" style="width:66px" 
             onkeypress="return positiveKeyFilter(this);" title="" maxlength="9" runat="server" />
    Boletas de pago:
    </td>
    <td>
    <input id="txtRecordingPaymentReceipt" name="txtRecordingPaymentReceipt" type="text" class="textBox" style="width:162px" 
           title="" maxlength="48" runat="server" />
    </td>
    <td class="lastCell">&nbsp;</td>
  </tr>
</table>
                    </td>
                  </tr>
                  <tr>
                    <td>El C. Registrador: &nbsp; &nbsp;&nbsp;Lic.</td>
                    <td colspan="2">
                      <select id="cboAuthorizedBy" name="cboAuthorizedBy" class="selectBox" style="width:304px" title="" onchange="return updateUserInterface();" runat="server">
                      </select>
                    </td>
                    <td>Estado:</td>
                    <td>
                      <select id="cboStatus" name="cboStatus" class="selectBox" style="width:134px" title="" runat="server">
                      </select>
                    </td>
                    <td class="lastCell">&nbsp;</td>
                  </tr>
                  <tr id="rowNoVigentOrIlegibleButtons" style="display:none">
                    <td>&nbsp;</td>
                    <td colspan="2">
                      <input type="button" value="Analizar más tarde" class="button" style="width:110px" onclick='doOperation("registerAsPendingRecording")' title='Guarda la inscripción y la marca como pendiente para su análisis posterior' />
                      <img src="../themes/default/textures/pixel.gif" height="1px" width="42px" alt="" />
                      <input type="button" value="Registrar como no legible" class="button" style="width:144px" onclick='doOperation("registerAsNoLegibleRecording")' title='Guarda la inscripción y la marca como no legible' />									
                    </td>
                    <td colspan="2" align="right">
                      <input type="button" value="Registrar como no vigente" class="button" style="width:142px" onclick='doOperation("registerAsObsoleteRecording")' title='Guarda la inscripción y la marca como no vigente' />
                      &nbsp;
                    </td>
                    <td class="lastCell">&nbsp;</td>
                  </tr>
                </table>
              </td>
              </tr>
              <tr><td class="subTitle">Información general de la inscripción</td></tr>
              <tr>
                <td>
                  <span id="spanRecordingDocumentEditor" runat="server"></span>
                  <table class="editionTable">
                    <tr>
                      <td>Observaciones:<br /><br /></td>
                      <td colspan="2" class="lastCell">
                        <textarea id="txtObservations" name="txtObservations" class="textArea" style="width:558px" cols="320" rows="2" runat="server"></textarea>
                      </td>
                    </tr>
                    <tr id="rowEditButtons" style="display:none">
                      <td>&nbsp;</td>
                      <td colspan="2" class="lastCell">
                        <input id='btnEditRecording' type="button" value="Editar esta inscripción" class="button" style="width:130px" onclick='doOperation("onclick_editRecordingForEdition");' title='Guarda la inscripción y la marca como no legible' />
                        <img src="../themes/default/textures/pixel.gif" height="1px" width="216px" alt="" />
                        <input id='btnDeleteRecording' type="button" value="Eliminar" class="button" disabled='disabled' style="width:70px" onclick='doOperation("deleteRecording")' title='Elimina completamente esta inscripción y todos los actos y propiedades que contiene' />											
                        <img src="../themes/default/textures/pixel.gif" height="1px" width="16px" alt="" />
                        <input id='btnSaveRecording' type="button" value="Guardar los cambios" class="button" disabled='disabled' style="width:112px" onclick='doOperation("saveRecording")' title='Guarda la inscripción y la marca como no vigente' />
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr><td class="subTitle">Actos jurídicos vigentes contenidos en la inscripción</td></tr>
              <tr>
                <td>
                  <table class="editionTable">
                    <tr>
                      <td colspan="8" class="lastCell">
                        <div style="overflow:auto;width:660px;">
                          <table class="details" style="width:99%">
                            <tr class="detailsHeader">
                              <td>#</td>
                              <td width="90%">Actos jurídicos vigentes</td>
                              <td>Estado acto</td>
                              <td>Predio</td>
                              <td>Estado predio</td>
                              <td>¿Qué desea hacer?</td>
                            </tr>
                            <%=gRecordingActs%>
                          </table>
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <td>Categoría:</td>
                      <td colspan="6">
                        <select id="cboRecordingActTypeCategory" name="cboRecordingActTypeCategory" class="selectBox" style="width:272px" title="" onchange="return updateUserInterface(this);" runat='server'>
                        </select>
                        Sobre el predio:&nbsp;
                        <select id="cboProperty" class="selectBox" style="width:160px" title="" onchange="return updateUserInterface(this);" runat='server'>
                          <option value="0">"Agregar un nuevo predio</option>
                          <option value="-1">Seleccionar un predio</option>
                        </select>
                      </td>
                      <td class="lastCell">&nbsp;</td>
                    </tr>
                    <tr id="divRegisteredPropertiesSection" style="display:none">
                      <td>Libro:<br /><br />&nbsp;</td>
                      <td colspan="6">
                        <select id="cboAnotherRecorderOffice" class="selectBox" style="width:160px" title="" onchange="return updateUserInterface(this);" runat='server'>
                        </select>
                        <select id="cboAnotherRecordingBook" class="selectBox" style="width:356px" title="" onchange="return updateUserInterface(this);" runat='server'>
                        </select>
                        <br />
                        Inscripción:
                        <select id="cboAnotherRecording" class="selectBox" style="width:78px" title="" onchange="return updateUserInterface(this);" runat='server'>
                        </select>
                        <img src="../themes/default/buttons/search.gif" alt="" title="Ejecuta la búsqueda" style="margin-left:-8px" onclick="doOperation('showAnotherRecording')" />
                        &nbsp;&nbsp;&nbsp;Predio ya inscrito:&nbsp;
                        <select id="cboAnotherProperty" class="selectBox" style="width:150px" title="" runat='server'>
                        </select>
                      </td>
                      <td class="lastCell">&nbsp;</td>
                    </tr>
                    <tr>
                      <td>Acto jurídico:</td>
                      <td colspan="5">
                        <select id="cboRecordingActType" name="cboRecordingActType" class="selectBox" style="width:420px" title="" onchange="return updateUserInterface();">
                          <option value="">( Primero seleccionar la categoría de la inscripción )</option>
                        </select>
                      </td>
                      <td>
                        <input type="button" value="Agregar un acto" class="button" style="width:88px" onclick='doOperation("registerAsIncompleteRecording")' />
                      </td>
                      <td class="lastCell">&nbsp;</td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td class="subTitle">Anotaciones, gravámenes y otras limitaciones</td>
              </tr>
              <tr>
                <td>
                  <table class="editionTable">
                    <tr>
                     <td class="lastCell" colspan="7">
                      <div style="overflow:auto;width:660px;">
                        <table class="details" style="width:99%">
                          <tr class="detailsHeader">
                            <td>#</td>
                            <td>Predio</td>
                            <td width="30%">Anotación o limitación</td>
                            <td width="30%">Libro registral / Inscripción </td>
                            <td>Presentación/Autoriz</td>
                            <td>Estado</td>
                            <td>&nbsp;</td>
                          </tr>
                          <%=gAnnotationActs%>
                          <tr class="selectedItem">
                            <td colspan="8"><a href="javascript:doOperation('showAnnotationsEditor')">Agregar una anotación, un gravamen o limitación</a></td>
                          </tr>
                        </table>
                      </div>
                    </td>
                    </tr>	
                    <tr id="divAnnotationEditorRow0" style="display:none">
                      <td>Categoría:</td>
                      <td colspan="5">
                        <select id="cboAnnotationCategory" name="cboAnnotationCategory" class="selectBox" style="width:160px" title="" onchange="return updateUserInterface(this);" runat="server">
                        </select>
                      Predio:
                        <select id="cboAnnotationProperty" name="cboAnnotationProperty" class="selectBox" style="width:116px" title="" onchange="return updateUserInterface(this);" runat='server'>
                          <option value="0">Nuevo folio</option>
                        </select>
                      Documento:
                      <select id="cboAnnotationDocumentType" name="cboAnnotationDocumentType" class="selectBox" style="width:136px" title="" onchange="return updateUserInterface(this);" runat="server">
                        <option value="">( Seleccionar )</option>
                        <option value="2410" title="oNotaryRecording">Escritura pública</option>
                        <option value="2411" title="oTitleRecording">Título de propiedad</option>
                        <option value="2412" title="oJudicialRecording">Orden de Juez</option>
                        <option value="2413" title="oPrivateRecording">Contrato privado</option>
                        <option value="2409" title="">No determinado</option>
                      </select>
                      </td>
                      <td class="lastCell">&nbsp;</td>
                    </tr>
                    <tr id="divAnnotationEditorRow1" style="display:none">
                      <td>Tipo de movimiento:</td>
                      <td colspan="5">
                        <select id="cboAnnotation" name="cboAnnotation" class="selectBox" style="width:532px" title="" onchange="return updateUserInterface();">
                          <option value="">( Primero seleccionar la categoría de la anotación )</option>							
                        </select>
                      </td>
                      <td class="lastCell">&nbsp;</td>
                    </tr>
                    <tr id="divAnnotationEditorRow2" style="display:none">
                      <td>Libro de referencia:</td>
                      <td colspan="5">
                        <select id="cboAnnotationBook" name="cboAnnotationBook" class="selectBox" style="width:532px" title="" onchange="return updateUserInterface(this);" >
                          <option value="">( Seleccionar el libro de registro donde se encuentra )</option>
                        </select>
                      </td>
                      <td class="lastCell">&nbsp;</td>
                    </tr>
                    <tr id="divAnnotationEditorRow3" style="display:none">
                      <td>Número de inscripción:</td>
                      <td>
                        <input id="txtAnnotationNumber" name="txtAnnotationNumber" onkeypress="return integerKeyFilter(this);" type="text" class="textBox" style="width:35px;margin-right:0px" title="" maxlength="8" runat="server" />
                        <select id="cboBisAnnotationNumber" class="selectBox" style="width:52px" title="" runat='server'>
                          <option value=""></option>
                          <option value="-Bis">-Bis</option>
                          <option value="-01">-01</option>
                          <option value="-02">-02</option>
                          <option value="-03">-03</option>
                          <option value="-04">-04</option>
                          <option value="-05">-05</option>
                        </select>
                        &nbsp; &nbsp;
                        De la imagen:  
                      </td>
                      <td><input id="txtAnnotationImageStartIndex" name="txtAnnotationImageStartIndex" type="text" class="textBox" style="width:40px" onkeypress="return integerKeyFilter(this);" title="" maxlength="4" runat="server" /></td>
                      <td>a la imagen:</td>
                      <td>
                        <input id="txtAnnotationImageEndIndex" name="txtAnnotationImageEndIndex" type="text" class="textBox" style="width:40px" title="" onkeypress="return integerKeyFilter(this);" maxlength="4" runat="server" />&nbsp;
                        <img src="../themes/default/buttons/search.gif" alt="" title="Ejecuta la búsqueda" style="margin-left:-8px" onclick="doOperation('showAdditionalImage')" />
                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        <input type="button" value="No legible" class="button" style="width:64px" onclick='doOperation("appendNoLegibleAnnotation")' title="Anexa una anotación o limitación como no legible para ser registrada posteriormente" />
                      </td>
                      <td>&nbsp;</td>
                      <td class="lastCell">&nbsp;</td>
                    </tr>
                    <tr id="divAnnotationEditorRow4" style="display:none">
                      <td>Fecha de presentación:</td>
                      <td>
                        <input type="text" class="textBox" id='txtAnnotationPresentationDate' name='txtAnnotationPresentationDate' style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
                        <img id='imgAnnotationPresentationDate' src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('txtAnnotationPresentationDate'), getElement('imgAnnotationPresentationDate'));" title="Despliega el calendario" alt="" style="margin-left:-4px" />
                        &nbsp; Hora:
                      </td>
                      <td><input id="txtAnnotationPresentationTime" name="txtAnnotationPresentationTime" type="text" class="textBox" style="width:40px" maxlength="5" title="" onkeypress='return hourKeyFilter(this);' runat="server" /></td>
                      <td>Autorización:</td>
                      <td>
                        <input id='txtAnnotationAuthorizationDate' name='txtAnnotationAuthorizationDate' type="text" class="textBox" style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
                        <img id='imgAnnotationAuthorizationDate' src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('txtAnnotationAuthorizationDate'), getElement('imgAnnotationAuthorizationDate'));" title="Despliega el calendario" alt=""  style="margin-left:-4px" />
                        &nbsp; &nbsp; &nbsp;
                        <input type="button" value="Heredar" class="button" style="width:64px" onclick='doOperation("inheritAnnotationData")' title="Hereda la información de la inscripción del predio a esta anotación o limitación" />
                      </td>
                      <td colspan="2" class="lastCell">&nbsp;</td>
                    </tr>
                    <tr id="divAnnotationEditorRow4bis" style="display:none">
                      <td class="lastCell" colspan="7">
<table id="oAnnotationPaymentTable" class="editionTable" style="display:inline;">
  <tr>
    <td>Total pago derechos: &nbsp;&nbsp;$</td>
    <td>
    <input id="txtAnnotationPayment" name="txtAnnotationPayment" type="text" class="textBox" style="width:66px" 
             onkeypress="return positiveKeyFilter(this);" title="" maxlength="9" runat="server" />
    Boletas de pago:
    </td>
    <td colspan="3">
    <input id="txtAnnotationPaymentReceipt" name="txtAnnotationPaymentReceipt" type="text" class="textBox" style="width:162px" 
           title="" maxlength="48" runat="server" />
    </td>
    <td class="lastCell">&nbsp;</td>
  </tr>
</table>
                      </td>
                    </tr>
                    <tr id="divAnnotationEditorRow5" style="display:none">
                      <td>El C. Registrador: &nbsp; Lic.</td>
                      <td colspan="4">
                        <select id="cboAnnotationAuthorizedBy" name="cboAnnotationAuthorizedBy" class="selectBox" style="width:374px" title="">
                          <option value="">( Seleccionar al C. Oficial Registrador )</option>
                        </select>
                        &nbsp; &nbsp;
                        <input type="button" value="Agregar anotación" class="button" style="width:110px" onclick='doOperation("appendAnnotation")' title="Anexa la anotación o limitación a la inscripción actual" />
                      </td>
                      <td>&nbsp;</td>
                      <td class="lastCell">&nbsp;</td>
                    </tr>              
                  </table>
                  <table id="divAnnotationEditorRow6" class="editionTable" style="display:none">
                    <tr><td class="subTitle" colspan="7">Información general de la anotación</td></tr>
                    <tr><td colspan="7"><span id="spanAnnotationDocumentEditor" runat="server"></span></td></tr>
                    <tr>
                      <td>Observaciones:<br /><br /></td>
                      <td colspan="5">
                        <textarea id="txtAnnotationObservations" name="txtAnnotationObservations" class="textArea" style="width:560px" cols="120" rows="2" runat="server"></textarea>
                      </td>
                      <td class="lastCell">&nbsp;</td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td class="separator">
                &nbsp;
                </td>
              </tr>
              <tr>
                <td>
                  <table>
                    <tr>
                      <td nowrap='nowrap'>Ir a la inscripción: &nbsp;<input id="txtGoToRecording" name="txtGoToRecording" type="text" class="textBox" maxlength="5" style="width:35px;margin-right:0px" onkeypress="return integerKeyFilter(this);" runat="server" /></td>
                      <td nowrap='nowrap'><img src="../themes/default/buttons/search.gif" alt="" onclick="return doOperation('gotoRecording')" title="Ejecuta la búsqueda" /></td>
                      <td width='88px' nowrap='nowrap'>&nbsp;</td>
                      <td><img src='../themes/default/buttons/first.gif' onclick='doOperation("moveToRecording", "First");' title='Muestra la primera inscripción' alt='' /></td>
                      <td><img src='../themes/default/buttons/previous.gif' onclick='doOperation("moveToRecording", "Previous");' title='Muestra la inscripción anterior' alt='' /></td>
                      <td><img src='../themes/default/buttons/next.gif' onclick='doOperation("moveToRecording", "Next");' title='Muestra la siguiente inscripción' alt='' /></td>
                      <td><img src='../themes/default/buttons/last.gif' onclick='doOperation("moveToRecording", "Last");' title='Muestra la última inscripción' alt='' /></td>
                      <td width='48px' nowrap='nowrap'>&nbsp;</td>
                      <td nowrap='nowrap'>
                      <input type="button" value="Actualizar" class="button" style="width:68px" onclick='doOperation("refresh")' />
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      <input type="button" value="Nueva inscripción" class="button" style="width:108px" onclick='doOperation("newRecording")' /></td>												
                    </tr>
                  </table>
                </td>
              </tr>
            </table>  <!-- tabStripItemView_0 !-->

            <table id="tabStripItemView_1" class="editionTable" style="display:none;">
              <tr>
                <td class="lastCell">
                  <iframe id="ifraItemEditor" style="z-index:99;left:0px;top:0px;" 
                          marginheight="0" marginwidth="0" frameborder="0" scrolling="no"
                          src="" width="670px" visible="false" >
                  </iframe>
                </td>
              </tr>
            </table> <!-- tabStripItemView_1 !-->
            
     
            <table id="tabStripItemView_2" class="editionTable" style="display:none;">
              <tr>
                <td class="subTitle">Buscar en este libro</td>
              </tr>
              <tr>
                <td>
                  <table class="editionTable">
                    <tr>
                      <td>Buscar en:</td>
                      <td>
                        <select id="Select4" name="cboZone" class="selectBox" style="width:164px" runat='server' title="">
                          <option value="">( Todos los campos )</option>
                          <option value="">Número de inscripción</option>
                          <option value="">Involucrados</option>
                          <option value="">Folio electrónico</option>
                          <option value="">Clave catastral</option>
                          <option value="">Domicilio del predio</option>
                          <option value="">Recibo de pago</option>
                          <option value="">Acto jurídico</option>
                          <option value="">Fedatario</option>
                        </select>
                      </td>
                      <td>
                        <input type="text" class="textBox" id='Text23' name='txtExternalNumber' style="width:230px" maxlength="32" runat='server' title="" />
                        <img src="../themes/default/buttons/search.gif" alt="" onclick="return doOperation('loadData')" title="Ejecuta la búsqueda" style="margin-left:-4px" />												
                      </td>
                      <td class="lastCell">&nbsp;</td>
                    </tr>
                    <tr>
                      <td>Presentación:</td>
                      <td colspan="2">
                        <input type="text" class="textBox" id='txtSearchPresentationFromDate' name='txtSearchPresentationFromDate' style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
                        <img id='img2' src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('txtSearchPresentationFromDate'), getElement('imgFromDate'));" title="Despliega el calendario" alt="" />
                        Al día:
                        <input type="text" class="textBox" id='txtSearchPresentationToDate' name='txtSearchPresentationToDate' style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
                        <img id='img3' src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('txtSearchPresentationToDate'), getElement('imgFromDate'));" title="Despliega el calendario" alt="" />													
                      </td>
                      <td class="lastCell">&nbsp;</td>
                    </tr>
                    <tr>
                      <td>Autorización:</td>
                      <td colspan="2">
                        <input type="text" class="textBox" id='txtSearchAuthorizationFromDate' name='txtSearchAuthorizationFromDate' style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
                        <img id='img4' src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('txtSearchAuthorizationFromDate'), getElement('imgFromDate'));" title="Despliega el calendario" alt="" />
                        Al día:
                        <input type="text" class="textBox" id='txtSearchAuthorizationToDate' name='txtFromDate' style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
                      </td>
                      <td class="lastCell">&nbsp;</td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td class="subTitle">Índice de inscripciones</td>
              </tr>
              <tr>
                <td>
                  <table class="editionTable">
                    <tr>
                      <td>
                        <%=GetRecordingsViewerGrid()%>
                      </td>
                      <td class="lastCell">&nbsp;</td>
                    </tr>
                    <tr>
                      <td>
                        <span class="leftItem"><%=recordingBook.Recordings.Count%> inscripciones registradas.</span>
                        <span class="rightItem">Página
                        <select class="selectBox" id="cboRecordingViewerPage" name="cboRecordingViewerPage" 
                                style="width:45px" runat="server" onchange="doOperation('refreshRecordingViewer')" >
                        </select>de <%=RecordingViewerPages()%>&nbsp;</span>
                      </td>
                      <td class="lastCell">&nbsp;</td>
                     </tr>
                  </table>
                </td>
              </tr>
            </table> <!-- tabStripItemView_2 !-->
              
            <table id="tabStripItemView_3" class="editionTable" style="display:none;">
              <tr><td class="subTitle">Información pendiente en este libro</td></tr>
              <tr><td>Aquí va el visualizador</td></tr>
            </table> <!-- tabStripItemView_3 !-->
            
            </td>
          </tr>
        </table>
      </div> <!--divContent!-->		
    </div> <!-- end divBody !-->  
  </div> <!-- end divCanvas !-->
</form>
<iframe id="ifraCalendar" style="z-index:99;left:0px;visibility:hidden;position:relative;top:0px" 
    marginheight="0"  marginwidth="0" frameborder="0" scrolling="no"
    src="../user.controls/calendar.aspx" width="100%">
</iframe>
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
      case 'registerAsNoLegibleRecording':
        success = registerAsNoLegibleRecording();
        break;
      case 'registerAsObsoleteRecording':
        success = registerAsObsoleteRecording();
        break;
      case 'registerAsPendingRecording':
        success = registerAsPendingRecording();
        break;
      case 'registerAsIncompleteRecording':
        success = registerAsIncompleteRecording();
        <% if (!recording.IsNew) { %>
          command = 'appendRecordingAct';
        <% } %>
        break;
      case 'appendAnnotation':
        success = appendAnnotation();
        break;
      case 'appendNoLegibleAnnotation':
        success = appendNoLegibleAnnotation();
        break;
      case 'deleteAnnotation':
        success = deleteAnnotation(arguments[1], arguments[2]);
        break;
      case 'showAnnotationsEditor':
        showAnnotationsEditor();
        return;
      case 'newRecording':
        success = true;
        break;
      case 'addPropertyToRecordingAct':
        addPropertyToRecordingAct(arguments[1], arguments[2]);
        return;
      case 'modifyRecordingActType':
        modifyRecordingActType(arguments[1], arguments[2]);
        return;
      case 'editRecordingAct':
        editRecordingAct(arguments[1]);
        return;
      case 'editAnnotation':
        editAnnotation(arguments[1], arguments[2]);
        return;
      case 'editProperty':
        editProperty(arguments[1], arguments[2]);
        return;
      case 'deleteRecordingAct':
        deleteRecordingAct(arguments[1], arguments[2]);
        return;
      case 'deleteRecordingActProperty':
        deleteRecordingActProperty(arguments[1], arguments[2]);
        return;
      case 'inheritAnnotationData':
        inheritAnnotationData();
        return;
      case "upwardRecordingAct":
        upwardRecordingAct(arguments[1], arguments[2]);
        return;
      case "downwardRecordingAct":
        downwardRecordingAct(arguments[1], arguments[2]);
        return;
      case 'selectRecordingActOperation':
        alert("Requiero se seleccione una operación de la lista.");
        return;
      case 'gotoImage':
        gotoImage();
        return;
      case 'moveToImage':
        moveToImage(arguments[1]);
        return;
      case 'zoomImage':
        return doZoom();
      case 'insertEmptyImageBefore':
        if (!getElement('cboImageOperation').disabled) {
          insertEmptyImageBefore();
        }
        return;
      case 'deleteImage':
        if (!getElement('cboImageOperation').disabled) {
          deleteImage();
        }
        return;
      case 'refresh':
        sendPageCommand(command);
        return;
      case 'refreshImages':
        if (!getElement('cboImageOperation').disabled) {
          refreshImages();
        }
        return;		
      case 'gotoRecording':
        gotoRecording();
        return;
      case 'moveToRecording':
        sendPageCommand(command, "goto=" + arguments[1]);
        return;
      case 'showAnotherRecording':
        showAnotherRecording();
        return;
      case "showAdditionalImage":
        showAdditionalImage();
        break;
      case "onclick_editRecordingForEdition":
        onclick_editRecordingForEdition();
        return;
      case 'saveRecording':
        success = saveRecording();
        break;
      case 'deleteRecording':
        deleteRecording();
        break;
      case 'refreshRecordingViewer':
        refreshRecordingViewer();
        return;
      case 'refreshRecording':
        window.location.reload(false);
        return;
      case 'gotoRecordingBook':
        gotoRecordingBook();
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

  function showAnotherRecording() {
    if (getElement('cboAnotherRecordingBook').value.length == 0) {
      alert("Requiero se seleccione el libro registral que se desea consultar.");
      return;
    }
    var source = "recording.book.analyzer.aspx?";
    source += "bookId=" + getElement('cboAnotherRecordingBook').value;

    if (getElement('cboAnotherRecording').value.length != 0) {
      source += "&id=" + getElement('cboAnotherRecording').value;
    }
    createNewWindow(source);
  }


  function gotoRecordingBook(recordingBookId, recordingId) {
    var source = "recording.book.analyzer.aspx?";
    source += "bookId=" + recordingBookId;
    source += "&id=" + recordingId;
    createNewWindow(source);
  }

  function inheritAnnotationData() {
    var sMsg = "Heredar los datos de la inscripción principal.\n\n";

    sMsg += "Esta operación copiará la información de la inscripción principal hacia esta nueva anotación,";
    sMsg += "con excepción del número de inscripción, del rango de imágenes y de las observaciones.\n\n";

    sMsg += "¿Heredo los datos de la inscripción principal hacia esta anotación o limitación?";

    if (!confirm(sMsg)) {
      return false;
    }
    var data = getRecordingRawData();

    var dataArray = data.split('|');
    
    getElement('txtAnnotationPresentationDate').value = dataArray[0];
    getElement('txtAnnotationPresentationTime').value = dataArray[1];
    getElement('txtAnnotationAuthorizationDate').value = dataArray[2];


    getElement('txtAnnotationPayment').value = dataArray[3];
    getElement('txtAnnotationPaymentReceipt').value = dataArray[5];

    getElement('cboAnnotationAuthorizedBy').value = dataArray[7];
    getElement('cboAnnotationDocumentType').value = dataArray[8];
    <%=oAnnotationDocumentEditor.ClientID%>_inheritAnnotationData(<%=recording.Id%>);

    return true;
  }

  function getRecordingRawData() {
    var ajaxURL = "../ajax/land.registration.system.data.aspx";
    ajaxURL += "?commandName=getRecordingRawData";
    ajaxURL += "&recordingId=<%=recording.Id%>";

    return invokeAjaxMethod(false, ajaxURL, null);
  }

  function registerAsObsoleteRecording() {
    <% if (recording.RecordingActs.Count > 0) { %>
      alert("Esta inscripción contiene actos jurídicos, razón por la cual no puede cambiarse al estado de no vigente.");
      return false;
    <% } %>
    if (!validateRecordingStep1()) {
      return false;
    }
    if (!validateRecordingSemantics()) {
      return false;
    }
    var sMsg = "Registrar la inscripción como NO VIGENTE\n\n";
    
    sMsg += "Esta operación guardará la inscripción como NO VIGENTE,\n";
    sMsg += "con la siguiente información:\n\n";

    sMsg += getRecordingDataForm();
    
    sMsg += "¿Registro la inscripción como NO VIGENTE?";
    
    return confirm(sMsg);	
  }
  
  function registerAsNoLegibleRecording() {
    if (!validateRecordingStep1()) {
      return false;
    }
    if (!validateRecordingSemantics()) {
      return false;
    }
    var sMsg = "Registrar la inscripción como no legible\n\n";
    
    sMsg += "Esta operación guardará la inscripción como no legible, para\n";
    sMsg += "que posteriormente se busque en legajos u otros documentos la\n";
    sMsg += "información correcta:\n\n";

    sMsg += getRecordingDataForm();
    
    sMsg += "¿Registro la inscripción como no legible?";
    
    return confirm(sMsg);
  }
  
  function registerAsPendingRecording() {
    if (!validateRecordingStep1()) {
      return false;
    }
    if (!validateRecordingStep2()) {
      return false;
    }
    if (getElement("txtObservations").value == '') {
      alert("Requiero un texto descriptivo que indique el motivo por el que se dejará pendiente esta inscripción.");
      return false;
    }
    if (!validateRecordingSemantics()) {
      return false;
    }
    var sMsg = "Registrar la inscripción como pendiente.\n\n";
    
    sMsg += "Esta operación guardará la inscripción como pendiente, para\n";
    sMsg += "que en un futuro se agregue la información faltante:\n\n";

    sMsg += getRecordingDataForm();
    
    sMsg += "¿Registro esta inscripción como pendiente, para su análisis posterior?";
    
    return confirm(sMsg);
  }
  
  function registerAsIncompleteRecording() {
    var onlyChangeRecording = (arguments.length == 1);
    if (!validateRecordingStep1()) {
      return false;
    }
    if (!validateRecordingStep2()) {
      return false;
    }
    if (!onlyChangeRecording) {
      if (!validateRecordingAct()) {
        return false;
      }
    }
    if (!validateRecordingSemantics()) {
      return false;
    }
    if (onlyChangeRecording) {
      return confirm("¿Guardo los cambios efectuados en esta inscripción?");	  
    }
    <% if (recording.IsNew) { %>
      var sMsg = "Registrar la inscripción como vigente\n\n";
      
      sMsg += "Esta operación guardará la inscripción como vigente, con la\n";
      sMsg += "siguiente información:\n\n";

      sMsg += getRecordingDataForm();
      
      sMsg += "Acto jurídico:\t" + getComboOptionText(getElement('cboRecordingActType')) + "\n";
      sMsg += "Predio:\t\t" + getComboOptionText(getElement('cboProperty')) + "\n";
      if (getElement('cboProperty').value == "-1") {
        sMsg += "Folio:\t\t" + getComboOptionText(getElement('cboAnotherProperty')) + "\n\n";
      } else {
        sMsg += "\n";
      }
      sMsg += "¿Registro la inscripción " + getElement('txtRecordingNumber').value + 
              getElement('cboBisRecordingNumber').value + " como vigente?";
    <% } else { %>
      var sMsg = "Agregar un acto jurídico vigente\n\n";
      
      sMsg += "Esta operación agregará el siguiente acto jurídico a esta inscripción:\n\n";
          
      sMsg += "Libro:\t\t<%=recordingBook.FullName%>\n";
      sMsg += "Inscripción:\t" + getElement('txtRecordingNumber').value + 
              getElement('cboBisRecordingNumber').value + "\n\n";
      
      sMsg += "Acto jurídico:\t" + getComboOptionText(getElement('cboRecordingActType')) + "\n";
      sMsg += "Predio:\t\t" + getComboOptionText(getElement('cboProperty')) + "\n";	
      if (getElement('cboProperty').value == "-1") {
        sMsg += "Folio:\t\t" + getComboOptionText(getElement('cboAnotherProperty')) + "\n\n";
      } else {
        sMsg += "\n";
      }
      <% if (base.recording.Status == RecordingStatus.Obsolete) { %>
      sMsg += "IMPORTANTE: La inscripción pasará de estado No vigente a Incompleta.\n\n";
      <% } %>
      sMsg += "¿Agrego el acto jurídico a la inscripción " + getElement('txtRecordingNumber').value + 
              getElement('cboBisRecordingNumber').value + "?";			
    <% } %>			
    return confirm(sMsg);
  }

  function insertEmptyImageBefore() {
    var newCurrentImagePosition = getCurrentImage() + 1;
    var newBookImageCount = selectedBookImageCount(null) + 1;
    var sMsg = "Insertar una imagen faltante.\n\n";
    sMsg += "Esta operación insertará una imagen vacía en la posición\n";
    sMsg += "actual, por lo que la imagen que actualmente se está\n";
    sMsg += "visualizando en pantalla se volverá la número " + newCurrentImagePosition + ", y el\n";
    sMsg += "libro ahora contendrá " +  newBookImageCount + " imágenes.\n\n";
    
    sMsg += "¿Inserto una imagen vacía en la posición actual?";
    
    if (confirm(sMsg)) {
      sendPageCommand("insertEmptyImageBefore");
      return;
    }
  }

  function deleteImage() {
    var newBookImageCount = selectedBookImageCount(null) - 1;
    var sMsg = "Eliminar una imagen duplicada o incorrecta.\n\n";
    sMsg += "Esta operación eliminará la imagen que actualmente\n";
    sMsg += "se está visualizando en pantalla, por lo que el libro\n";
    sMsg += "ahora contendrá " +  newBookImageCount + " imágenes.\n\n";
    
    sMsg += "¿Elimino la imagen que actualmente se está visualizando\n";
    sMsg += "y que ocupa la posición " + getCurrentImage() + "?";

    if (confirm(sMsg)) {
      sendPageCommand("deleteImage");
      return;
    }
  }
  
  function refreshImages() {
    var newBookImageCount = selectedBookImageCount(null) - 1;
    var sMsg = "Actualizar las imágenes del libro.\n\n";
    sMsg += "Esta operación actualizará todos los nombres de las imágenes que\n";
    sMsg += "conforman este libro, y recalculará las estadísticas de las mismas.\n\n";
    
    sMsg += "¿Actualizo todos los nombres de las imágenes y las estadísticas?";

    if (confirm(sMsg)) {
      sendPageCommand("refreshImagesStatistics");
      return;
    }	
  }

  function addPropertyToRecordingAct(recordingActId, propertyId) {
    var itemId = "_" + recordingActId + "_" + propertyId;
      
    var sMsg = "Agregar otra propiedad al acto jurídico.\n\n";		
    sMsg += "Esta operación agregará una nueva propiedad al siguiente acto jurídico:\n\n";
    sMsg += getInnerText('ancRecordingAct_' + recordingActId).toUpperCase() + "\n";
    sMsg += "Número de acto:\t" + getInnerText('ancRecordingActIndex' + itemId) + "\n";
    sMsg += "Propiedad base:\t" + getInnerText('ancRecordingActProperty' + itemId) + "\n\n";
    
    sMsg += "¿Agrego una nueva propiedad al acto jurídico seleccionado?";
    
    if (confirm(sMsg)) {
      sendPageCommand("appendPropertyToRecordingAct", "recordingActId=" + recordingActId);
      return;
    }
  }	

  function editProperty(propertyId, recordingActId) {	
    var oEditor = getElement("ifraItemEditor");
    
    oEditor.src = "property.editor.aspx?propertyId=" + propertyId + "&recordingActId=" + recordingActId;
    
    oEditor.visible = true;
    doCommand('onClickTabStripCmd', getElement('tabStripItem_1'));
    getElement("top").scrollIntoView(false);
    return true;
  }

  function editRecordingAct(recordingActId) {
    var oEditor = getElement("ifraItemEditor");
    
    oEditor.src = "recording.act.editor.aspx?id=" + recordingActId;

    oEditor.visible = true;
    doCommand('onClickTabStripCmd', getElement('tabStripItem_1'));
    getElement("top").scrollIntoView(false);
    return true;
  }

  function editAnnotation(recordingId, annotationId) {
    showRecordingImages(recordingId);
    editRecordingAct(annotationId);
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

  function deleteAnnotation(propertyId, recordingActId) {
    <% if (!User.CanExecute("BatchCapture.Supervisor")) { %>
      showNotAllowedMessage();
      return;
    <% } %>
    var itemKey = "_" + propertyId + "_" + recordingActId;
    var sMsg = "Eliminar la anotación o limitación.\n\n";
    sMsg += "Esta operación eliminará la siguiente anotación o limitación asociada\n";
    sMsg += "al predio que se detalla:\n\n";
    sMsg += getInnerText('ancAnnotation' + itemKey).toUpperCase() + "\n";
    sMsg += "Folio del predio:\t\t" + getInnerText('ancAnnotationProperty' + itemKey) + "\n";
    sMsg += "Libro de referencia:\t\t" + getInnerText('ancAnnotationBook' + itemKey) + "\n";
    sMsg += "Número de inscripción:\t" + getInnerText('ancAnnotationNumber' + itemKey) + "\n";
    sMsg += "Fecha de presentación:\t" + getInnerText('ancAnnotationPresentation' + itemKey) + "\n\n";
        
    sMsg += "¿Elimino esta anotación o limitación ligada al predio que se indica?";
    
    if (confirm(sMsg)) {
      sendPageCommand("deleteAnnotation", "recordingActId=" + recordingActId + "|propertyId=" + propertyId);
      return;
    }
  }
  
  function deleteRecording() {	
    <% if (!User.CanExecute("BatchCapture.Supervisor")) { %>
      showNotAllowedMessage();
      return false;
    <% } %> 
    <% if (recording.GetPropertiesAnnotationsList().Count > 0) { %>
      alert("No puedo eliminar esta inscripción debido a que contiene anotaciones.");
      return false;
    <% } %>
    <% if (recording.RecordingActs.Count > 0) { %>
      alert("No puedo eliminar esta inscripción ya que contiene actos jurídicos.");
      return false;
    <% } %>
    
    var sMsg = "Eliminar la inscripción del libro registral.\n\n";		
    sMsg += "Esta operación eliminará la siguiente inscripción contenida en este libro registral:\n\n";				
    sMsg += "Libro:\t\t<%=recordingBook.FullName%>\n";
    sMsg += "Inscripción:\t" + getElement('txtRecordingNumber').value + 
            getElement('cboBisRecordingNumber').value + "\n\n";
    sMsg += "¿Elimino la inscripción " + getElement('txtRecordingNumber').value + 
            getElement('cboBisRecordingNumber').value + " de este libro?";		
    if (confirm(sMsg)) {
      sendPageCommand("deleteRecording", "id=<%=recording.Id%>");
      return;
    }
  }
  
  function deleteRecordingAct(recordingActId, propertyId) {
    <% if (!User.CanExecute("BatchCapture.Supervisor")) { %>
      showNotAllowedMessage();
      return;
    <% } %>
    if (!validateDeleteRecordingAct(recordingActId)) {
      return false;
    }
    var itemId = "_" + recordingActId + "_" + propertyId;
    
    var sMsg = "Eliminar el acto jurídico y la propiedad asociada.\n\n";		
    sMsg += "Esta operación eliminará el siguiente acto jurídico, junto con ";
    sMsg += "la propiedad que está asociada al mismo:\n\n";
    sMsg += getInnerText('ancRecordingAct_' + recordingActId).toUpperCase() + "\n";
    sMsg += "Posición:\t\t" + getInnerText('ancRecordingActIndex' + itemId) + "\n";
    sMsg += "Propiedad:\t" + getInnerText('ancRecordingActProperty' + itemId) + "\n\n";

    <% if (recording.RecordingActs.Count == 1) { %>
    sMsg += "IMPORTANTE: Este es el único acto jurídico registrado en esta\n";
    sMsg += "inscripción. Al eliminarse, también se cambiará el estado de la\n";
    sMsg += "inscripción a pendiente o incompleta.\n\n";
    <% } %>
    sMsg += "¿Elimino este acto jurídico de la lista de actos vigentes,\n";
    sMsg += "así como la propiedad asociada a dicho acto?";
    if (confirm(sMsg)) {
      sendPageCommand("deleteRecordingAct", "recordingActId=" + recordingActId);
      return;
    }
  }	
  
  function deleteRecordingActProperty(recordingActId, propertyId) {
    <% if (!User.CanExecute("BatchCapture.Supervisor")) { %>
      showNotAllowedMessage();
      return;
    <% } %>
    if (!validateDeleteRecordingActProperty(recordingActId, propertyId)) {
      return false;
    }
    var itemId = "_" + recordingActId + "_" + propertyId;
    var sMsg = "Eliminar la propiedad relacionada con el acto jurídico.\n\n";
    
    sMsg += "Esta operación eliminará la siguiente propiedad relacionada con el\n"
    sMsg += "acto jurídico que se indica, pero no eliminará el acto jurídico en sí:\n\n";							
    sMsg += getInnerText('ancRecordingAct_' + recordingActId).toUpperCase() + "\n";
    sMsg += "Número de acto:\t " + getInnerText('ancRecordingActIndex' + itemId) + "\n";
    sMsg += "Propiedad a eliminar: " + getInnerText('ancRecordingActProperty' + itemId) + "\n\n";

    sMsg += "¿Elimino esta propiedad relacionada al acto jurídico que se indica?";		
    
    if (confirm(sMsg)) {
      sendPageCommand("deleteRecordingActProperty", "recordingActId=" + recordingActId + "|propertyId=" + propertyId);
      return;
    }
  }
    
  function modifyRecordingActType(recordingActId, propertyId) {
    <% if (!User.CanExecute("BatchCapture.Supervisor")) { %>
      showNotAllowedMessage();
      return;
    <% } %>
    if (getElement('cboRecordingActType').value == '') {
      alert("Para modificar este acto jurídico, se debe seleccionar de la lista de actos jurídicos el nuevo tipo de acto.");
      return false;
    }
    var itemId = "_" + recordingActId + "_" + propertyId;
            
    var sMsg = "Modificar el tipo del acto jurídico.\n\n";		
    sMsg += "Esta operación modificará el tipo del siguiente acto jurídico:\n\n";
    
    sMsg += "Libro:\t\t<%=recordingBook.FullName%>\n";
    sMsg += "Inscripción:\t" + getElement('txtRecordingNumber').value + 
            getElement('cboBisRecordingNumber').value + "\n\n";		
    sMsg += getInnerText('ancRecordingAct_' + recordingActId).toUpperCase() + "\n";
    sMsg += "Posición:\t\t" + getInnerText('ancRecordingActIndex' + itemId) + "\n"
    sMsg += "Propiedad:\t" + getInnerText('ancRecordingActProperty' + itemId) + "\n\n";
    sMsg += "Nuevo tipo:\t" + getComboOptionText(getElement('cboRecordingActType')) + "\n\n";
    
    sMsg += "¿Modifico el acto jurídico ubicado en la posición " + getInnerText('ancRecordingActIndex' + itemId) + "?";
    if (confirm(sMsg)) {
      sendPageCommand("modifyRecordingActType", "recordingActId=" + recordingActId);
      return;
    }
  }

  function downwardRecordingAct(recordingActId, propertyId) {
    var itemId = "_" + recordingActId + "_" + propertyId;
    
    var sMsg = "Bajar este acto en la secuencia jurídica de la inscripción.\n\n";		
    sMsg += "Esta operación ubicará este acto jurídico por debajo del acto\n";
    sMsg += "jurídico que lo precede dentro de esta inscripción:\n\n";
    sMsg += getInnerText('ancRecordingAct_' + recordingActId).toUpperCase() + "\n";
    sMsg += "Posición actual:\t" + Number(getInnerText('ancRecordingActIndex' + itemId)) + "\n";
    sMsg += "Nueva posición:\t" + Number(Number(getInnerText('ancRecordingActIndex' + itemId)) + 1).toString() + "\n";
    sMsg += "Propiedad base:\t" + getInnerText('ancRecordingActProperty' + itemId) + "\n\n";
    sMsg += "La secuencia jurídica indica qué acto jurídico antecede a otro u\n";
    sMsg += "otros dentro de una misma inscripción y para la misma propiedad.\n\n";		
    sMsg += "¿Bajo este acto jurídico dentro de la inscripción?";
    
    if (confirm(sMsg)) {
      sendPageCommand("downwardRecordingAct", "recordingActId=" + recordingActId);
      return;
    }
  }

  function upwardRecordingAct(recordingActId, propertyId) {
    var itemId = "_" + recordingActId + "_" + propertyId;
    
    var sMsg = "Subir este acto en la secuencia jurídica de la inscripción.\n\n";		
    sMsg += "Esta operación ubicará este acto jurídico por encima del acto\n";
    sMsg += "jurídico que lo antecede dentro de esta inscripción:\n\n";
    sMsg += getInnerText('ancRecordingAct_' + recordingActId).toUpperCase() + "\n";
    sMsg += "Posición actual:\t" + Number(getInnerText('ancRecordingActIndex' + itemId)) + "\n";
    sMsg += "Nueva posición:\t" + Number(Number(getInnerText('ancRecordingActIndex' + itemId)) - 1).toString() + "\n";
    sMsg += "Propiedad base:\t" + getInnerText('ancRecordingActProperty' + itemId) + "\n\n";
    sMsg += "La secuencia jurídica indica qué acto jurídico antecede a otro u\n";
    sMsg += "otros dentro de una misma inscripción y para la misma propiedad.\n\n";		
    sMsg += "¿Subo este acto jurídico dentro de la inscripción?";
    
    if (confirm(sMsg)) {
      sendPageCommand("upwardRecordingAct", "recordingActId=" + recordingActId);
      return;
    }
  }

  function validateAnnotationSemantics() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=validateAnnotationSemanticsCmd";
    url += "&annotationTypeId=" + getElement("cboAnnotation").value;
    url += "&annotationBookId=" + getElement("cboAnnotationBook").value;
    url += "&propertyId=" + getElement("cboAnnotationProperty").value;    
    url += "&number=" + getElement("txtAnnotationNumber").value;
    url += "&bisSuffixNumber=" + getElement("cboBisAnnotationNumber").value;    
    url += "&imageStartIndex=" + getElement("txtAnnotationImageStartIndex").value;
    url += "&imageEndIndex=" + getElement("txtAnnotationImageEndIndex").value;
    url += "&presentationTime=" + getElement("txtAnnotationPresentationDate").value + " " + getElement("txtAnnotationPresentationTime").value;
    url += "&authorizationDate=" + getElement("txtAnnotationAuthorizationDate").value;
    url += "&authorizedById=" + getElement("cboAnnotationAuthorizedBy").value;

    return invokeAjaxValidator(url);
  }

  function validateDeleteRecordingAct(recordingActId) {
    var ajaxURL = "../ajax/land.registration.system.data.aspx";
    ajaxURL += "?commandName=validateDeleteRecordingActCmd";
    ajaxURL += "&recordingId=<%=recording.Id%>";
    ajaxURL += "&recordingActId=" + recordingActId;

    return invokeAjaxValidator(ajaxURL);
  }
    
  function validateDeleteRecordingActProperty(recordingActId, propertyId) {
    var ajaxURL = "../ajax/land.registration.system.data.aspx";
    ajaxURL += "?commandName=validateDeleteRecordingActPropertyCmd";
    ajaxURL += "&recordingId=<%=recording.Id%>";
    ajaxURL += "&recordingActId=" + recordingActId;
    ajaxURL += "&propertyId=" + propertyId;

    return invokeAjaxValidator(ajaxURL);
  }
 
  function validateRecordingSemantics() {
    <% if (!recording.IsNew) { %>
      if (existsElement("btnSaveRecording") && getElement("btnSaveRecording").disabled) {
        return true;
      }
    <% } %>
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=validateRecordingSemanticsCmd";
    url += "&recordingBookId=<%=recordingBook.Id%>";
    url += "&recordingId=<%=recording.Id%>";
    url += "&number=" + getElement("txtRecordingNumber").value;
    url += "&bisSuffixNumber=" + getElement("cboBisRecordingNumber").value;
    url += "&imageStartIndex=" + getElement("txtImageStartIndex").value;
    url += "&imageEndIndex=" + getElement("txtImageEndIndex").value;
    url += "&presentationTime=" + getElement("txtPresentationDate").value + " " + getElement("txtPresentationTime").value;
    url += "&authorizationDate=" + getElement("txtAuthorizationDate").value;
    url += "&authorizedById=" + getElement("cboAuthorizedBy").value;

    return invokeAjaxValidator(url);
  }

  function appendAnnotation() {
    if (!validateAnnotationStep1()) {
      return false;
    }
    if (!validateAnnotationStep2()) {
      return false;
    }
    if (!validateAnnotationSemantics()) {
      return false;
    }
    var currentAnnotationId = findAnnotationIdWithEditorData();
    if (currentAnnotationId > 0) {
      return appendPropertyToAnnotation(currentAnnotationId);
    }
    
    var sMsg = "Registrar la anotación o limitación\n\n";
    
    sMsg += "Esta operación anexará una anotación sobre la inscripción actual, con la\n";
    sMsg += "siguiente información:\n\n";

    sMsg += getAnnotationDataForm();

    sMsg += "¿Registro esta anotación o limitación?";

    return confirm(sMsg);
  }
  
  function appendPropertyToAnnotation(annotationId) {
    var sMsg = "Agregar un predio a una anotación o limitación ya existente.\n\n";
    
    sMsg += "Esta operación anexará el predio con folio " + getComboOptionText(getElement('cboAnnotationProperty')) + "\n";
    sMsg += "a la siguiente anotación o limitación ya existente:\n\n";

    sMsg += getAnnotationDataForm();

    sMsg += "¿Agrego el predio " + getComboOptionText(getElement('cboAnnotationProperty')) + " a la anotación que se indica?";

    if (confirm(sMsg)) {
      sendPageCommand("appendPropertyToAnnotation", "annotationId=" + annotationId);
      return;
    } else {
      return false;
    }
  }

  function findAnnotationIdWithEditorData() {
    var url = "../ajax/land.registration.system.data.aspx?commandName=findAnnotationIdCmd";
    url += "&annotationBookId=" + getElement("cboAnnotationBook").value;
    url += "&annotationTypeId=" + getElement("cboAnnotation").value;    
    url += "&propertyId=" + getElement("cboAnnotationProperty").value;    
    url += "&number=" + getElement("txtAnnotationNumber").value;
    url += "&bisSuffixNumber=" + getElement("cboBisAnnotationNumber").value;    
    url += "&imageStartIndex=" + getElement("txtAnnotationImageStartIndex").value;
    url += "&imageEndIndex=" + getElement("txtAnnotationImageEndIndex").value;
    url += "&presentationTime=" + getElement("txtAnnotationPresentationDate").value + " " + getElement("txtAnnotationPresentationTime").value;
    url += "&authorizationDate=" + getElement("txtAnnotationAuthorizationDate").value;
    url += "&authorizedById=" + getElement("cboAnnotationAuthorizedBy").value;

    var annotationId = invokeAjaxMethod(false, url, null);
    
    return Number(annotationId);
  }
  
  function appendNoLegibleAnnotation() {
    if (getElement('txtAnnotationImageStartIndex').value.length == 0 && getElement('txtAnnotationImageEndIndex').value.length == 0) {
      getElement('txtAnnotationImageStartIndex').value = '1';
      getElement('txtAnnotationImageEndIndex').value = '1';
    }  
    if (!validateAnnotationStep1()) {
      return false;
    }
    if (!validateAnnotationSemantics()) {
      return false;
    }
    var sMsg = "Registrar la anotación o limitación como no legible\n\n";
    
    sMsg += "Esta operación anexará una anotación sobre la inscripción actual\n";
    sMsg += "con el estado de no legible, para que posteriormente se busque en\n";
    sMsg += "legajos u otros documentos la información correcta:\n\n";

    sMsg += getAnnotationDataForm();

    sMsg += "¿Registro la anotación o limitación como NO LEGIBLE?";
    
    return confirm(sMsg);
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
    } else if (oControl == getElement("cboAnotherRecorderOffice")) {
      resetAnotherRecordingBooksCombo();
    } else if (oControl == getElement("cboAnotherRecordingBook")) {
      resetAnotherRecordingsCombo();
    } else if (oControl == getElement("cboAnotherRecording")) {
      resetAnotherPropertiesCombo();
    } else if (oControl == getElement("cboAnnotationBook")) {
      resetAnnotationsOfficialsCombo();
    } else if (oControl == getElement("cboRecordingType")) {
      <%=oRecordingDocumentEditor.ClientID%>_updateUserInterface(getComboSelectedOption("cboRecordingType").title);
    } else if (oControl == getElement("cboAnnotationDocumentType")) {
      <%=oAnnotationDocumentEditor.ClientID%>_updateUserInterface(getComboSelectedOption("cboAnnotationDocumentType").title); 
    }
  }

  function resetAnotherRecordingBooksCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getRecordingBooksStringArrayCmd";
    if (getElement("cboAnotherRecorderOffice").value.length != 0) {
      url += "&recorderOfficeId=" + getElement("cboAnotherRecorderOffice").value;
    } else {
      url += "&recorderOfficeId=0";
    }
    url += "&recordingActTypeCategoryId=1051";

    invokeAjaxComboItemsLoader(url, getElement("cboAnotherRecordingBook"));

    resetAnotherRecordingsCombo();
  }

  function resetAnotherRecordingsCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getRecordingNumbersStringArrayCmd";
    if (getElement("cboAnotherRecordingBook").value.length != 0) {
      url += "&recordingBookId=" + getElement("cboAnotherRecordingBook").value;
    } else {
      url += "&recordingBookId=0";
    }
    invokeAjaxComboItemsLoader(url, getElement("cboAnotherRecording"));
    resetAnotherPropertiesCombo();
  }
    
  function resetAnotherPropertiesCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getRecordingPropertiesArrayCmd";
    if (getElement("cboAnotherRecording").value.length != 0) {
      url += "&recordingId=" + getElement("cboAnotherRecording").value; 
    } else {
      url += "&recordingId=0"; 
    }
    invokeAjaxComboItemsLoader(url, getElement("cboAnotherProperty"));
  }

  function showRegisteredPropertiesSection() {
    if (getElement("cboProperty").value == "-1") {
      getElement("divRegisteredPropertiesSection").style.display = "inline";
    } else {
      getElement("divRegisteredPropertiesSection").style.display = "none";
    }
  }

  function resetRecordingsTypesCombo() {    
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getRecordingTypesStringArrayCmd";
    url += "&recordingActTypeCategoryId=" + getElement("cboRecordingActTypeCategory").value; 

    invokeAjaxComboItemsLoader(url, getElement("cboRecordingActType"));
  }

  function resetAnnotationsTypesCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getAnnotationTypesStringArrayCmd";
    url += "&annotationTypeCategoryId=" + getElement("cboAnnotationCategory").value; 

    invokeAjaxComboItemsLoader(url, getElement("cboAnnotation"))
  }
  
  function resetAnnotationsOfficialsCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getAnnotationsOfficialsStringArrayCmd";
    url += "&recordingBookId=" + getElement("cboAnnotationBook").value;

    invokeAjaxComboItemsLoader(url, getElement("cboAnnotationAuthorizedBy"))
  }

  function resetAnnotationsBooksCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getRecordingBooksStringArrayCmd";
    url += "&recorderOfficeId=<%=recordingBook.RecorderOffice.Id.ToString()%>";       
    url += "&recordingActTypeCategoryId=" + getElement("cboAnnotationCategory").value; 

    invokeAjaxComboItemsLoader(url, getElement("cboAnnotationBook"))
  }
    
  function validateRecordingStep1() {
    <% if (!recording.IsNew) { %>
      if (existsElement("btnSaveRecording") && getElement("btnSaveRecording").disabled) {
        return true;
      }
    <% } %>
    if (getElement('cboRecordingType').value == '') {
      alert("Necesito se proporcione el tipo de inscripción.");
      return false;
    }
    if (getElement('txtRecordingNumber').value == '') {
      alert("Necesito se proporcione el número de inscripción.");
      return false;
    }
    if (!isNumeric(getElement('txtRecordingNumber'))) {
      alert("No reconozco el número de inscripción proporcionado.");
      return false;
    }
    if (Number(getElement('txtRecordingNumber').value) <= 0) {
      alert("Los números de inscripción deben ser mayores a cero.");
      return false;
    }
    <% if (base.DisplayImages()) { %>
    if (getElement('txtImageStartIndex').value == '') {
      alert("Requiero se proporcione el número de imagen en donde comienza el documento.");
      return false;
    }
    if (!isNumericValue(getElement('txtImageStartIndex').value)) {
      alert("No reconozco el número de imagen donde comienza el documento.");
      return false;
    }
    if (getElement('txtImageEndIndex').value == '') {
      alert("Requiero se proporcione el número de imagen en donde termina el documento.");
      return false;
    }
    if (!isNumericValue(getElement('txtImageEndIndex').value)) {
      alert("No reconozco el número de imagen donde termina el documento.");
      return false;
    }
    if (getElement('txtImageStartIndex').value <= 0) {
      alert("La imagen inicial debe ser mayor a cero.");
      return false;
    }
    if (Number(getElement('txtImageStartIndex').value) > Number(getElement('txtImageEndIndex').value)) {
      alert("El número de imagen donde comienza la inscripción no pude ser mayor al número de imagen donde termina la misma.");
      return false;
    }
    <% } %>
    if (getElement('txtPresentationDate').value != '') {
      if (!isDate(getElement('txtPresentationDate'))) {
        alert("No reconozco la fecha de presentación de la inscripción.");
        return false;
      }
      if (isNoLabourDate(getElement('txtPresentationDate').value)) {
        if (!confirm("La fecha de presentación de la inscripción está marcada como un día no laborable.\n\n¿La fecha de presentación está correcta?")) {
          return false;
        }
      }
    }
    if (getElement('txtPresentationTime').value != '') {
      if (!isHour(getElement("txtPresentationTime"))) {
        alert("No reconozco la hora en la que se presentó la inscripción.");
        return;
      } else {
        getElement("txtPresentationTime").value = formatAsTime(getElement("txtPresentationTime").value);
      }
    }
    if (getElement('txtAuthorizationDate').value != '') {
      if (!isDate(getElement('txtAuthorizationDate'))) {
        alert("No reconozco la fecha de autorización de la inscripción.");
        return false;
      }
      if (isNoLabourDate(getElement('txtAuthorizationDate').value)) {
        if (!confirm("La fecha de autorización de la inscripción está marcada como un día no laborable.\n\n¿La fecha de autorización está correcta?")) {
          return false;
        }
      }
    }
    if (getElement('txtPresentationDate').value != '' && getElement('txtAuthorizationDate').value != '') {		
      if (!isValidDatePeriod(getElement('txtPresentationDate').value, getElement('txtAuthorizationDate').value)) {
        alert("La fecha de autorización de la inscripción no puede ser anterior a su fecha de presentación.");
        return false;
      }
      if (daysBetween(getElement('txtPresentationDate').value, getElement('txtAuthorizationDate').value) > 30) {
        if (!confirm("Transcurrieron más de 30 días entre la fecha de presentación y la fecha de autorización de la inscripción.\n\n¿Las fechas de la inscripción están correctas?")) {
          return false;
        }
      }		  
    }
    if (getElement('cboAuthorizedBy').value == '') {
      alert("Necesito se seleccione de la lista al C. Oficial Registrador que autorizó esta inscripción.");
      return false;
    }
    if (!validatePayment(getElement('txtRecordingPayment'), getElement('txtRecordingPaymentReceipt'))) {
      return false;      
    }
    if (!<%=oRecordingDocumentEditor.ClientID%>_validate(getElement("txtPresentationDate").value)) {
      return false;
    }
    <% if (base.DisplayImages()) { %>
    var overlappingRecordings = getOverlappingRecordingsCount(<%=recordingBook.Id%>, <%=recording.Id%>, getElement("txtImageStartIndex").value, getElement("txtImageEndIndex").value);
    if (overlappingRecordings > 0) {
      var sMsg = "Posible traslape de imágenes de inscripciones.\n\nEn las imágenes comprendidas en el rango de la " + getElement('txtImageStartIndex').value;
      if (overlappingRecordings == 1) {
        sMsg += " a la " + getElement('txtImageEndIndex').value + ", existe otra inscripción.\n\n¿Las imágenes inicial y final son correctas?";
      } else { 
        sMsg += " a la " + getElement('txtImageEndIndex').value + ", existen otras " + overlappingRecordings + " inscripciones.\n\n¿Es esto correcto?";
      }
      if (!confirm(sMsg)) {
        return false;
      }
    }
    <% } %>
    return true;
  }
  
  function validatePayment(oPayment, oReceipt) {
    if (oPayment.value.length == 0) {
      sMsg  = "Validación del pago de derechos.\n\n";
      sMsg += "Requiero se proporcione el importe total por pago de derechos.\n\n";
      alert(sMsg);
      return false;
    }
    if (!isNumeric(oPayment)) {
      sMsg  = "Validación del pago de derechos.\n\n";
      sMsg += "No reconozco el importe total por pago de derechos.";
      alert(sMsg);
      return false;
    }
    if (convertToNumber(oPayment.value) < 0) {
      sMsg  = "Validación del pago de derechos.\n\n";
      sMsg += "No reconozco importes por pago de derechos negativos.";
      alert(sMsg);
      return false;
    }
    if (oReceipt.value.length == 0) {
      sMsg = "Validación del pago de derechos.\n\n";
      sMsg += "No se proporcionó la boleta de pago pero sí el importe\n";
      sMsg += "total por pago de derechos de inscripción.\n\n";
      sMsg += "¿El número de boleta de pago no es legible o no consta?";
      if (!confirm(sMsg)) {
        return false;
      }
    }
    if (0 < oReceipt.value.length && oReceipt.value.length < 6) {
      sMsg = "Validación del pago de derechos.\n\n";
      sMsg += "El número de boleta de pago contiene menos de seis caracteres.\n\n";
      sMsg += "¿El número de boleta de pago es correcto?";
      if (!confirm(sMsg)) {
        return false;
      }
    }
    return true;
  }

  function validateRecordingStep2() {
    <% if (!recording.IsNew) { %>
      if (existsElement("btnSaveRecording") && getElement("btnSaveRecording").disabled) {
        return true;
      }
    <% } %>
    if (getElement('txtPresentationDate').value == '') {
      alert("Requiero la fecha de presentación de la inscripción.");
      return false;
    }
    if (getElement("txtPresentationTime").value == '') {
      alert("Requiero la hora de presentación de la inscripción.");
      return;
    }
    if (getElement('txtAuthorizationDate').value == '') {
      alert("Requiero la fecha de autorización de la inscripción.");
      return false;
    }
    return true;
  }
    
  function validateRecordingAct() {
    if (getElement('cboRecordingActType').value == '') {
      alert("Necesito se seleccione de la lista el tipo de acto jurídico.");
      return false;
    }
    if (getElement('cboProperty').value == '') {
      alert("Necesito se seleccione de la lista el predio sobre el que aplicará el acto jurídico.");
      return false;
    }
    if (getElement('cboProperty').value == '-1' && getElement('cboAnotherProperty').value == "") {
      alert("Necesito se seleccione de la lista el predio ya registrado o inscrito sobre el que aplicará el acto jurídico.");
      return false;
    }
    return true;
  }
    
  function validateAnnotationStep1() {
    if (getElement('cboAnnotation').value == '') {
      alert("Necesito se seleccione de la lista el tipo de anotación.");
      return false;
    }
    if (getElement('cboAnnotationBook').value == '') {
      alert("Requiero se seleccione el libro al que hace referencia la anotación.");
      return false;
    }
    if (getElement('cboAnnotationProperty').value == '') {
      alert("Necesito se seleccione el predio al que hace referencia la anotación.");
      return false;
    }
    if (getElement('cboAnnotationDocumentType').value == '') {
      alert("Necesito se proporcione el tipo de documento de la anotación.");
      return false;
    }
    if (getElement('txtAnnotationNumber').value == '') {
      alert("Necesito se proporcione el número de inscripción de la anotación.");
      return false;
    }
    if (!isNumeric(getElement('txtAnnotationNumber'))) {
      alert("No reconozco el número de inscripción de la anotación proporcionado.");
      return false;
    }
    if (getElement('txtAnnotationImageStartIndex').value == '') {
      alert("Requiero se proporcione el número de imagen en donde comienza la anotación que se desea agregar.");
      return false;
    }
    if (getElement('txtAnnotationImageEndIndex').value == '') {
      alert("Requiero se proporcione el número de imagen en donde termina la anotación que se desea agregar.");
      return false;
    }		
    if (!isNumericValue(getElement('txtAnnotationImageStartIndex').value)) {
      alert("No reconozco el número de imagen donde comienza la anotación.");
      return false;
    }
    if (!isNumericValue(getElement('txtAnnotationImageEndIndex').value)) {
      alert("No reconozco el número de imagen donde termina la anotación.");
      return false;
    }
    if (Number(getElement('txtAnnotationImageStartIndex').value) > Number(getElement('txtAnnotationImageEndIndex').value)) {
      alert("El número de imagen donde comienza la anotación no pude ser mayor al número de imagen donde termina.");
      return false;
    }
    if (!isEmpty(getElement('txtAnnotationPresentationDate'))) {
      if (!isDate(getElement('txtAnnotationPresentationDate'))) {
        alert("No reconozco la fecha de presentación de la anotación.");
        return false;
      }
      if (isNoLabourDate(getElement('txtAnnotationPresentationDate').value)) {
        if (!confirm("La fecha de presentación de la anotación está marcada como un día no laborable.\n\n¿La fecha de presentación de la anotación está correcta?")) {
          return false;
        }			
      }
      if (!isValidDatePeriod(getElement('txtPresentationDate').value, getElement('txtAnnotationPresentationDate').value)) {
        alert("La fecha de presentación de la anotación no puede ser anterior a la fecha de presentación de la inscripción del predio.");
        return false;
      }
    }
    if (getElement('txtAnnotationPresentationTime').value != '') {
      if (!isHour(getElement("txtAnnotationPresentationTime"))) {
        alert("No reconozco la hora en la que se presentó la anotación.");
        return;
      } else {
        getElement("txtAnnotationPresentationTime").value = formatAsTime(getElement("txtAnnotationPresentationTime").value);
      }
    }
    if (!isEmpty(getElement('txtAnnotationAuthorizationDate'))) {
      if (!isDate(getElement('txtAnnotationAuthorizationDate'))) {
        alert("No reconozco la fecha de autorización de la anotación.");
        return false;
      }
      if (isNoLabourDate(getElement('txtAnnotationAuthorizationDate').value)) {
        if (!confirm("La fecha de autorización de la anotación está marcada como un día no laborable.\n\n¿La fecha de autorización de la anotación está correcta?")) {
          return false;
        }
      }
      if (!isValidDatePeriod(getElement('txtAuthorizationDate').value, getElement('txtAnnotationAuthorizationDate').value)) {
        alert("La fecha de autorización de la anotación no puede ser anterior a la fecha de autorización de la inscripción del predio.");
        return false;
      }			
    }		
    if (!isEmpty(getElement('txtAnnotationPresentationDate')) && !isEmpty(getElement('txtAnnotationAuthorizationDate'))) {
      if (!isValidDatePeriod(getElement('txtAnnotationPresentationDate').value, getElement('txtAnnotationAuthorizationDate').value)) {
        alert("La fecha de autorización de la anotación no puede ser anterior a su fecha de presentación.");
        return false;
      }		  
      if (daysBetween(getElement('txtAnnotationPresentationDate').value, getElement('txtAnnotationAuthorizationDate').value) > 30) {
        if (!confirm("Transcurrieron más de 30 días entre la fecha de presentación y la fecha de autorización de la anotación.\n\n¿Las fechas de la anotación están correctas?")) {
          return false;
        }
      }
    }
    if (getElement('cboAnnotationAuthorizedBy').value == '') {
      alert("Necesito se seleccione de la lista al C. Oficial Registrador que autorizó la anotación.");
      return false;
    }
    if (!validatePayment(getElement('txtAnnotationPayment'), getElement('txtAnnotationPaymentReceipt'))) {
      return false;
    }
    if (!<%=oAnnotationDocumentEditor.ClientID%>_validate(getElement("txtAnnotationPresentationDate").value)) {
      return false;
    }
    var overlappingRecordings = getOverlappingRecordingsCount(getElement("cboAnnotationBook").value, 0, getElement("txtAnnotationImageStartIndex").value, getElement("txtAnnotationImageEndIndex").value);
    if (overlappingRecordings > 0) {
      var sMsg = "Posible traslape de imágenes de anotaciones.\n\nEn las imágenes comprendidas en el rango de la " + getElement('txtAnnotationImageStartIndex').value;
      if (overlappingRecordings == 1) {
        sMsg += " a la " + getElement('txtAnnotationImageEndIndex').value + ", existe otra anotación o limitación.\n\n¿Las imágenes inicial y final son correctas?";
      } else { 
        sMsg += " a la " + getElement('txtAnnotationImageEndIndex').value + ", existen otras " + overlappingRecordings + " anotaciones o limitaciones.\n\n¿Es esto correcto?";
      }
      if (!confirm(sMsg)) {
        return false;
      }
    }
    return true;
  }

  function validateAnnotationStep2() {
    if (getElement('txtAnnotationPresentationDate').value == '') {
      alert("Requiero la fecha de presentación de la anotación que se desea agregar.");
      return false;
    }
    if (getElement("txtAnnotationPresentationTime").value == '') {
      alert("Requiero la hora de presentación de la anotación que se desea agregar.");
      return false;
    }
    if (getElement('txtAnnotationAuthorizationDate').value == '') {
      alert("Requiero la fecha de autorización de la anotación que se desea agregar.");
      return false;
    }
    return true;
  }
    
  function moveToImage(position) {
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
        newPosition = Math.min(Number(getElement("hdnCurrentImagePosition").value) + 1, selectedBookImageCount() - 1);
        break;
      case "last":
        ajaxURL += "&position=" + position;
        newPosition = selectedBookImageCount() - 1;
        break;
      case "refresh":
        ajaxURL += "&position=" + position;
        newPosition = getRecordingStartImageIndex() - 1;
        break;
      default:
        alert("No reconozco la posición de la imagen que se desea desplegar.");
        return;
    }
    if (getElement('cboRecordingBookSelector').value.length == 0) {
      return;
    } else if (getElement('cboRecordingBookSelector').selectedIndex == 0) {
      ajaxURL += "&directoryId=<%=recordingBook.ImagingFilesFolder.Id%>";
    } else if (getElement("cboRecordingBookSelector").value.substring(0, 1) != "&") {
      ajaxURL += "&recordingId=" + getElement('cboRecordingBookSelector').value;
    } else if (getElement("cboRecordingBookSelector").value.substring(0, 1) == "&") {
      ajaxURL += getElement("cboRecordingBookSelector").value;
    } else {
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
    var imageXOfY = getCurrentImage() + " de " + selectedBookImageCount();
    setInnerText(getElement("spanPageTitle"), '<%=recording.IsNew ? "Nueva inscripción" : "Inscripción " + recording.Number%> en <%=recordingBook.FullName%>');
    <% if (!base.DisplayImages()) { %>
    setInnerText(getElement("spanCurrentImage"), "No digitalizado");
    return;
    <% } %>
    if (getElement("cboRecordingBookSelector").value.length == 0) {
      // no-op
    } else if (getElement("cboRecordingBookSelector").selectedIndex == 0) {
      setInnerText(getElement("spanCurrentImage"), "Imagen " + imageXOfY);
    } else if (getElement("cboRecordingBookSelector").value.substring(0, 1) != "&") {
      setInnerText(getElement("spanCurrentImage"), "Imagen " + imageXOfY + " de la anotación " + getComboOptionText(getElement("cboRecordingBookSelector")));
    } else if (getElement("cboRecordingBookSelector").value.substring(0, 1) == "&") {
      setInnerText(getElement("spanCurrentImage"), "Imagen " + imageXOfY + " del apéndice " + getComboOptionText(getElement("cboRecordingBookSelector")));
    }
  }

  function getCurrentImage() {
    return Number(Number(getElement("hdnCurrentImagePosition").value) + 1);
  }

  function pickCurrentImage(controlName) {
    <% if (base.DisplayImages()) { %>
    getElement(controlName).value = getCurrentImage();
    <% } %>
  }
  
  function selectedBookImageCount() {
    if (arguments.length == 1) {
      return <%=recordingBook.ImagingFilesFolder.FilesCount.ToString()%>;
    }

    var ajaxURL = "../ajax/land.registration.system.data.aspx?commandName=getRecordingBookImageCountCmd";

    if (getElement('cboRecordingBookSelector').value.substring(0,1) == "&") {
      ajaxURL += getElement('cboRecordingBookSelector').value;
    } else if (getElement('cboRecordingBookSelector').value > 0) {
      ajaxURL += "&recordingId=" + getElement('cboRecordingBookSelector').value;
    } else {
      ajaxURL += "&recordingBookId=<%=recordingBook.Id%>";
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
    var imageCount = selectedBookImageCount();
    if (Number(getElement("txtGoToImage").value) > imageCount) {
      alert("El libro seleccionado sólo contiene " + imageCount + " imágenes.");
      return false;
    }
    
    var ajaxURL = "../ajax/land.registration.system.data.aspx?commandName=getDirectoryImageURL";
    var newPosition = Number(getElement("txtGoToImage").value) -  1;
    ajaxURL += "&position=" + newPosition;
    ajaxURL += "&directoryId=<%=recordingBook.ImagingFilesFolder.Id%>";
    ajaxURL += "&currentPosition=" + getElement("hdnCurrentImagePosition").value;
    var result = invokeAjaxMethod(false, ajaxURL, null);
    getElement("imgCurrent").src = result;
    getElement("hdnCurrentImagePosition").value = newPosition;
    setPageTitle();

    return true;
  }

  function gotoRecording() {
    if (getElement("txtGoToRecording").value.length == 0) {
      alert("Necesito conocer el número de inscripción que se desea visualizar.");
      return false;
    }
    if (!isNumeric(getElement("txtGoToRecording"))) {
      alert("No reconozco el número de inscripción proporcionado.");
      return false;
    }
    if (Number(getElement("txtGoToRecording").value) <= 0) {
      alert("No reconozco el número de inscripción que se desea visualizar.");
      return false;
    }
    var ajaxURL = "../ajax/land.registration.system.data.aspx?commandName=getRecordingIdCmd";
    ajaxURL += "&recordingBookId=<%=recordingBook.Id%>";	  
    ajaxURL += "&number=" + getElement("txtGoToRecording").value;
    
    var result = invokeAjaxMethod(false, ajaxURL, null);
    if (Number(result) != 0) {
      sendPageCommand("gotoRecording", "id=" + result);
      return;
    } else {
      alert("No ha sido registrada ninguna inscripción con el número " + getElement("txtGoToRecording").value + " en este libro.");
      return;    
    }
  }

  function refreshRecordingViewer() {
    var ajaxURL = "../ajax/land.registration.system.data.aspx?commandName=getRecordingsViewerPageCmd";
    ajaxURL += "&recordingBookId=<%=recordingBook.Id%>";
    ajaxURL += "&page=" + getElement("cboRecordingViewerPage").value;
    ajaxURL += "&itemsPerPage=<%=recordingsPerViewerPage%>";
    
    var result = invokeAjaxMethod(false, ajaxURL, null);
    getElement("tblRecordingsViewer").outerHTML = result;
    return;
  }

  function getOverlappingRecordingsCount(recordingBookId, recordingId, imageStartIndex, imageEndIndex) {
    var ajaxURL = "../ajax/land.registration.system.data.aspx?commandName=getOverlappingRecordingsCountCmd";
    ajaxURL += "&recordingBookId=" + recordingBookId;
    ajaxURL += "&recordingId=" + recordingId;		
    ajaxURL += "&imageStartIndex=" + imageStartIndex;
    ajaxURL += "&imageEndIndex=" + imageEndIndex;

    var result = invokeAjaxMethod(false, ajaxURL, null);

    return Number(result);
  }

  function getRecordingBookImageCount(recordingBookId) {
    var ajaxURL = "../ajax/land.registration.system.data.aspx?commandName=getRecordingBookImageCountCmd";
    ajaxURL += "&recordingBookId=" + recordingBookId;

    var result = invokeAjaxMethod(false, ajaxURL, null);

    return Number(result);
  }

  function showRecordingForEdition(showEditorFlag) {
    if (showEditorFlag) {
      getElement("btnEditRecording").value = "Descartar los cambios";
      getElement("btnDeleteRecording").disabled = false;
      getElement("btnSaveRecording").disabled = false;
      disableControls(getElement("tblRecording"), false);
      <%=oRecordingDocumentEditor.ClientID%>_disabledControl(false);
      getElement("txtObservations").disabled = false;
    } else if (getElement("btnEditRecording").value == "Descartar los cambios") {
      doOperation("refreshRecording");
    } else {
      getElement("btnEditRecording").value = "Editar esta inscripción";
      getElement("btnDeleteRecording").disabled = true;
      getElement("btnSaveRecording").disabled = true;
      disableControls(getElement("tblRecording"), true);
      <%=oRecordingDocumentEditor.ClientID%>_disabledControl(true);
      getElement("txtObservations").disabled = true;
    }
  }

  function onclick_editRecordingForEdition() {
    if (getElement("btnEditRecording").value == "Editar esta inscripción") {
      showRecordingForEdition(false);
      showRecordingForEdition(true);
    } else {
      showRecordingForEdition(false);
    }
  }

  function showAdditionalImage() {
    if (getElement('cboAnnotationBook').value == '') {
      alert("Requiero se seleccione primero el libro de referencia.");
      return;
    }
    var gotoImage = Number();
    if (getElement("txtAnnotationImageEndIndex").value != '') {
      gotoImage = Number(getElement("txtAnnotationImageEndIndex").value);
    } else if (getElement("txtAnnotationImageStartIndex").value != '') {
      gotoImage = Number(getElement("txtAnnotationImageStartIndex").value);
    } else {
      gotoImage = 1;
    }
    var recordingBookImageCount = 0;
    
    if (gotoImage > 0) {
      recordingBookImageCount = getRecordingBookImageCount(getElement('cboAnnotationBook').value);
    }
    if (gotoImage > recordingBookImageCount) {
      alert("El libro " + getComboOptionText(getElement('cboAnnotationBook')) + " contiene sólo " + recordingBookImageCount + " imágenes.");
      return false;
    }
    var source = "directory.image.viewer.aspx?";
    source += "id=" + getElement('cboAnnotationBook').value;
    source += "&gotoImage=" + gotoImage;
    createNewWindow(source);
  }
  
  function showAnnotationsEditor() {
    <% if (recording.RecordingActs.Count == 0) { %>
      alert("Para poder anexar una anotación o limitación, requiero que la inscripción contenga al menos un acto jurídico traslativo de dominio.");
      return;
    <% } %>
    if (getElement("divAnnotationEditorRow0").style.display == 'inline') {
      getElement("divAnnotationEditorRow0").style.display = 'none';
      getElement("divAnnotationEditorRow1").style.display = 'none';
      getElement("divAnnotationEditorRow2").style.display = 'none';
      getElement("divAnnotationEditorRow3").style.display = 'none';
      getElement("divAnnotationEditorRow4").style.display = 'none';
      getElement("divAnnotationEditorRow4bis").style.display = 'none';  
      getElement("divAnnotationEditorRow5").style.display = 'none';
      getElement("divAnnotationEditorRow6").style.display = 'none';			
      
    } else {
      getElement("divAnnotationEditorRow0").style.display = 'inline';
      getElement("divAnnotationEditorRow1").style.display = 'inline';
      getElement("divAnnotationEditorRow2").style.display = 'inline';
      getElement("divAnnotationEditorRow3").style.display = 'inline';
      getElement("divAnnotationEditorRow4").style.display = 'inline';
      getElement("divAnnotationEditorRow4bis").style.display = 'inline';
      getElement("divAnnotationEditorRow5").style.display = 'inline';
      getElement("divAnnotationEditorRow6").style.display = 'inline';			
    }
  }	
  
  function saveRecording() {
    if (getElement("cboStatus").value == "<%=(char) Empiria.Land.Registration.RecordingStatus.Obsolete%>") {
      return registerAsObsoleteRecording();
    } else if (getElement("cboStatus").value == "<%= (char) Empiria.Land.Registration.RecordingStatus.NoLegible%>") {
      return registerAsNoLegibleRecording();
    } else if (getElement("cboStatus").value == "<%=(char) Empiria.Land.Registration.RecordingStatus.Pending%>") {
      return registerAsPendingRecording();		
    } else if (getElement("cboStatus").value == "<%= (char) Empiria.Land.Registration.RecordingStatus.Incomplete%>") {
      return registerAsIncompleteRecording(false);
    }
  }
  
  function getAnnotationDataForm() {
    var sMsg = "";
    
    sMsg += "Libro:\t\t<%=recordingBook.FullName%>\n";
    sMsg += "Inscripción:\t" + getElement('txtRecordingNumber').value + 
            getElement('cboBisRecordingNumber').value + "\n\n";
    sMsg += getComboOptionText(getElement('cboAnnotation')).toUpperCase() + "\n";
    sMsg += "Inscrita en:\t" + getComboOptionText(getElement('cboAnnotationBook')) + "\n";
    sMsg += "Número:\t\t" + getElement('txtAnnotationNumber').value + getElement('cboBisAnnotationNumber').value;		
    if (getElement('txtAnnotationImageStartIndex').value != '1' && getElement('txtAnnotationImageEndIndex').value != '1') {
      sMsg += ", ubicada de la imagen " + getElement('txtAnnotationImageStartIndex').value + " a la " + getElement('txtAnnotationImageEndIndex').value + "\n";
    }  else {
      sMsg += ", ubicada en una imagen no determinada.\n";
    }
    if (getElement('txtAnnotationPresentationDate').value.length != 0) {
      sMsg += "Presentación:\t" + "El día " + getElement('txtAnnotationPresentationDate').value + " a las " + getElement('txtAnnotationPresentationDate').value + "\n";
    } else {
      sMsg += "Presentación:\t" + "No determinada\n";
    }
    if (getElement('txtAnnotationAuthorizationDate').value.length != 0) {
      sMsg += "Autorización:\t" + "El día " + getElement('txtAnnotationAuthorizationDate').value + "\n";
    } else {
      sMsg += "Autorización:\t" + "No determinada\n";
    }
    if (getElement('cboAnnotationAuthorizedBy').value.length != 0) {
      sMsg += "C.Registrador:\t" + "Lic. " + getComboOptionText(getElement('cboAnnotationAuthorizedBy')) + "\n\n";
    } else {
      sMsg += "C.Registrador:\t" + "No determinado\n\n";
    }
    return sMsg;
  }

  function getRecordingDataForm() {
    var sMsg = "";
    
    sMsg += "Libro:\t\t<%=recordingBook.FullName%>\n";
    sMsg += "Inscripción:\t" + getElement('txtRecordingNumber').value + 
            getElement('cboBisRecordingNumber').value + "\n";
    <% if (base.DisplayImages()) { %>
    sMsg += "De la imagen:\t" + getElement('txtImageStartIndex').value + "\n";
    sMsg += "A la imagen:\t" + getElement('txtImageEndIndex').value + "\n\n";
    <% } %>
    if (getElement('txtPresentationDate').value.length != 0) {
      sMsg += "Presentación:\t" + "El día " + getElement('txtPresentationDate').value + " a las " + getElement('txtPresentationTime').value + "\n";
    } else {
      sMsg += "Presentación:\t" + "No determinada\n";
    }
    if (getElement('txtAuthorizationDate').value.length != 0) {
      sMsg += "Autorización:\t" + "El día " + getElement('txtAuthorizationDate').value + "\n";
    } else {
      sMsg += "Autorización:\t" + "No determinada\n";
    }
    if (getElement('cboAuthorizedBy').value.length != 0) {
      sMsg += "C.Registrador:\t" + "Lic. " + getComboOptionText(getElement('cboAuthorizedBy')) + "\n\n";
    } else {
      sMsg += "C.Registrador:\t" + "No determinado\n\n";
    }
    return sMsg;
  }

//  function disableRecordingEditor() {
//    getElement("rowNoVigentOrIlegibleButtons").style.display = 'none';
//    getElement("rowEditButtons").style.display = 'inline';
//  	getElement("btnEditRecording").value = "Editar esta inscripción";
//		getElement("btnDeleteRecording").disabled = true;
//		getElement("btnSaveRecording").disabled = true;
//    disableControls(getElement("tblRecording"), true);
//    <%=oRecordingDocumentEditor.ClientID%>_disabledControl(true);
//    getElement("txtObservations").disabled = true;
//  }

  function window_onload() {
    setWorkplace2();
    setPageTitle();
    <% if (recording.IsNew) { %>
      getElement("rowNoVigentOrIlegibleButtons").style.display = 'inline';
      getElement("rowEditButtons").style.display = 'none';
      showRecordingForEdition(true);
    <% } else { %>
      getElement("rowNoVigentOrIlegibleButtons").style.display = 'none';
      getElement("rowEditButtons").style.display = 'inline';
      showRecordingForEdition(false);
    <% } %>
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
    ifraItemEditor_onresize();
    window_onscroll();
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

  function ifraItemEditor_onresize() {
    var oFrame = getElement("ifraItemEditor");
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
  addEvent(getElement("ifraItemEditor"), 'resize', ifraItemEditor_onresize);
  addEvent(getElement('<%=txtRecordingPaymentReceipt.ClientID%>'), 'keypress', upperCaseKeyFilter);
  addEvent(getElement('<%=txtAnnotationPaymentReceipt.ClientID%>'), 'keypress', upperCaseKeyFilter);

  /* ]]> */
  </script>
</html>