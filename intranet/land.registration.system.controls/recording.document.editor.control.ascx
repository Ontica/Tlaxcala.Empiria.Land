<%@ Control Language="C#" AutoEventWireup="false" EnableViewState="true" Inherits="Empiria.Web.UI.LRS.RecordingDocumentFullEditorControl" CodeFile="recording.document.editor.control.ascx.cs" %>
<table id="oNotaryOfficialLetter" class="editionTable" style="display:none;" runat="server">
  <tr>
    <td>
      Tipo de oficio:
    </td>
    <td>
      <select id="cboNotaryOfficialLetterSubtype" class="selectBox" style="width:220px" title="" runat="server">
        <option value=''>( Seleccionar )</option>
        <option value='744'>Aviso preventivo</option>
        <option value='757'>Aviso definitivo</option>
        <option value='739'>Cancelación de aviso</option>
        <option value='741'>Cancelación de hipoteca</option>
        <option value='755'>Fe de erratas</option>
      </select>
    </td>
    <td class="lastCell">
      No. Oficio: &nbsp;
      <input id="txtNotaryOfficialLetterNo" type="text" class="textBox" style="width:100px" title="" maxlength="36"  runat="server" />
      <input type="button" class="button" value="Sin Núm." style="width:52px;height:24px;vertical-align:middle;margin-left:-8px" onclick="getElement('<%=txtNotaryOfficialLetterNo.ClientID%>').value='S/N'" />
      &nbsp;&nbsp;Fecha del oficio:
      <input id='txtNotaryOfficialLetterIssueDate' type="text" class="textBox" style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
      <img id='imgNotaryOfficialLetterIssueDate' src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('<%=txtNotaryOfficialLetterIssueDate.ClientID%>'), getElement('imgNotaryOfficialLetterIssueDate'));" title="Despliega el calendario" alt="" />
    </td>
  </tr>
  <tr>
    <td>Ciudad:</td>
    <td>
      <select id="cboNotaryOfficialLetterIssuePlace" class="selectBox" style="width:220px" title="" runat="server" >
      </select>
    </td>
    <td class="lastCell">
      Notaría:
      <select id="cboNotaryOfficialLetterIssueOffice" class="selectBox" style="width:50px" title="" runat="server" >
      </select>
      Lic:
      <select id="cboNotaryOfficialLetterIssuedBy" class="selectBox" style="width:262px" title="" runat="server" >
      </select>
    </td>
  </tr>
</table>
<table id="oNotaryPublicDeed" class="editionTable" style="display:none;" runat="server">
  <tr>
    <td>Ciudad:</td>
    <td>
      <select id="cboNotaryDocIssuePlace" class="selectBox" style="width:220px" title="" runat="server" >
      </select>
    </td>
    <td class="lastCell">
      Notaría:
      <select id="cboNotaryDocIssueOffice" class="selectBox" style="width:50px" title="" runat="server" >
      </select>
      Lic:
      <select id="cboNotaryDocIssuedBy" class="selectBox" style="width:262px" title="" runat="server" >
      </select>
    </td>
  </tr>
  <tr>
    <td>Volumen / libro:</td>
    <td class="lastCell" colspan="2">
      <input id="txtNotaryDocBook" type="text" class="textBox" style="width:40px"
             onkeypress="return integerKeyFilter(this);" title="" maxlength="6"  runat="server" />
      Escritura:
        <input id="txtNotaryDocNumber" name="txtNotaryDocNumber" type="text" class="textBox" style="width:40px"
         onkeypress="return integerKeyFilter(this);" title="" maxlength="6"  runat="server" />
       &nbsp;Folios del: &nbsp;<input id="txtNotaryDocStartSheet" name="txtNotaryDocStartSheet" type="text" class="textBox" style="width:50px"
         onkeypress="return integerKeyFilter(this);" title="" maxlength="6"  runat="server" />
       al:&nbsp;&nbsp;
       <input id="txtNotaryDocEndSheet" name="txtNotaryDocEndSheet" type="text" class="textBox" style="width:40px"
         onkeypress="return integerKeyFilter(this);" title="" maxlength="6"  runat="server" />
      Fecha de la escritura:
      <input type="text" class="textBox" id='txtNotaryDocIssueDate' name='txtNotaryDocIssueDate' style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
      <img id='imgNotaryDocIssueDate' src="../themes/default/buttons/ellipsis.gif"
      onclick="return showCalendar(getElement('<%=txtNotaryDocIssueDate.ClientID%>'), getElement('imgNotaryDocIssueDate'));" title="Despliega el calendario" alt="" />
    </td>
  </tr>
</table>
<table id="oEjidalSystemTitle" class="editionTable" style="display:none;" runat="server">
  <tr>
    <td colspan="2">
      Título de propiedad No: &nbsp;
    <input id="txtPropTitleDocNumber" type="text" class="textBox" style="width:136px" onkeypress="return upperCaseKeyFilter(this);"
         title="" maxlength="32" runat="server" /></td>
    <td>Expedido por:</td>
    <td class="lastCell">C.
      <select id="cboPropTitleDocIssuedBy" class="selectBox" style="width:328px" title="" runat="server">
      </select>
    </td>
  </tr>
  <tr>
    <td>Fecha del acta de asamblea:</td>
    <td>
      <input id='txtPropTitleIssueDate' type="text" class="textBox" style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
      <img id='imgPropTitleIssueDate' src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('<%=txtPropTitleIssueDate.ClientID%>'), getElement('imgPropTitleIssueDate'));" title="Despliega el calendario" alt="" />
    </td>
    <td class="lastCell" colspan="2">
      Expedido en:
      <select id="cboPropTitleIssueOffice" class="selectBox" style="width:166px" title="" runat="server">
      </select>
      Folio:
      <input id="txtPropTitleStartSheet" type="text" class="textBox" style="width:136px" onkeypress="return upperCaseKeyFilter(this);" title="" maxlength="32"  runat="server" />
    </td>
  </tr>
</table>
<table id="oJudgeOfficialLetter" class="editionTable" style="display:none;" runat="server">
  <tr>
    <td>
      Tipo de oficio:
    </td>
    <td>
      <select id="cboJudicialDocSubtype" class="selectBox" style="width:220px" title="" runat="server">
        <option value=''>( Seleccionar )</option>
        <option value='782'>Adjudicación por herencia</option>
        <option value='783'>Adjudicación por remate judicial</option>
        <option value='778'>Apeo y deslinde</option>
        <option value='784'>Apertura de servidumbre</option>
        <option value='737'>Cancelación de embargo</option>
        <option value='779'>Cancelación de servidumbre</option>
        <option value='770'>Embargo</option>
        <option value='769'>Embargo (reinscripción)</option>
        <option value='780'>Inmovilización de predio</option>
        <option value='776'>Nombramiento de albacea provisional</option>
        <option value='720'>Nombramiento de albacea definitivo</option>
        <option value='781'>Nulidad de inscripción</option>
        <option value='777'>Sentencia de patrimonio familiar</option>
        <option value='771'>Sentencia de usucapión</option>
      </select>
    </td>
    <td>
      Expediente: &nbsp;
      <input id="txtJudicialDocBook" type="text" class="textBox" style="width:120px" title="" maxlength="36"  runat="server" />
    </td>
    <td class="lastCell">
      Oficio: &nbsp;
      <input id="txtJudicialDocNumber" type="text" class="textBox" style="width:100px" title="" maxlength="36"  runat="server" />
      Fecha:
      <input id='txtJudicialDocIssueDate' type="text" class="textBox" style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
      <img id='imgJudicialDocIssueDate' src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('<%=txtJudicialDocIssueDate.ClientID%>'), getElement('imgJudicialDocIssueDate'));" title="Despliega el calendario" alt="" />
    </td>
  </tr>
  <tr>
    <td>
      Ciudad:
    </td>
    <td>
      <select id="cboJudicialDocIssuePlace" class="selectBox" style="width:220px" title="" runat="server">
      </select>
    </td>
    <td>
      Autoridad:
      <select id="cboJudicialDocIssueOffice" class="selectBox" style="width:150px" title="" runat="server">
      </select>
    </td>
    <td class="lastCell">
      Funcionario:
      <select id="cboJudicialDocIssuedBy" class="selectBox" style="width:226px" title="" runat="server">
      </select>
    </td>
  </tr>
</table>
<table id="oPrivateContract" class="editionTable" style="display:none;" runat="server">
  <tr>
    <td>
      Tipo de documento:
    </td>
    <td>
      <select id="cboPrivateDocSubtype" class="selectBox" style="width:192px" title="" runat="server">
        <option value=''>( Seleccionar )</option>
        <option value='785'>Aclaración (corrección)</option>
        <option value='761'>Contrato de arrendamiento</option>
        <option value='770'>Embargo</option>
        <option value='765'>Fianza</option>
        <option value='780'>Inmovilización de predio</option>
      </select>
      <!--
        <option value='760'>Capitulación matrimonial</option>
        <option value='762'>Contrato de comodato</option>
        <option value='764'>Contrato de crédito hipotecario</option>
        <option value='767'>Contrato de crédito prendario</option>
        <option value='766'>Contrato Infonavit</option>
        <option value='763'>Contrato traslativo de dominio</option>
      !-->
    </td>
    <td>
      Expedido por:
    </td>
    <td colspan="3" class="lastCell">
      <select id="cboPrivateDocIssuedBy" class="selectBox" style="width:312px" title="" runat="server">
        <option value="">( Primero seleccionar el tipo de documento )</option>
      </select>
    </td>
  </tr>
  <tr>
   <td>
      Expedido en:
    </td>
    <td>
    <select id="cboPrivateDocIssuePlace" class="selectBox" style="width:192px" title="" runat="server">
    </select>
    </td>
    <td>
      No. documento:
    </td>
    <td>
      <input id="txtPrivateDocNumber" type="text" class="textBox" style="width:122px" title="" maxlength="32" runat="server" />
      <input type="button" class="button" value="S/N" style="width:26px;height:24px;vertical-align:middle;margin-left:-8px" onclick="getElement('<%=txtPrivateDocNumber.ClientID%>').value='S/N'" />
    </td>
    <td class="lastCell">
      Fecha:
      <input id='txtPrivateDocIssueDate' type="text" class="textBox" style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
      <img id='imgPrivateDocIssueDate' src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('<%=txtPrivateDocIssueDate.ClientID%>'), getElement('imgPrivateDocIssueDate'));" title="Despliega el calendario" alt="" />
    </td>
  </tr>
</table>
<script type="text/javascript">
  /* <![CDATA[ */


  function <%=this.ClientID%>_validate(presentationDate) {
    if (getElement("<%=oNotaryPublicDeed.ClientID%>").style.display == 'inline') {
      return <%=this.ClientID%>_validateNotaryRecording(presentationDate);
    } else if (getElement("<%=oNotaryOfficialLetter.ClientID%>").style.display == 'inline') {
      return <%=this.ClientID%>_validateNotaryOfficialLetter(presentationDate);
    } else if (getElement("<%=oEjidalSystemTitle.ClientID%>").style.display == 'inline') {
      return <%=this.ClientID%>_validateTitleRecording(presentationDate);
    } else if (getElement("<%=oJudgeOfficialLetter.ClientID%>").style.display == 'inline') {
      return <%=this.ClientID%>_validateJudicialRecording(presentationDate);
    } else if (getElement("<%=oPrivateContract.ClientID%>").style.display == 'inline') {
      return <%=this.ClientID%>_validatePrivateRecording(presentationDate);
    } else {
      return true;
    }
  }

  function <%=this.ClientID%>_validateNotaryRecording(presentationDate) {
    if (getElement("<%=cboNotaryDocIssuePlace.ClientID%>").value.length == 0) {
      alert("Requiero se proporcione la ciudad a la que pertenece la\nnotaría donde se efectuó la protocolización.")
      return false;
    }
    if (getElement("<%=cboNotaryDocIssueOffice.ClientID%>").value.length == 0) {
      alert("Requiero se proporcione la notaría donde se efectuó la protocolización.")
      return false;
    }
    if (getElement("<%=cboNotaryDocIssuedBy.ClientID%>").value.length == 0) {
      alert("Necesito se proporcione el nombre del notario que protocolizó la inscripción.")
      return false;
    }
    if (getElement("<%=txtNotaryDocBook.ClientID%>").value.length == 0) {
      alert("Requiero conocer el número de volumen donde está protocolizada la inscripción.")
      return false;
    }
    if (getElement("<%=txtNotaryDocNumber.ClientID%>").value.length == 0) {
      alert("Necesito se proporcione el número de escritura que le corresponde a esta inscripción.")
      return false;
    }
    if (getElement("<%=txtNotaryDocIssueDate.ClientID%>").value.length != 0) {
      if (!isDate(getElement('<%=txtNotaryDocIssueDate.ClientID%>'))) {
        alert("No reconozco la fecha en que fue protocolizada la inscripción.");
        return false;
      }
      if (!isValidDatePeriod(getElement('<%=txtNotaryDocIssueDate.ClientID%>').value, presentationDate)) {
        alert("La fecha de protocolización de la inscripción no puede ser posterior a su fecha de presentación.");
        return false;
      }
    } else {
      if (!confirm("No se ha proporcionado la fecha en que se protocolizó la inscripción.\n\n¿Se desconoce la fecha de protocolozación?")) {
        return false;
      }
    }
    return true;
  }

  function <%=this.ClientID%>_validateNotaryOfficialLetter(presentationDate) {
    if (getElement("<%=cboNotaryOfficialLetterSubtype.ClientID%>").value.length == 0) {
      alert("Requiero se proporcione el tipo de oficio.");
      return false;
    }
    if (getElement("<%=txtNotaryDocNumber.ClientID%>").value.length == 0) {
      getElement("<%=txtNotaryDocNumber.ClientID%>").value = "S/N";
    }
    if (getElement("<%=txtNotaryOfficialLetterIssueDate.ClientID%>").value.length == 0) {
      alert("Necesito se proporcione la fecha del oficio.")
      return false;
    }
    if (!isDate(getElement('<%=txtNotaryOfficialLetterIssueDate.ClientID%>'))) {
      alert("No reconozco la fecha del oficio.");
      return false;
    }
    if (!isValidDatePeriod(getElement('<%=txtNotaryOfficialLetterIssueDate.ClientID%>').value, presentationDate)) {
      alert("La fecha del oficio no puede ser posterior a su fecha de presentación.");
      return false;
    }
    if (getElement("<%=cboNotaryOfficialLetterIssuePlace.ClientID%>").value.length == 0) {
      alert("Requiero se proporcione la ciudad a la que pertenece la\nnotaría que envió el oficio.")
      return false;
    }
    if (getElement("<%=cboNotaryOfficialLetterIssueOffice.ClientID%>").value.length == 0) {
      alert("Requiero se proporcione la notaría que envió el oficio.")
      return false;
    }
    if (getElement("<%=cboNotaryOfficialLetterIssuedBy.ClientID%>").value.length == 0) {
      alert("Necesito se proporcione el nombre del notario que firmó el oficio.")
      return false;
    }
    return true;
  }

  function <%=this.ClientID%>_validateTitleRecording(presentationDate) {
    if (getElement("<%=txtPropTitleDocNumber.ClientID%>").value.length == 0) {
      alert("Necesito se proporcione el número de título de propiedad.")
      return false;
    }
    if (getElement("<%=cboPropTitleDocIssuedBy.ClientID%>").value.length == 0) {
      alert("Necesito se proporcione el nombre del funcionario que expidió el título de propiedad.")
      return false;
    }
    if (getElement("<%=txtPropTitleIssueDate.ClientID%>").value.length != 0) {
      if (!isDate(getElement('<%=txtPropTitleIssueDate.ClientID%>'))) {
        alert("No reconozco la fecha del acta de asamblea.");
        return false;
      }
      if (!isValidDatePeriod(getElement('<%=txtPropTitleIssueDate.ClientID%>').value, presentationDate)) {
        alert("La fecha del acta de asamblea no puede ser posterior a la fecha de presentación de la inscripción.");
        return false;
      }
    } else {
      if (!confirm("No se ha proporcionado la fecha del acta de asamblea.\n\n¿Se desconoce la fecha del acta de asamblea?")) {
        return false;
      }
    }
    if (getElement("<%=cboPropTitleIssueOffice.ClientID%>").value.length == 0) {
      alert("Necesito se proporcione la dependencia en donde estaba inscrita la propiedad.")
      return false;
    }
    if (getElement("<%=txtPropTitleStartSheet.ClientID%>").value.length == 0) {
      alert("Requiero se proporcione el folio de inscripción del predio dentro de la dependencia seleccionada.")
      return false;
    }
    return true;
  }

  function <%=this.ClientID%>_validateJudicialRecording(presentationDate) {
    if (getElement("<%=cboJudicialDocSubtype.ClientID%>").value.length == 0) {
      alert("Requiero se proporcione el tipo de documento.")
      return false;
    }
    if (getElement("<%=cboJudicialDocIssuePlace.ClientID%>").value.length == 0) {
      alert("Requiero se proporcione la ciudad a la que pertenece la dependencia que envió la orden o resolución de registro.")
      return false;
    }
    if (getElement("<%=cboJudicialDocIssueOffice.ClientID%>").value.length == 0) {
      alert("Requiero se seleccione de la lista la dependencia que envió la orden de registro.")
      return false;
    }
    if (getElement("<%=cboJudicialDocIssuedBy.ClientID%>").value.length == 0) {
      alert("Necesito se seleccione el nombre del funcionario público que emitió la orden o resolución de registro.")
      return false;
    }
    if (getElement("<%=txtJudicialDocBook.ClientID%>").value.length == 0) {
      alert("Requiero conocer el número de expediente relacionado con la orden o resolución de registro.")
      return false;
    }
    if (getElement("<%=txtJudicialDocNumber.ClientID%>").value.length == 0) {
      alert("Necesito se proporcione el número de oficio relacionado con la orden o resolución de registro.")
      return false;
    }
    if (getElement("<%=txtJudicialDocIssueDate.ClientID%>").value.length != 0) {
      if (!isDate(getElement('<%=txtJudicialDocIssueDate.ClientID%>'))) {
        alert("No reconozco la fecha del oficio.");
        return false;
      }
      if (!isValidDatePeriod(getElement('<%=txtJudicialDocIssueDate.ClientID%>').value, presentationDate)) {
        alert("La fecha del oficio no puede ser posterior a la fecha de registro de la inscripción.");
        return false;
      }
    } else {
      if (!confirm("No se ha proporcionado la fecha del oficio.\n\n¿Se desconoce la fecha del oficio?")) {
        return false;
      }
    }
    return true;
  }

  function <%=this.ClientID%>_validatePrivateRecording(presentationDate) {
    if (getElement("<%=cboPrivateDocSubtype.ClientID%>").value.length == 0) {
      alert("Requiero se proporcione el tipo de documento.");
      return false;
    }
    if (getElement("<%=cboPrivateDocIssuedBy.ClientID%>").value.length == 0) {
      alert("Necesito conocer la entidad emisora del documento o contrato.")
      return false;
    }
    if (getElement("<%=cboPrivateDocIssuePlace.ClientID%>").value.length == 0) {
      alert("Requiero conocer la ciudad donde se expidió el documento o se celebró el contrato.");
      return false;
    }
    if (getElement("<%=txtPrivateDocIssueDate.ClientID%>").value.length == 0) {
      alert("Necesito se proporcione la fecha del documento o contrato.");
      return false;
    }
    if (!isDate(getElement('<%=txtPrivateDocIssueDate.ClientID%>'))) {
      alert("No reconozco la fecha del documento o celebración del contrato.");
      return false;
    }
    if (!isValidDatePeriod(getElement('<%=txtPrivateDocIssueDate.ClientID%>').value, presentationDate)) {
      alert("La fecha del documento no puede ser posterior a la fecha de presentación de la inscripción.");
      return false;
    }
    if (getElement("<%=txtPrivateDocNumber.ClientID%>").value.length == 0) {
      alert("Necesito se proporcione el número de documento o contrato.")
      return false;
    }
    return true;
  }

  function <%=this.ClientID%>_updateUserInterface(documentTypeTag) {
    getElement("<%=oNotaryOfficialLetter.ClientID%>").style.display = 'none';
    getElement("<%=oNotaryPublicDeed.ClientID%>").style.display = 'none';
    getElement("<%=oEjidalSystemTitle.ClientID%>").style.display = 'none';
    getElement("<%=oJudgeOfficialLetter.ClientID%>").style.display = 'none';
    getElement("<%=oPrivateContract.ClientID%>").style.display = 'none';

    if (documentTypeTag.length != 0) {
      getElement("<%=this.ClientID%>_" + documentTypeTag).style.display = 'inline';
    }
  }

  function <%=this.ClientID%>_disabledControl(disabledFlag) {
    disableControls(getElement("<%=oNotaryOfficialLetter.ClientID%>"), disabledFlag);
    disableControls(getElement("<%=oNotaryPublicDeed.ClientID%>"), disabledFlag);
    disableControls(getElement("<%=oEjidalSystemTitle.ClientID%>"), disabledFlag);
    disableControls(getElement("<%=oJudgeOfficialLetter.ClientID%>"), disabledFlag);
    disableControls(getElement("<%=oPrivateContract.ClientID%>"), disabledFlag);
  }

  function <%=this.ClientID%>_updateControls(sourceName) {
    var url = "../ajax/land.registration.system.data.aspx";
    switch (sourceName) {
      case "oNotaryOfficialLetterRecording.IssuePlace":
        url += "?commandName=getNotaryOfficesInPlaceStringArrayCmd";
        url += "&placeId=" + getElement('<%=cboNotaryOfficialLetterIssuePlace.ClientID%>').value;
        invokeAjaxComboItemsLoader(url, getElement('<%=cboNotaryOfficialLetterIssueOffice.ClientID%>'));
        return;
      case "oNotaryOfficialLetterRecording.IssueOffice":
        url += "?commandName=getNotariesInNotaryOfficeStringArrayCmd";
        url += "&notaryOfficeId=" + getElement('<%=cboNotaryOfficialLetterIssueOffice.ClientID%>').value;
        invokeAjaxComboItemsLoader(url, getElement('<%=cboNotaryOfficialLetterIssuedBy.ClientID%>'));
        return;
      case "oNotaryPublicDeed.IssuePlace":
        url += "?commandName=getNotaryOfficesInPlaceStringArrayCmd";
        url += "&placeId=" + getElement('<%=cboNotaryDocIssuePlace.ClientID%>').value;
        invokeAjaxComboItemsLoader(url, getElement('<%=cboNotaryDocIssueOffice.ClientID%>'));
        return;
      case "oNotaryPublicDeed.IssueOffice":
        url += "?commandName=getNotariesInNotaryOfficeStringArrayCmd";
        url += "&notaryOfficeId=" + getElement('<%=cboNotaryDocIssueOffice.ClientID%>').value;
        invokeAjaxComboItemsLoader(url, getElement('<%=cboNotaryDocIssuedBy.ClientID%>'));
        return;
      case "oJudgeOfficialLetter.IssuePlace":
        url += "?commandName=getJudicialOfficeInPlaceStringArrayCmd";
        url += "&placeId=" + getElement('<%=cboJudicialDocIssuePlace.ClientID%>').value;
        invokeAjaxComboItemsLoader(url, getElement('<%=cboJudicialDocIssueOffice.ClientID%>'));
        return;
      case "oJudgeOfficialLetter.IssueOffice":
        url += "?commandName=getJudgesInJudicialOfficeStringArrayCmd";
        url += "&judicialOfficeId=" + getElement('<%=cboJudicialDocIssueOffice.ClientID%>').value;
        invokeAjaxComboItemsLoader(url, getElement('<%=cboJudicialDocIssuedBy.ClientID%>'));
        return;
      case "oPrivateContract.DocumentSubtype":
        url += "?commandName=getIssueEntitiesForDocumentTypeStringArrayCmd";
        url += "&documentTypeId=" + getElement('<%=cboPrivateDocSubtype.ClientID%>').value;
        invokeAjaxComboItemsLoader(url, getElement('<%=cboPrivateDocIssuedBy.ClientID%>'));
        return;
      default:
        alert("La opción de actualización del UI '" + sourceName + "' no ha sido definida en el programa.")
        return;
    }
  }

  addEvent(getElement('<%=cboNotaryOfficialLetterIssuePlace.ClientID%>'), 'change', function() { <%=this.ClientID%>_updateControls("oNotaryOfficialLetterRecording.IssuePlace") } );
  addEvent(getElement('<%=cboNotaryOfficialLetterIssueOffice.ClientID%>'), 'change', function() { <%=this.ClientID%>_updateControls("oNotaryOfficialLetterRecording.IssueOffice") } );
  addEvent(getElement('<%=cboNotaryDocIssuePlace.ClientID%>'), 'change', function() { <%=this.ClientID%>_updateControls("oNotaryPublicDeed.IssuePlace") } );
  addEvent(getElement('<%=cboNotaryDocIssueOffice.ClientID%>'), 'change', function() { <%=this.ClientID%>_updateControls("oNotaryPublicDeed.IssueOffice") } );

  addEvent(getElement('<%=cboJudicialDocIssuePlace.ClientID%>'), 'change', function() { <%=this.ClientID%>_updateControls("oJudgeOfficialLetter.IssuePlace") } );
  addEvent(getElement('<%=cboJudicialDocIssueOffice.ClientID%>'), 'change', function() { <%=this.ClientID%>_updateControls("oJudgeOfficialLetter.IssueOffice") } ); 
  addEvent(getElement('<%=txtJudicialDocBook.ClientID%>'), 'keypress', upperCaseKeyFilter);
  addEvent(getElement('<%=txtJudicialDocNumber.ClientID%>'), 'keypress', upperCaseKeyFilter);

  addEvent(getElement('<%=txtPropTitleDocNumber.ClientID%>'), 'keypress', upperCaseKeyFilter);
  addEvent(getElement('<%=txtPropTitleStartSheet.ClientID%>'), 'keypress', upperCaseKeyFilter);

  addEvent(getElement('<%=cboPrivateDocSubtype.ClientID%>'), 'change', function() { <%=this.ClientID%>_updateControls("oPrivateContract.DocumentSubtype") } );
  addEvent(getElement('<%=txtPrivateDocNumber.ClientID%>'), 'keypress', upperCaseKeyFilter);
  
  /* ]]> */
</script>
