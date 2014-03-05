<thead>
  <%=((Empiria.Presentation.Web.MultiViewDashboard) this.Page).ViewTitle%>
  <tr>
    <th>
			<a href="javascript:sendPageCommand('sortData', 'TransactionKey ASC')">Trámite</a> / 
			<a href="javascript:sendPageCommand('sortData', 'DocumentKey DESC')">Núm documento</a> /
			<a href="javascript:sendPageCommand('sortData', 'TransactionType ASC')">Tipo trámite</a> / 
			<a href="javascript:sendPageCommand('sortData', 'DocumentType ASC')">Tipo documento</a> /
			<a href="javascript:sendPageCommand('sortData', 'RecorderOffice ASC')">Distrito</a> /
			<a href="javascript:sendPageCommand('sortData', 'TransactionStatusName ASC')">Estado</a> /
			<a href="javascript:sendPageCommand('sortData', 'ControlNumber ASC')">Ctr</a>
		</th>
    <th>
			<a href="javascript:sendPageCommand('sortData', 'RequestedBy ASC')">Nombre</a> / 
		  <a href="javascript:sendPageCommand('sortData', 'DocumentNumber ASC')">Instrumento</a> / 
			<a href="javascript:sendPageCommand('sortData', 'ReceiptTotal ASC')">Derechos</a> / 
			<a href="javascript:sendPageCommand('sortData', 'ReceiptNumber DESC')">Recibo</a> /
			<a href="javascript:sendPageCommand('sortData', 'PostingTime ASC')">Precalificación</a> / 
			<a href="javascript:sendPageCommand('sortData', 'PresentationTime ASC')">Presentación</a>
    </th>
    <th>¿Qué debo hacer con el trámite?</th>
  </tr>
</thead>
<%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).HintContent%>
