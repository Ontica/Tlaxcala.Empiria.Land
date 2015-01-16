<%@ Import Namespace="Empiria.Presentation" %>
<%@ Import Namespace="Empiria.Land.Registration" %>
<%@ Import Namespace="Empiria.Land.UI" %>
<%# ((int) DataBinder.Eval(Container, "ItemIndex")) == 0 ? "<tbody>" : String.Empty %>
<tr class="<%# ((int) DataBinder.Eval(Container, "ItemIndex") % 2 == 0 ? String.Empty  : "oddDataRow") %>" onmouseover="dataGridRowSelect(this, true);" onmouseout="dataGridRowSelect(this, false);">
	<td style="white-space:nowrap;" width="30%">
    <%# DataBinder.Eval(Container, "DataItem.RecordingCapturedBy")%>
	</td>
	<td style="white-space:nowrap;" align="right">
    <%#((int)DataBinder.Eval(Container, "DataItem.TotalRecordingsCount")).ToString("N0")%>
	</td>
	<td style="white-space:nowrap;" align="right">
    <%#((int)DataBinder.Eval(Container, "DataItem.ObsoleteRecordingsCount")).ToString("N0")%>
	</td>
	<td style="white-space:nowrap;" align="right">
    <%#((int)DataBinder.Eval(Container, "DataItem.NoLegibleRecordingsCount")).ToString("N0")%>
	</td>
	<td style="white-space:nowrap;" align="right">
    <%#((int)DataBinder.Eval(Container, "DataItem.PendingRecordingsCount")).ToString("N0")%>
	</td>
	<td style="white-space:nowrap;" align="right">
    <%#((int)DataBinder.Eval(Container, "DataItem.ActiveRecordingsCount")).ToString("N0")%>
	</td>
	<td style="white-space:nowrap;" align="right">
    <%#((int)DataBinder.Eval(Container, "DataItem.IncompleteRecordingsCount")).ToString("N0")%>
	</td>
	<td style="white-space:nowrap;" align="right">
    <%#((int)DataBinder.Eval(Container, "DataItem.RegisteredRecordingsCount")).ToString("N0")%>
	</td>
	<td style="white-space:nowrap;" align="right">
    <%#((int)DataBinder.Eval(Container, "DataItem.ClosedRecordingsCount")).ToString("N0")%>
	</td>
	<td style="white-space:nowrap;" align="right">
    <%#((int)DataBinder.Eval(Container, "DataItem.RecordingActsCount")).ToString("N0")%>
	</td>
	<td style="white-space:nowrap;" align="right">
    <%#((int)DataBinder.Eval(Container, "DataItem.PropertiesCount")).ToString("N0")%>
	</td>
	<td width="30%">&nbsp;</td>
</tr>
