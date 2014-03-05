<thead>
  <%=((Empiria.Presentation.Web.MultiViewDashboard) this.Page).ViewTitle%>
  <tr>
    <th>
			<a href="javascript:sendPageCommand('sortData', 'RecordingBookFullName ASC')">Libro</a> / 
			<a href="javascript:sendPageCommand('sortData', 'RecordingsControlCount DESC')">Inscripciones</a> / 
			<a href="javascript:sendPageCommand('sortData', 'RegisteredRecordingsCount DESC')">Completas</a> / 
			<a href="javascript:sendPageCommand('sortData', 'IncompleteRecordingsCount DESC')">Incompletas</a> /
			<a href="javascript:sendPageCommand('sortData', 'LeftCapturedRecordingsCount DESC')">Por registrar</a> /
			<a href="javascript:sendPageCommand('sortData', 'CapturedRecordingsPercentage DESC')">% Avance</a>
		</th>
    <th>Digitalizador / Cortador / Último analista asignado</th>
    <th>&nbsp;</th>    
  </tr>
</thead>
<%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).HintContent%>
