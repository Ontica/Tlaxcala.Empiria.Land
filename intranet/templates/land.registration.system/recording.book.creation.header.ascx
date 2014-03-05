<thead>
  <%=((Empiria.Presentation.Web.MultiViewDashboard) this.Page).ViewTitle%>
  <tr>
    <th>
			<a href="javascript:sendPageCommand('sortData', 'FilesFolderDisplayName ASC')">Directorio</a> / 
			<a href="javascript:sendPageCommand('sortData', 'FilesCount ASC')">Imágenes</a> / 
			<a href="javascript:sendPageCommand('sortData', 'FilesTotalSize ASC')">Tamaño</a> / 
			<a href="javascript:sendPageCommand('sortData', 'LastUpdateDate ASC')">Modificado</a>
		</th>
    <th>Información del libro registral</th>
    <th>¿Qué debo hacer?</th>
  </tr>
</thead>
<%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).HintContent%>
