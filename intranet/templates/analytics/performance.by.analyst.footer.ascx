<tfoot>
  <tr>
    <td>
      <b>Totales:</b>
      <br /><br />&nbsp;
    </td>
    <td>
      <b><%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).GetColumnTotal("TotalRecordingsCount").ToString("N0")%></b>
      <br /><br />&nbsp;
    </td>
    <td>
      <b><%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).GetColumnTotal("ObsoleteRecordingsCount").ToString("N0")%></b>
      <br /><br />
      (%) <b><%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).GetColumnPercentage("ObsoleteRecordingsCount", "TotalRecordingsCount").ToString("N2")%></b>
    </td>
    <td>
      <b><%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).GetColumnTotal("NoLegibleRecordingsCount").ToString("N0")%></b>
      <br /><br />
      (%) <b><%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).GetColumnPercentage("NoLegibleRecordingsCount", "TotalRecordingsCount").ToString("N2")%></b>
    </td>
    <td>
      <b><%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).GetColumnTotal("PendingRecordingsCount").ToString("N0")%></b>
      <br /><br />
      (%) <b><%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).GetColumnPercentage("PendingRecordingsCount", "TotalRecordingsCount").ToString("N2")%></b>
    </td>
    <td>
      <b><%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).GetColumnTotal("ActiveRecordingsCount").ToString("N0")%></b>
      <br /><br />
      (%) <b><%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).GetColumnPercentage("ActiveRecordingsCount", "TotalRecordingsCount").ToString("N2")%></b>
    </td>
    <td>
      <b><%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).GetColumnTotal("IncompleteRecordingsCount").ToString("N0")%></b>
      <br /><br />
      (%) <b><%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).GetColumnPercentage("IncompleteRecordingsCount", "TotalRecordingsCount").ToString("N2")%></b>
    </td>
    <td>
      <b><%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).GetColumnTotal("RegisteredRecordingsCount").ToString("N0")%></b>
      <br /><br />
      (%) <b><%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).GetColumnPercentage("RegisteredRecordingsCount", "TotalRecordingsCount").ToString("N2")%></b>
    </td>
    <td>
      <b><%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).GetColumnTotal("ClosedRecordingsCount").ToString("N0")%></b>
      <br /><br />
      (%) <b><%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).GetColumnPercentage("ClosedRecordingsCount", "TotalRecordingsCount").ToString("N2")%></b>
    </td>
    <td>
      <b><%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).GetColumnTotal("RecordingActsCount").ToString("N0")%></b>
      <br /><br />&nbsp; 
    </td>
    <td>
      <b><%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).GetColumnTotal("PropertiesCount").ToString("N0")%></b>
      <br /><br />&nbsp;
    </td>      
    <td>&nbsp;</td>
  </tr>
</tfoot>