<%@ Import Namespace="Empiria" %>
<%@ Import Namespace="Empiria.Presentation" %>
<%@ Import Namespace="Empiria.Land.Registration" %>
<%@ Import Namespace="Empiria.Land.UI" %>

<%# ((int) DataBinder.Eval(Container, "ItemIndex")) == 0 ? "<tbody>" : String.Empty %>
<%# ((int) DataBinder.Eval(Container, "ItemIndex")) % 3 == 0 ? "<tr class='" + ((int) DataBinder.Eval(Container, "ItemIndex") % 2 == 0 ? String.Empty  : "oddDataRow") + "' onmouseover='dataGridRowSelect(this, true);' onmouseout='dataGridRowSelect(this, false);'>" : String.Empty %> 
	<td style="white-space:nowrap;">
		<table class="ghostTable" width="30%">
			<tr><td rowspan="6"><a href="javascript:doOperation('viewRecordingBook', <%#DataBinder.Eval(Container, "DataItem.RecordingBookId")%>)"><img src="../themes/default/app.icons/library.gif" alt='' title="Abre este libro registral para su consulta" style='margin-right:20px' /></a></td>
					<td colspan="4" style='line-height:16pt'><a id="ancDirectory<%#DataBinder.Eval(Container, "DataItem.RecordingBookId")%>" class="detailsLinkTitle" href="javascript:doOperation('viewRecordingBook', <%#DataBinder.Eval(Container, "DataItem.RecordingBookId")%>)" title="Abre este libro registral para su consulta"><%#DataBinder.Eval(Container, "DataItem.RecordingBookFullName")%></a></td></tr>
			<tr><td colspan="4" style="width:100%; line-height:8pt"><b><%#DataBinder.Eval(Container, "DataItem.RecordingsClassName")%></b></td></tr>
			<tr><td>Distrito:</td><td><span class='boldItem'><%#DataBinder.Eval(Container, "DataItem.RecorderOffice")%> &nbsp; &nbsp; &nbsp;</span></td><td>Tipo:&nbsp;&nbsp;</td><td style="width:100%"><span class='boldItem'><%#DataBinder.Eval(Container, "DataItem.RecordingsClassName")%></span></td></tr>
			<tr><td>Sección:</td><td><span class='boldItem'><%#DataBinder.Eval(Container, "DataItem.SectionTag")%>&nbsp; &nbsp; &nbsp;</span></td><td>Inscripciones:&nbsp;&nbsp;</td><td style="width:100%"><span class='boldItem'><%#((int)DataBinder.Eval(Container, "DataItem.RecordingsControlCount")).ToString("N0")%></span></td></tr>
      <tr><td>Libro:</td><td><span class='boldItem'><%#DataBinder.Eval(Container, "DataItem.ParentRecordingBookTag")%></span></td><td style="white-space:nowrap;">Fecha inicial:</td><td style="width:100%"><span class='boldItem'><%#(EmpiriaString.DateTimeString((DateTime)DataBinder.Eval(Container, "DataItem.RecordingsControlFirstDate")))%></span></td></tr>
			<tr><td>Volumen:&nbsp; &nbsp;</td><td><span class='boldItem'><%#DataBinder.Eval(Container, "DataItem.RecordingBookNumber")%></span></td><td style="white-space:nowrap;">Fecha final:&nbsp;&nbsp;</td><td style="width:100%"><span class='boldItem'><%#(EmpiriaString.DateTimeString((DateTime)DataBinder.Eval(Container, "DataItem.RecordingsControlLastDate")))%></span>&nbsp;&nbsp;</td></tr>
		</table>
	</td>
<%# ((int) DataBinder.Eval(Container, "ItemIndex")) % 3 == 2 || ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).IsLastItem((int) DataBinder.Eval(Container, "ItemIndex")) ? "</tr>" : String.Empty %>
<%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).IsLastItem((int) DataBinder.Eval(Container, "ItemIndex")) ? "</tbody>" : String.Empty %>
