<%@ Page Language="C#" EnableViewState="true"  EnableSessionState="true" MasterPageFile="~/workplace/dashboard.master" AutoEventWireup="true" Inherits="Empiria.Web.UI.Workflow.ParticipantsManagementDashboard" Codebehind="participants.management.dashboard.aspx.cs" %>
<%@ OutputCache Location="None" NoStore="true" %>
<asp:Content ID="dashboardItem" ContentPlaceHolderID="dashboardItemPlaceHolder" runat="Server" EnableViewState="true">
<table id="tblDashboardMenu" class="tabStrip" style='display:<%=base.ShowTabStripMenu ? "inline" : "none"%>'>
  <tr>
    <td id="tabStripItem_0" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 0);" title="">Grupos de trabajo</td>
    <td id="tabStripItem_1" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 1);" title="">Control de usuarios</td>
    <td id="tabStripItem_2" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 2);" title="">Visor de cargas de trabajo</td>
    <td id="tabStripItem_3" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 3);" title="">Tareas en proceso</td>
    <td id="tabStripItem_4" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 4);" title="">Tareas reasignadas</td>        
    <td id="tabStripItem_5" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 5);" title="">Tareas descartadas</td>    
    <td>&nbsp; &nbsp;</td>
    <td><input id="currentTabStripItem" name="currentTabStripItem" type="hidden" /></td>
  </tr>
</table>
<div class="dashboardWorkarea">
  <table id="tblDashboardOptions" width="100%">
    <tr>
      <td nowrap="nowrap">Distrito:</td>
      <td>
		  <select id="cboOffice" class="selectBox" style="width:238px" runat="server" onchange="doOperation('updateUserInterface', this);">
        <option value="">( Todos los Distritos )</option>
        <option value="700">Calera</option>
        <option value="701">Concepción del Oro</option>                 
        <option value="702">Fresnillo</option>
        <option value="703">Jalpa</option>
        <option value="704">Jeréz</option>        
        <option value="705">Juchipila</option>
				<option value="706">Loreto</option>
        <option value="707">Miguel Auza</option>
        <option value="708">Nochistlán</option>
        <option value="709">Ojo Caliente</option>
        <option value="710">Pinos</option>                        			           
        <option value="711">Río Grande</option>        
        <option value="712">Sombrerete</option>
        <option value="713">Teul de González Ortega</option>          
        <option value="714">Tlaltenango</option>
        <option value="715">Valparaíso</option>        
        <option value="716">Villanueva</option>
        <option value="717">Zacatecas</option>
        <option value=''></option>
				<option value="718">Oficinas de terceros</option>
		    </select>
      </td>
			<% if (this.SelectedTabStrip < 3) { %>      
      <td nowrap="nowrap">Buscar por: </td>      
			<% } %>
			<% if (this.SelectedTabStrip >= 3) { %>
      <td nowrap="nowrap">Buscar: </td>
			<td nowrap="nowrap">
        <select id="cboSearch" name="cboSearch" class="selectBox" style="width:130px" runat="server">
          <option value="CustomerKeywords">Todos los campos</option>
          <option value="Phone1|Phone2">Asunto</option>
          <option value="Phone1|Phone22">Contenido</option>            
          <option value="CustomerAlias|CustomerNumber|RsFC">Emisor</option>
          <option value="CustomerAlias|CustomerNumber|RFdC">Involucrados</option>          
        </select>
      </td>
      <% } %>      
      <td nowrap="nowrap">      
        <input id="txtSearchExpression" name="txtSearchExpression" class="textBox" onkeypress="return searchTextBoxKeyFilter(window.event);"
               type="text" tabindex="-1" maxlength="80" style="width:200px" runat="server" />
      </td>
      <td align="left" nowrap="nowrap">
        <img src="../themes/default/buttons/search.gif" alt="" onclick="return doOperation('loadData')" title="Ejecuta la búsqueda" />
				<% if (this.SelectedTabStrip == 0) { %>
        <a href="javascript:doOperation('createWorkgroup')"><img src="../themes/default/buttons/go.button.png" alt=""
                 title="Imprime el reporte con la programación de reparto para las unidades seleccionadas" />Crear un grupo de trabajo</a> &nbsp; &nbsp;      
        <% } %>
				<% if (this.SelectedTabStrip == 1) { %>
        <a href="javascript:doOperation('createUser')"><img src="../themes/default/buttons/go.button.png" alt=""
                 title="Imprime el reporte con la programación de reparto para las unidades seleccionadas" />Registrar un nuevo usuario</a> &nbsp; &nbsp;       
        <% } %>        
     </td>
     <td width="80%">&nbsp;</td>
    </tr>
    <tr>
			<% if (this.SelectedTabStrip >= 2) { %>
      <td nowrap="nowrap">Del día:</td>
      <td nowrap="nowrap">
        <input type="text" class="textBox" id='txtFromDate' name='txtFromDate' style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
        <img id='imgFromDate' src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('<%=txtFromDate.ClientID%>'), getElement('imgFromDate'));" title="Despliega el calendario" alt="" />
        &nbsp;&nbsp;al día
        <input type="text" class="textBox" id='txtToDate' name='txtToDate' style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
        <img id='imgToDate' src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('<%=txtToDate.ClientID%>'), getElement('imgToDate'));" title="Despliega el calendario" alt="" />
      </td>
      <% } %>
      <td nowrap="nowrap">
				<% if (this.SelectedTabStrip == 2) { %>
        Categoría:
        <% } %>
				<% if (this.SelectedTabStrip >= 3) { %>
        Prioridad:
        <% } %>				
      </td>
			<% if (this.SelectedTabStrip >= 3) { %>           
      <td nowrap="nowrap">
 
        <select id="cboDistributionType" name="cboDistributionType" class="selectBox" onchange="doOperation('updateUserInterface', this);" style="width:130px" runat="server">
          <option value="">( Todas )</option>
          <option value="5">Urgente</option>
          <option value="3">Alta</option>
          <option value="2">Normal</option>
        </select>
      </td>
      <% } %>      
			<% if (this.SelectedTabStrip >= 2) { %>
      <td colspan="3">
				<select id="cboOrganization" class="selectBox" style="width:238px" runat="server" onchange="doOperation('updateUserInterface', this);">
					<option value="">( Todas las categorías )</option>
					<option value="703">Inscripciones</option>
					<option value="704">Anotaciones preventivas</option>
					<option value="705">Actos registrales</option>
					<option value="706">Calificaciones</option>
					<option value="707">Certificaciones</option>
					<option value="708">Devolución de documentos</option>
					<option value="709">Otras tareas</option>
		    </select>
      </td>
      <% } %>
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
