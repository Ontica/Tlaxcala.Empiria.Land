<thead>
  <%=((Empiria.Presentation.Web.MultiViewDashboard) this.Page).ViewTitle%>
  <tr>
    <th>
			<a href="javascript:sendPageCommand('sortData', 'TransactionUID ASC')">Trámite</a> /
			<a href="javascript:sendPageCommand('sortData', 'DocumentUID DESC')">Documento</a> /
			<a href="javascript:sendPageCommand('sortData', 'TransactionType DESC')">Tipo trámite</a> /
			<a href="javascript:sendPageCommand('sortData', 'RecorderOffice DESC')">Distrito</a> /
			<a href="javascript:sendPageCommand('sortData', 'TransactionStatusName DESC')">Estado</a> /
			<a href="javascript:sendPageCommand('sortData', 'ImagingControlID DESC')">Acervo</a>
		</th>
    <th>
			<a href="javascript:sendPageCommand('sortData', 'RequestedBy ASC')">Nombre</a> /
			<a href="javascript:sendPageCommand('sortData', 'DocumentNumber DESC')">Instrumento</a> /
			<a href="javascript:sendPageCommand('sortData', 'ReceiptTotal DESC')">Derechos</a> /
			<a href="javascript:sendPageCommand('sortData', 'ReceiptNumber DESC')">Recibo</a> /
			<a href="javascript:sendPageCommand('sortData', 'PresentationTime DESC')">Present</a> /
			<a href="javascript:sendPageCommand('sortData', 'AuthorizationTime ASC')">Registro</a>
    </th>
    <th>
			<a href="javascript:sendPageCommand('sortData', 'Agency ASC')">Trámitó</a> /
			<a href="javascript:sendPageCommand('sortData', 'WorkingTime DESC')">Tiempo</a> /
			<a href="javascript:sendPageCommand('sortData', 'TotalTime DESC')">Dur</a> /
			<a href="javascript:sendPageCommand('sortData', 'ComplexityIndex DESC')">Cj</a> /
      <a href="javascript:sendPageCommand('sortData', 'LastReentryTime DESC')">F.Reing</a>
    </th>
    <th>
			<a href="javascript:sendPageCommand('sortData', 'ToContact ASC')">Lo tiene</a> /
			<a href="javascript:sendPageCommand('sortData', 'TrackTime DESC')">Recibido</a> /
			<a href="javascript:sendPageCommand('sortData', 'FromContact DESC')">Entregó</a>
    </th>
  </tr>
</thead>
<%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).HintContent%>
