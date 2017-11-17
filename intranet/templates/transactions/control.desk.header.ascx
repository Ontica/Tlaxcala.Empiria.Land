<thead>
  <%=((Empiria.Presentation.Web.MultiViewDashboard) this.Page).ViewTitle%>
  <tr>
    <th>
			<a href="javascript:sendPageCommand('sortData', 'TransactionUID ASC')">Trámite</a> /
			<a href="javascript:sendPageCommand('sortData', 'DocumentUID DESC')">Documento</a> /
			<a href="javascript:sendPageCommand('sortData', 'TransactionType ASC')">Tipo trámite</a> /
			<a href="javascript:sendPageCommand('sortData', 'DocumentType ASC')">Tipo documento</a> /
			<a href="javascript:sendPageCommand('sortData', 'RecorderOffice ASC')">Distrito</a> /
			<a href="javascript:sendPageCommand('sortData', 'TransactionStatusName ASC')">Estado</a> /
			<a href="javascript:sendPageCommand('sortData', 'ImagingControlID DESC')">Acervo</a>
		  <a>&#160;</a>		  <a>&#160;</a>      <a>&#160;</a>      <a>&#160;</a>
      <a>&#160;</a>		  <a>&#160;</a>
			<a href="javascript:sendPageCommand('sortData', 'RequestedBy ASC')">Nombre</a> /
		  <a href="javascript:sendPageCommand('sortData', 'DocumentDescriptor ASC')">Instrumento</a> /
			<a href="javascript:sendPageCommand('sortData', 'ReceiptTotal ASC')">Derechos</a> /
			<a href="javascript:sendPageCommand('sortData', 'ReceiptNo DESC')">Recibo</a> /
			<a href="javascript:sendPageCommand('sortData', 'PresentationTime ASC')">Presentación</a> /
			<a href="javascript:sendPageCommand('sortData', 'AuthorizationTime ASC')">Registro</a>
      <a>&#160;</a>		  <a>&#160;</a>      <a>&#160;</a>      <a>&#160;</a>
      <a>&#160;</a>		  <a>&#160;</a>      <a>&#160;</a>      <a>&#160;</a>
      <a>&#160;</a>		  <a>&#160;</a>      <a>&#160;</a>      <a>&#160;</a>

			<a href="javascript:sendPageCommand('sortData', 'ToContact ASC')">Lo tiene</a> /
			<a href="javascript:sendPageCommand('sortData', 'TrackTime DESC')">Recibido</a> /
			<a href="javascript:sendPageCommand('sortData', 'FromContact DESC')">Entregó</a>
      <a>&#160;</a>		  <a>&#160;</a>      <a>&#160;</a>      <a>&#160;</a>
      <a>&#160;</a>		  <a>&#160;</a>      <a>&#160;</a>      <a>&#160;</a>
      <a>&#160;</a>		  <a>&#160;</a>      <a>&#160;</a>      <a>&#160;</a>
      <a>&#160;</a>		  <a>&#160;</a>      <a>&#160;</a>      <a>&#160;</a>
      <a>&#160;</a>		  <a>&#160;</a>      <a>&#160;</a>      <a>&#160;</a>
      <a>&#160;</a>		  <a>&#160;</a>      <a>&#160;</a>      <a>&#160;</a>
    </th>
    <th>¿Qué debo hacer con el trámite?</th>
  </tr>
   <br />
  <br />
</thead>

<%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).HintContent%>
