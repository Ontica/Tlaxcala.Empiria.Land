<%@ Import Namespace="Empiria.Presentation" %>
<%@ Import Namespace="Empiria.Land.Registration" %>
<%@ Import Namespace="Empiria.Land.Registration.Transactions" %>
<%@ Import Namespace="Empiria.Land.UI" %>
<%# ((int) DataBinder.Eval(Container, "ItemIndex")) == 0 ? "<tbody>" : String.Empty %>
<tr class="<%# ((int) DataBinder.Eval(Container, "ItemIndex") % 2 == 0 ? String.Empty  : "oddDataRow") %>" onmouseover="dataGridRowSelect(this, true);" onmouseout="dataGridRowSelect(this, false);">
	<td style="width:20%">
		<table class="ghostTable">
			<tr><td rowspan="5">
            <a href="javascript:doOperation('editTransaction', <%#DataBinder.Eval(Container, "DataItem.TransactionId")%>)">
                <img src="../themes/default/app.icons/documents.gif" alt='' title="Abre el trámite" style='margin-right:20px' /></a>
                <br />
            <a href="javascript:doOperation('viewDocumentImaging', <%#DataBinder.Eval(Container, "DataItem.DocumentId")%>)" class="boldItem">
              <%#DataBinder.Eval(Container, "DataItem.ImagingControlID")%></a>
			    </td>
		      <td colspan="2" style='height:22px'><a id="ancTransactionKey<%#DataBinder.Eval(Container, "DataItem.TransactionId")%>" class="detailsLinkTitle" href="javascript:doOperation('editTransaction', <%#DataBinder.Eval(Container, "DataItem.TransactionId")%>)" title="Abre el trámite"><%#DataBinder.Eval(Container, "DataItem.TransactionUID")%></a>
         &#160;&#160;
          Documento: <a class="detailsLinkTitle" href="javascript:doOperation('showDocument', <%#DataBinder.Eval(Container, "DataItem.DocumentId")%>)" title="Muestra el documento"><%#DataBinder.Eval(Container, "DataItem.DocumentUID")%></a></td></tr>
      <tr><td style="width:20px">Trámite:&#160;</td><td width="70%"><span class='boldItem'><%#DataBinder.Eval(Container, "DataItem.TransactionType")%></span></td></tr>
      <tr><td style="width:20px">Documento:&#160;</td><td><span class='boldItem'><%#DataBinder.Eval(Container, "DataItem.DocumentType")%></span></td></tr>
      <tr><td style="">Distrito/Mesa:&#160;&#160;&#160;</td><td><span class='boldItem'><%#DataBinder.Eval(Container, "DataItem.RecorderOffice")%></span></td></tr>
      <tr><td>Estado actual:&#160;</td><td><span id='ancStatus<%#DataBinder.Eval(Container, "DataItem.TransactionId")%>' class='boldItem'><%#DataBinder.Eval(Container, "DataItem.CurrentTransactionStatusName")%></span>&#160;&#160;&#160;</td></tr>
    </table>
	</td>
	<td style="white-space:nowrap;width:30%">
		<table class="ghostTable">
      <tr><td style="width:100%; white-space:normal" colspan="2"><span id="ancRequestedBy<%#DataBinder.Eval(Container, "DataItem.TransactionId")%>" class='boldItem' style="width:100%; white-space:normal"><%#DataBinder.Eval(Container, "DataItem.RequestedBy")%></span></td></tr>
      <tr><td style="width:20px">Instrumento:&#160;</td><td width="90%"><span id="ancInstrument<%#DataBinder.Eval(Container, "DataItem.TransactionId")%>" class='boldItem' style="white-space:normal"><%#((string)DataBinder.Eval(Container, "DataItem.DocumentDescriptor")).Length == 0 ? "No proporcionado" : DataBinder.Eval(Container, "DataItem.DocumentDescriptor") %></span></td></tr>
      <tr><td style="width:20px">Derechos:&#160;</td><td><span class='boldItem'><%#((decimal)DataBinder.Eval(Container, "DataItem.PaymentsTotal")).ToString("C2")%></span>&#160;&#160;R: <%#DataBinder.Eval(Container, "DataItem.ReceiptNo")%></td></tr>
			<tr><td style="width:20px">Presentación:&#160;</td>
        <td><span class='boldItem'><%#((DateTime)DataBinder.Eval(Container, "DataItem.PresentationTime")) == Empiria.ExecutionServer.DateMaxValue ? "No presentado" : ((DateTime)DataBinder.Eval(Container, "DataItem.PresentationTime")).ToString("dd/MMM/yyyy HH:mm")%></span>
       &#160; <%#((DateTime)DataBinder.Eval(Container, "DataItem.AuthorizationTime")) == Empiria.ExecutionServer.DateMinValue ? "" : "Reg: <span class='boldItem'>" + ((DateTime)DataBinder.Eval(Container, "DataItem.AuthorizationTime")).ToString("dd/MMM/yyyy") + "</span>" %>
        </td>
			</tr>
      <tr><td colspan="2">
            <input class="button" type='button' value="Generar carátula y número de control" onclick="javascript:doOperation('generateImagingControlID', <%#DataBinder.Eval(Container, "DataItem.TransactionId")%>, <%#DataBinder.Eval(Container, "DataItem.DocumentId")%>)"
                   style="width:200px;display:<%# (Convert.ToChar(DataBinder.Eval(Container, "DataItem.TransactionStatus")) == 'A') && (string) DataBinder.Eval(Container, "DataItem.ImagingControlID") == "" ? "inline" : "none" %>"  />
          </td>
      </tr>
    </table>
  </td>
	<td style="white-space:nowrap;width:40%">
		<br />
		Nuevo estado:
		<select id="cboOperation<%#DataBinder.Eval(Container, "DataItem.TransactionId")%>" class="selectBox" style="width:220px" title="">
			<option value=''>( Seleccionar )</option>
      <%#LRSHtmlSelectControls.GetTransactionNewStatusComboItems((int) DataBinder.Eval(Container, "DataItem.TransactionTypeId"), (int) DataBinder.Eval(Container, "DataItem.DocumentTypeId"), (LRSTransactionStatus) Convert.ToChar(DataBinder.Eval(Container, "DataItem.TransactionStatus")))%>
    </select><img class='comboExecuteImage' src="../themes/default/buttons/next.gif" alt=""  title="Ejecuta la operación seleccionada" onclick="doTransactionOperation(<%# DataBinder.Eval(Container, "DataItem.TransactionId")%>)"/>
   <br />
	 <textarea id="txtNotes<%# DataBinder.Eval(Container, "DataItem.TransactionId")%>" class="textArea" rows="2" cols="72" style="width:288px"></textarea>
	</td>
</tr>
<%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).IsLastItem((int) DataBinder.Eval(Container, "ItemIndex")) ? "</tbody>" : String.Empty %>
