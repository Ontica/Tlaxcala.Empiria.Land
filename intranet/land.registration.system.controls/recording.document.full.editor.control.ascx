<%@ Control Language="C#" AutoEventWireup="false" EnableViewState="true" Inherits="Empiria.Web.UI.LRS.RecordingDocumentFullEditorControl" CodeFile="recording.document.full.editor.control.ascx.cs" %>
<table id="oPreemptiveNotice" class="editionTable" style="display:none;" runat="server">
    <tr>
    <td>Ciudad:</td>
    <td>
      <select id="cboPreemptiveNoticeIssuePlace" class="selectBox" style="width:168px" title="" runat="server" >
      </select>
    </td>
    <td class="lastCell">
      Notaría:
      <select id="cboPreemptiveNoticeIssueOffice" class="selectBox" style="width:50px" title="" runat="server" >
      </select>
      Lic:
      <select id="cboPreemptiveNoticeIssuedBy" class="selectBox" style="width:262px" title="" runat="server" >
      </select>
    </td>
  </tr>
  <tr>
    <td colspan='2'>&nbsp;</td>
    <td class="lastCell">
      Oficio: &nbsp;
      <input id="txtPreemptiveNoticeDocNumber" type="text" class="textBox" style="width:100px" title="" maxlength="36"  runat="server" />
      <input type="button" class="button" value="Sin Núm." style="width:52px;height:24px;vertical-align:middle;margin-left:-8px" onclick="getElement('<%=txtPreemptiveNoticeDocNumber.ClientID%>').value='S/N'" />
      &nbsp;&nbsp;Fecha del oficio:
      <input id='txtPreemptiveNoticeDocIssueDate' type="text" class="textBox" style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
      <img id='imgPreemptiveNoticeIssueDate' src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('<%=txtPreemptiveNoticeDocIssueDate.ClientID%>'), getElement('imgPreemptiveNoticeIssueDate'));" title="Despliega el calendario" alt="" />
    </td>
  </tr>
</table>
<table id="oNotaryRecording" class="editionTable" style="display:none;" runat="server">
    <tr>
    <td>Ciudad:</td>
    <td>
      <select id="cboNotaryDocIssuePlace" class="selectBox" style="width:168px" title="" runat="server" >
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
<table id="oTitleRecording" class="editionTable" style="display:none;" runat="server">
  <tr>
    <td>
      Título de propiedad número:
    </td>
    <td><input id="txtPropTitleDocNumber" type="text" class="textBox" style="width:106px" onkeypress="return upperCaseKeyFilter(this);" 
         title="" maxlength="32" runat="server" /></td>
    <td>Expedido por:</td>
    <td class="lastCell">C. 
      <select id="cboPropTitleDocIssuedBy" class="selectBox" style="width:290px" title="" runat="server">
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
      <input id="txtPropTitleStartSheet" type="text" class="textBox" style="width:100px" onkeypress="return integerKeyFilter(this);" title="" maxlength="32"  runat="server" />
    </td>
  </tr>
</table>
<table id="oJudicialRecording" class="editionTable" style="display:none;" runat="server">
  <tr>
    <td>
      Tipo de documento:
    </td>
    <td>
      <select id="cboJudicialDocSubtype" class="selectBox" style="width:160px" title="" runat="server">
        <option value=''>( Seleccionar )</option>
        <option value='773'>Decreto</option>
        <option value='770'>Embargo</option>
        <option value='775'>Programa de Desarrollo Municipal</option>
        <option value='772'>Resolución judicial</option>
        <option value='771'>Sentencia de usucapión</option>
        <option value=''></option>
        <option value='774'>Cancelación de embargo</option>
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
      <select id="cboJudicialDocIssuePlace" class="selectBox" style="width:160px" title="" runat="server">
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
<table id="oPrivateRecording" class="editionTable" style="display:none;" runat="server">
  <tr>
    <td>
      Tipo de contrato:
    </td>
    <td>
      <select id="cboPrivateDocSubtype" class="selectBox" style="width:160px" title="" runat="server">
        <option value=''>( Seleccionar )</option>
        <option value='760'>Capitulación matrimonial</option>
        <option value='761'>Contrato de arrendamiento</option>
        <option value='762'>Contrato de comodato</option>
        <option value='764'>Contrato de crédito hipotecario</option>
        <option value='767'>Contrato de crédito prendario</option>
        <option value='766'>Contrato Infonavit</option>
        <option value='763'>Contrato traslativo de dominio</option>
        <option value='765'>Fianza</option>
      </select>
    </td>
    <td>
      Núm de contrato:
      <input id="txtPrivateDocNumber" type="text" class="textBox" style="width:102px" title="" maxlength="32"  runat="server" />
    </td>
    <td class="lastCell">
      Fecha del contrato:
      <input id='txtPrivateDocIssueDate' type="text" class="textBox" style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
      <img id='imgPrivateDocIssueDate' src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('<%=txtPrivateDocIssueDate.ClientID%>'), getElement('imgPrivateDocIssueDate'));" title="Despliega el calendario" alt="" />
    </td>
  </tr>
  <tr>
   <td>
      Ciudad:
    </td>
    <td>
      <select id="cboPrivateDocIssuePlace" class="selectBox" style="width:160px" title="" runat="server">
      </select>
    </td>
    <td>
      Certificó:
      <select id="cboPrivateDocMainWitnessPosition" class="selectBox" style="width:148px" title="" runat="server">
      </select>
    </td>
    <td class="lastCell">
      C.
      <select id="cboPrivateDocMainWitness" class="selectBox" style="width:244px" title="" runat="server">
      </select>
    </td>
  </tr>
</table>
<script type="text/javascript">
  /* <![CDATA[ */

  function <%=this.ClientID%>_inheritAnnotationData(baseRecordingId) {    
    var rawData = <%=this.ClientID%>_getRecordingDocumentRawData(baseRecordingId);

    if (rawData.length == 0) {
      <%=this.ClientID%>_updateUserInterface('');
      return;
    }
    var dataArray = rawData.split('|');

    <%=this.ClientID%>_updateUserInterface(dataArray[0]);

    switch (dataArray[0]) {
      case "oNotaryRecording":
        <%=this.ClientID%>_inheritNotaryRecordingData(dataArray);
        return;
      case "oTitleRecording":
        <%=this.ClientID%>_inheritTitleRecordingData(dataArray);
        return;
      case "oJudicialRecording":
        <%=this.ClientID%>_inheritJudicialRecordingData(dataArray);
        return;
      case "oPrivateRecording":
        <%=this.ClientID%>_inheritPrivateRecordingData(dataArray);
        return;
      default:
        alert("No reconozco el tipo de documento regresado: " + dataArray[0]);
        return;
    }
  }

  function <%=this.ClientID%>_inheritNotaryRecordingData(dataArray) {
     getElement('<%=this.ClientID%>_cboNotaryDocIssuePlace').value = dataArray[1];
     <%=this.ClientID%>_updateControls('oNotaryRecording.IssuePlace');

     getElement('<%=this.ClientID%>_cboNotaryDocIssueOffice').value = dataArray[2];
     <%=this.ClientID%>_updateControls('oNotaryRecording.IssueOffice');

     getElement('<%=this.ClientID%>_cboNotaryDocIssuedBy').value = dataArray[3];
     getElement('<%=this.ClientID%>_txtNotaryDocBook').value = dataArray[4];
     getElement('<%=this.ClientID%>_txtNotaryDocNumber').value = dataArray[5];
     getElement('<%=this.ClientID%>_txtNotaryDocStartSheet').value = dataArray[6];
     getElement('<%=this.ClientID%>_txtNotaryDocEndSheet').value = dataArray[7];
     getElement('<%=this.ClientID%>_txtNotaryDocIssueDate').value = dataArray[8];
  }

  function <%=this.ClientID%>_inheritTitleRecordingData(dataArray) {
    getElement('<%=this.ClientID%>_txtPropTitleDocNumber').value = dataArray[1];
    getElement('<%=this.ClientID%>_cboPropTitleDocIssuedBy').value = dataArray[2];
    getElement('<%=this.ClientID%>_txtPropTitleIssueDate').value = dataArray[3];
    getElement('<%=this.ClientID%>_cboPropTitleIssueOffice').value = dataArray[4];
    getElement('<%=this.ClientID%>_txtPropTitleStartSheet').value = dataArray[5];
  }

  function <%=this.ClientID%>_inheritJudicialRecordingData(dataArray) {

    getElement('<%=this.ClientID%>_cboJudicialDocIssuePlace').value = dataArray[1];
    <%=this.ClientID%>_updateControls('oJudicialRecording.IssuePlace');

    getElement('<%=this.ClientID%>_cboJudicialDocIssueOffice').value = dataArray[2];
    <%=this.ClientID%>_updateControls('oJudicialRecording.IssueOffice');

    getElement('<%=this.ClientID%>_cboJudicialDocIssuedBy').value = dataArray[3];
    getElement('<%=this.ClientID%>_txtJudicialDocBook').value = dataArray[4];
    getElement('<%=this.ClientID%>_txtJudicialDocNumber').value = dataArray[5];
    getElement('<%=this.ClientID%>_txtJudicialDocIssueDate').value = dataArray[6];
  }

  function <%=this.ClientID%>_inheritPrivateRecordingData(dataArray) {
    getElement('<%=this.ClientID%>_cboPrivateDocIssuePlace').value = dataArray[1];
    <%=this.ClientID%>_updateControls('oPrivateRecording.IssuePlace');
    getElement('<%=this.ClientID%>_txtPrivateDocIssueDate').value = dataArray[2];
    getElement('<%=this.ClientID%>_txtPrivateDocNumber').value = dataArray[3];
    getElement('<%=this.ClientID%>_cboPrivateDocMainWitnessPosition').value = dataArray[4];
    <%=this.ClientID%>_updateControls('oPrivateRecording.MainWitnessPosition');
    getElement('<%=this.ClientID%>_cboPrivateDocMainWitness').value = dataArray[5];  
  }

  function <%=this.ClientID%>_getRecordingDocumentRawData(baseRecordingId) {
    var ajaxURL = "../ajax/land.registration.system.data.aspx";
    ajaxURL += "?commandName=getRecordingDocumentRawData";
    ajaxURL += "&recordingId=" + baseRecordingId;

    return invokeAjaxMethod(false, ajaxURL, null);
  }

  function <%=this.ClientID%>_validate(presentationDate) {
    if (getElement("<%=oNotaryRecording.ClientID%>").style.display == 'inline') {
      return <%=this.ClientID%>_validateNotaryRecording(presentationDate);
    } else if (getElement("<%=oTitleRecording.ClientID%>").style.display == 'inline') {
      return <%=this.ClientID%>_validateTitleRecording(presentationDate);
    } else if (getElement("<%=oJudicialRecording.ClientID%>").style.display == 'inline') {
      return <%=this.ClientID%>_validateJudicialRecording(presentationDate);
    } else if (getElement("<%=oPrivateRecording.ClientID%>").style.display == 'inline') {
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
      alert("Requiero se proporcione el tipo de documento.")
      return false;
    }
    if (getElement("<%=cboPrivateDocIssuePlace.ClientID%>").value.length == 0) {
      alert("Requiero conocer la ciudad donde se celebró el contrato.")
      return false;
    }
    if (getElement("<%=txtPrivateDocIssueDate.ClientID%>").value.length != 0) {
      if (!isDate(getElement('<%=txtPrivateDocIssueDate.ClientID%>'))) {
        alert("No reconozco la fecha de celebración del contrato.");
        return false;
      }
      if (!isValidDatePeriod(getElement('<%=txtPrivateDocIssueDate.ClientID%>').value, presentationDate)) {
        alert("La fecha del contrato no puede ser posterior a la fecha de presentación de la inscripción.");
        return false;
      }
    } else {
      if (!confirm("No se ha proporcionado la fecha de celebración del contrato.\n\n¿Se desconoce la fecha del contrato?")) {
        return false;
      }
    }
    if (getElement("<%=txtPrivateDocNumber.ClientID%>").value.length == 0) {
      alert("Necesito se proporcione el número de contrato.")
      return false;
    }
    if (getElement("<%=cboPrivateDocMainWitnessPosition.ClientID%>").value.length == 0) {
      alert("Requiero conocer el cargo público del funcionario público que certificó el contrato.")
      return false;
    }
    if (getElement("<%=cboPrivateDocMainWitness.ClientID%>").value.length == 0) {
      alert("Requiero se seleccione el nombre del funcionario público que certificó el contrato.")
      return false;
    }
    return true;
  }

  function <%=this.ClientID%>_updateUserInterface(documentTypeTag) {
    getElement("<%=oPreemptiveNotice.ClientID%>").style.display = 'none';
    getElement("<%=oNotaryRecording.ClientID%>").style.display = 'none';
    getElement("<%=oTitleRecording.ClientID%>").style.display = 'none';
    getElement("<%=oJudicialRecording.ClientID%>").style.display = 'none';
    getElement("<%=oPrivateRecording.ClientID%>").style.display = 'none';

    if (documentTypeTag.length != 0) {
      getElement("<%=this.ClientID%>_" + documentTypeTag).style.display = 'inline';
    }
  }

  function <%=this.ClientID%>_disabledControl(disabledFlag) {
    disableControls(getElement("<%=oPreemptiveNotice.ClientID%>"), disabledFlag);
    disableControls(getElement("<%=oNotaryRecording.ClientID%>"), disabledFlag);
    disableControls(getElement("<%=oTitleRecording.ClientID%>"), disabledFlag);
    disableControls(getElement("<%=oJudicialRecording.ClientID%>"), disabledFlag);
    disableControls(getElement("<%=oPrivateRecording.ClientID%>"), disabledFlag);
  }

  function <%=this.ClientID%>_updateControls(sourceName) {
    var url = "../ajax/land.registration.system.data.aspx";
    switch (sourceName) {
      case "oPreemptiveNoticeRecording.IssuePlace":
        url += "?commandName=getNotaryOfficesInPlaceStringArrayCmd";
        url += "&placeId=" + getElement('<%=cboPreemptiveNoticeIssuePlace.ClientID%>').value;
        invokeAjaxComboItemsLoader(url, getElement('<%=cboPreemptiveNoticeIssueOffice.ClientID%>'));
        return;
      case "oPreemptiveNoticeRecording.IssueOffice":
        url += "?commandName=getNotariesInNotaryOfficeStringArrayCmd";
        url += "&notaryOfficeId=" + getElement('<%=cboPreemptiveNoticeIssueOffice.ClientID%>').value;
        invokeAjaxComboItemsLoader(url, getElement('<%=cboPreemptiveNoticeIssuedBy.ClientID%>'));
        return;
      case "oNotaryRecording.IssuePlace":
        url += "?commandName=getNotaryOfficesInPlaceStringArrayCmd";
        url += "&placeId=" + getElement('<%=cboNotaryDocIssuePlace.ClientID%>').value;
        invokeAjaxComboItemsLoader(url, getElement('<%=cboNotaryDocIssueOffice.ClientID%>'));
        return;
      case "oNotaryRecording.IssueOffice":
        url += "?commandName=getNotariesInNotaryOfficeStringArrayCmd";
        url += "&notaryOfficeId=" + getElement('<%=cboNotaryDocIssueOffice.ClientID%>').value;
        invokeAjaxComboItemsLoader(url, getElement('<%=cboNotaryDocIssuedBy.ClientID%>'));
        return;
      case "oJudicialRecording.IssuePlace":
        url += "?commandName=getJudicialOfficeInPlaceStringArrayCmd";
        url += "&placeId=" + getElement('<%=cboJudicialDocIssuePlace.ClientID%>').value;
        invokeAjaxComboItemsLoader(url, getElement('<%=cboJudicialDocIssueOffice.ClientID%>'));
        return;
      case "oJudicialRecording.IssueOffice":
        url += "?commandName=getJudgesInJudicialOfficeStringArrayCmd";
        url += "&judicialOfficeId=" + getElement('<%=cboJudicialDocIssueOffice.ClientID%>').value;
        invokeAjaxComboItemsLoader(url, getElement('<%=cboJudicialDocIssuedBy.ClientID%>'));
        return;
      case "oPrivateRecording.IssuePlace":
      case "oPrivateRecording.MainWitnessPosition":
        url += "?commandName=getWitnessInPositionStringArrayCmd";
        url += "&placeId=" + getElement('<%=cboPrivateDocIssuePlace.ClientID%>').value;
        url += "&positionId=" + getElement('<%=cboPrivateDocMainWitnessPosition.ClientID%>').value;
        invokeAjaxComboItemsLoader(url, getElement('<%=cboPrivateDocMainWitness.ClientID%>'));
        return;
      default:
        alert("La opción de actualización del UI '" + sourceName + "' no ha sido definida en el programa.")
        return;
    }
  }

  addEvent(getElement('<%=cboPreemptiveNoticeIssuePlace.ClientID%>'), 'change', function() { <%=this.ClientID%>_updateControls("oPreemptiveNoticeRecording.IssuePlace") } );
  addEvent(getElement('<%=cboPreemptiveNoticeIssueOffice.ClientID%>'), 'change', function() { <%=this.ClientID%>_updateControls("oPreemptiveNoticeRecording.IssueOffice") } );

  addEvent(getElement('<%=cboNotaryDocIssuePlace.ClientID%>'), 'change', function() { <%=this.ClientID%>_updateControls("oNotaryRecording.IssuePlace") } );
  addEvent(getElement('<%=cboNotaryDocIssueOffice.ClientID%>'), 'change', function() { <%=this.ClientID%>_updateControls("oNotaryRecording.IssueOffice") } );

  addEvent(getElement('<%=cboJudicialDocIssuePlace.ClientID%>'), 'change', function() { <%=this.ClientID%>_updateControls("oJudicialRecording.IssuePlace") } );
  addEvent(getElement('<%=cboJudicialDocIssueOffice.ClientID%>'), 'change', function() { <%=this.ClientID%>_updateControls("oJudicialRecording.IssueOffice") } );
  addEvent(getElement('<%=cboPrivateDocIssuePlace.ClientID%>'), 'change', function() { <%=this.ClientID%>_updateControls("oPrivateRecording.IssuePlace") } );
  addEvent(getElement('<%=cboPrivateDocMainWitnessPosition.ClientID%>'), 'change', function() { <%=this.ClientID%>_updateControls("oPrivateRecording.MainWitnessPosition") } );
  addEvent(getElement('<%=txtJudicialDocBook.ClientID%>'), 'keypress', upperCaseKeyFilter);
  addEvent(getElement('<%=txtJudicialDocNumber.ClientID%>'), 'keypress', upperCaseKeyFilter);

  /* ]]> */
</script>
 