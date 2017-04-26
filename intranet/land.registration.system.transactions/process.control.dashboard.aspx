
<%@ Page Language="C#" EnableViewState="true" ViewStateMode="Disabled" EnableSessionState="true" MasterPageFile="~/workplace/dashboard.master" Inherits="Empiria.Land.WebApp.ProcessControlDashboard" CodeFile="process.control.dashboard.aspx.cs" %>
<%@ Import Namespace="Empiria.Land.WebApp" %>
<asp:Content ID="dashboardItem" ContentPlaceHolderID="dashboardItemPlaceHolder" runat="Server" EnableViewState="true">
<table id="tblDashboardMenu" class="tabStrip" style='display:<%=base.ShowTabStripMenu ? "inline" : "none"%> '>
  <tr>
    <td id="tabStripItem_0" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 0);" title="">Mis trámites pendientes</td>
    <td id="tabStripItem_1" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 1);" title="">Documentos por entregar</td>
    <td id="tabStripItem_2" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 2);" title="">Mi trabajo realizado</td>
    <td id="tabStripItem_3" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 3);" title="">Recibir documentos</td>
    <td id="tabStripItem_4"  style='display:<%=Empiria.ExecutionServer.CurrentPrincipal.IsInRole("LRSTransaction.DeliveryDesk") ? "inline" : "none"%>  class:"tabOff"' onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 4);" title="">Ventanilla de entregas</td>
    <td id="tabStripItem_5" style='display:<%=Empiria.ExecutionServer.CurrentPrincipal.IsInRole("LRSTransaction.ControlDesk") ? "inline" : "none"%> class:"tabOff"' onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 5);" title="">Mesa de control</td>
    <td id="tabStripItem_6" style='display:<%=Empiria.ExecutionServer.CurrentPrincipal.IsInRole("LRSTransaction.DigitalizationDesk") ? "inline" : "none"%> class:"tabOff"' onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 6);" title="">Mesa de digitalización</td>
    <td id="tabStripItem_7" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 7);" title="">Buscar trámites</td>
    <td  class="tabEmpty">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</td>
    <td  class="tabEmpty"><input id="currentTabStripItem" name="currentTabStripItem" type="hidden" /></td>
  </tr>
</table>

<div class="dashboardWorkarea">
  <table id="tblDashboardOptions" style="width:100%;">
    <tr>
      <td nowrap="nowrap">Trámite:</td>
      <td nowrap="nowrap">
				<select id="cboProcessType" class="selectBox" style="width:176px" runat="server" onchange="doOperation('updateUserInterface', this);">
          <option value=''>( Todos los trámites )</option><option value='699'>Avisos preventivos y definitivos</option><option value='700'>Inscripción de documentos</option><option value='702'>Expedición de certificados</option>
          <option value='707'>Procede</option><option value='704'>Trámite Comercio</option><option value='705'>Archivo General de Notarías</option><option value='706'>Oficialía de partes</option>
				</select>
        <span style="display:<%=!base.IsTabStripSelected(TabStrip.MesaDeControl) ? "inline" : "none" %>">
          <a href="javascript:doOperation('createLRSTransaction')"><img src="../themes/default/buttons/go.button.png" alt=""
           title="Registra un nuevo trámite ante la Oficina del Registro Público de la Propiedad" />Registrar nuevo trámite</a>
        </span>
        <span style="display:<%=base.IsTabStripSelected(TabStrip.MesaDeControl) ? "inline" : "none" %>">
				  <select id="cboResponsible" class="selectBox" style="width:168px" runat="server" onchange="doOperation('updateUserInterface', this);">
            <option value="">( Todos los responsables )</option>
				  </select>
        </span>
      </td>
      <td nowrap="nowrap">Buscar:</td>
			<td nowrap="nowrap">
        <select id="cboSearch" name="cboSearch" class="selectBox" style="width:152px" runat="server">
          <option value="">Todos los campos</option>
          <option value="TransactionUID">Número de trámite</option>
          <option value="DocumentUID">Número de documento</option>
          <option value="ReceiptNo">Número de boleta</option>
          <option value="ImagingControlID">No de control de acervo</option>
          <option value="DocumentDescriptor">Instrumento</option>
        </select>

        <input id="txtSearchExpression" name="txtSearchExpression" class="textBox" onkeypress="return searchTextBoxKeyFilter(window.event);"
               type="text" tabindex="-1" maxlength="80" style="width:204px" runat="server" />

        <img src="../themes/default/buttons/search.gif" alt="" onclick="doOperation('loadData')" title="Ejecuta la búsqueda" />
       &#160;&#160;&#160;&#160;
        <a href="javascript:doOperation('removeFilters')">Quitar los filtros</a>
       &#160;&#160;&#160;&#160;
        <%  if (base.IsTabStripSelected(TabStrip.MesaDeDigitalizacion) &&
                Empiria.ExecutionServer.CurrentPrincipal.IsInRole("LRSTransaction.DigitalizationDesk")) { %>
        <a href="javascript:doOperation('processDocumentImages')">
        <img src="../themes/default/bullets/scribble_doc_sm.gif" alt="" title="" style="margin-right:8px" />Procesar imágenes</a>&#160;&#160;&#160;
        <% } %>
      </td>
     <td width="80%">&#160;</td>
    </tr>
    <tr>
      <td nowrap="nowrap">Fecha:</td>
      <td nowrap="nowrap">
        <select id="cboDate" name="cboDate" class="selectBox" onchange="doOperation('updateUserInterface', this);" style="width:98px" runat="server">
          <option value="">No filtrar</option>
          <option value="PresentationTime">Presentación</option>
          <option value="AuthorizationTime">Registro</option>
          <option value="LastDeliveryTime">Entrega</option>
        </select>
        Del:
        <input type="text" class="textBox" id='txtFromDate' name='txtFromDate' style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
        <img id='imgFromDate' style="margin-left:-8px" src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(event, getElement('<%=txtFromDate.ClientID%>'), getElement('imgFromDate'), '255px');" title="Despliega el calendario" alt="" />
        al:
        <input type="text" class="textBox" id='txtToDate' name='txtToDate' style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
        <img id='imgToDate' style="margin-left:-8px" src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(event, getElement('<%=txtToDate.ClientID%>'), getElement('imgToDate'), '355px');" title="Despliega el calendario" alt="" />
          <a href="javascript:doOperation('setTodayDate')">Hoy</a>
      </td>
      <td nowrap="nowrap">
        Distrito:
      </td>
      <td nowrap="nowrap" colspan="4">
        <select id="cboRecorderOffice" name="cboRecorderOffice" class="selectBox" onchange="doOperation('updateUserInterface', this);" style="width:152px" runat="server">
				  <option value="">( Todos )</option>
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
        <span style="display:<%=base.IsTabStripSelected(TabStrip.RecibirDocumentos) ? "inline" : "none" %>">
           Origen:
           <select id="cboFrom" name="cboFrom" class="selectBox" onchange="doOperation('updateUserInterface', this);" style="width:200px" runat="server">
            <option value="">( ¿Quién le está entregando? )</option>
          </select>
        </span>
        <span style="display:<%=!base.IsTabStripSelected(TabStrip.RecibirDocumentos) ? "inline" : "none" %>">
         Estado:
         <select id="cboStatus" name="cboStatus" class="selectBox" onchange="doOperation('updateUserInterface', this);" style="width:170px" runat="server">
          <option value="(TransactionStatus <> 'X')">( Todos los no eliminados )</option>
          <option value="(TrackStatus <> 'C' AND TransactionStatus NOT IN('X','Y','D','L','H','Q','C'))">Trámites en proceso</option>
          <option value="(TrackStatus = 'C' AND TransactionStatus <> 'X')">Trámites concluidos</option>
          <option value="(LastReentryTime <> '2078-12-31' AND TrackStatus <> 'C' AND TransactionStatus <> 'X')">Reingresos en proceso</option>
          <option value="(ImagingControlID <> '')">Con Núm de control documental</option>
          <option value="(ImagingControlID = '' AND TransactionStatus IN ('A','D','C'))">Sin Núm de control documental</option>
          <option value="">- - - - - - - - - - - - - - - - - - - - -</option>
          <option value="(TransactionStatus = 'Y')">Calificación</option>
          <option value="(TransactionStatus = 'K')">En mesa de control</option>
          <option value="(TransactionStatus = 'R')">Trámite recibido</option>
          <option value="(TransactionStatus = 'G')">Registro en libros</option>
          <option value="(TransactionStatus = 'E')">Elaboración</option>
          <option value="(TransactionStatus = 'J')">En área jurídica</option>
          <option value="(TransactionStatus = 'V')">Revisión</option>
          <option value="(TransactionStatus = 'S')">En firma</option>
          <option value="(TransactionStatus = 'A')">Digitalización y resguardo</option>
          <option value="(TransactionStatus IN ('D','L'))">Por entregar o devolver</option>
          <option value="(TransactionStatus IN ('C','Q'))">Entregados y devueltos al interesado</option>
          <option value="(TransactionStatus = 'H')">Trámite archivado</option>
          <option value="(TransactionStatus = 'X')">Trámite eliminado</option>
        </select>
        </span>
        Tiempo:
        <select id="cboElapsedTime" class="selectBox" style="width:90px" runat="server" onchange="doOperation('updateUserInterface', this);">
          <option value=''>(Todos)</option>
          <option value='(WorkingTime <= 86400*3)'><= 3 días</option>
          <option value='(WorkingTime >= 86400*3)'>>= 3 días</option>
          <option value='(WorkingTime <= 86400*5)'><= 5 días</option>
          <option value='(WorkingTime >= 86400*5)'>>= 5 días</option>
          <option value='(WorkingTime <= 86400*10)'><= 10 días</option>
          <option value='(WorkingTime >= 86400*10)'>>= 10 días</option>
          <option value='(WorkingTime <= 86400*15)'><= 15 días</option>
          <option value='(WorkingTime >= 86400*15)'>>= 15 días</option>
          <option value='(WorkingTime <= 86400*20)'><= 20 días</option>
          <option value='(WorkingTime >= 86400*20)'>>= 20 días</option>
          <option value='(WorkingTime >= 86400*25)'>>= 25 días</option>
          <option value='(WorkingTime >= 86400*30)'>>= 30 días</option>
          <option value='(WorkingTime >= 86400*40)'>>= 40 días</option>
          <option value='(WorkingTime >= 86400*50)'>>= 50 días</option>
        </select>
       &#160;&#160;
        <a href="javascript:doOperation('showUniversalSearcher')">
                <img src="../themes/default/bullets/agenda_sm.gif" alt="" title="" style="margin-right:8px" />Consultar el acervo</a>&#160;&#160;&#160;
        <a href="javascript:doOperation('showSearchRecordingsView')">
                <img src="../themes/default/bullets/agenda_sm.gif" alt="" title="" style="margin-right:8px" />Información registral (anterior)</a>&#160;&#160;&#160;
        <%--<a href="../land.registration.system/recording.book.analyzer.aspx?bookId=1339" target="_blank">capt hist</a>--%>
      </td>
    </tr>
  </table>
  <div id="divObjectExplorer" class="dataTableContainer">
    <table>
      <asp:Repeater id="itemsRepeater" runat="server" EnableViewState="False"></asp:Repeater>
    </table>
  </div>
  <%=base.NavigationBarContent()%>
</div>
<script type="text/javascript">
    /* <![CDATA[ */
    function doOperation(operationName) {
        switch (operationName) {
            case 'loadData':
                loadData();
                return;
            case 'createObject':
                createObject();
                return;
            case 'doControlDeskOperation':
                doControlDeskOperation(arguments[1]);
                return;
            case 'createLRSTransaction':
                createLRSTransaction();
                return;
            case 'receiveLRSTransaction':
                receiveLRSTransaction();
                return;
            case 'takeLRSTransaction':
                takeLRSTransaction(arguments[1]);
                return;
            case 'returnDocumentToMe':
                returnDocumentToMe(arguments[1]);
                return;
            case 'printOnSignReport':
                printOnSignReport();
                return;
            case 'setTodayDate':
                setTodayDate();
                return;
            case 'receiveDocuments':
                receiveLRSDocuments(arguments[1]);
                break;
            case 'executeWorkflowTask':
                executeWorkflowTask(arguments[1], arguments[2]);
                return;
            case 'editTransaction':
                showTransactionEditor(arguments[1]);
                return;
            case 'removeFilters':
                removeFilters();
                return;
            case 'showUniversalSearcher':
                showUniversalSearcher();
                return;
            case 'showSearchRecordingsView':
                showSearchRecordingsView();
                return;
            case 'updateUserInterface':
                updateUserInterface(arguments[1]);
                return;
            case 'generateImagingControlID':
                generateImagingControlID(arguments[1], arguments[2]);
                return;
            case 'viewDocumentImaging':
                viewDocumentImaging(arguments[1]);
                return;
            case 'processDocumentImages':
                processsDocumentImages();
                return;
            default:
                alert('La operación solicitada todavía no ha sido definida en el programa.');
                return;
        }
    }
    function generateImagingControlID(transactionId, documentId) {
        var sMsg = "Generar número de control documental\n\n";
        sMsg += "Trámite: \t     " + getInnerText('ancTransactionKey' + transactionId) + "\n";
        sMsg += "Interesado:     " + getInnerText('ancRequestedBy' + transactionId) + "\n";
        sMsg += "Instrumento:  " + getInnerText('ancInstrument' + transactionId) + "\n\n";
        sMsg += "¿Desea generar el número de control documental para el trámite indicado?";
        if (confirm(sMsg)) {
            var qs = "id=" + documentId;
            sendPageCommand("generateImagingControlID", qs);
        }
    }
    function viewDocumentImaging(documentId) {
        var url = "../land.registration.system/document.imaging.control.slip.aspx?id=" + documentId;
        createNewWindow(url);
    }
    function showSearchRecordingsView() {
        createNewWindow("<%=base.GetLegacyDataViewerUrl()%>");
    }
    var oUniversalSearcherWindow = null;
    function showUniversalSearcher() {
        oUniversalSearcherWindow = openInWindow(oUniversalSearcherWindow,
            '../land.registration.system/by.resource.analyzer.aspx', true);
    }
    function executeWorkflowTask(workflowTaskName, objectId) {
        alert(workflowTaskName + " " + objectId);
    }
    function createLRSTransaction() {
        if (getElement('<%=cboProcessType.ClientID%>').value.length == 0) {
          alert("Requiero se seleccione de la lista el tipo de trámite que se desea registrar.");
          return;
      }
      var source = "transaction.editor.aspx?";
      source += "id=0&typeId=" + getElement('<%=cboProcessType.ClientID%>').value;
        createNewWindow(source);
    }
    function printOnSignReport() {
        var source = "transaction.report.aspx";
        createNewWindow(source);
    }
    function receiveLRSTransaction(transactionId) {
        var sMsg = "Recepción del trámite por parte del interesado\n\n";
        sMsg += "Trámite: \t     " + getInnerText('ancTransactionKey' + transactionId) + "\n";
        sMsg += "Interesado:     " + getInnerText('ancRequestedBy' + transactionId) + "\n";
        sMsg += "Instrumento:  " + getInnerText('ancInstrument' + transactionId) + "\n\n";
        sMsg += "¿Está recibiendo los documentos de este trámite por parte del interesado?";
        if (confirm(sMsg)) {
            var qs = "id=" + transactionId;
            qs += "|notes=" + getElement("txtNotes" + transactionId).value;
            sendPageCommand("receiveLRSTransaction", qs);
        }
    }
    function setTodayDate() {
        getElement('<%=txtFromDate.ClientID%>').value = '<%=DateTime.Today.ToString("dd/MMM/yyyy")%>';
      getElement('<%=txtToDate.ClientID%>').value = '<%=DateTime.Today.ToString("dd/MMM/yyyy")%>';
    }
    function takeLRSTransaction(transactionId) {
        var nextStatus = getInnerText('ancNextStatusID' + transactionId);
        if (nextStatus == 'S') {
    <% if (!Empiria.ExecutionServer.CurrentPrincipal.IsInRole("LRSTransaction.DocumentSigner")) { %>
        alert("No tengo registrados los permisos necesarios para entregarle este documento.\n\nEl documento está marcado como 'Recibir para firma'.");
        return;
    <% } %>
    }
    if (nextStatus == 'K') {
    <% if (!Empiria.ExecutionServer.CurrentPrincipal.IsInRole("LRSTransaction.ControlDesk")) { %>
            alert("No tengo registrados los permisos necesarios para entregarle este documento.\n\nEl documento está marcado para recibirlo en mesa de control.\n\nSólo los responsables de la mesa de control pueden tomarlo.");
            return;
    <% } %>
    }
    if (nextStatus == 'A') {
    <% if (!Empiria.ExecutionServer.CurrentPrincipal.IsInRole("LRSTransaction.DocumentSafeguard")) { %>
            alert("No tengo registrados los permisos necesarios para entregarle este documento.\n\nEl documento está marcado para recibirlo en la mesa de digitalización y resguardo'.");
            return;
	 	<% } %>
        }
        if (nextStatus == 'D' || nextStatus == 'L') {
    <% if (!Empiria.ExecutionServer.CurrentPrincipal.IsInRole("LRSTransaction.DeliveryDesk")) { %>
            alert("No tengo registrados los permisos necesarios para entregarle este documento.\n\nEl documento ya está listo para entregarlo (o devolverlo) al interesado.\n\nSólo los responsables de ventanilla de entregas pueden tomarlo.");
            return;
    <% } %>
        }
        if (nextStatus == 'V') {
      <% if (!Empiria.ExecutionServer.CurrentPrincipal.IsInRole("LRSTransaction.QualityControl")) { %>
            alert("No tengo registrados los permisos necesarios para entregarle este documento.\n\nEste trámite está listo para enviarse al área de revisión.\n\nSólo el personal del área de revisión puede tomar este trámite.");
            return;
      <% } %>
        }
        if (nextStatus == 'J') {
      <% if (!Empiria.ExecutionServer.CurrentPrincipal.IsInRole("LRSTransaction.Juridic")) { %>
            alert("No tengo registrados los permisos necesarios para entregarle este documento.\n\nEste trámite está marcado para entregarse al área jurídica.");
            return;
      <% } %>
        }
        if (nextStatus == 'R' || nextStatus == 'C' || nextStatus == 'Q') {
            alert("No tengo registrados los permisos necesarios para entregarle este documento.\n\nEste trámite debe procesarse utilizando otra herramienta.");
            return;
        }
        var sMsg = "Recibir documentación.\n\n";
        sMsg += "Trámite: \t     " + getInnerText('ancTransactionKey' + transactionId) + "\n";
        sMsg += "Interesado:     " + getInnerText('ancRequestedBy' + transactionId) + "\n";
        sMsg += "Instrumento:  " + getInnerText('ancInstrument' + transactionId) + "\n\n";
        sMsg += "Estado actual:\t" + getInnerText('ancStatus' + transactionId) + "\n";
        sMsg += "Nuevo estado:\t" + getInnerText('ancNextStatus' + transactionId) + "\n\n";
        sMsg += "¿Está recibiendo los documentos del trámite referido?";
        if (confirm(sMsg)) {
            var qs = "id=" + transactionId;
            qs += "|notes=" + getElement("txtNotes" + transactionId).value;
            sendPageCommand("takeLRSTransaction", qs);
        }
    }
    function validateNextTransactionState(transactionId, newState) {
        var ajaxURL = "../ajax/land.registration.system.data.aspx";
        ajaxURL += "?commandName=validateNextTransactionStateCmd";
        ajaxURL += "&transactionId=" + transactionId + "&newState=" + newState;
        return invokeAjaxValidator(ajaxURL);
    }
    function doControlDeskOperation(transactionId) {
        var operation = getElement("cboOperation" + transactionId).value;
        var temp = "";
        switch (operation) {
            case "ReturnToControlDesk":
                temp = "Dejar pendiente el 'siguiente estado' de este trámite.\n\n";
                temp += "Este trámite ya tiene asignado el siguiente estado.\n\n" +
                    "Después de esta operación el trámite seguirá en mesa de control " +
                    "pero el siguiente estado quedará pendiente de asignar.\n\n";
                temp += "Trámite: \t     " + getInnerText('ancTransactionKey' + transactionId) + "\n";
                temp += "Interesado:     " + getInnerText('ancRequestedBy' + transactionId) + "\n";
                temp += "Instrumento:  " + getInnerText('ancInstrument' + transactionId) + "\n";
                temp += "Sig. estado:  " + getInnerText('ancNextStatus' + transactionId) + "\n\n";
                temp += "¿Dejo pendiente el siguiente estado de este trámite?";
                break;
            case "ReceiveInControlDesk":
                var responsible = getInnerText('ancResponsible' + transactionId);
                temp = "Recibir el trámite en la mesa de control.\n\n";
                temp += "Este trámite se recibirá en la mesa de control.\n\n" +
                    "Se supone que " + responsible + " le está entregando físicamente los documentos de dicho trámite, " +
                    "de lo contrario no debería ejecutar esta operación.\n\n";
                temp += "Trámite: \t     " + getInnerText('ancTransactionKey' + transactionId) + "\n";
                temp += "Interesado:     " + getInnerText('ancRequestedBy' + transactionId) + "\n";
                temp += "Instrumento:  " + getInnerText('ancInstrument' + transactionId) + "\n\n";
                temp += "¿Recibir el trámite en mesa de control?";
                break;
            case "PullToControlDesk":
                var responsible = getInnerText('ancResponsible' + transactionId);
                temp = "Traer el trámite a la mesa de control.\n\n";
                temp += "Este trámite se traerá a la mesa de control.\n\n" +
                    "Se supone que " + responsible + " NO está laborando y que dejó este trámite en su bandeja de trabajo.\n\n" +
                    "Quien ejecuta esta operación debe tener físicamente los documentos de dicho trámite, " +
                    "y asegurarse que " + responsible + " NO está en la oficina, " +
                    "de lo contrario no debería ejecutar esta operación.\n\n";
                temp += "Trámite: \t     " + getInnerText('ancTransactionKey' + transactionId) + "\n";
                temp += "Interesado:     " + getInnerText('ancRequestedBy' + transactionId) + "\n";
                temp += "Instrumento:  " + getInnerText('ancInstrument' + transactionId) + "\n";
                temp += "Fuera de la oficina:  " + responsible + "\n\n";
                temp += "¿Recibir el trámite de la persona que NO está laborando?";
                break;
            case "Unarchive":
                temp = "Desarchivar este trámite.\n\n" +
                    "Este trámite se encuentra archivado.\n\n" +
                    "Si tiene permisos, en el editor de trámites debe existir una opción para desarchivarlo.\n\n";
                alert(temp);
                return;
            case "Nothing":
                temp = "Por ahora no hay nada qué hacer con este trámite.\n\n" +
                    "El trámite se encuentra en un estado que no permite enviarlo " +
                    "o recibirlo en la mesa de control.";
                alert(temp);
                return;
            case "Undefined":
                temp = "Operación del tipo 'Undefined' en la mesa de control.\n\n" +
                    "Esto representa un problema de programación en las reglas del sistema.\n\n" +
                    "Favor de avisar esta situación a soporte lo antes posible.";
                alert(temp);
                return;
            default:
                return doTransactionOperation(transactionId);
        }
        if (confirm(temp)) {
            var qs = "id=" + transactionId;
            qs += "|operation=" + operation;
            qs += "|notes=" + getElement("txtNotes" + transactionId).value;
            sendPageCommand("executeControlDeskOperation", qs);
        }
    }
    function doTransactionOperation(transactionId) {
        var newState = getElement("cboOperation" + transactionId).value;
        if (newState == "") {
            alert("Requiero se seleccione el nuevo estado del trámite");
            return;
        }
        if (!validateNextTransactionState(transactionId, newState)) {
            return;
        }
        var temp = "";
        if (newState == "R") {
            return receiveLRSTransaction(transactionId);
        } else if (newState == "P") {
            temp = "Enviar este trámite a otra mesa de trabajo.\n\n";
            temp += "Trámite: \t     " + getInnerText('ancTransactionKey' + transactionId) + "\n";
            temp += "Interesado:     " + getInnerText('ancRequestedBy' + transactionId) + "\n";
            temp += "Instrumento:  " + getInnerText('ancInstrument' + transactionId) + "\n\n";
            temp += "¿Preparo este trámite para enviarlo a otra mesa de trabajo?";
        } else if (newState == "S") {
            temp = "Enviar trámite a firma\n\n";
            temp += "Trámite: \t     " + getInnerText('ancTransactionKey' + transactionId) + "\n";
            temp += "Interesado:     " + getInnerText('ancRequestedBy' + transactionId) + "\n";
            temp += "Instrumento:  " + getInnerText('ancInstrument' + transactionId) + "\n\n";
            temp += "¿El trámite está listo para firma?";
        } else if (newState == "A") {
            temp = "Enviar trámite a la mesa de digitalización y resguardo de documentos.\n\n";
            temp += "Trámite: \t     " + getInnerText('ancTransactionKey' + transactionId) + "\n";
            temp += "Interesado:     " + getInnerText('ancRequestedBy' + transactionId) + "\n";
            temp += "Instrumento:  " + getInnerText('ancInstrument' + transactionId) + "\n\n";
            temp += "¿El trámite está revisado, firmado y listo para enviarse a la mesa de digitalización y resguardo de documentos?";
        } else if (newState == "D") {
            temp = "Enviar trámite a mesa de entrega\n\n";
            temp += "¿El trámite está listo para entregarlo al interesado?";
        } else if (newState == "C") {
            temp = "Entregar el trámite al interesado\n\n";
            temp += "Trámite: \t     " + getInnerText('ancTransactionKey' + transactionId) + "\n";
            temp += "Interesado:     " + getInnerText('ancRequestedBy' + transactionId) + "\n";
            temp += "Instrumento:  " + getInnerText('ancInstrument' + transactionId) + "\n\n";
            temp += "¿Se está entregando el trámite al interesado?";
        } else if (newState == "L") {
            temp = "Devolver el trámite al interesado, ya que no procede\n\n";
            temp += "Trámite: \t     " + getInnerText('ancTransactionKey' + transactionId) + "\n";
            temp += "Interesado:     " + getInnerText('ancRequestedBy' + transactionId) + "\n";
            temp += "Instrumento:  " + getInnerText('ancInstrument' + transactionId) + "\n\n";
            temp += "¿Se va a devolver el trámite al interesado?";
        } else if (newState == "H") {
            temp = "Archivar este trámite\n\n";
            temp += "Trámite: \t     " + getInnerText('ancTransactionKey' + transactionId) + "\n";
            temp += "Interesado:     " + getInnerText('ancRequestedBy' + transactionId) + "\n";
            temp += "Instrumento:  " + getInnerText('ancInstrument' + transactionId) + "\n\n";
            temp += "¿Marco este trámite como archivado? (Ya no será posible hacerle cambios)";
        } else if (newState == "X") {
            temp = "Eliminar este trámite\n\n";
            temp += "Trámite: \t     " + getInnerText('ancTransactionKey' + transactionId) + "\n";
            temp += "Interesado:     " + getInnerText('ancRequestedBy' + transactionId) + "\n";
            temp += "Instrumento:  " + getInnerText('ancInstrument' + transactionId) + "\n\n";
            temp += "¿Elimino este trámite en forma definitiva?";
        } else {
            temp = "Enviar este trámite a otra parte del proceso:\n\n";
            temp += "Trámite: \t     " + getInnerText('ancTransactionKey' + transactionId) + "\n";
            temp += "Interesado:     " + getInnerText('ancRequestedBy' + transactionId) + "\n";
            temp += "Instrumento:  " + getInnerText('ancInstrument' + transactionId) + "\n\n";
            temp += "¿Muevo este trámite al estado seleccionado?";
        }
        if (confirm(temp)) {
            var qs = "id=" + transactionId;
            qs += "|state=" + newState;
            qs += "|notes=" + getElement("txtNotes" + transactionId).value;
            sendPageCommand("changeTransactionStatus", qs);
        }
    }
    function returnDocumentToMe(transactionId) {
        var sMsg = "Regresar trámite a mi bandeja de pendientes\n\n";
        sMsg += "¿Regreso el documento a la bandeja de trámites pendientes?";
        if (confirm(sMsg)) {
            sendPageCommand("returnDocumentToMe", "id=" + transactionId);
        }
    }
    function processsDocumentImages() {
        var sMsg = "Esta operación procesará las imágenes pendientes de incorporar en el sistema.\n\n";
        sMsg += "Dependiendo del número de imágenes, el proceso puede tardar varios minutos, incluso horas.\n\n";
        sMsg += "¿Proceso las imágenes pendientes?";
        if (confirm(sMsg)) {
            sendPageCommand("processsDocumentImages");
        }
    }
    function showTransactionEditor(transactionId) {
        var source = "transaction.editor.aspx?";
        source += "id=" + transactionId;
        createNewWindow(source);
    }
    function createObject() {
        alert('La operación solicitada todavía no ha sido definida en el programa.');
        return false;
    }
    function loadData() {
        sendPageCommand("loadData");
    }
    function updateUserInterface(oSourceControl) {
        sendPageCommand("updateUserInterface");
    }
    function removeFilters() {
        getElement('<%=cboProcessType.ClientID%>').value = '';
      getElement('<%=cboDate.ClientID%>').value = '';
    getElement('<%=cboSearch.ClientID%>').value = '';
    getElement('<%=txtSearchExpression.ClientID%>').value = '';
    getElement('<%=txtFromDate.ClientID%>').value = '01/ene/2016';
    getElement('<%=txtToDate.ClientID%>').value = '<%=DateTime.Today.ToString("dd/MMM/yyyy")%>';
    getElement('<%=cboRecorderOffice.ClientID%>').value = '';
    getElement('<%=cboStatus.ClientID%>').value = '';
    getElement('<%=cboElapsedTime.ClientID%>').value = '';
    getElement('<%=cboResponsible.ClientID%>').value = '';
    }
  //var timeout = setTimeout("location.reload(true);", 300000);
	/* ]]> */
	</script>
</asp:Content>



