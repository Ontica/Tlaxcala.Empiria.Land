<%@ Page language="c#" Inherits="Empiria.Web.UI.OLDLogonPage" EnableViewState="false" EnableSessionState="true" Codebehind="default.old.aspx.cs" %>
<%@ OutputCache Location="None" NoStore="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es-mx">
<head>
  <title><%="Inicio » " + Empiria.ExecutionServer.Name + " » " + Empiria.ExecutionServer.CustomerName %></title>
  <meta http-equiv="Expires" content="-1" />
  <meta http-equiv="Pragma" content="no-cache" />
  <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
  <meta name="MS.LOCALE" content="ES-MX" />
  <meta name="CATEGORY" content="home page" />
	<script type="text/javascript" src="./scripts/empiria.ajax.js"></script>
	<script type="text/javascript" src="./scripts/empiria.general.js"></script>
	<link href="./themes/default/css/logon.css" type="text/css" rel="stylesheet" />
	<base target="_blank" />
	<script type="text/javascript">
	/* <![CDATA[ */

		var gbSended = false;

    function doOperation(operationName) {
      switch(operationName) {
        case 'updateUserInterface':
          return updateUserInterface(arguments[1]);
        case 'sendOperation':
          return sendOperation();          
        default:
          alert("La operación proporcionada está fuera de servicio. Favor de intentar más tarde.");
          return;
      }
    }

    function sendOperation() {
      <% if (viewResultFlag) { %>
        getElement('cboOption').value = '';
        getElement("txtTransactionKey").value = '';
        getElement("txtEMail").value = '';
        getElement("txtPropertyKey").value = '';
        getElement("cboRecordingOffice").value = '';
        getElement("cboSection").value = '';
        getElement("cboVolume").value = '';
        getElement("cboRecording").value = '';
        window.frmEditor.submit();
        return;
      <% } %>
      var option = getElement('cboOption').value;
      if (!validateOperation(option)) {
        return;
      }
      window.frmEditor.submit();
    }

    function validateOperation(option) {
      if (option.length == 0) {
        alert("Requiero se proporcione una opción de la lista.");
        return false;
      }
      switch(option) {
        case 'transaction':
          return validateTransaction();
        case 'property':
          return validateProperty();
        case 'recording':
          return validateRecording();
        case 'book':         
          return validateBook();
      }
      return false;
    }

    function validateTransaction() {
			if (getElement("txtTransactionKey").value == '') {
				alert("Requiero se proporcione el número de trámite, el cual se encuentra impreso arriba del código de barras de la Boleta de Recepción.");
				getElement("txtTransactionKey").focus();
				return false;
			}
			if (getElement("txtTransactionKey").value.length != 14) {
				alert("El número de trámite está incompleto. Debe constar de catorce letras y dígitos, con un guión en la penúltima posición.");
				getElement("txtTransactionKey").focus();
				return false;
			}
      return true;
    }

    function validateProperty() {
			if (getElement("txtPropertyKey").value == '') {
				alert("Requiero se proporcione el folio electrónico del predio.");
				getElement("txtPropertyKey").focus();
				return false;
			}
			if (getElement("txtPropertyKey").value.length != 10) {
				alert("El folio electrónico del predio está incompleto. Debe constar de diez letras o dígitos, con un guión en la penúltima posición.");
				getElement("txtPropertyKey").focus();
				return false;
			}
      return true;
    }

    function validateRecording() { 
      return false;
    }

    function validateBook() {
      createNewWindow("./land.registration.system/directory.image.viewer.aspx?id=" + getElement('cboVolume').value);
      return false;      
    }

    function updateUserInterface(oControl) {
      switch (oControl.id) {
        case 'cboOption':
          updateOperationsUserInteface();
          return;
        case 'cboRecordingOffice':
          resetRecordingBooksCombo();
          return;
        case 'cboSection':
          resetRecordingBooksCombo();
          return;
        case 'cboVolume':
          return;
      }
    }

    function updateOperationsUserInteface() {
      getElement('rowTransaction0').style.display = 'none';
      getElement('rowTransactionResult0').style.display = 'none';
      getElement('rowTransactionResult1').style.display = 'none';
      getElement('rowTransactionResult2').style.display = 'none';
      getElement('rowTransactionResult3').style.display = 'none';
      getElement('rowTransactionResult4').style.display = 'none';
      getElement('rowProperty0').style.display = 'none';
      getElement('rowRecordings0').style.display = 'none';
      getElement('rowRecordings1').style.display = 'none';
      getElement('rowRecordings2').style.display = 'none';
      getElement('rowRecordings3').style.display = 'none';
      if (getElement('cboOption').value == "transaction") {
        getElement('rowTransaction0').style.display = 'inline';
        <% if (viewResultFlag) { %>
        getElement('rowTransactionResult0').style.display = 'inline';
        getElement('rowTransactionResult1').style.display = 'inline';
        <% if (!isFinished) { %>
        getElement('rowTransactionResult2').style.display = 'inline';
        getElement('rowTransactionResult3').style.display = 'inline';
        getElement('rowTransactionResult4').style.display = 'inline';
        <% } %>
        <% } %>
      } else if (getElement('cboOption').value == "property") {
        getElement('rowProperty0').style.display = 'inline';
      } else if (getElement('cboOption').value == "recording") {
        getElement('rowRecordings0').style.display = 'inline';
        getElement('rowRecordings1').style.display = 'inline';
        getElement('rowRecordings2').style.display = 'inline';
        getElement('rowRecordings3').style.display = 'inline';
      } else if (getElement('cboOption').value == "book") {
        getElement('rowRecordings0').style.display = 'inline';
        getElement('rowRecordings1').style.display = 'inline';
        getElement('rowRecordings2').style.display = 'inline';
      }
    }
   
   	function resetRecordingBooksCombo() {
      var url = "./ajax/land.registration.system.data.aspx";
      url += "?commandName=getRecordingBooksStringArrayCmd";
      url += "&recorderOfficeId=" + getElement('cboRecordingOffice').value;       
      url += "&recordingActTypeCategoryId=" + getElement('cboSection').value; 

      invokeAjaxComboItemsLoader(url, getElement("cboVolume"))
	  }

		function window_onload() {
			if (window.parent.frames.length != 0) {
				window.open("../default.aspx", "_top", null, true);
			}
      updateOperationsUserInteface();
      <%=theClientScript%>
		}

		addEvent(window, 'load', window_onload);

	/* ]]> */
	</script>
</head>
<body>
	<form id="frmEditor" method="post" target="_self" runat="server">
    <div id="divMainBanner"><img src="./themes/default/customer/pleca-roja.png" style="cursor: auto;" width="636px" alt="" title="" /></div>
		<div id="divMain">     
			<div id="divLeftColumn">
			  <br />
			  <img align="middle" class="decoratorImage" src="./themes/default/customer/customer.full.logo.png" alt="" style='margin-left:16px;margin-top:8px' />
			  <br /><br /><br /><br /><br /><br /><br />

			</div>
			<div id="divRightColumn">
					<br />
					<div class="title"><%=Empiria.ExecutionServer.Name%></div>
					<br /><br /><br /><br /><br /><br /><br /><br /><br />
          <table>
            <tr><td colspan="2"><strong>¿Qué desea hacer?</strong></td></tr>
            <tr><td colspan="2">
             <select id="cboOption" class="selectBox" runat="server" style="width:248px" onchange="doOperation('updateUserInterface', this)">
                <option value="">( Seleccionar una opción de la lista )</option>
                <option value="transaction">Consultar el estado de un trámite</option>
                <option value="property">Consultar un predio</option>
                <option value="book">Consultar un libro</option>
              </select>
                <!--<option value="recording">Consultar una inscripción</option>!-->
            </td></tr>
            <tr id="rowTransaction0" style="display:none">
              <td>Número de trámite:</td>
              <td><input id="txtTransactionKey" class="textBox" type="text" maxlength="14" size="24" style="width:142px" name="txtTransactionKey" runat="server" /></td>
            </tr>
            <tr id="rowTransactionResult0" style="display:none">
              <td>Estado del trámite:</td>
              <td>
                <b id="lblTransactionState" runat="server">No determinado</b>
              </td>
            </tr>
            <tr id="rowTransactionResult1" style="display:none">
              <td>Fecha de entrega:</td>
              <td>
                <b ID="lblTransactionDelivery" runat="server">No determinada</b>
              </td>
            </tr>
            <tr id="rowTransactionResult2" style="display:none">
              <td colspan="2">Si desea que le avisemos cuando su trámite está listo, favor de<br />
              proporcionarnos su correo electrónico:</td>
            </tr>
            <tr id="rowTransactionResult3" style="display:none">
              <td>Correo electrónico:</td>
              <td><input id="txtEMail" name="txtEMail" class="textBox" type="text" maxlength="32" size="24" style="width:128px" runat="server" /></td>
            </tr>
            <tr id="rowTransactionResult4" style="display:none">
              <td colspan="2">
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                <input id="cmbApplyEMail" name="cmbApplyEMail" type="button" style="width:128px" value="Registrar correo" />
              </td>
            </tr>
            <tr id="rowProperty0" style="display:none">
              <td>Folio electrónico:</td>
              <td><input id="txtPropertyKey" name="txtPropertyKey" class="textBox" type="text" maxlength="10" size="24" style="width:154px" runat="server" /></td>
            </tr>
            <tr id="rowRecordings0" style="display:none">
              <td>Distrito:</td>
              <td>
                <select id="cboRecordingOffice" class="selectBox" runat="server" style="width:268px" onchange="doOperation('updateUserInterface', this)">
                  <option value="0">( Distrito )</option>
                  <option value="101">Hidalgo</option>
	                <option value="102">Cuauhtémoc</option>
	                <option value="103">Juárez</option>
	                <option value="104">Lardizábal y Uribe</option>
	                <option value="105">Morelos</option>
	                <option value="106">Ocampo</option>
	                <option value="107">Xicohténcatl</option>
	                <option value="108">Zaragoza</option>
                </select> 
              </td>
            </tr>
            <tr id="rowRecordings1" style="display:none">
              <td>Sección:</td>
              <td>
                <select id="cboSection" class="selectBox" style="width:268px" runat="server" onchange="doOperation('updateUserInterface', this)">
                  <option value="0">( Sección )</option>
	                <option value="1051">Primera / Traslativos de dominio</option>
	                <option value="1052">Segunda / Hipotecas y embargos</option>
	                <option value="1053">Arrendamientos</option>
	                <option value="1054">Sentencias</option>
	                <option value="1055">Testamentos p&#250;blicos</option>
	                <option value="1056">Cr&#233;ditos agr&#237;colas</option>
	                <option value="1057">Procede</option>
	                <option value="1063">Diario</option>
                </select> 
              </td>
            </tr>
            <tr id="rowRecordings2" style="display:none">
              <td>Volumen:</td>
              <td>
                <select id="cboVolume" class="selectBox" style="width:268px" runat="server" onchange="doOperation('updateUserInterface', this)">
                  <option value="">( Volumen )</option>
                </select> 
              </td>
            </tr>
            <tr id="rowRecordings3" style="display:none">
              <td>Partida:</td>
              <td>
                <select id="cboRecording" style="width:268px" runat="server" >
                  <option value="">( Partida )</option>
                </select> 
              </td>
            </tr>
            <tr id="rowSubmit" style="display:inline">
              <td colspan="2">
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                <input id="cmdSend" name="cmdSend" type="button" style="width:128px;height:28px" value="Consultar" onclick="doOperation('sendOperation')" runat="server" />
              </td>
            </tr>
          </table>
        <br /><br />
				<div class="divOptionsMenu">
					<cite>Departamento de Informática<br />
					<b>Dirección de Notarías y Registros Públicos</b></cite>
				</div>
			</div> <!-- /div divRightColumn !-->		
			<div id="divFooter">
				<span class="leftItem"><a href="<%=Empiria.ProductInformation.Url%>"><%=Empiria.ProductInformation.Name%></a></span>
				<span class="rightItem"><a href="<%=Empiria.ProductInformation.CopyrightUrl%>"><%=Empiria.ProductInformation.Copyright%></a></span>
        <br />
			</div>
		</div> <!-- /div divMain !-->
	</form>
</body>
</html>
