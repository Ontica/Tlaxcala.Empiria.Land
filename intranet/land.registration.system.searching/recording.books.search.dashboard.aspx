<%@ Page Language="C#" EnableViewState="true"  EnableSessionState="true" MasterPageFile="~/workplace/dashboard.master" AutoEventWireup="true" Inherits="Empiria.Web.UI.LRS.RecordingBooksSearchDashboard" CodeFile="recording.books.search.dashboard.aspx.cs" %>
<%@ OutputCache Location="None" NoStore="true" %>
<asp:Content ID="dashboardItem" ContentPlaceHolderID="dashboardItemPlaceHolder" runat="Server" EnableViewState="true">
<table id="tblDashboardMenu" class="tabStrip" style='display:<%=base.ShowTabStripMenu ? "inline" : "none"%>'>
  <tr>
    <td id="tabStripItem_0" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 0);" title="">Acervo digitalizado</td>
    <td id="tabStripItem_1" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 1);" title="">Índice de personas</td>
    <td id="tabStripItem_2" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 2);" title="">Consultar predios</td>
    <td>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</td>
    <td><input id="currentTabStripItem" name="currentTabStripItem" type="hidden" /></td>
  </tr>
</table>
<div class="dashboardWorkarea">
  <table id="tblDashboardOptions" width="100%">
    <tr>
      <td nowrap="nowrap">Distrito:</td>
      <td>
				<select id="cboRecorderOffice" class="selectBox" style="width:180px" onchange="doOperation('updateUserInterface', this);" runat="server" >
				</select>
      </td>
      <% if (this.SelectedTabStrip == 0) { %>
      <td nowrap="nowrap">Tipo:</td>
      <td>
				<select id="cboRecordingClass" class="selectBox" style="width:180px" onchange="doOperation('updateUserInterface', this);" runat="server" >
				</select>
      </td>
      <% } %>
      <% if (this.SelectedTabStrip == 0) { %>
      <td nowrap="nowrap">Datos del libro:</td>
      <% } else if (this.SelectedTabStrip == 1) { %>
      <td nowrap="nowrap">Datos de la persona:</td>
      <% } else if (this.SelectedTabStrip == 2) { %>
      <td nowrap="nowrap">Datos del predio:</td>
      <% } %>
      <td nowrap="nowrap">
        <input id="txtSearchExpression" name="txtSearchExpression" class="textBox" onkeypress="return searchTextBoxKeyFilter(window.event);"
               type="text" tabindex="-1" maxlength="320" style="width:320px" runat="server" />
        <img src="../themes/default/buttons/search.gif" alt="" onclick="return doOperation('loadData')" title="Ejecuta la búsqueda" />
      </td>
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
      case 'showRecording':
        showRecordingBookViewer(arguments[1], arguments[2]);
        return;
      default:
        alert('La operación \'' + operationName + '\' todavía no ha sido definida en el programa.');
        return;
    }
  }

	function openRecordingBookViewer(recordingBookId) {
		var source = "../land.registration.system/recording.book.analyzer.aspx?"
		source += "bookId=" + recordingBookId;

		createNewWindow(source);
	}

	function showRecordingBookViewer(recordingBookId, recordingId) {
		var source = "../land.registration.system/recording.book.analyzer.aspx?"
		source += "bookId=" + recordingBookId + "&id=" + recordingId;

		createNewWindow(source);
	}

	function openDirectoryImagesViewer(directoryId, goToLastPage) {
		var source = "../land.registration.system/directory.image.viewer.aspx?";
		source += "directoryId=" + directoryId;
		source += "&goLast=" + goToLastPage;

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

	/* ]]> */
	</script>
</asp:Content>
