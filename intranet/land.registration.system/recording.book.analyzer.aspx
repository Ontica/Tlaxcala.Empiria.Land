<%@ Page Language="C#" EnableViewState="true" AutoEventWireup="true" Inherits="Empiria.Land.WebApp.RecordingBookAnalyzer" CodeFile="recording.book.analyzer.aspx.cs" %>
<%@ OutputCache Location="None" NoStore="true" %>
<%@ Import Namespace="Empiria.Land.Registration" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es-mx">
<head id="Head1" runat="server">
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="Expires" content="-1" />
<meta http-equiv="Pragma" content="no-cache" />
<meta name="MS.LOCALE" content="ES-MX" />

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
        Registro histórico de partidas
      </span>
      <span id="spanCurrentImage" class="rightItem appTitle" style="margin-right:8px">
        &#160;
      </span>
    </div> <!--divHeader!-->
    <div id="divBody">
      <div id="divContent" style="height: 652px; width: 892px;">
        <table cellpadding="0" cellspacing="0">
          <tr>
            <td id="divImageViewer" valign='top' style="position:relative;overflow:hidden;">
              <div id="divImageContainer">
                  <object id="documentViewer" type="text/html" style="width:100%; height:115%;overflow:hidden!important;">
                    <p>Visor de imágenes de libros</p>
                  </object>
                </div>
            </td>
            <td><img src="../themes/default/textures/pixel.gif" height="1px" width="12px" alt="" /></td>
            <td id="divDocumentViewer" valign="top" style="height: 652px; width: 892px;">
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
                      <input type="text" class="textBox" readonly="readonly" style="width:368px"  title="" value="<%=recordingBook.AsText%>" />
                      &#160;Tipo de inscripción:
                    </td>
                    <td>
                      <select id="cboRecordingType" name="cboRecordingType" class="selectBox" style="width:136px" title="" onchange="return updateUserInterface(this);" runat="server">
                        <option value="">( Seleccionar )</option>
                        <option value="2409">No determinado</option>
                        <option value="2410" title="oNotaryPublicDeed">Escritura pública</option>
                        <option value="2414" title="oNotaryOfficialLetter">Oficio de notaría</option>
                        <option value="2412" title="oJudgeOfficialLetter">Documento de juzgado</option>
                        <option value="2413" title="oPrivateContract">Documento de terceros</option>
                        <option value="2411" title="oEjidalSystemTitle">Título de propiedad</option>
                      </select>
                    </td>
                    <td class="lastCell">&#160;</td>
                  </tr>
                  <tr>
                    <td>Número de Partida:</td>
                    <td>
                      <input id="txtRecordingNumber" type="text" class="textBox" style="width:35px;margin-right:0px" onkeypress="return integerKeyFilter(window.event, true);" title="" maxlength="5" runat="server" />
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
                      &#160;&#160;&#160;Inscrita de la imagen:
                    </td>
                    <td>
                      <input id="txtImageStartIndex" name="txtImageStartIndex" type="text" class="textBox" style="width:40px"
                             onkeypress="return integerKeyFilter(window.event, true);" title="" maxlength="4"
                             runat="server" /><img src="../themes/default/buttons/select_page.gif"
                                                   onclick="pickCurrentImage('txtImageStartIndex')"
                                                   title="Selecciona el número de imagen que se está desplegando" alt="" />
                    </td>
                    <td>a la imagen:</td>
                    <td>
                      <input id="txtImageEndIndex" name="txtImageEndIndex" type="text" class="textBox" style="width:40px"
                             onkeypress="return integerKeyFilter(window.event, true);" title="" maxlength="4"
                             runat="server" /><img src="../themes/default/buttons/select_page.gif"
                                                    onclick="pickCurrentImage('txtImageEndIndex')"
                                                    title="Selecciona el número de imagen que se está desplegando" alt="" />
                    </td>
                    <td class="lastCell">&#160;</td>
                  </tr>
                  <tr>
                    <td>Fecha de presentación:</td>
                    <td>
                      <input id='txtPresentationDate' name='txtPresentationDate' type="text" class="textBox" style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
                      <img id='imgPresentationDate' src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(event, getElement('<%=txtPresentationDate.ClientID%>'), getElement('imgPresentationDate'),'155px', '-60px');" title="Despliega el calendario" alt="" />
                       &#160;&#160;&#160;&#160;&#160;&#160;&#160;Hora de presentación:</td>
                    <td><input id="txtPresentationTime" name="txtPresentationTime" type="text" class="textBox" style="width:40px;margin-right:2px" maxlength="5" title="" onkeypress='return hourKeyFilter(window.event, true);' runat="server" />Hrs&#160;</td>
                    <td>F. Autorización:</td>
                    <td>
                      <input id='txtAuthorizationDate' name='txtAuthorizationDate' type="text" class="textBox" style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
                      <img id='imgAuthorizationDate' src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(event, getElement('txtAuthorizationDate'), getElement('imgAuthorizationDate'),'520px' , '-60px');" title="Despliega el calendario" alt="" />
                    </td>
                    <td class="lastCell">&#160;</td>
                  </tr>
                  <tr>
                    <td>El C. Registrador: &#160; &#160;&#160;Lic.</td>
                    <td colspan="2">
                      <select id="cboAuthorizedBy" name="cboAuthorizedBy" class="selectBox" style="width:304px" title="" onchange="return updateUserInterface();" runat="server">
                      </select>
                    </td>
                    <td>Estado:</td>
                    <td>
                      <select id="cboStatus" name="cboStatus" class="selectBox" style="width:134px" title="" runat="server">
                      </select>
                    </td>
                    <td class="lastCell">&#160;</td>
                  </tr>
                  <tr>
                    <td>Notas sobre el análisis:<br />&#160;</td>
                    <td class="lastCell" colspan="5">
                      <textarea id="txtObservations" name="txtObservations" class="textArea" style="width:524px;" cols="240" rows="2" runat="server"></textarea>
                    </td>
                    <td class="lastCell">&#160;</td>
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
                      <td>Resumen:<br /><br /><br /><br /><br />&#160;</td>
                      <td class="lastCell" colspan="2">
                        <textarea id="txtResumen" name="txtResumen" class="textArea" style="width:564px;" cols="240" rows="5" runat="server"></textarea>
                      </td>
                    </tr>
                    <tr id="rowEditButtons" style="display:table-row">
                      <td>&#160;</td>
                      <td class="lastCell" colspan="2">
                        <input id='btnEditRecording' type="button" value="Editar esta inscripción" class="button" style="width:130px" onclick='doOperation("onclick_editRecordingForEdition");' title='Guarda la inscripción y la marca como no legible' />
                        <img src="../themes/default/textures/pixel.gif" height="1px" width="216px" alt="" />
                        <input id='btnDeleteRecording' type="button" value="Eliminar" class="button" disabled='disabled' style="width:70px" onclick='doOperation("deleteRecording")' title='Elimina completamente esta inscripción y todos los actos y propiedades que contiene' />
                        <img src="../themes/default/textures/pixel.gif" height="1px" width="16px" alt="" />
                        <input id='btnSaveRecording' type="button" value="Guardar los cambios" class="button" disabled='disabled' style="width:112px" onclick='doOperation("saveRecording")' title='Guarda la inscripción ' />
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr id="rowRecordingActsTitle"><td class="subTitle">Actos jurídicos vigentes contenidos en la inscripción</td></tr>
              <tr id="rowRecordingActsGridAndEditor">
                <td>
                  <table class="editionTable">
                    <tr>
                      <td colspan="8" class="lastCell">
                        <div style="overflow:auto;width:660px;">
                          <table class="details" style="width:99%">
                            <tr class="detailsHeader">
                              <td>#</td>
                              <td width="50%">Actos jurídicos vigentes</td>
                              <td width="30%">Inscrito en</td>
                              <td>Folio real</td>
                              <td>&#160;</td>
                            </tr>
                            <%=gRecordingActs%>
                          </table>
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <td>Tipo de acto:</td>
                      <td colspan="6">
                        <select id="cboRecordingActTypeCategory" name="cboRecordingActTypeCategory" class="selectBox" style="width:256px" title="" onchange="return updateUserInterface(this);" runat='server'>
                        </select>
                        Acto:
                        <select id="cboRecordingActType" name="cboRecordingActType" class="selectBox" style="width:276px" title="" onchange="return updateUserInterface();">
                          <option value="">( Primero seleccionar una categoría )</option>
                        </select>
                      </td>
                      <td class="lastCell">&#160;</td>
                    </tr>
                    <tr>
                      <td>Sobre el predio:</td>
                      <td colspan="5">
                        <select id="cboProperty" class="selectBox" style="width:162px" title="" onchange="return updateUserInterface(this);" runat='server'>

                        </select><input id='chkCreatePartition' type="checkbox" disabled="disabled"
                                        onchange="return updateUserInterface(this);" runat="server" />Sobre fracción
                        &#160; &#160; &#160; &#160; &#160; &#160;
                        Clave catastral:
                        <input id='txtCadastralKey' name='txtCadastralKey' type="text" class="textBox" style="width:192px;" title="" runat="server" />
                      </td>
                      <td>
                        &#160;
                      </td>
                      <td class="lastCell">&#160;</td>
                    </tr>
                    <tr id="rowPartitionSection" style="display:none">
                      <td>Tipo de fracción:</td>
                      <td colspan="6">
                        <select id="cboPropertyPartitionType" class="selectBox" style="width:162px" title=""
                                onchange="return updateUserInterface(this);" runat="server">
                          <option value="">( Seleccionar )</option>
                          <option value="Bodega">Bodega</option>
                          <option value="Casa">Casa</option>
                          <option value="Departamento">Departamento</option>
                          <option value="Estacionamiento">Estacionamiento</option>
                          <option value="Fracción">Fracción</option>
                          <option value="Local comercial">Local comercial</option>
                          <option value="Lote">Lote</option>
                        </select>
                        &#160;
                        Número:
                        <input id="txtPartitionNo" type="text" class="textBox" style="width:122px; margin-right:0" maxlength="40" runat="server" />
                        <label><input id="chkNoNumberPartition" type="checkbox" onclick="updatePartitionControls();" />Sin número</label>
<%--
                        <label><input id="chkGeneratePartitionRank" type="checkbox" onclick="updatePartitionControls()" />Generar un rango</label>
                          <tr id="divRepeatPartitionUntilRow" style="display:none">
                          <td colspan="2">&#160;</td>
                          <td>Número final:</td>
                          <td><input id="txtRepeatPartitionUntil" type="text" class="textBox" style="width:122px; margin-right:0" maxlength="4" /></td>
                          <td class="lastCell">&#160;</td>
                        </tr>--%>
                      </td>
                      <td class="lastCell">&#160;</td>
                    </tr>
                    <tr>
                      <td></td>
                      <td colspan="5" align="right" style="border-top: dotted 1px">Registrar este acto:
                        <select id="cboRecordingMode" class="selectBox" style="width:110px" title="" onchange="return updateUserInterface(this);" runat='server'>
                          <option value="">( Seleccionar )</option>
                          <option value="this">En esta partida</option>
                          <option value="marginal">Al margen</option>
                          <option value="otherRecording">En otra partida</option>
                        </select>
                        <input type="button" value="Agregar el acto jurídico" class="button" style="width:124px" onclick='doOperation("appendRecordingAct")' />
                        &#160; &#160; &#160;
                        </td>
                        <td class="lastCell">&#160;</td>
                    </tr>
                    <tr id="rowRegisterOnMargin" style="display:none">
                      <td style="vertical-align:top">Fecha de la<br />anotación:<br /><br />&#160;</td>
                      <td colspan="5" style="vertical-align:top">
                        <table class="internalTable">
                          <tr>
                            <td style="vertical-align:top">
                              <input id='txtMarginalNoteDate' name='txtMarginalNoteDate' type="text" class="textBox"
                                       style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
                              <img id='imgMarginalNoteDate' src="../themes/default/buttons/ellipsis.gif"
                                 onclick="return showCalendar(event, getElement('txtMarginalNoteDate'), getElement('imgMarginalNoteDate'), '70px', '240px');" title="Despliega el calendario" alt="" />
                            </td>
                            <td style="vertical-align:top">
                              Anotación<br />
                              al margen:
                            </td>
                            <td>
                              <textarea id="txtMarginalNote" name="txtMarginalNote" class="textArea" style="width:404px;" cols="240" rows="4" runat="server"></textarea>
                            </td>
                            </tr>
                        </table>
                      </td>
                      <td class="lastCell">&#160;</td>
                    </tr>
                    <tr id="rowRegisterInAnotherSection" style="display:none">
                      <td>Sección:<br /><br />&#160;</td>
                      <td colspan="6">
                        <select id="cboAnotherRecorderOffice" class="selectBox" style="width:160px" title="" onchange="return updateUserInterface(this);" runat='server'>
                        </select>
                        Volumen:
                        <select id="cboAnotherRecordingBook" class="selectBox" style="width:356px" title="" onchange="return updateUserInterface(this);" runat='server'>
                        </select>
                        <br />
                        Partida:
                        <select id="cboAnotherRecording" class="selectBox" style="width:78px" title="" onchange="return updateUserInterface(this);" runat='server'>
                        </select>
                        <img src="../themes/default/buttons/search.gif" alt="" title="Ejecuta la búsqueda" style="margin-left:-8px" onclick="doOperation('showAnotherRecording')" />
                        &#160;&#160;&#160;Predio ya inscrito:&#160;
                        <select id="cboAnotherProperty" class="selectBox" style="width:150px" title="" runat='server'>
                        </select>
                      </td>
                      <td class="lastCell">&#160;</td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td class="separator">
                &#160;
                </td>
              </tr>
              <tr id="rowRecordingNavigationControl">
                <td>
                  <table>
                    <tr>
                      <td nowrap='nowrap'>Ir a la inscripción: &#160;<input id="txtGoToRecording" name="txtGoToRecording" type="text" class="textBox" maxlength="5" style="width:35px;margin-right:0px" onkeypress="return integerKeyFilter(this);" runat="server" /></td>
                      <td nowrap='nowrap'><img src="../themes/default/buttons/search.gif" alt="" onclick="return doOperation('gotoRecording')" title="Ejecuta la búsqueda" /></td>
                      <td width='88px' nowrap='nowrap'>&#160;</td>
                      <td><img src='../themes/default/buttons/first.gif' onclick='doOperation("moveToRecording", "First");' title='Muestra la primera inscripción' alt='' /></td>
                      <td><img src='../themes/default/buttons/previous.gif' onclick='doOperation("moveToRecording", "Previous");' title='Muestra la inscripción anterior' alt='' /></td>
                      <td><img src='../themes/default/buttons/next.gif' onclick='doOperation("moveToRecording", "Next");' title='Muestra la siguiente inscripción' alt='' /></td>
                      <td><img src='../themes/default/buttons/last.gif' onclick='doOperation("moveToRecording", "Last");' title='Muestra la última inscripción' alt='' /></td>
                      <td width='48px' nowrap='nowrap'>&#160;</td>
                      <td nowrap='nowrap'>
                      <input type="button" value="Actualizar" class="button" style="width:68px" onclick='doOperation("refresh")' />
                      &#160;&#160;&#160;&#160;&#160;
                      <input type="button" value="Nueva inscripción" class="button" style="width:108px" onclick='doOperation("newRecording")' /></td>												
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
             <!-- tabStripItemView_0 !-->

            <table id="tabStripItemView_1" class="editionTable" style="display:none;">
              <tr>
                <td class="lastCell">
                  <iframe id="ifraItemEditor" style="z-index:99;left:0px;top:0px;"
                          marginheight="0" marginwidth="0" frameborder="0" scrolling="no"
                          src="" width="670px" height="1200px" visible="false" >
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
                      <td class="lastCell">&#160;</td>
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
                      <td class="lastCell">&#160;</td>
                    </tr>
                    <tr>
                      <td>
                        <span class="leftItem"><%=recordingBook.Recordings.Count%> inscripciones registradas.</span>
                        <span class="rightItem">Página
                        <select class="selectBox" id="cboRecordingViewerPage" name="cboRecordingViewerPage"
                                style="width:45px" runat="server" onchange="doOperation('refreshRecordingViewer')" >
                        </select>de <%=RecordingViewerPages()%>&#160;</span>
                      </td>
                      <td class="lastCell">&#160;</td>
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
<iframe id="ifraCalendar" style="z-index:99;visibility:hidden;position:relative; width:225px;  height:160px;"    
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
      case 'saveRecording':
        success = saveRecording();
        break;
      case 'appendRecordingAct':
        success = appendRecordingAct();
        break;
      case 'newRecording':
        success = true;
        break;
      case 'changeRecordingAct':
        changeRecordingActType(arguments[1], arguments[2]);
        return;
      case 'editRecordingAct':
        editRecordingAct(arguments[1]);
        return;
      case 'editResource':
        editProperty(arguments[1], arguments[2]);
        return;
      case 'deleteRecordingAct':
        deleteRecordingAct(arguments[1], arguments[2]);
        return;
      case 'deleteRecordingActProperty':
        deleteRecordingActProperty(arguments[1], arguments[2]);
        return;
      case 'selectRecordingActOperation':
        alert("Requiero se seleccione una operación de la lista.");
        return;
      case 'refresh':
        sendPageCommand(command);
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
      case "onclick_editRecordingForEdition":
        onclick_editRecordingForEdition();
        return;
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

  function displayImageSet() {
    var newURL = "./image.set.viewer.aspx?id=<%=base.imageSet.Id%>&gotoImage=<%=Math.Max(base.recording.StartImageIndex - 1, 0)%>";

    var clone = getElement("documentViewer").cloneNode(true);
    clone.setAttribute('data', newURL);

    var parent = getElement("documentViewer").parentNode;

    parent.removeChild(getElement("documentViewer"));
    parent.appendChild(clone);
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


  function saveRecording() {
    if (!validateRecordingStep1()) {
      return false;
    }
    if (!validateRecordingStep2()) {
      return false;
    }
    var sMsg = "Guardar la inscripción.\n\n";

    sMsg += getRecordingDataForm();
    sMsg += "¿Guardo los cambios efectuados en esta inscripción?";

    return confirm(sMsg);
  }

  function appendRecordingAct() {
    if (!validateRecordingAct()) {
      return false;
    }
    if (!validateRecordingSemantics()) {
      return false;
    }
    var sMsg = "Agregar un acto jurídico vigente\n\n";

    sMsg += "Esta operación agregará el siguiente acto jurídico a esta inscripción:\n\n";

    sMsg += "Libro:\t\t<%=recordingBook.AsText%>\n";
    sMsg += "Inscripción:\t" + getElement('txtRecordingNumber').value +
    getElement('cboBisRecordingNumber').value + "\n\n";

    sMsg += "Acto jurídico:\t" + getComboOptionText(getElement('cboRecordingActType')) + "\n";
    sMsg += "Predio:\t\t" + getComboOptionText(getElement('cboProperty')) + "\n";
    if (getElement('cboProperty').value == "-1") {
      sMsg += "Folio:\t\t" + getComboOptionText(getElement('cboAnotherProperty')) + "\n\n";
    } else {
      sMsg += "\n";
    }
    <% if (base.recording.Status == RecordableObjectStatus.Obsolete) { %>
    sMsg += "IMPORTANTE: La inscripción pasará de estado No vigente a Incompleta.\n\n";
    <% } %>
    sMsg += "¿Agrego el acto jurídico a la inscripción " + getElement('txtRecordingNumber').value +
              getElement('cboBisRecordingNumber').value + "?";
    return confirm(sMsg);
  }

  function editProperty(propertyId, recordingActId) {	
    var oEditor = getElement("ifraItemEditor");

    oEditor.src = "real.estate.editor.aspx?propertyId=" + propertyId + "&recordingActId=" + recordingActId;

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

  function deleteRecording() {	
    <% if (!Empiria.ExecutionServer.CurrentPrincipal.IsInRole("BatchCapture.Supervisor")) { %>
      showNotAllowedMessage();
      return false;
    <% } %>
    <% if (recording.RecordingActs.Count > 0) { %>
      alert("No puedo eliminar esta inscripción ya que contiene actos jurídicos.");
      return false;
    <% } %>

    var sMsg = "Eliminar la inscripción del libro registral.\n\n";		
    sMsg += "Esta operación eliminará la siguiente inscripción contenida en este libro registral:\n\n";				
    sMsg += "Libro:\t\t<%=recordingBook.AsText%>\n";
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
    <% if (!Empiria.ExecutionServer.CurrentPrincipal.IsInRole("BatchCapture.Supervisor")) { %>
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
    <% if (!Empiria.ExecutionServer.CurrentPrincipal.IsInRole("BatchCapture.Supervisor")) { %>
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

  function changeRecordingActType(recordingActId, propertyId) {
    if (getElement('cboRecordingActType').value == '') {
      alert("Para modificar este acto jurídico, se debe seleccionar de la lista de actos jurídicos el nuevo tipo de acto.");
      return false;
    }

    var sMsg = "Modificar el tipo del acto jurídico.\n\n";		
    sMsg += "Esta operación modificará el tipo del siguiente acto jurídico:\n\n";

    sMsg += "Libro:\t\t<%=recordingBook.AsText%>\n";
    sMsg += "Inscripción:\t" + getElement('txtRecordingNumber').value +
            getElement('cboBisRecordingNumber').value + "\n\n";
    sMsg += "Nuevo tipo:\t" + getComboOptionText(getElement('cboRecordingActType')) + "\n\n";

    sMsg += "¿Modifico el acto jurídico?";
    if (confirm(sMsg)) {
      sendPageCommand("changeRecordingActType", "recordingActId=" + recordingActId);
      return;
    }
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
    url += "&recordingNumber=" + getElement("txtRecordingNumber").value + getElement("cboBisRecordingNumber").value;
    url += "&imageStartIndex=" + getElement("txtImageStartIndex").value;
    url += "&imageEndIndex=" + getElement("txtImageEndIndex").value;
    url += "&presentationTime=" + getElement("txtPresentationDate").value + " " + getElement("txtPresentationTime").value;
    url += "&authorizationDate=" + getElement("txtAuthorizationDate").value;
    url += "&authorizedById=" + getElement("cboAuthorizedBy").value;

    return invokeAjaxValidator(url);
  }

  function updateUserInterface(oControl) {
    if (oControl == null) {
      return;
    }
    if (oControl == getElement("cboRecordingActTypeCategory")) {
      resetRecordingsTypesCombo();
    } else if (oControl == getElement("cboProperty")) {
      onPropertyComboChanged();
    } else if (oControl == getElement("chkCreatePartition")) {
      showPartitionSection();
    } else if (oControl == getElement("cboRecordingMode")) {
      onRecordingModeComboChanged();
    } else if (oControl == getElement("cboAnotherRecorderOffice")) {
      resetAnotherRecordingBooksCombo();
    } else if (oControl == getElement("cboAnotherRecordingBook")) {
      resetAnotherRecordingsCombo();
    } else if (oControl == getElement("cboAnotherRecording")) {
      resetAnotherPropertiesCombo();
    } else if (oControl == getElement("cboRecordingType")) {
      <%=oRecordingDocumentEditor.ClientID%>_updateUserInterface(getComboSelectedOption("cboRecordingType").title);
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

  function onRecordingModeComboChanged() {
    getElement("rowRegisterInAnotherSection").style.display = "none";
    getElement("rowRegisterOnMargin").style.display = "none";

    if (getElement("cboRecordingMode").value == "this") {

    } else if (getElement("cboRecordingMode").value == "marginal") {
      getElement("rowRegisterOnMargin").style.display = "table-row";
    } else if (getElement("cboRecordingMode").value == "otherRecording") {
      getElement("rowRegisterInAnotherSection").style.display = "table-row";
    }
  }

  function onPropertyComboChanged() {
    if (getElement("cboProperty").value == "0") {
      getElement("chkCreatePartition").disabled = true;
    } else {
      getElement("chkCreatePartition").disabled = false;
    }
  }

  function showPartitionSection() {
    if (getElement("chkCreatePartition").checked) {
      getElement("rowPartitionSection").style.display = "table-row";
    } else {
      getElement("rowPartitionSection").style.display = "none";
    }
  }

  function resetRecordingsTypesCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getRecordingTypesStringArrayCmd";
    url += "&recordingActTypeCategoryId=" + getElement("cboRecordingActTypeCategory").value;

    invokeAjaxComboItemsLoader(url, getElement("cboRecordingActType"));
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
    if (!<%=oRecordingDocumentEditor.ClientID%>_validate(getElement("txtPresentationDate").value)) {
      return false;
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

  function setPageTitle() {
    <% if (recording.IsNew) { %>
      s = "Nueva partida";
    <% } else { %>
      s = "Partida <%=recording.Number %>";
    <% } %>
    setInnerText(getElement("spanCurrentImage"), s);
  }

  function getCurrentImage() {
    // TODO: Get current image from imageviewer control
    //return Number(Number(getElement("hdnCurrentImagePosition").value) + 1);
  }

  function pickCurrentImage(controlName) {
    <% if (base.DisplayImages()) { %>
      //getElement(controlName).value = getCurrentImage();
    <% } %>
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
    ajaxURL += "&recordingNumber=" + getElement("txtGoToRecording").value;

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

  function getRecordingDataForm() {
    var sMsg = "";

    sMsg += "Libro:\t\t<%=recordingBook.AsText%>\n";
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

  function window_onload() {
    displayImageSet();
    setWorkplace2();
    setPageTitle();
    <% if (recording.IsNew) { %>
      getElement("rowEditButtons").style.display = 'table-row';
      getElement("rowRecordingActsTitle").style.display = 'none'
      getElement("rowRecordingActsGridAndEditor").style.display = 'none';
      getElement("rowRecordingNavigationControl").style.display = 'none';

      showRecordingForEdition(true);
    <% } else { %>
      getElement("rowEditButtons").style.display = 'table-row';
      getElement("rowRecordingActsTitle").style.display = 'table-row';
      getElement("rowRecordingActsGridAndEditor").style.display = 'table-row';
      getElement("rowRecordingNavigationControl").style.display = 'table-row';
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
      divBody.style.height = height + "px";
      divContent.style.height = (height - 18) + "px";
      divImageContainer.style.height = (height - 78) + "px";
    }
    if (width > 28) {
      divContent.style.width = (width - 28) + "px";
    }
    if (((width - 700) - 38) > 700) {
      divImageContainer.style.width = ((width - 700) - 38) + "px";
    } else {
      divImageContainer.style.width = 672 + "px";
    }
  }

  function window_onresize() {
    ifraItemEditor_onresize();
    window_onscroll();
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

  function ifraItemEditor_onresize() {
    return;
    var oFrame = getElement("ifraItemEditor");
    var oBody = oFrame.document.body;

    var newHeight = oBody.scrollHeight + oBody.clientHeight;

    if (newHeight <= 1200) {
      oFrame.style.height = 1200;
    } else {
      oFrame.style.height = newHeight;
    }
  }

  addEvent(window, 'load', window_onload);
  addEvent(window, 'resize', window_onresize);
  addEvent(getElement('divContent'), 'scroll', window_onscroll);
  addEvent(getElement("ifraItemEditor"), 'resize', ifraItemEditor_onresize);

  /* ]]> */
  </script>
</html>
