<%@ Page Language="C#" EnableViewState="true"  EnableSessionState="true" MasterPageFile="~/workplace/dashboard.master" AutoEventWireup="true" Inherits="Empiria.Web.UI.LRSAnalytics.DailyHistoricRecordingDashboard" CodeFile="daily.historic.recording.dashboard.aspx.cs" %>
<%@ OutputCache Location="None" NoStore="true" %>
<asp:Content ID="dashboardItem" ContentPlaceHolderID="dashboardItemPlaceHolder" runat="Server" EnableViewState="true">
<table id="tblDashboardMenu" class="tabStrip" style='display:<%=base.ShowTabStripMenu ? "inline" : "none"%>'>
  <tr>
    <td id="tabStripItem_0" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 0);" title="">Productividad en la captura histórica</td>
    <td id="tabStripItem_1" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 1);" title="">Análisis de calidad</td>
    <td id="tabStripItem_2" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 2);" title="">Análisis de trámites</td>
    <td id="tabStripItem_3" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 3);" title="">Análisis de consultas</td>
    <td>&nbsp; &nbsp;</td>
    <td><input id="currentTabStripItem" name="currentTabStripItem" type="hidden" /></td>
  </tr>
</table>
<div class="dashboardWorkarea">
  <table id="tblDashboardOptions" width="100%">
    <tr>
      <% if (base.SelectedTabStrip == 0 || base.SelectedTabStrip == 2) { %>
      <td nowrap="nowrap">Analizar:</td>
      <td>
				<select id="cboView" name="cboView" class="selectBox" style="width:250px" runat="server" onchange="doOperation('updateUserInterface', this);">
					<option value="">( Seleccionar )</option>
					<option value="DayByDayProgressAnalysis">Avance de análisis y captura por Distrito</option>
					<option value="ProductivityByAnalyst">Productividad de analistas</option>
					<option value="RecordingActTypeAnalysis">Incidencia de actos jurídicos</option>
				</select>
        <!--	
					<option value="RecorderOfficeProgressAnalysis">Avance de análisis y captura por Distrito</option>
          <option value="ProductivityByAnalystPerHour">Productividad de analistas por hora</option>
        !-->
      </td>
      <td nowrap="nowrap">Distrito:</td>
      <td>
				<select id="cboRecorderOffice" class="selectBox" style="width:180px" onchange="doOperation('updateUserInterface', this);" runat="server" >
				</select>
      </td>
      <td nowrap="nowrap">Del día:</td>
      <td nowrap="nowrap">
        <input type="text" class="textBox" id='txtFromDate' name='txtFromDate' style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
        <img id='imgFromDate' src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('<%=txtFromDate.ClientID%>'), getElement('imgFromDate'));" title="Despliega el calendario" alt="" />
        &nbsp;&nbsp;al día
        <input type="text" class="textBox" id='txtToDate' name='txtToDate' style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
        <img id='imgToDate' src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('<%=txtToDate.ClientID%>'), getElement('imgToDate'));" title="Despliega el calendario" alt="" />
      </td>
      <td align="left" nowrap="nowrap">
        <img src="../themes/default/buttons/search.gif" alt="" onclick="doOperation('loadData')" title="Ejecuta la búsqueda" />
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
      case 'createObject':
        createObject();
        return;
      case 'updateUserInterface':
        updateUserInterface(arguments[1]);
        return;
      default:
        alert('La operación solicitada todavía no ha sido definida en el programa.');
        return;
    }
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
