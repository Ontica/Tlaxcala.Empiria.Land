<tr class="<%# ((int) DataBinder.Eval(Container, "ItemIndex") % 2 == 0) ? "detailsItem" : "detailsOddItem" %>">
	<td style="width: 75%;">
		<a class="detailsLinkTitle" href="javascript:doCommand('createViewCmd', '~/security/user.editor.aspx?id=<%# DataBinder.Eval(Container, "DataItem.Id") %>', 750, 1000, null, true)" target="_top"><%# DataBinder.Eval(Container, "DataItem.DisplayName") %></a>
		<br />
		<%# DataBinder.Eval(Container, "DataItem.TypeInfo.DisplayName") %><br />
		<%# DataBinder.Eval(Container, "DataItem.EMailAddress") %>
	</td>
	<td align="right">
		<span class="boldItem"><%# DataBinder.Eval(Container, "DataItem.PostedBy.DisplayName") %></span>
		<br />
	  <%# ((DateTime)(DataBinder.Eval(Container, "DataItem.StartDate"))).ToString("dd/MMM/yyyy") %>
	</td>
	<td>&nbsp;</td>
</tr>