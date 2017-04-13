<%@ Import Namespace="Empiria.Presentation" %>
<%@ Import Namespace="Empiria.Land.Registration" %>
<%@ Import Namespace="Empiria.Land.UI" %>

<%# ((int) DataBinder.Eval(Container, "ItemIndex")) == 0 ? "<tbody>" : String.Empty %>
<tr class="<%# ((int) DataBinder.Eval(Container, "ItemIndex") % 2 == 0 ? String.Empty  : "oddDataRow") %>" onmouseover="dataGridRowSelect(this, true);" onmouseout="dataGridRowSelect(this, false);">
	<td style="white-space:nowrap;">
		<table class="ghostTable">
			<tr><td rowspan="5"><a href="javascript:doOperation('viewRecordingBook', <%#DataBinder.Eval(Container, "DataItem.RecordingBookId")%>)"><img src="../themes/default/app.icons/library.gif" alt='' title="Muestra las Imágenes de este libro registral" style='margin-right:20px' /></a></td>
					<td colspan="6" style='width:100%;height:22px'><a id="ancRecordingBook<%#DataBinder.Eval(Container, "DataItem.RecordingBookId")%>" class="detailsLinkTitle" href="javascript:doOperation('viewRecordingBook', <%#DataBinder.Eval(Container, "DataItem.RecordingBookId")%>)" title="Muestra las imágenes de este libro registral"><%#DataBinder.Eval(Container, "DataItem.RecordingBookFullName")%></a></td></tr>
			<tr><td style="width:20px">Inscripciones:&#160;</td><td><span id="ancRecordingsControlCount<%#DataBinder.Eval(Container, "DataItem.RecordingBookId")%>" class='boldItem'><%#((int)DataBinder.Eval(Container, "DataItem.RecordingsControlCount")).ToString("N0")%></span>&#160;&#160;&#160;</td><td>Vigentes:</td><td><span class='boldItem'><%#((int)DataBinder.Eval(Container, "DataItem.ActiveRecordingsCount")).ToString("N0")%>&#160;&#160;&#160;&#160;&#160;&#160;</span></td><td>Tipo:</td><td><span class='boldItem'><%#DataBinder.Eval(Container, "DataItem.RecordingsClassName")%>&#160;</span></td></tr>
			<tr><td style="width:20px">Completas:</td><td><span id="ancCurrentCapturedRecordingsCount<%#DataBinder.Eval(Container, "DataItem.RecordingBookId")%>" class='boldItem'><%#((int)DataBinder.Eval(Container, "DataItem.RegisteredRecordingsCount")).ToString("N0")%></span>&#160;&#160;&#160;</td><td>No vigentes:&#160;</td><td><span class='boldItem'><%#((int)DataBinder.Eval(Container, "DataItem.ObsoleteRecordingsCount")).ToString("N0")%></span></td><td style="width:20px">Imágenes:&#160;</td><td><span class='boldItem'><%#((int)DataBinder.Eval(Container, "DataItem.FilesCount")).ToString("N0")%> (<%#((int)DataBinder.Eval(Container, "DataItem.FilesTotalSize") / 1024).ToString("N0")%> MB)</span></td></tr>
			<tr><td style="width:20px">Incompletas:</td><td><span class='boldItem'><%#((int)DataBinder.Eval(Container, "DataItem.IncompleteRecordingsCount")).ToString("N0")%></span></td><td>No legibles:</td><td><span class='boldItem'><%#((int)DataBinder.Eval(Container, "DataItem.NoLegibleRecordingsCount")).ToString("N0")%></span>&#160;&#160;&#160;</td><td style="width:20px">Estado:&#160;&#160;</td><td><span class='boldItem'><%#DataBinder.Eval(Container, "DataItem.RecordingBookStatusName")%></span>&#160;&#160;</td></tr>
			<tr><td style="white-space:nowrap">Por registrar:</td><td><span class='boldItem'><%#((int)DataBinder.Eval(Container, "DataItem.LeftCapturedRecordingsCount")).ToString("N0")%>&#160;&#160;&#160;</span></td><td>Pendientes:&#160;</td><td><span class='boldItem'><%#((int)DataBinder.Eval(Container, "DataItem.PendingRecordingsCount")).ToString("N0")%></span></td><td style="width:20px">Avance:&#160;&#160;</td><td><span class='boldItem'><%# Convert.ToDecimal(DataBinder.Eval(Container, "DataItem.CapturedRecordingsPercentage")).ToString("P2")%></span>&#160;&#160;</td></tr>
		</table>
	</td>
	<td style="white-space:nowrap;">
	  <img src="../themes/default/textures/pixel.gif" height="20px" width="1px" alt="" />
	  <br />
		<table class="ghostTable">
		  <tr><td>Digitalizado por:</td><td><span class='boldItem'><%#DataBinder.Eval(Container, "DataItem.ImagesCapturedBy")%></span></td></tr>
		  <tr><td>Cortado por:</td><td><span class='boldItem'><%#DataBinder.Eval(Container, "DataItem.ImagesReviewedBy")%></span></td></tr>
		  <tr><td>Analista asignado:&#160;</td><td><span class='boldItem'><%#DataBinder.Eval(Container, "DataItem.AssignedTo")%></span></td></tr>
		  <tr><td>Rango de fechas:&#160;</td>
		      <td><span class='boldItem'>Del <%#((DateTime)DataBinder.Eval(Container, "DataItem.RecordingsControlFirstDate")).ToString("dd/MMM/yyyy")%>
		          al <%#((DateTime)DataBinder.Eval(Container, "DataItem.RecordingsControlLastDate")).ToString("dd/MMM/yyyy")%>		
		      </span></td>
		  </tr>
    </table>
	</td>
	<td style="white-space:nowrap;width:40%">
		<span class='boldItem'>¿Qué debo hacer con este libro?</span><br /><br />
	  <img src="../themes/default/textures/pixel.gif" height="20px" width="1px" alt="" />
		&#160;<a href="javascript:doOperation('viewRecordingBook', <%#DataBinder.Eval(Container, "DataItem.RecordingBookId")%>)" title='' ><img src="../themes/default/bullets/edit_sm.gif" alt="" title="Abre el analizador de libros registrales"/>Analizar las inscripciones de este libro</a>
		<br /><br />
    <img src="../themes/default/textures/pixel.gif" height="20px" width="1px" alt="" />
		<span style="display:<%#(int) DataBinder.Eval(Container, "DataItem.LeftCapturedRecordingsCount") == 0 ? "inline" : "none"%>">
		&#160;<a href="javascript:doOperation('sendRecordingBookToQualityControl', <%#DataBinder.Eval(Container, "DataItem.RecordingBookId")%>)" title='' ><img src="../themes/default/bullets/todo.ok.gif" alt="" title="Envía este libro al área de control de calidad"/>Enviar este libro al área de control de calidad</a>
		</span>
	</td>
</tr>
<%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).IsLastItem((int) DataBinder.Eval(Container, "ItemIndex")) ? "</tbody>" : String.Empty %>
