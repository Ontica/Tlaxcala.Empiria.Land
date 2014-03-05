<thead>
  <%=((Empiria.Presentation.Web.MultiViewDashboard) this.Page).ViewTitle%>
  <tr>
    <th><a href="javascript:sendPageCommand('sortData', 'RecorderOffice ASC')">Distrito</a></th>
    <th align="right"><a href="javascript:sendPageCommand('sortData', 'TotalRecordingsCount DESC')">Libros totales</a></th>
    <th align="right"><a href="javascript:sendPageCommand('sortData', 'ObsoleteRecordingsCount DESC')">Imágenes</a></th>
    <th align="right"><a href="javascript:sendPageCommand('sortData', 'PendingRecordingsCount DESC')">Inscripciones</a></th>
    <th align="right"><a href="javascript:sendPageCommand('sortData', 'PendingRecordingsCount DESC')">No legibles</a></th>
    <th align="right"><a href="javascript:sendPageCommand('sortData', 'NoLegibleRecordingsCount DESC')">No vigentes</a></th>
    <th>&nbsp;</th>
  </tr>
</thead>
<%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).HintContent%>
