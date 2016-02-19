<%@ Page Language="C#" EnableViewState="true"  EnableSessionState="true" MasterPageFile="~/workplace/dashboard.master" AutoEventWireup="true" Inherits="Empiria.Land.WebApp.DocumentClassificationDashboard" CodeFile="document.classification.dashboard.aspx.cs" %>
<%@ OutputCache Location="None" NoStore="true" %>
<asp:Content ID="dashboardItem" ContentPlaceHolderID="dashboardItemPlaceHolder" runat="Server" EnableViewState="true">
<table id="tblDashboardMenu" class="tabStrip" style='display:<%=base.ShowTabStripMenu ? "inline" : "none"%>'>
  <tr>
    <td id="tabStripItem_0" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 0);" title="">Mis libros asignados</td>
    <td id="tabStripItem_1" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 1);" title="">Mis inscripciones pendientes</td>
    <td id="tabStripItem_2" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 2);" title="">Mis inscripciones registradas</td>
    <td>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</td>
    <td><input id="currentTabStripItem" name="currentTabStripItem" type="hidden" /></td>
  </tr>
</table>
<div class="dashboardWorkarea">
  <table id="tblDashboardOptions" width="100%">
    <tr>
      <% if (this.SelectedTabStrip >= 1) { %>
      <td nowrap="nowrap">Distrito:</td>
      <td>
				<select id="cboRecorderOffice" class="selectBox" style="width:180px" onchange="doOperation('updateUserInterface', this);" runat="server" >
				</select>
      </td>
      <td nowrap="nowrap">Sección:</td>
      <td>
				<select id="cboRecordingBookSection" class="selectBox" style="width:80px" onchange="doOperation('updateUserInterface', this);" runat="server" >
				</select>
      </td>
      <td nowrap="nowrap">Libro:</td>
      <td>
				<select id="cboRecordingBook" class="selectBox" style="width:80px" onchange="doOperation('updateUserInterface', this);" runat="server">
				</select>
      </td>
     <td nowrap="nowrap">Volumen:</td>
      <td>
				<select id="cboRecordingBookVolume" class="selectBox" style="width:80px" onchange="doOperation('updateUserInterface', this);" runat="server" >				
		    </select>
      </td>
      <td nowrap="nowrap">Buscar: </td>
      <td nowrap="nowrap">
        <input id="txtSearchExpression" name="txtSearchExpression" class="textBox" onkeypress="return searchTextBoxKeyFilter(window.event);"
               type="text" tabindex="-1" maxlength="80" style="width:140px" runat="server" />
        <img src="../themes/default/buttons/search.gif" alt="" onclick="return doOperation('loadData')" title="Ejecuta la búsqueda" />
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
      case 'updateUserInterface':
        updateUserInterface(arguments[1]);
        return;
      case 'viewRecordingBook':
        openRecordingBookViewer(arguments[1]);
        return;
      case 'sendRecordingBookToQualityControl':
        sendRecordingBookToQualityControl(arguments[1]);
        return;
      default:
        alert('La operación \'' + operationName + '\' todavía no ha sido definida en el programa.');
        return;
    }
  }
	
  function loadData() {
    sendPageCommand("loadData");
  }	

	function openRecordingBookViewer(recordingBookId) {
		source = "recording.book.analyzer.aspx?"
		source += "bookId=" + recordingBookId;

		createNewWindow(source);
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

  function updateUserInterface(oSourceControl) {
    sendPageCommand("updateUserInterface");
  }

	/* ]]> */
	</script>
</asp:Content>
