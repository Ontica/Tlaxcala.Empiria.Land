﻿<%@ Page Language="C#" EnableViewState="true"  EnableSessionState="true" MasterPageFile="~/workplace/dashboard.master" AutoEventWireup="true" Inherits="Empiria.Web.UI.Workflow.WorkflowManagementDashboard" CodeFile="workflow.management.dashboard.aspx.cs" %>
<%@ OutputCache Location="None" NoStore="true" %>
<asp:Content ID="dashboardItem" ContentPlaceHolderID="dashboardItemPlaceHolder" runat="Server" EnableViewState="true">
<table id="tblDashboardMenu" class="tabStrip" style='display:<%=base.ShowTabStripMenu ? "inline" : "none"%>'>
  <tr>
    <td id="tabStripItem_0" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 0);" title="">Administración de procesos</td>
    <td id="tabStripItem_1" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 1);" title="">Administración de tareas</td>
    <td id="tabStripItem_2" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 2);" title="">Visor de flujos de trabajo</td>
    <td id="tabStripItem_3" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 3);" title="">Visor de tareas</td>
    <td>&#160;&#160;</td>
    <td><input id="currentTabStripItem" name="currentTabStripItem" type="hidden" /></td>
  </tr>
</table>
<div class="dashboardWorkarea">
  <table id="tblDashboardOptions" width="100%">
    <tr>
     <td nowrap="nowrap">Categoría:</td>
      <td>
		  <select id="cboOrganization" class="selectBox" style="width:238px" runat="server" onchange="doOperation('updateUserInterface', this);">
        <option value="">( Todas las categorías )</option>
        <option value="700">Recepción de documentos</option>
        <option value="701">Documentos por revisar</option>
        <option value="702">Determinar importe de derechos</option>
				<option value="703">Inscripciones</option>
        <option value="704">Anotaciones</option>
        <option value="705">Actos registrales</option>
        <option value="706">Calificaciones</option>
        <option value="707">Certificaciones</option>
        <option value="708">Devolución de documentos</option>
        <option value="709">Otras tareas</option>
		    </select>
      </td>
      <td nowrap="nowrap">Buscar por: </td>
      <td nowrap="nowrap">
        <input id="txtSearchExpression" name="txtSearchExpression" class="textBox" onkeypress="return searchTextBoxKeyFilter(window.event);"
               type="text" tabindex="-1" maxlength="80" style="width:200px" runat="server" />
      </td>
      <td align="left" nowrap="nowrap">
        <img src="../themes/default/buttons/search.gif" alt="" onclick="doOperation('loadData')" title="Ejecuta la búsqueda" />
       &#160;&#160;&#160;
			<% if (this.SelectedTabStrip >= 1)  { %>
        <a href="javascript:doOperation('createObject')"><img src="../themes/default/buttons/go.button.png" alt=""
                 title="Imprime el reporte con la programación de reparto para las unidades seleccionadas" />Crear una nueva tarea</a>&#160;&#160;
      <% } %>
      </td>
     <td width="80%">&#160;</td>
    </tr>
    <tr>
			<% if (this.SelectedTabStrip >= 2)  { %>
      <td nowrap="nowrap">Del día:</td>
      <td nowrap="nowrap">
        <input type="text" class="textBox" id='txtFromDate' name='txtFromDate' style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
        <img id='imgFromDate' src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(event, getElement('<%=txtFromDate.ClientID%>'), getElement('imgFromDate'));" title="Despliega el calendario" alt="" />
       &#160;&#160;al día
        <input type="text" class="textBox" id='txtToDate' name='txtToDate' style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
        <img id='imgToDate' src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(event, getElement('<%=txtToDate.ClientID%>'), getElement('imgToDate'));" title="Despliega el calendario" alt="" />
      </td>
      <td nowrap="nowrap">
        Estado:
      </td>
      <td nowrap="nowrap">
        <select id="cboDistributionType" name="cboDistributionType" class="selectBox" onchange="doOperation('updateUserInterface', this);" style="width:130px" runat="server">
          <option value="">( Todos )</option>
          <option value="A">Activo</option>
          <option value="S">Suspendido</option>
          <option value="C">Cancelado</option>
        </select>
      </td>
			<% } %>
      <td nowrap="nowrap" colspan="3">

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
