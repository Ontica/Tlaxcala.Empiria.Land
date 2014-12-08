<%@ Page Language="C#" EnableViewState="true"  EnableSessionState="true" MasterPageFile="~/workplace/dashboard.master" AutoEventWireup="true" Inherits="Empiria.Web.UI.LRS.DocumentDigitalizationDashboard" CodeFile="document.digitalization.dashboard.aspx.cs" %>
<%@ OutputCache Location="None" NoStore="true" %>
<%@ Import Namespace="Empiria.Presentation" %>
<%@ Import Namespace="Empiria.Land.UI" %>
<asp:Content ID="dashboardItem" ContentPlaceHolderID="dashboardItemPlaceHolder" runat="Server" EnableViewState="true">
<table id="tblDashboardMenu" class="tabStrip" style='display:<%=base.ShowTabStripMenu ? "inline" : "none"%>'>
  <tr>
    <td id="tabStripItem_0" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 0);" title="">Directorios pendientes</td>
    <td id="tabStripItem_1" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 1);" title="">Asignación de libros</td>
    <td id="tabStripItem_2" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 2);" title="">Libros en análisis y captura</td>
    <td id="tabStripItem_3" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 3);" title="">Libros en revisión de calidad</td>
    <td id="tabStripItem_4" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 4);" title="">Libros terminados</td>
    <td id="tabStripItem_5" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 5);" title="">Control de inscripciones</td>    
    <td>&nbsp; &nbsp; &nbsp; &nbsp;</td>
    <td><input id="currentTabStripItem" name="currentTabStripItem" type="hidden" /></td>
  </tr>
</table>
<div class="dashboardWorkarea">
  <table id="tblDashboardOptions" width="100%">
    <tr>
      <td nowrap="nowrap">Distrito:</td>
      <td>
				<select id="cboRecorderOffice" class="selectBox" style="width:150px" onchange="doOperation('updateUserInterface', this);" runat="server" >
				</select>
      </td>
      <% if (this.SelectedTabStrip >= 1) { %>
      <td nowrap="nowrap">Tipo:</td>
      <td>
				<select id="cboRecordingClass" class="selectBox" style="width:158px" onchange="doOperation('updateUserInterface', this);" runat="server" >
				</select>
      </td>
      <% } %>
      <% if (this.SelectedTabStrip == 5) { %>
      <td nowrap="nowrap">Volumen:</td>
      <td>
				<select id="cboBookVolume" class="selectBox" style="width:188px" onchange="doOperation('updateUserInterface', this);" runat="server" >
				</select>
      </td>
      <td nowrap="nowrap">Inscripciones:</td>
      <td>
				<select id="cboRecordingStatus" class="selectBox" style="width:98px" onchange="doOperation('updateUserInterface', this);" runat="server" >
          <option value=''>(Todas)</option>
          <option value='P'>Pendientes</option>
          <option value='L'>No legibles</option>
          <option value='I'>Vigentes</option>
          <option value='S'>No vigentes</option>
				</select>
      </td>
      <% } %>
      <% if (this.SelectedTabStrip != 5) { %>
      <td nowrap="nowrap">Buscar: </td>
      <td nowrap="nowrap">
        <input id="txtSearchExpression" name="txtSearchExpression" class="textBox" onkeypress="return searchTextBoxKeyFilter(window.event);"
               type="text" tabindex="-1" maxlength="80" style="width:140px" runat="server" />
      </td>
      <% } %>
      <td nowrap="nowrap">
        <img src="../themes/default/buttons/search.gif" alt="" onclick="return doOperation('loadData')" title="Ejecuta la búsqueda" />
      </td>
      <% if (this.SelectedTabStrip == 0 && Empiria.ExecutionServer.CurrentUserId == -3) { %>
      <td align="left" nowrap="nowrap">
					&nbsp; &nbsp; &nbsp;
					<a href="javascript:doOperation('processImagingDirectories');"
						title="Vuelve a leer todos los directorios con imágenes de libros para todos los Distritos" ><img src="../themes/default/buttons/go.button.png" alt=""/>Reprocesar directorios</a> &nbsp; &nbsp;
		  </td>
			<% } %>
      <td width="80%">&nbsp;</td>
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
      case 'processImagingDirectories':
				processImagingDirectories();
				return; 
      case 'createObject':
        createObject();
        return;
      case 'updateUserInterface':
        updateUserInterface(arguments[1]);
        return;
			case 'viewDirectoryImages':
        openDirectoryImagesViewer(arguments[1], false);
        return;
      case 'viewDirectoryLastImage':
        openDirectoryImagesViewer(arguments[1], true);
        return;
      case 'viewRecordingBook':
        openRecordingBookViewer(arguments[1]);
        return;
			case 'createRecordBookWithDirectory':
        createRecordBookWithDirectory(arguments[1]);
        return;
      case 'assignRecordingBook':
        assignRecordingBook(arguments[1]);
        return;
      case 'unassignRecordingBook':
        unassignRecordingBook(arguments[1]);
        return;
      case 'sendRecordingBookToLastAnalyst':
        sendRecordingBookToLastAnalyst(arguments[1]);
        return;
      case 'sendRecordingBookToQualityControl':
        sendRecordingBookToQualityControl(arguments[1]);
        return;         
      case 'updateRecordingsControlCount':
        updateRecordingsControlCount(arguments[1]);
        return;
      case 'updateRecordingsControlDates':
        updateRecordingsControlDates(arguments[1]);
        return; 
      case 'closeRecordingBook':
        closeRecordingBook(arguments[1]);
        return;
      default:
        alert('La operación \'' + operationName + '\' todavía no ha sido definida en el programa.');
        return;
    }
  }

	function openRecordingBookViewer(recordingBookId) {
		source = "recording.book.analyzer.aspx?"
		source += "bookId=" + recordingBookId;

		createNewWindow(source);
	}

	function assignRecordingBook(recordingBookId) {
		var oCboRecordingBookAnalyst = getElement("cboRecordingBookAnalyst" + recordingBookId);
		
		if (oCboRecordingBookAnalyst.value == "") {
			alert("Necesito conocer al analista al se le asignará este libro.");
			return;
		}
		var sMsg = "Asignación del libro registral para su análisis y captura histórica.\n\n";
		sMsg += "Esta operación asignará este libro registral al analista seleccionado,\n";
		sMsg += "y mientras el libro está en proceso de registro no podrá asignarse\n";
		sMsg += "a ningún otro usuario:\n\n";
		sMsg += "Libro registral:\t" + getInnerText("ancRecordingBook" + recordingBookId) + "\n";		
		sMsg += "Analista asignado:\t" + getComboOptionText(oCboRecordingBookAnalyst) + "\n\n";
		sMsg += "¿Asigno este libro al analista seleccionado?";
		if (confirm(sMsg)) {
			var queryString = "id=" + recordingBookId + "|";
			queryString += "analystId=" + oCboRecordingBookAnalyst.value + "|";
			queryString += "notes=" + getElement("txtNotes" + recordingBookId).value;
			sendPageCommand("assignRecordingBook", queryString);
		}
	}

	function unassignRecordingBook(recordingBookId) {
		var sMsg = "Dejar el libro registral sin analista asignado.\n\n";
		sMsg += "Esta operación dejará al analista actual sin ningún libro asignado,\n";
		sMsg += "y mientras no se le asigne un nuevo libro, el analista no podrá\n";
		sMsg += "efectuar trabajos de análisis jurídico:\n\n";
		sMsg += "Libro registral:\t" + getInnerText("ancRecordingBook" + recordingBookId) + "\n";		
		sMsg += "Analista actual:\t" + getInnerText("ancAssignedAnalyst" + recordingBookId) + "\n\n";
		sMsg += "¿Dejo este libro sin analista asignado?";
		if (confirm(sMsg)) {
			var queryString = "id=" + recordingBookId + "|";
			queryString += "notes=" + getElement("txtNotes" + recordingBookId).value;
			sendPageCommand("unassignRecordingBook", queryString);
		}
	}

	function sendRecordingBookToLastAnalyst(recordingBookId) {
		var sMsg = "Regresar este libro al área de análisis y captura.\n\n";
		sMsg += "Esta operación enviará este libro nuevamente al área de análisis\n";
		sMsg += "y captura para efectuar trabajos de corrección.\n\n";
		sMsg += "Libro registral:\t" + getInnerText("ancRecordingBook" + recordingBookId) + "\n";		
		sMsg += "Último analista:\t" + getInnerText("ancAssignedAnalyst" + recordingBookId) + "\n\n";
		sMsg += "¿Regresar este libro para su análisis y captura?";
		if (confirm(sMsg)) {
			var queryString = "id=" + recordingBookId + "|";
			queryString += "notes=" + getElement("txtNotes" + recordingBookId).value;
			sendPageCommand("sendRecordingBookToLastAnalyst", queryString);
		}
	}

	function sendRecordingBookToQualityControl(recordingBookId) {
		var sMsg = "Enviar el libro al área de control de calidad.\n\n";
		sMsg += "Esta operación enviará este libro al área de control de calidad,\n";
		sMsg += "por lo que a partir de ahora ya no podrán hacercele modificaciones\n";
		sMsg += "a menos que sea reasignado posteriormente:\n\n";
		sMsg += "Libro registral:\n" + getInnerText("ancRecordingBook" + recordingBookId) + "\n\n";
		sMsg += "¿Envío este libro al área de control de calidad?";
		if (confirm(sMsg)) {
			var queryString = "id=" + recordingBookId;
			sendPageCommand("sendRecordingBookToQualityControl", queryString);
		}
	}	
	
	
	function closeRecordingBook(recordingBookId) {
		if (getElement("txtCloseAuthorizationSign" + recordingBookId).value == "") {
			alert("Para efectuar esta operación requiero proporcione su firma electrónica.");
			return false;
		}
		var sMsg = "Cierre de libros registrales.\n\n";
		sMsg += "Esta operación cerrará el libro registral seleccionado, lo que significa\n";
		sMsg += "que el libro ya está concluido y que pasará a formar parte de los libros\n";
		sMsg += "de la Oficina del Registro Público correspondiente:\n\n";
		sMsg += "Libro registral:   " + getInnerText("ancRecordingBook" + recordingBookId) + "\n\n";
		sMsg += "¿Cierro el libro registral seleccionado?";
		if (confirm(sMsg)) {
			var queryString = "id=" + recordingBookId + "|";
			queryString += "esign=" + getElement("txtCloseAuthorizationSign" + recordingBookId).value + "|";			
			queryString += "notes=" + getElement("txtNotes" + recordingBookId).value;
			sendPageCommand("closeRecordingBook", queryString);
		}
	}
	
	function updateRecordingsControlCount(recordingBookId) {
		var controlRecordingsCount = getInnerText("ancRecordingsControlCount" + recordingBookId);
		var currentCapturedRecordingsCount = getInnerText("ancCurrentCapturedRecordingsCount" + recordingBookId);
		var newControlRecordingsCount = getElement("txtRecordingsControlCount" + recordingBookId).value;
				
		if (isEmpty(getElement("txtRecordingsControlCount" + recordingBookId))) {
			alert("Necesito conocer el número de inscripciones de control del libro.");
			return false;
		}
		if (!isNumeric(getElement("txtRecordingsControlCount" + recordingBookId))) {
			alert("No reconozco el número de inscipciones de control proporcionado.");
			return false;
		}
		if (Number(newControlRecordingsCount) == Number(controlRecordingsCount)) {
			alert("El número de inscripciones de control proporcionado es igual al que ya tiene asignado este libro.");
			return false;
		}
		
		var sMsg = "";		
		if (Number(newControlRecordingsCount) < Number(currentCapturedRecordingsCount)) {
			sMsg = "El número de inscripciones proporcionado no puede ser menor que el\n";
			sMsg += "número de inscripciones que ya fueron registradas.\n\n";
			sMsg += "En su lugar, se deben eliminar las inscripciones del libro sobrantes.";
			alert(sMsg);
			return false;
		}
		if (Number(newControlRecordingsCount) == Number(currentCapturedRecordingsCount)) {
			sMsg = "El número de inscripciones proporcionado coincide con el número\n";
			sMsg += "de inscripciones que ya fueron registradas en el libro, por lo que no\n";
			sMsg += "se le podrán agregar nuevas inscripciones al mismo.\n\n";
			sMsg += "¿Es esto correcto?";
			if (!confirm(sMsg)) {
				return false;
			}
		}
		sMsg = "Modificar el número de inscripciones de control del libro\n\n";
		sMsg += "Esta operación modificará el número de inscripciones de control del\n"
		sMsg += "libro registral seleccionado:\n\n"
		sMsg += "Libro registral:   " + getInnerText("ancRecordingBook" + recordingBookId) + "\n";		
		sMsg += "Inscripciones de control:   " + newControlRecordingsCount + "\n\n";
		sMsg += "¿Modifico el número de inscripciones de control del libro?";
		if (confirm(sMsg)) {
			var queryString = "id=" + recordingBookId + "|";
			queryString += "controlRecordingsCount=" + newControlRecordingsCount;
			sendPageCommand("updateRecordingsControlCount", queryString);
		}
	}
	
	function updateRecordingsControlDates(recordingBookId) {
		if (isEmpty(getElement("txtFromDate" + recordingBookId))) {
			alert("Requiero conocer la fecha de presentación de la primera inscripción que contiene el libro.");
			return false;
		}
		if (!isDate(getElement("txtFromDate" + recordingBookId))) {
			alert("Necesito conocer la fecha de presentación de la primera inscripción que contiene el libro.");
			return false;
		}
		if (isEmpty(getElement("txtToDate" + recordingBookId))) {
			alert("Necesito conocer la fecha de autorización de la última inscripción contenida en el libro.");
			return false;
		}
		if (!isDate(getElement("txtToDate" + recordingBookId))) {
			alert("No reconozco la fecha de autorización de la última inscripción contenida en el libro.");
			return false;
		}
		if (!isDate(getElement("txtToDate" + recordingBookId))) {
			alert("No reconozco la fecha de autorización de la última inscripción contenida en el libro.");
			return false;
		}
		if (!isValidDatePeriod(getElement('txtFromDate' + recordingBookId).value, getElement('txtToDate' + recordingBookId).value)) {
			alert("La fecha de presentación de la primera inscripción debería ser anterior o igual a la fecha de autorización de la última inscripción.");
			return false;
		}
		if (!isValidDatePeriod(getElement('txtToDate' + recordingBookId).value, '<%=System.DateTime.Today.ToString("dd/MMM/yyyy")%>')) {
			alert("La fecha de autorización de la última inscripción debería\nser anterior o igual al día de hoy.");
			return false;
		}
		
		sMsg = "Modificar el rango de fechas de control del libro\n\n";
		sMsg += "Esta operación modificará el rango de fechas de control del\n"
		sMsg += "siguiente libro registral:\n\n"
		sMsg += getInnerText("ancRecordingBook" + recordingBookId) + "\n";		
		sMsg += "Fecha de presentación de la primera inscripción:  " + getElement("txtFromDate" + recordingBookId).value + "\n";
		sMsg += "Fecha de autorización de la última inscripción:     " + getElement("txtToDate" + recordingBookId).value + "\n\n";		
		sMsg += "¿Modifico el rango de fechas de control de este libro?";
		if (confirm(sMsg)) {
			var queryString = "id=" + recordingBookId;
			queryString += "|fromDate=" + getElement("txtFromDate" + recordingBookId).value;
			queryString += "|toDate=" + getElement("txtToDate" + recordingBookId).value;
			
			sendPageCommand("updateRecordingsControlDates", queryString);
		}
	}
	
	function createRecordBookWithDirectory(directoryId) {
		var directoryName = getElement("ancDirectory" + directoryId).innerText;
		var registerOfficeName = getElement("lblRegisterOffice" + directoryId).innerText;
		var bookSectionName = getElement("lblSectionName" + directoryId).innerText;
    var bookName = getElement("lblBookName" + directoryId).innerText;
		var volumeName = getElement("lblVolumeName" + directoryId).innerText;		

		if (!validateRecordingBook(directoryId)) {
			return;
		}
    if (bookName == "00") {
      bookName = "No aplica";
    }
		var sMsg = "Creación del libro registral.\n\n";
		sMsg += "Esta operación creará el libro registral de acuerdo a la información\n";
		sMsg += "contenida en el directorio " + directoryName + ":\n\n";
		sMsg += "Distrito:\t\t\t" + registerOfficeName + "\n";
		sMsg += "Sección:\t\t\t" + bookSectionName + "\n";
    if (bookName.length != 0) {
		  sMsg += "Libro:\t\t\t" + bookName + "\n";
    }
		sMsg += "Volumen:\t\t\t" + volumeName + "\n";
		sMsg += "Tipo:\t\t\t" + getComboOptionText(getElement("cboRecordingsClass" + directoryId)) + "\n";
		sMsg += "Inscripciones:\t\t" + getElement("txtRecordingsControlCount" + directoryId).value + "\n";
		sMsg += "Primera presentación:\t" + getElement("txtFromDate" + directoryId).value + "\n";
		sMsg += "Última autorización:\t\t" + getElement("txtToDate" + directoryId).value + "\n";
		sMsg += "Digitalizado por:\t\t" + getComboOptionText(getElement("cboCapturedBy" + directoryId)) + "\n";
		sMsg += "Cortado por:\t\t" + getComboOptionText(getElement("cboReviewedBy" + directoryId)) + "\n\n";
		sMsg += "¿Creo el libro registral asociado al directorio " + directoryName + "?";

		if (confirm(sMsg)) {
			var queryString = "id=" + directoryId;
			queryString += "|capturedById=" + getElement("cboCapturedBy" + directoryId).value;
			queryString += "|reviewedById=" + getElement("cboReviewedBy" + directoryId).value;
			queryString += "|recordingsClassId=" + getElement("cboRecordingsClass" + directoryId).value;
			queryString += "|controlRecordingsCount=" + getElement("txtRecordingsControlCount" + directoryId).value;
			queryString += "|fromDate=" + getElement("txtFromDate" + directoryId).value;
			queryString += "|toDate=" + getElement("txtToDate" + directoryId).value;
			
			sendPageCommand("createRecordBookWithDirectory", queryString);
		}
	}

	function validateRecordingBook(directoryId) {
		if (getElement("cboCapturedBy" + directoryId).value.length == 0) {
			alert("Necesito conocer el grupo de trabajo o usuario que digitalizó el libro.");
			return false;
		}
		if (getElement("cboReviewedBy" + directoryId).value.length == 0) {
			alert("Requiero se proporcione el grupo de trabajo o usuario encargado de \ncortar y mejorar las imágenes del libro.");
			return false;
		}
		if (getElement("cboRecordingsClass" + directoryId).value.length == 0) {
			alert("Necesito conocer el tipo de inscripciones que contiene el libro.");
			return false;
		}
		if (isEmpty(getElement("txtRecordingsControlCount" + directoryId))) {
			alert("Necesito conocer el número de inscripciones registradas en el libro.");
			return false;
		}
		if (!isNumeric(getElement("txtRecordingsControlCount" + directoryId))) {
			alert("No reconozco el número de inscipciones proporcionado.");
			return false;
		}
		var controlRecordingsCount = Number(getElement("txtRecordingsControlCount" + directoryId).value);		
		if (controlRecordingsCount <= 0) {
			alert("El número de inscrpciones debe ser mayor que cero.");
			return false;
		}
		if (!(50 < controlRecordingsCount && controlRecordingsCount < 150)) {
			if (!confirm("El número de inscripciones proporcionado me parece incorrecto.\n\n¿El libro realmente contiene " + controlRecordingsCount + " inscripciones?")) {
				return false;
			}
		}		
		if (isEmpty(getElement("txtFromDate" + directoryId))) {
			alert("Requiero conocer la fecha de presentación de la primera inscripción que contiene el libro.");
			return false;
		}
		if (!isDate(getElement("txtFromDate" + directoryId))) {
			alert("No reconozco la fecha de presentación de la primera inscripción que contiene el libro.");
			return false;
		}
		if (isEmpty(getElement("txtToDate" + directoryId))) {
			alert("Necesito conocer la fecha de autorización de la última inscripción contenida en el libro.");
			return false;
		}
		if (!isDate(getElement("txtToDate" + directoryId))) {
			alert("No reconozco la fecha de autorización de la última inscripción contenida en el libro.");
			return false;
		}
		if (!isValidDatePeriod(getElement('txtFromDate' + directoryId).value, getElement('txtToDate' + directoryId).value)) {
			alert("La fecha de presentación del la primera inscripción debería\nser anterior o igual a la fecha de autorización de la última inscripción.");
			return false;
		}
		if (!isValidDatePeriod(getElement('txtToDate' + directoryId).value, '<%=System.DateTime.Today.ToString("dd/MMM/yyyy")%>')) {
			alert("La fecha de autorización de la última inscripción debería ser anterior o igual al día de hoy.");
			return false;
		}
		return true;
	}

	function openDirectoryImagesViewer(directoryId, goToLastPage) {
		var source = "directory.image.viewer.aspx?";
		source += "directoryId=" + directoryId;
		source += "&goLast=" + goToLastPage;

		createNewWindow(source);
	}
	
  function createObject() {
    alert('La operación solicitada todavía no ha sido definida en el programa.');
    return false;
  }

	function processImagingDirectories() {
	  if (getElement("<%=cboRecorderOffice.ClientID%>").value.length == 0) {
	    alert("Para reprocesar los directorios, requiero se seleccione\nde la lista el Distrito Judicial correspondiente.");
	    return false;
    }
		var sMsg = "Reprocesamiento de directorios de imágenes.\n\n";

		sMsg += "Esta operación hace una revisión exhaustiva en todos los directorios\n";
		sMsg += "que contienen las imágenes de los libros digitalizados, por lo que\n";
		sMsg += "generalmente sólo se ejecuta cuando se cargan nuevas imágenes.\n\n";

		sMsg += "Distrito que se procesará: " + getComboOptionText(getElement("<%=cboRecorderOffice.ClientID%>")) + "\n\n";
		
		sMsg += "Dependiendo de la cantidad de imágenes, es posible que el proceso tarde varios minutos.\n\n";
		sMsg += "¿Reproceso todos los directorios de imágenes para el Distrito seleccionado?";
		if (confirm(sMsg)) {
			sendPageCommand("processImagingDirectories");
		}
	}

  function loadData() {
    sendPageCommand("loadData");
  }
  
  function updateUserInterface(oSourceControl) {
    sendPageCommand("updateUserInterface");
  }

  function doPendingBookOperation(recordingBookId) {
		var operationName = getElement("cboOperation" + recordingBookId).value;
		switch(operationName) {
	    case "assignRecordingBook":
			  return doOperation(operationName, recordingBookId);
	    case "updateRecordingsControlCount":
			  return doOperation(operationName, recordingBookId);
			case "unassignRecordingBook":
				return doOperation(operationName, recordingBookId);
			case "sendRecordingBookToLastAnalyst":
				return doOperation(operationName, recordingBookId);
	    case "sendRecordingBookToQualityControl":
				return doOperation(operationName, recordingBookId);	    
			case "closeRecordingBook":
				return doOperation(operationName, recordingBookId);
      case 'updateRecordingsControlDates':
        return doOperation(operationName, recordingBookId);
	    case "":
			  alert("Requiero se seleccione una operación de la lista.");				
				return false;
			default:
        alert('La operación seleccionada \'' + operationName + '\' todavía no ha sido definida en el programa.');			
				return false;	
	   }
  }

  function changePendingBookOperationsUI(recordingBookId) {
		getElement('divRecordingBookAnalyst' + recordingBookId).style.display = "none";
    getElement('divRecordingsControlCount' + recordingBookId).style.display = "none";
    getElement('divRecordingsControlDates' + recordingBookId).style.display = "none";
    getElement('divCloseRecordingBook' + recordingBookId).style.display = "none";
    
    var operationName = getElement('cboOperation' + recordingBookId).value;
		switch(operationName) {
	    case "assignRecordingBook":
				getElement('divRecordingBookAnalyst' + recordingBookId).style.display = "inline";
	      return;
	   case "updateRecordingsControlCount":
	      getElement('divRecordingsControlCount' + recordingBookId).style.display = "inline";
	      return;
	   case "updateRecordingsControlDates":
	      getElement('divRecordingsControlDates' + recordingBookId).style.display = "inline";
	      return;
	   case "unassignRecordingBook":
				getElement('divRecordingBookAnalyst' + recordingBookId).style.display = "inline";
	      return;   
	   case "closeRecordingBook":
	      getElement('divCloseRecordingBook' + recordingBookId).style.display = "inline";
	      return;
	   default:
	      return;
	   }
  }

	/* ]]> */
	</script>
</asp:Content>
