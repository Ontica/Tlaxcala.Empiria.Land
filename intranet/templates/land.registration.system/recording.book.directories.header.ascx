<thead>
  <%=((Empiria.Presentation.Web.MultiViewDashboard) this.Page).ViewTitle%>
  <tr>
    <th colspan="3">
			<a href="javascript:sendPageCommand('sortData', 'FilesFolderDisplayName ASC')">Directorio de imágenes</a> / 
			<a href="javascript:sendPageCommand('sortData', 'FilesCount ASC')">Número de imágenes</a> / 
			<a href="javascript:sendPageCommand('sortData', 'FilesTotalSize ASC')">Tamaño</a> / 
			<a href="javascript:sendPageCommand('sortData', 'LastUpdateDate ASC')">Última modificación</a>    			
		</th>
  </tr>
</thead>
<%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).HintContent%>
