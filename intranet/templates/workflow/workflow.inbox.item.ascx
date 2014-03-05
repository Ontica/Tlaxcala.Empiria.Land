<tr class="<%# ((int) DataBinder.Eval(Container, "ItemIndex") % 2 == 0) ? "detailsItem" : "detailsOddItem" %>">
  <td><img src="../themes/default/bullets/todosm.gif" alt="" title="Alerta" /></td>
  <td><img src="../themes/default/bullets/clip.gif" alt="" title="Elementos adjuntos" /></td>
  <td>
    <a class="detailsLinkTitle" href="javascript:doCommand('createViewCmd', 'WebUI.Workflow.DoWorkItem', 'id=<%# DataBinder.Eval(Container, "DataItem.WorkItemId")%>')"><%# DataBinder.Eval(Container, "DataItem.Description") %></a><br />
  </td>
  <td nowrap="nowrap">Manuel Cota</td>
  <td nowrap="nowrap">Grupo de trabajo</td>  
  <td nowrap="nowrap"><%# ((DateTime) DataBinder.Eval(Container, "DataItem.StartTime")).ToString("dd/MMM/yyyy HH:mm") %></td>
  <td nowrap="nowrap"><%# ((DateTime) DataBinder.Eval(Container, "DataItem.StartTime")).ToString("dd/MMM/yyyy HH:mm") %></td>
</tr>
