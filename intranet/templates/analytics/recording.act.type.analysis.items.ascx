<%@ Import Namespace="Empiria.Presentation" %>
<%@ Import Namespace="Empiria.Land.Registration" %>
<%@ Import Namespace="Empiria.Land.UI" %>
<%# ((int) DataBinder.Eval(Container, "ItemIndex")) == 0 ? "<tbody>" : String.Empty %>
<tr class="<%# ((int) DataBinder.Eval(Container, "ItemIndex") % 2 == 0 ? String.Empty  : "oddDataRow") %>" onmouseover="dataGridRowSelect(this, true);" onmouseout="dataGridRowSelect(this, false);">
	<td style="white-space:nowrap;">
    <%# DataBinder.Eval(Container, "DataItem.RecordingActTypeDisplayName")%>
	</td>
	<td style="white-space:nowrap;" align="right">
    <%#((int)DataBinder.Eval(Container, "DataItem.RecordingActsCount")).ToString("N0")%>   
	</td>
	<td style="white-space:nowrap;" align="right">
    <%# Convert.ToDecimal(DataBinder.Eval(Container, "DataItem.ParetoItemPercentage")).ToString("P2")%>
	</td>
	<td style="white-space:nowrap;" align="right">
    <%# Convert.ToDecimal(DataBinder.Eval(Container, "DataItem.ParetoCumulativePercentage")).ToString("P2")%>
	</td>
	<td style="white-space:nowrap;" align="right">
    <%# DataBinder.Eval(Container, "DataItem.ParetoItemRanking")%>
	</td>
	<td width="40%">
	  <img src="../themes/default/textures/gauge.jpg" height="20px" width="<%# Convert.ToDecimal(DataBinder.Eval(Container, "DataItem.ParetoItemPercentage")) * 100%>%" alt="" />
	</td>
</tr>
<%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).IsLastItem((int) DataBinder.Eval(Container, "ItemIndex")) ? "</tbody>" : String.Empty %>
