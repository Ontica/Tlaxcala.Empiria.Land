<thead>
  <%=((Empiria.Presentation.Web.MultiViewDashboard) this.Page).ViewTitle%>
  <tr>
    <th colspan="3">
			<a href="javascript:sendPageCommand('sortData', 'RecordingBookNumber DESC, RecordingBookFullName ASC')">Libro registral</a> / 
			<a href="javascript:sendPageCommand('sortData', 'RecordingsControlCount ASC')">Número de inscripciones</a> / 
			<a href="javascript:sendPageCommand('sortData', 'RecordingsControlFirstDate DESC')">Rango de fechas</a>
		</th>
  </tr>
</thead>
<%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).HintContent%>
