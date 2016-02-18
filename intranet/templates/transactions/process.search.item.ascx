<%@ Import Namespace="Empiria" %>
<%@ Import Namespace="Empiria.Land.Registration" %>
<%@ Import Namespace="Empiria.Land.Registration.Transactions" %>
<%@ Import Namespace="Empiria.Land.UI" %>
<%# ((int) DataBinder.Eval(Container, "ItemIndex")) == 0 ? "<tbody>" : String.Empty %>
<tr class="<%# ((int) DataBinder.Eval(Container, "ItemIndex") % 2 == 0 ? String.Empty  : "oddDataRow") %>" onmouseover="dataGridRowSelect(this, true);" onmouseout="dataGridRowSelect(this, false);">
	<td style="width:20%">
		<table class="ghostTable">
			<tr><td rowspan="5"><a href="javascript:doOperation('editTransaction', <%#DataBinder.Eval(Container, "DataItem.TransactionId")%>)"><img src="../themes/default/app.icons/documents.gif" alt='' title="Abre el trámite" style='margin-right:20px' /></a></td>
					<td colspan="2" style='height:22px'><a id='ancTransactionKey<%#DataBinder.Eval(Container, "DataItem.TransactionId")%>' class="detailsLinkTitle" href="javascript:doOperation('editTransaction', <%#DataBinder.Eval(Container, "DataItem.TransactionId")%>)" title="Abre el trámite"><%#DataBinder.Eval(Container, "DataItem.TransactionUID")%></a>
          &nbsp;&nbsp;
          Documento: <a class="detailsLinkTitle" href="javascript:doOperation('showDocument', <%#DataBinder.Eval(Container, "DataItem.DocumentId")%>)" title="Muestra el documento"><%#DataBinder.Eval(Container, "DataItem.DocumentUID")%></a></td></tr>
      <tr><td style="width:20px">Trámite:&nbsp;</td><td width="70%"><span class='boldItem'><%#DataBinder.Eval(Container, "DataItem.TransactionType")%></span></td></tr>
      <tr><td style="width:20px">Documento:&nbsp;</td><td><span class='boldItem'><%#DataBinder.Eval(Container, "DataItem.DocumentType")%></span></td></tr>
      <tr><td style="">Distrito/Mesa: &nbsp; &nbsp; &nbsp;</td><td><span class='boldItem'><%#DataBinder.Eval(Container, "DataItem.RecorderOffice")%></span></td></tr>
      <tr><td>Estado actual:&nbsp;</td><td><span class='boldItem'><%#DataBinder.Eval(Container, "DataItem.CurrentTransactionStatusName")%></span>&nbsp;&nbsp;&nbsp;</td></tr>
    </table>
	</td>
	<td style="white-space:nowrap;width:30%">
		<table class="ghostTable">
      <tr><td style="width:100%; white-space:normal" colspan="2"><span class='boldItem' style="width:100%; white-space:normal"><%#DataBinder.Eval(Container, "DataItem.RequestedBy")%></span></td></tr>
      <tr><td style="width:20px">Instrumento:&nbsp;</td><td width="90%"><span class='boldItem'><%#((string)DataBinder.Eval(Container, "DataItem.DocumentDescriptor")).Length == 0 ? "No proporcionado" : DataBinder.Eval(Container, "DataItem.DocumentDescriptor") %></span></td></tr>
      <tr><td style="width:20px">Derechos:&nbsp;</td><td><span class='boldItem'><%#((decimal)DataBinder.Eval(Container, "DataItem.PaymentsTotal")).ToString("C2")%></span> &nbsp;&nbsp;R: <%#DataBinder.Eval(Container, "DataItem.ReceiptNo")%></td></tr>
			<tr><td style="width:20px">Presentación:&nbsp;</td><td><span class='boldItem'><%#((DateTime)DataBinder.Eval(Container, "DataItem.PresentationTime")) == Empiria.ExecutionServer.DateMaxValue ? "No presentado" : ((DateTime)DataBinder.Eval(Container, "DataItem.PresentationTime")).ToString("dd/MMM/yyyy HH:mm")%></span></td></tr>
      <tr><td style="white-space:nowrap">Siguiente estado:&nbsp;</td><td><span id="ancNextStatus<%#DataBinder.Eval(Container, "DataItem.TransactionId")%>" class='boldItem'><%#DataBinder.Eval(Container, "DataItem.NextTransactionStatusName")%></span></td></tr>
    </table>
  </td>
	<td style="white-space:nowrap;width:10%">
		<table class="ghostTable">
      <tr><td style="width:100%; white-space:normal" colspan="2"><span class='boldItem' style="width:100%; white-space:normal"><%#DataBinder.Eval(Container, "DataItem.Agency")%></span></td></tr>
      <tr><td style="white-space:nowrap">Tiempo de trabajo:&nbsp;</td><td width="70%"><span class='boldItem'><%#EmpiriaString.TimeSpanString((int)DataBinder.Eval(Container, "DataItem.WorkingTime"))%></span></td></tr>
      <tr><td style="white-space:nowrap">Duración total:&nbsp;</td><td><span class='boldItem'><%#EmpiriaString.TimeSpanString((int)DataBinder.Eval(Container, "DataItem.TotalTime"))%></span></td></tr>
			<tr><td style="width:100px">Complejidad:&nbsp;</td><td><span class='boldItem'><%#((decimal)DataBinder.Eval(Container, "DataItem.ComplexityIndex")).ToString("N1")%></span></td></tr>
			<tr style='display:<%#((DateTime)DataBinder.Eval(Container, "DataItem.ExpectedDelivery")) == Empiria.ExecutionServer.DateMaxValue ? "none" : "visible"%>'><td style="white-space:nowrap">A entregar el:&nbsp;</td><td><span class='boldItem'><%#((DateTime)DataBinder.Eval(Container, "DataItem.ExpectedDelivery")) == Empiria.ExecutionServer.DateMaxValue ? String.Empty : ((DateTime)DataBinder.Eval(Container, "DataItem.ExpectedDelivery")).ToString("dd/MMM/yyyy")%></span></td></tr>
      <tr style='display:<%#((DateTime)DataBinder.Eval(Container, "DataItem.LastReentryTime")) == Empiria.ExecutionServer.DateMaxValue ? "none" : "visible"%>'><td style="white-space:nowrap" colspan="2"><span class='detailsLinkTitleOrange'><%#((DateTime)DataBinder.Eval(Container, "DataItem.LastReentryTime")) == Empiria.ExecutionServer.DateMaxValue ? String.Empty : "Reingreso: &nbsp;" + ((DateTime)DataBinder.Eval(Container, "DataItem.LastReentryTime")).ToString("dd/MMM/yyyy HH:mm")%></span></td></tr>
    </table>
  </td>
	<td style="white-space:nowrap;width:20%">
		<table class="ghostTable">
      <tr><td colspan="2"><b>Último movimiento:</b></td></tr>
      <tr><td style="width:48px;" nowrap="nowrap">Lo tiene:&nbsp;</td><td width="90%"><span class='boldItem'><%# Convert.ToChar(DataBinder.Eval(Container, "DataItem.CurrentTransactionStatus")) == 'Y' || ((int) DataBinder.Eval(Container, "DataItem.NextContactId") == -6) ? "Interesado" : DataBinder.Eval(Container, "DataItem.Responsible")%></span></td></tr>
      <tr><td style="width:20px">Recibió:&nbsp;</td><td><span class='boldItem'><%#((DateTime)DataBinder.Eval(Container, "DataItem.CheckInTime")).ToString("dd/MMM/yyyy HH:mm")%></span></td></tr>
      <tr><td style="width:20px">Entregó:&nbsp;</td><td><span class='boldItem'><%# Convert.ToChar(DataBinder.Eval(Container, "DataItem.CurrentTransactionStatus")) == 'Y' || ((int) DataBinder.Eval(Container, "DataItem.NextContactId") == -6) ? DataBinder.Eval(Container, "DataItem.Responsible") : DataBinder.Eval(Container, "DataItem.AssignedBy")%></span></td></tr>
    </table>
  </td>
</tr>
<%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).IsLastItem((int) DataBinder.Eval(Container, "ItemIndex")) ? "</tbody>" : String.Empty %>
