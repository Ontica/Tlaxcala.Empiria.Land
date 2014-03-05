<thead>
  <%=((Empiria.Presentation.Web.MultiViewDashboard) this.Page).ViewTitle%>
  <tr>
    <th><a href="javascript:sendPageCommand('sortData', 'RecordingCapturedBy ASC')">Nombre del analista</a></th>
    <th align="right"><a href="javascript:sendPageCommand('sortData', 'TotalRecordingsCount DESC')">Inscripciones</a></th>
    <th align="right"><a href="javascript:sendPageCommand('sortData', 'ObsoleteRecordingsCount DESC')">No vigentes</a></th>
    <th align="right"><a href="javascript:sendPageCommand('sortData', 'NoLegibleRecordingsCount DESC')">No legibles</a></th>
    <th align="right"><a href="javascript:sendPageCommand('sortData', 'PendingRecordingsCount DESC')">Pendientes</a></th>
    <th align="right"><a href="javascript:sendPageCommand('sortData', 'ActiveRecordingsCount DESC')">Vigentes</a></th>
    <th align="right"><a href="javascript:sendPageCommand('sortData', 'IncompleteRecordingsCount DESC')">Incompletas</a></th>
    <th align="right"><a href="javascript:sendPageCommand('sortData', 'RegisteredRecordingsCount DESC')">Registradas</a></th>
    <th align="right"><a href="javascript:sendPageCommand('sortData', 'ClosedRecordingsCount DESC')">Cerradas</a></th>
    <th align="right"><a href="javascript:sendPageCommand('sortData', 'RecordingActsCount DESC')">Actos jurídicos</a></th>
    <th align="right"><a href="javascript:sendPageCommand('sortData', 'PropertiesCount DESC')">Predios</a></th>
    <th>&nbsp;</th>
  </tr>
</thead>
<%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).HintContent%>
