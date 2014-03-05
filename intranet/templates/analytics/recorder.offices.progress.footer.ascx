<tfoot align="left">
  <tr align='left'>
    <td>
      <b>Totales:</b>
      <br /><br />&nbsp;
    </td>
	  <td style="white-space:nowrap;" align='left'>
      <table class="ghostTable" align='left'>
        <tr><td style="text-align:left">Libros de traslativo:&nbsp;&nbsp;&nbsp;</td><td align="right" style='width:120px'><span class='boldItem'><%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).GetColumnTotal("DomainTotalBooks").ToString("N0")%></span></td><td>&nbsp;</td></tr>
        <tr><td style="text-align:left">Libros creados:</td><td align="right"><span class='boldItem'><%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).GetColumnTotal("DomainCreatedBooks").ToString("N0")%></span></td><td align="right">&nbsp; &nbsp; &nbsp;<span class='boldItem'><%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).GetColumnPercentage("DomainCreatedBooks", "DomainTotalBooks").ToString("N1")%> %</span></td></tr>
        <tr><td style="text-align:left">Libros por crear: </td><td align="right"><span class='boldItem'><%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).GetColumnTotal("DomainNotCreatedBooks").ToString("N0")%></span></td><td align="right">&nbsp; &nbsp; &nbsp;<span class='boldItem'><%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).GetColumnPercentage("DomainNotCreatedBooks", "DomainTotalBooks").ToString("N1")%> %</span></td></tr>
      </table>
	  </td>
    <td style="white-space:nowrap;" align='left'>
      <table class="ghostTable" align='left'>
        <tr><td style="text-align:left">Total imágenes:&nbsp;&nbsp;&nbsp;</td><td align="right" style='width:120px'><span class='boldItem'><%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).GetColumnTotal("DomainFilesCount").ToString("N0")%></span></td><td>(traslat)</td></tr>
        <tr><td style="text-align:left">No legibles:</td><td align="right"><span class='boldItem'><%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).GetColumnTotal("NoLegibleToReplaceImages").ToString("N0")%></span></td><td align="right">&nbsp; &nbsp; &nbsp;<span class='boldItem'><%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).GetColumnPercentage("NoLegibleToReplaceImages", "DomainFilesCount").ToString("N2")%> %</span></td></tr>
        <tr><td style="text-align:left">Proyectadas:</td><td align="right"><span class='boldItem'><%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).GetColumnTotal("NoLegibleToReplaceImagesPry").ToString("N0")%></span></td><td align="right">&nbsp; &nbsp; &nbsp;<span class='boldItem'><%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).GetColumnPercentage("NoLegibleToReplaceImagesPry", "DomainFilesCount").ToString("N2")%> %</span></td></tr>
      </table>
	  </td>
    <td style="white-space:nowrap;" align='left'>
      <table class="ghostTable" align='left'>
        <tr><td style="text-align:left">Total inscripciones:&nbsp;&nbsp;&nbsp;</td><td align="right" style='width:120px'><span class='boldItem'><%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).GetColumnTotal("DomainRecordingsControlCount").ToString("N0")%></span></td><td>(traslat)</td></tr>
        <tr><td style="text-align:left">Registradas:</td><td align="right"><span class='boldItem'><%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).GetColumnTotal("CapturedRecordingsCount").ToString("N0")%></span></td><td align="right">&nbsp; &nbsp; &nbsp;<span class='boldItem'><%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).GetColumnPercentage("CapturedRecordingsCount", "DomainRecordingsControlCount").ToString("N2")%> %</span></td></tr>
        <tr><td style="text-align:left">Por registrar: </td><td align="right"><span class='boldItem'><%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).GetColumnTotal("LeftCapturedRecordingsCount").ToString("N0")%></span></td><td align="right">&nbsp; &nbsp; &nbsp;<span class='boldItem'><%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).GetColumnPercentage("LeftCapturedRecordingsCount", "DomainRecordingsControlCount").ToString("N2")%> %</span></td></tr>
      </table>
	  </td>
    <td style="white-space:nowrap;" align='left'>
      <table class="ghostTable">
        <tr><td style="text-align:left">No legibles:&nbsp;&nbsp;&nbsp;</td><td align="right"><span class='boldItem'><%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).GetColumnPercentage("NoLegibleRecordingsCount", "CapturedRecordingsCount").ToString("N2")%> %</span></td></tr>
        <tr><td style="text-align:left">Reales:</td><td align="right" style='width:120px'><span class='boldItem'><%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).GetColumnTotal("NoLegibleRecordingsCount").ToString("N0")%></span></td></tr>
        <tr><td style="text-align:left">Proyectadas: </td><td align="right"><span class='boldItem'><%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).GetColumnTotal("NoLegibleRecordingsPry").ToString("N0")%></span></td></tr>
      </table>
	  </td>
    <td style="white-space:nowrap;" align='left'>
      <table class="ghostTable">
        <tr><td style="text-align:left">No vigentes:&nbsp;&nbsp;&nbsp;</td><td align="right"><span class='boldItem'><%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).GetColumnPercentage("ObsoleteRecordingsCount", "CapturedRecordingsCount").ToString("N2")%> %</span></td></tr>
        <tr><td style="text-align:left">Reales:</td><td align="right" style='width:120px'><span class='boldItem'><%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).GetColumnTotal("ObsoleteRecordingsCount").ToString("N0")%></span></td></tr>
        <tr><td style="text-align:left">Proyectadas: </td><td align="right"><span class='boldItem'><%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).GetColumnTotal("ObsoleteRecordingsPry").ToString("N0")%></span></td></tr>
      </table>
	  </td>
    <td>&nbsp;</td>
  </tr>
</tfoot>