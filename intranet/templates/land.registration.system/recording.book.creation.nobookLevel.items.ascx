<%@ Import Namespace="Empiria" %>
<%@ Import Namespace="Empiria.Presentation" %>
<%@ Import Namespace="Empiria.Land.Registration" %>
<%@ Import Namespace="Empiria.Land.UI" %>

<%# ((int) DataBinder.Eval(Container, "ItemIndex")) == 0 ? "<tbody>" : String.Empty %>
<tr class="<%# ((int) DataBinder.Eval(Container, "ItemIndex") % 2 == 0 ? String.Empty  : "oddDataRow") %>" onmouseover="dataGridRowSelect(this, true);" onmouseout="dataGridRowSelect(this, false);">
	<td style="white-space:nowrap;">
		<table class="ghostTable">
			<tr><td rowspan="5"><a href="javascript:doOperation('viewDirectoryImages', <%#DataBinder.Eval(Container, "DataItem.FilesFolderId")%>)"><img src="../themes/default/app.icons/library.gif" alt='' title="Muestra las imágenes contenidas en este directorio" style='margin-right:20px' /></a></td>
					<td colspan="2" style='width:100%;height:22px'><a id="ancDirectory<%#DataBinder.Eval(Container, "DataItem.FilesFolderId")%>" class="detailsLinkTitle" href="javascript:doOperation('viewDirectoryImages', <%#DataBinder.Eval(Container, "DataItem.FilesFolderId")%>)" title="Muestra las imágenes contenidas en este directorio"><%#DataBinder.Eval(Container, "DataItem.FilesFolderDisplayName")%></a></td></tr>
			<tr><td>Imágenes:</td><td style="width:100%"><span class='boldItem'><%#((int)DataBinder.Eval(Container, "DataItem.FilesCount")).ToString("N0")%></span></td></tr>
			<tr><td style="width:20px">Tamaño:</td><td style="width:100%"><span class='boldItem'><%#((int)DataBinder.Eval(Container, "DataItem.FilesTotalSize") / 1024).ToString("N0")%> MB</span></td></tr>
			<tr><td style="width:20px">Modificado:&nbsp;&nbsp;</td><td style="width:100%"><span class='boldItem'><%#(EmpiriaString.DateTimeString((DateTime)DataBinder.Eval(Container, "DataItem.LastUpdateDate")))%></span>&nbsp;&nbsp;</td></tr>
			<tr><td style="width:20px">Estado:&nbsp;&nbsp;</td><td style="width:100%"><span class='boldItem'><%#DataBinder.Eval(Container, "DataItem.FilesFolderStatusName")%></span>&nbsp;&nbsp;</td></tr>				
		</table>
	</td>
	<td style="white-space:nowrap;">
		Distrito: <span id="lblRegisterOffice<%#DataBinder.Eval(Container, "DataItem.FilesFolderId")%>" class='boldItem'><%#DataBinder.Eval(Container, "DataItem.FilesFolderOwner")%></span>&nbsp; &nbsp;
		Sección: <span id="lblSectionName<%#DataBinder.Eval(Container, "DataItem.FilesFolderId")%>" class='boldItem'><%#EmpiriaString.GetSection((string) DataBinder.Eval(Container, "DataItem.FilesFolderDisplayName"), '-', 1)%></span>&nbsp; &nbsp;
    <span id="lblBookName<%#DataBinder.Eval(Container, "DataItem.FilesFolderId")%>" class='boldItem'></span>
		Volumen: <span id="lblVolumeName<%#DataBinder.Eval(Container, "DataItem.FilesFolderId")%>" class='boldItem'><%#EmpiriaString.GetSection((string) DataBinder.Eval(Container, "DataItem.FilesFolderDisplayName"), '-', 2)%></span>&nbsp;&nbsp;<br /><br />
		Digitalizado por: 
			<select id="cboCapturedBy<%#DataBinder.Eval(Container, "DataItem.FilesFolderId")%>" class="selectBox" style="width:302px" title="">
				<%#LRSHtmlSelectControls.GetBookImageDigitalizersComboItems(RecorderOffice.Parse((int) DataBinder.Eval(Container, "DataItem.FilesFolderOwnerId")), ComboControlUseMode.ObjectCreation, RecorderOffice.Empty)%>
      </select>
    <br />
		Cortado por: &nbsp; &nbsp;&nbsp;
			<select id="cboReviewedBy<%#DataBinder.Eval(Container, "DataItem.FilesFolderId")%>" class="selectBox" style="width:302px" title="">
				<%#LRSHtmlSelectControls.GetBookImageClippersComboItems(RecorderOffice.Parse((int) DataBinder.Eval(Container, "DataItem.FilesFolderOwnerId")), ComboControlUseMode.ObjectCreation, RecorderOffice.Empty)%>
      </select>
    <br />
    Tipo: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
    <select id="cboRecordingsClass<%#DataBinder.Eval(Container, "DataItem.FilesFolderId")%>" class="selectBox" style="width:180px" title="">
      <%#LRSHtmlSelectControls.GetRecordingBookClassesComboItems("( Seleccionar )")%>
		</select>
    Inscripciones: <input id="txtRecordingsControlCount<%#DataBinder.Eval(Container, "DataItem.FilesFolderId")%>" class="textBox" type="text" maxlength="4" style="width:32px" onkeypress="return integerKeyFilter(this);" />
    <br />
    Fecha de la primera inscripción:&nbsp; &nbsp; &nbsp; &nbsp;<input type="text" class="textBox" id='txtFromDate<%# DataBinder.Eval(Container, "DataItem.FilesFolderId")%>' style="margin-right:2px;width:64px;" onblur="formatAsDate(this)" title="" value="" /><img id='imgFromDate<%# DataBinder.Eval(Container, "DataItem.FilesFolderId")%>' 
    src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('txtFromDate<%# DataBinder.Eval(Container, "DataItem.FilesFolderId")%>'), getElement('imgFromDate<%# DataBinder.Eval(Container, "DataItem.FilesFolderId")%>'));" title="Despliega el calendario"  style="padding:0px;margin:0px" alt="" hspace="0" />
    &nbsp;
    Última:&nbsp; &nbsp;<input type="text" class="textBox" id='txtToDate<%# DataBinder.Eval(Container, "DataItem.FilesFolderId")%>' style="margin-right:2px;width:64px;" onblur="formatAsDate(this)" title="" value="" /><img id='imgToDate<%# DataBinder.Eval(Container, "DataItem.FilesFolderId")%>' 
    src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('txtToDate<%# DataBinder.Eval(Container, "DataItem.FilesFolderId")%>'), getElement('imgToDate<%# DataBinder.Eval(Container, "DataItem.FilesFolderId")%>'));" title="Despliega el calendario"  style="padding:0px;margin:0px" alt="" hspace="0" />
	</td>
	<td style="white-space:nowrap;width:40%">
		<span class='boldItem'>¿Qué debo hacer con este directorio?</span><br /><br />
		&nbsp; &nbsp; &nbsp;<a class='detailsLink' href="javascript:doOperation('createRecordBookWithDirectory', <%#DataBinder.Eval(Container, "DataItem.FilesFolderId")%>)" title="Crea el libro registral correspondiente a este directorio"><img src="../themes/default/buttons/go.button.png" alt=''/>Crear el libro registral asociado</a>		    
		<br /><br />
		&nbsp; &nbsp; &nbsp;<a class='detailsLink' href="javascript:doOperation('viewDirectoryLastImage', <%#DataBinder.Eval(Container, "DataItem.FilesFolderId")%>)" title="Presenta en pantalla la última imagen de este directorio, que típicamente contiene la última inscripción registrada."><img src="../themes/default/buttons/go.button.png" alt='' />Mostrar la última imagen digitalizada</a>
	</td>
</tr>
<%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).IsLastItem((int) DataBinder.Eval(Container, "ItemIndex")) ? "</tbody>" : String.Empty %>
