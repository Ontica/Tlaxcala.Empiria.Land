<thead>
  <%=((Empiria.Presentation.Web.MultiViewDashboard) this.Page).ViewTitle%>
  <tr>
    <th>
			<a href="javascript:sendPageCommand('sortData', 'TransactionKey ASC')">Trámite</a> / 
			<a href="javascript:sendPageCommand('sortData', 'DocumentKey DESC')">Núm documento</a> /
			<a href="javascript:sendPageCommand('sortData', 'TransactionType DESC')">Tipo trámite</a> / 
			<a href="javascript:sendPageCommand('sortData', 'RecorderOffice DESC')">Distrito</a> /
			<a href="javascript:sendPageCommand('sortData', 'TransactionStatusName DESC')">Estado</a> /
			<a href="javascript:sendPageCommand('sortData', 'ControlNumber DESC')">Ctr</a>
		</th>
    <th>
			<a href="javascript:sendPageCommand('sortData', 'RequestedBy ASC')">Nombre</a> / 
			<a href="javascript:sendPageCommand('sortData', 'DocumentNumber DESC')">Instrumento</a> / 
			<a href="javascript:sendPageCommand('sortData', 'ReceiptTotal DESC')">Derechos</a> / 
			<a href="javascript:sendPageCommand('sortData', 'ReceiptNumber DESC')">Recibo</a> /
			<a href="javascript:sendPageCommand('sortData', 'PresentationTime DESC')">Present</a>
    </th>
    <th>
			<a href="javascript:sendPageCommand('sortData', 'ManagementAgency ASC')">Tramitó</a> / 
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
