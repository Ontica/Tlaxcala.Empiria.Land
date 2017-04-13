<%@ Import Namespace="Empiria" %>
<%@ Import Namespace="Empiria.Presentation" %>
<%@ Import Namespace="Empiria.Land.Registration" %>
<%@ Import Namespace="Empiria.Land.UI" %>

<%# ((int) DataBinder.Eval(Container, "ItemIndex")) == 0 ? "<tbody>" : String.Empty %>
<tr class="<%# ((int) DataBinder.Eval(Container, "ItemIndex") % 2 == 0 ? String.Empty  : "oddDataRow") %>" onmouseover="dataGridRowSelect(this, true);" onmouseout="dataGridRowSelect(this, false);">
  <td style="width:30%;white-space:nowrap; line-height:22px">
    <a href="javascript:doOperation('showRecording', <%#DataBinder.Eval(Container, "DataItem.RecordingBookId")%>, <%#DataBinder.Eval(Container, "DataItem.RecordingId")%>)" class="detailsLinkTitle"><%#DataBinder.Eval(Container, "DataItem.FirstFamilyName")%> <%#DataBinder.Eval(Container, "DataItem.SecondFamilyName")%> <%#DataBinder.Eval(Container, "DataItem.FirstName")%></a>
    <br />
    CURP: <b class="boldItem"><%#DataBinder.Eval(Container, "DataItem.CURPNumber")%></b>&#160; RFC:<b class="boldItem"><%#DataBinder.Eval(Container, "DataItem.TaxIDNumber")%></b>&#160; IFE: <b class="boldItem"><%#DataBinder.Eval(Container, "DataItem.IFENumber")%></b>
    <br />
    Originario: <b class="boldItem"><%#DataBinder.Eval(Container, "DataItem.RegistryLocation")%></b>&#160;&#160; &#160; &#160; &#160; &#160; F.Nac: <b class="boldItem"><%# ((DateTime)DataBinder.Eval(Container, "DataItem.RegistryDate")) < DateTime.Today ? ((DateTime)DataBinder.Eval(Container, "DataItem.RegistryDate")).ToString("dd/MMM/yyyy") : "No consta"%></b>
    <br />
    Participa como: <b class="boldItem"><%#DataBinder.Eval(Container, "DataItem.PartyRole")%></b>&#160;&#160; Modo: <b class="boldItem"><%#DataBinder.Eval(Container, "DataItem.OwnershipModeName")%></b>
  </td>
  <td style="width:40%;line-height:22px; white-space:normal">
    <a href="javascript:doOperation('showRecording', <%#DataBinder.Eval(Container, "DataItem.RecordingBookId")%>, <%#DataBinder.Eval(Container, "DataItem.RecordingId")%>)"  class="detailsLinkTitle"><%#DataBinder.Eval(Container, "DataItem.PropertyUID")%></a>
   &#160;&#160; &#160; &#160; Clave catastral: <b class="boldItem"><%#DataBinder.Eval(Container, "DataItem.CadastralKey")%></b>
   &#160;&#160; <a href="#">Ver en mapa</a>
    <br />
    Tipo de predio: <b class="boldItem"><%#DataBinder.Eval(Container, "DataItem.PropertyType")%></b>
   &#160;&#160;
    <b class="boldItem"><%#DataBinder.Eval(Container, "DataItem.PropertyCommonName")%></b>
   &#160;&#160;&#160;&#160;&#160;
    Superficie:
    <b class="boldItem"><%#((decimal)DataBinder.Eval(Container, "DataItem.TotalArea")).ToString("#,##0.00######")%> <%#DataBinder.Eval(Container, "DataItem.TotalAreaUnitAbbr")%></b>
    <br />
    Calle: <b class="boldItem"><%#DataBinder.Eval(Container, "DataItem.Street")%></b>&#160; No: <b class="boldItem"><%#DataBinder.Eval(Container, "DataItem.ExternalNumber")%> <%#DataBinder.Eval(Container, "DataItem.InternalNumber")%></b>
    <br />
    Fracc: <b class="boldItem"><%#DataBinder.Eval(Container, "DataItem.FractionTag")%></b>&#160;&#160;
    Lote: <b class="boldItem"><%#DataBinder.Eval(Container, "DataItem.BatchTag")%></b>&#160;&#160;
    Mnz: <b class="boldItem"><%#DataBinder.Eval(Container, "DataItem.BlockTag")%></b>&#160;&#160;
    Sec/Zn: <b class="boldItem"><%#DataBinder.Eval(Container, "DataItem.SectionTag")%></b>&#160;&#160;
    Cuartel: <b class="boldItem"><%#DataBinder.Eval(Container, "DataItem.SuperSectionTag")%></b>
    <br />
    Ubicación:&#160;&#160;&#160;&#160;<b class="boldItem" style="white-space:normal"><%#DataBinder.Eval(Container, "DataItem.Ubication")%></b>
    <br />
    Asentamiento: <b class="boldItem"><%#DataBinder.Eval(Container, "DataItem.Settlement")%></b>&#160;&#160; Municipio: <b class="boldItem"><%#DataBinder.Eval(Container, "DataItem.Municipality")%></b>
  </td>
  <td style="width:30%;line-height:22px; white-space:normal">
    <a href="javascript:doOperation('showRecording', <%#DataBinder.Eval(Container, "DataItem.RecordingBookId")%>, <%#DataBinder.Eval(Container, "DataItem.RecordingId")%>)"  class="detailsLinkTitle"><%#DataBinder.Eval(Container, "DataItem.RecordingBookFullName")%> / Insc: <%#DataBinder.Eval(Container, "DataItem.RecordingNumber")%></a>
    <br />
    Acto jurídico: <b class="boldItem"><%#DataBinder.Eval(Container, "DataItem.RecordingActTypeDisplayName")%></b>
    <br />
    Presentación: <b class="boldItem"><%# ((DateTime)DataBinder.Eval(Container, "DataItem.RecordingPresentationTime")).ToString("dd/MMM/yyyy HH:mm")%> hrs.</b>&#160;&#160;&#160; Autorización: <b class="boldItem"><%# ((DateTime)DataBinder.Eval(Container, "DataItem.RecordingAuthorizedTime")).ToString("dd/MMM/yyyy")%></b>
    <br />
    Propietario anterior: <b class="boldItem" style="white-space:normal"><%#DataBinder.Eval(Container, "DataItem.FirstKnownOwner")%></b>
  </td>
  <td>

  </td>
</tr>
<%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).IsLastItem((int) DataBinder.Eval(Container, "ItemIndex")) ? "</tbody>" : String.Empty %>
