<%@ Control Language="C#" AutoEventWireup="false" Inherits="Empiria.Land.WebApp.RecordingActAttributesEditorControl" CodeFile="recording.act.attributes.editor.control.ascx.cs" %>
<tr id="creditFieldsRow1" visible="false" runat="server">
  <td>
    Fecha del contrato:
  </td>
  <td colspan="5" class="lastCell">
    <input id='txtContractDate' type="text" class="textBox" style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
    <img id='imgContractDate' src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('<%=txtContractDate.ClientID%>'), getElement('imgContractDate'));" title="Despliega el calendario" alt="" />
    &nbsp; &nbsp; &nbsp; &nbsp;
    Número de contrato:
    <input id="txtContractNumber" type="text" class="textBox" style="width:88px;" title="" maxlength="24" runat="server" />
  </td>
</tr>
<tr id="creditFieldsRow2" visible="false" runat="server">
  <td>
    Lugar del contrato:
  </td>
  <td colspan="5" class="lastCell">
    <input id='txtContractPlace' type="text" class="textBox" style="width:90px;" title="" />
    <img src="../themes/default/buttons/search.gif" alt="" title="Ejecuta la búsqueda" style="margin-left:-4px" onclick="this_searchContractPlaces()" />
    <select id="cboContractPlace" class="selectBox" style="width:378px" onchange="return updateUserInterface();" runat="server">
    </select>
  </td>
</tr>
<tr id="creditFieldsRow3" visible="false" runat="server">
  <td>
    Plazo del crédito:
  </td>
  <td colspan="5" class="lastCell">
    <input id="txtTermPeriod" type="text" class="textBox" style="width:30px;"
              onkeypress="return integerKeyFilter(this);" title="" maxlength="3" runat="server" />
    <select id="cboTermUnit" class="selectBox" style="width:82px;margin-left:-6px" runat="server">
      <option value="">(?)</option>
      <option value="618">Meses</option>
      <option value="617">Años</option>
      <option value="619">Bimestres</option>
      <option value="-2">No consta</option>
    </select>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    Interés:
    <input id="txtInterestRate" type="text" class="textBox" style="width:32px;" onblur='this_formatAsNumber(this);'
    onkeypress="return positiveKeyFilter(this);" title="" maxlength="6" runat="server" /><b>% </b>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    Tasa de referencia:
    &nbsp;
    <select id="cboInterestRateType" class="selectBox" style="width:108px;" runat="server">
      <option value="">(?)</option>
      <option value="635">Tasa fija</option>
      <option value="636">Cetes 28 días</option>
      <option value="637">Cetes 91 días</option>
      <option value="638">TIIE 28 días</option>
      <option value="639">TIIE 91 días</option>
      <option value="-2">No consta</option>
    </select>
  </td>
</tr>
<% if (!base.BlockAllFields) { %>
<tr>
  <td>Importe del avalúo:&nbsp;</td>
  <td colspan="5" class="lastCell">
    <input id="txtAppraisalAmount" type="text" class="textBox" style="width:90px;"
            onkeypress="return positiveKeyFilter(this);" onblur='this_formatAsNumber(this);'
            title="" maxlength="18" runat="server" />
    <select id="cboAppraisalCurrency" class="selectBox" style="width:52px;margin-left:-6px" runat="server">
      <option value="">(?)</option>
      <option value="600" title="Pesos mexicanos">MXN</option>
      <option value="602" title="Unidades de inversión">UDIS</option>
      <option value="-2" title="No consta">N/C</option>
    </select>
    <% if (base.DisplayOperationAmount ||  true) { %>
    Importe de la operación:
    <input id="txtOperationAmount" type="text" class="textBox" style="width:90px;" onblur='this_formatAsNumber(this, 4);'
              onkeypress="return positiveKeyFilter(this);" title="" maxlength="18" runat="server" />
    <select id="cboOperationCurrency" class="selectBox" style="width:52px;margin-left:-6px" runat="server">
      <option value="">(?)</option>
      <option value="600" title="Pesos mexicanos">MXN</option>
      <option value="602" title="Unidades de inversión">UDIS</option>
      <option value="603" title="Salarios mínimos">SM</option>
      <option value="601" title="Dólares americanos">USD</option>
      <option value="-2" title="No consta">N/C</option>
    </select>
    <input type="button" value="Igualar" class="button" tabindex="-1" style="width:50px;vertical-align:middle" onclick="javascript:equateValues('<%=txtAppraisalAmount.ClientID%>', '<%=txtOperationAmount.ClientID%>');equateValues('<%=cboAppraisalCurrency.ClientID%>', '<%=cboOperationCurrency.ClientID%>')" />
    <% } %>
  </td>
</tr>
<% } %>
<script type="text/javascript">
/* <![CDATA[ */

  function <%=this.ClientID%>_validate() {
    <% if (base.BlockAllFields) { %>
      return true;
    <% } %>
    <% if (base.DisplayCreditFields) { %>
      if (!<%=this.ClientID%>_validateCreditFields()) {
        return false;
      }
    <% } %>
    if (getElement('<%=cboAppraisalCurrency.ClientID%>').value.length == 0) {
      alert("Requiero la moneda del importe del avalúo.");
      return false;
    }
    if (Number(getElement('<%=cboAppraisalCurrency.ClientID%>').value) < 0 &&
        getElement('<%=txtAppraisalAmount.ClientID%>').value.length != 0) {
      alert("Se seleccionó 'No consta' como moneda pero el importe del avalúo sí se proporcionó.");
      return false;
    }
    if (Number(getElement('<%=cboAppraisalCurrency.ClientID%>').value) > 0 &&
        getElement('<%=txtAppraisalAmount.ClientID%>').value.length == 0) {
      alert("Requiero el importe del avalúo.");
      return false;
    }
    <% if (base.DisplayOperationAmount) { %>
      if (getElement('<%=cboOperationCurrency.ClientID%>').value.length == 0) {
        alert("Requiero la moneda del importe de la operación.");
        return false;
      }
      if (Number(getElement('<%=cboOperationCurrency.ClientID%>').value) < 0 &&
          getElement('<%=txtOperationAmount.ClientID%>').value.length != 0) {
        alert("Se seleccionó 'No consta' como moneda pero el importe de la operación sí se proporcionó.");
        return false;
      }
      if (Number(getElement('<%=cboOperationCurrency.ClientID%>').value) > 0 &&
          getElement('<%=txtOperationAmount.ClientID%>').value.length == 0) {
        alert("Requiero el importe de la operación.");
        return false;
      }
    <% } %>
    return true;
  }
  function <%=this.ClientID%>_validateCreditFields() {
    if (getElement('<%=txtContractDate.ClientID%>').value.length == 0) {
      if (!confirm("No se proporcionó la fecha del contrato.\n\n¿La fecha del contrato no consta?")) {
        return false;
      }
    } else {
      if (!isDate(getElement('<%=txtContractDate.ClientID%>'))) {
        alert("No reconozco la fecha del contrato.");
        return false;
      }
    }
    if (getElement('<%=cboContractPlace.ClientID%>').value.length == 0) {
      alert("Requiero se seleccione el lugar donde se formalizó el contrato.");
      return false;
    }
    if (getElement('<%=cboTermUnit.ClientID%>').value.length == 0) {
      alert("Requiero se seleccione la unidad de medida del plazo del crédito.");
      return false;
    }
    if (getElement('<%=cboTermUnit.ClientID%>').value != '-2' && getElement('<%=txtTermPeriod.ClientID%>').value.length == 0) {
      alert("Necesito se proporcione el número de períodos del plazo del crédito.");
      return false;
    }
    if (getElement('<%=cboTermUnit.ClientID%>').value == '-2' && getElement('<%=txtTermPeriod.ClientID%>').value.length != 0) {
      alert("La unidad de medida del plazo del crédito es 'No consta'. Sin embargo, sí se proporcionó el número de períodos del mismo.");
      return false;
    }
    if (getElement('<%=cboInterestRateType.ClientID%>').value.length == 0) {
      alert("Requiero se seleccione la tasa de referencia.");
      return false;
    }
    if (getElement('<%=cboInterestRateType.ClientID%>').value != '-2' && getElement('<%=txtInterestRate.ClientID%>').value.length == 0) {
      alert("Necesito se proporcione el porcentaje de interés del crédito.");
      return false;
    }
    if (getElement('<%=cboTermUnit.ClientID%>').value == '-2' && getElement('<%=txtTermPeriod.ClientID%>').value.length != 0) {
      alert("La tasa de referencia del crédito es 'No consta'. Sin embargo, se proporcionó sí se proporcionó el porcentaje de interés.");
      return false;
    }
    return true;
  }

  function this_searchContractPlaces() {
    var url = "../ajax/geographic.data.aspx";
    url += "?commandName=getRegionsStringArrayCmd";
    url += "&header=( Seleccionar lugar del contrato )";
    url += "&keywords=" + getElement("txtContractPlace").value;

    invokeAjaxComboItemsLoader(url, getElement("<%=cboContractPlace.ClientID%>"));
  }

  function this_formatAsNumber(oControl) {
    if (oControl.value.length == 0) {
      return;
    }
    if (arguments[1] != null) {
      oControl.value = formatAsNumber(oControl.value, arguments[1]);
    } else {
      oControl.value = formatAsNumber(oControl.value);
    }
  }

  <% if (base.DisplayCreditFields) { %>
    addEvent(getElement('<%=txtContractNumber.ClientID%>'), 'keypress', upperCaseKeyFilter);
  <% } %>
/* ]]> */
</script>
