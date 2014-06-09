<%@ Page language="c#" Inherits="Empiria.Web.UI.LRS.LRSTransactionEditor" EnableViewState="true" EnableSessionState="true" CodeFile="transaction.editor.aspx.cs" %>
<%@ OutputCache Location="None" NoStore="true" %>
<%@ Register tagprefix="empiriaControl" tagname="LRSRecordingActSelectorControl" src="../land.registration.system.controls/recording.act.selector.control.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es-mx">
<head id="Head1" runat="server">
<title><%=GetTitle()%></title>
<meta http-equiv="Expires" content="-1" /><meta http-equiv="Pragma" content="no-cache" />
<link href="../themes/default/css/secondary.master.page.css" type="text/css" rel="stylesheet" />
<link href="../themes/default/css/editor.css" type="text/css" rel="stylesheet" />
  <script type="text/javascript" src="../scripts/empiria.ajax.js"></script>
  <script type="text/javascript" src="../scripts/empiria.general.js"></script>
  <script type="text/javascript" src="../scripts/empiria.secondary.master.page.js"></script>
  <script type="text/javascript" src="../scripts/empiria.validation.js"></script>
  <script type="text/javascript" src="../scripts/empiria.calendar.js"></script>
</head>
<body>
<form id="aspnetForm" method="post" runat="server">
<div>
<input type="hidden" name="hdnPageCommand" id="hdnPageCommand" runat="server" />
</div>
<div id="divCanvas">
  <div id="divHeader">
    <span class="appTitle">
      <%=GetTitle()%>
    </span>
    <span class="rightItem">
    </span>
  </div>
  <div id="divBody">
    <div id="divContent">
  <table class="tabStrip">
    <tr>
      <td id="tabStripItem_0" class="tabOn" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);"  onclick="doCommand('onClickTabStripCmd', this);" title="">Información del trámite</td>
      <td id="tabStripItem_1" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="doCommand('onClickTabStripCmd', this);" title="">Actos jurídicos y conceptos</td>
      <td id="tabStripItem_2" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="doCommand('onClickTabStripCmd', this);" title="">Inscripción de documentos</td>
      <td id="tabStripItem_3" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="doCommand('onClickTabStripCmd', this);" title="">Emisión de certificados</td>
      <td id="tabStripItem_4" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="doCommand('onClickTabStripCmd', this);" title="">Historia del trámite</td>
      <td class="lastCell" colspan="1" rowspan="1"><a id="top" />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</td>
    </tr>
  </table>
  <table id="tabStripItemView_0" class="editionTable" style="display:inline">
    <tr>
      <td class="subTitle">Número de trámite, tipo de documento y recibo de pago</td>
    </tr>
    <tr>
    <td>
      <table id="transactionEditor0" class="editionTable">
        <tr>
          <td>Número de trámite:</td>
          <td colspan="3" class="lastCell">
            <input id='txtTransactionKey' type="text" class="textBox" readonly="readonly" style="width:180px;" title="" runat="server" />
            Distrito o mesa origen:
            <select id="cboRecorderOffice" class="selectBox" style="width:154px" onchange="return updateUserInterface(this);" runat="server">				  
              <option value="-1">No determinado</option>
     	        <option value="101">Hidalgo</option>
	            <option value="102">Cuauhtémoc</option>
	            <option value="103">Juárez</option>
	            <option value="104">Lardizábal y Uribe</option>
	            <option value="105">Morelos</option>
	            <option value="106">Ocampo</option>
	            <option value="107">Xicohténcatl</option>
	            <option value="108">Zaragoza</option>
	            <option value=""> </option>
	            <option value="146">Archivo General de Notarías</option>
	            <option value="145">Oficialía de partes</option>
	            <option value="147">Oficina del C. Director</option>
	            <option value="154">Jurídico</option>
	            <option value=""> </option>
	            <option value="139">Asoc civiles y créditos particulares (Rosario)</option>
              <option value="142">Avisos preventivos (Gregoria)</option>
	            <option value="138">Cert. de hipotecas (Lupita)</option>
	            <option value="135">Certificados (Lety Palacios)</option>
              <option value="137">Comercio (Laura)</option>
              <option value="134">Copias certificadas</option>
              <option value="141">Créditos (Javier Ceballos)</option>
              <option value="140">Embargos (Alejandra)</option>
              <option value="144">Infonavit (Rubén)</option>
              <option value="143">Procede (Tere Roldán)</option>
	            <option value="133">Sección 4ta</option>
	            <option value="136">Sección 5ta</option>
            </select>
          </td>
        </tr>
        <tr valign="bottom">
          <td>Tipo de documento:</td>
          <td colspan="3" class="lastCell">
            <select id="cboDocumentType" class="selectBox" style="width:186px" onchange="return updateUserInterface(this);" runat="server">
              <option value="">( Seleccionar )</option>
            </select>
            Núm de instrumento:
            <input id='txtDocumentNumber' type="text" class="textBox" style="width:128px;" title="" maxlength="32" runat="server" />
            <img src="../themes/default/buttons/search.gif" alt="" title="Busca un número de recibo" style="margin-left:-4px" onclick="doOperation('searchParty')" />
          </td>
        </tr>
        <tr>
          <td>Recibo de pago:</td>
          <td colspan="3" class="lastCell" valign="bottom">
            <input id='txtReceiptNumber' type="text" class="textBox" style="width:86px;" title="" maxlength="7" runat="server" onkeypress="return positiveKeyFilter(this);" />
            <input class="button" type="button" value="Validar pago" onclick="doOperation('validatePayment')" style="top:5px;height:26px;width:84px" /> 
            &nbsp;
            Importe total del pago de derechos:
            <b>$</b>&nbsp;<input id='txtReceiptTotal' type="text" class="textBox" onkeypress="return positiveKeyFilter(this);" style="width:71px;" title="" maxlength="8" runat="server" />
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td class="subTitle">Información del interesado</td>
  </tr>
   <tr>
    <td>
      <table class="editionTable">
        <tr>
          <td>Nombre del interesado:</td>
          <td colspan="3" class="lastCell">
            <input id='txtRequestedBy' type="text" class="textBox" style="width:428px;" title="" runat="server" />
            <img src="../themes/default/buttons/search.gif" alt="" title="Ejecuta la búsqueda" style="margin-left:-4px" onclick="doOperation('searchParty')" />
          </td>
        </tr>
        <tr>
          <td>Correo electrónico:</td>
          <td colspan="3" class="lastCell">
            <input id='txtContactEMail' type="text" class="textBox" style="width:189px;" title="" runat="server" />
            Teléfonos:
            <input id='txtContactPhone' type="text" class="textBox" style="width:168px;" title="" runat="server" />
          </td>
        </tr>
        <tr>
          <td>Tramitado por:</td>
          <td colspan="3" class="lastCell">
            <select id="cboManagementAgency" class="selectBox" style="width:336px" runat='server'>
              <option value="-1" title="oPrivateRecording">No determinado</option>
            </select>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td class="subTitle">Observaciones del interesado y de la Dependencia</td>
  </tr>
  <tr>
    <td>
      <table id="transactionEditor1" class="editionTable">
        <tr>
          <td>Interesado:<br />&nbsp;</td>
          <td colspan="2">
            <textarea id="txtRequestNotes" class="textArea" style="width:470px" cols="320" rows="2" runat="server"></textarea>
          </td>
          <td class="lastCell">&nbsp;</td>
        </tr>
        <tr>
          <td>Dependencia:<br />&nbsp;</td>
          <td colspan="2">
            <textarea id="txtOfficeNotes" class="textArea" style="width:470px" cols="320" rows="2" runat="server"></textarea>
          </td>
          <td class="lastCell">&nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td nowrap="nowrap">
            <% if (!transaction.IsNew) { %>
              <input class="button" type="button" value="Crear nuevo" onclick="doOperation('createNew')" style="height:28px;width:82px" runat="server" />
              &nbsp; &nbsp;
              <% if (base.ShowPrintPaymentOrderButton) { %>
                <input class="button" type="button" value="Orden de pago" onclick="doOperation('printOrderPayment')" style="height:28px;width:90px" runat="server" />
              <% } %>
              <% if (base.ShowTransactionVoucher) { %>
                <img src="../themes/default/bullets/pixel.gif" width="40px" height="1px" alt='' />
                <input id="button" class="button" type="button" value="Boleta de Recepción" onclick="doOperation('printTransactionReceipt')" style="height:28px;width:110px" runat="server" />
              <% } %>
            <% } else { %>
              <img src="../themes/default/bullets/pixel.gif" width="200px" height="1px" alt='' />
            <% } %>
          </td>
          <td nowrap="nowrap" width="280px">
            <% if (base.CanReceiveTransaction()) { %>
            <input id="cmdSaveAndReceive" class="button" type="button" value="Recibir trámite" onclick="doOperation('saveAndReceive')" style="height:30px;width:100px" runat="server" />
            <% } %>
            <% if (transaction.ReadyForReentry) { %>
            <input class="button" type="button" value="Reingresar trámite" onclick="doOperation('reentryTransaction')" style="height:30px;width:100px" runat="server" />
            <% } %>
            <input id="cmdSaveTransaction" class="button" type="button" value="Crear la solicitud" onclick="doOperation('saveTransaction')" style="height:28px;width:110px" runat="server" />
          </td>
          <td class="lastCell"></td>
        </tr>
      </table>
    </td>
  </tr>
</table>

    <table id="tabStripItemView_1" class="editionTable" style="display:none">
      <tr>
        <td class="subTitle">Actos jurídicos y conceptos involucrados</td>
      </tr>
      <tr>
        <td>
          <table class="editionTable" style="display:<%=base.transaction.IsNew ? "none" : "inline"%>">
            <tr>
              <td colspan="8" class="lastCell">
                <div style="overflow:auto;width:820px;">
                  <table class="details" style="width:99%">
                    <tr class="detailsHeader">
                      <td>#</td>
                      <td style="width:260px;white-space:nowrap">Acto jurídico</td>
                      <td>Fundamento</td>
                      <td>Recibo</td>
                      <td align='right'>Valor oper</td>
                      <td align='right'>D.Reg</td>
                      <td align='right'>Cotejo</td>
                      <td align='right'>Aclar</td>
                      <td align='right'>Usufr</td>
                      <td align='right'>Serv</td>
                      <td align='right'>C.Firmas</td>
                      <td align='right'>Foráneo</td>
                      <td align='right'>Subtotal</td>
                      <td align='right'>Dcto</td>
                      <td align='right'>Total</td>
                      <td>&nbsp;</td>
                    </tr>
                    <%=base.GetRecordingActs()%>
                  </table>
                </div>
              </td>                      
            </tr>
            <tr>
              <td>Tipo:</td>
              <td>
                <select id="cboRecordingActTypeCategory" class="selectBox" style="width:160px" onchange="return updateUserInterface(this);" runat="server">
                  <option value="1070">Traslativo de dominio</option>
                  <option value="1071">Limitaciones</option>
                  <option value="1072">Modificaciones</option>
                  <option value="1073">Anotaciones</option>
                  <option value="1074">Informativos</option>
                  <option value="1075">Cancelaciones</option>
                  <option value="1076">Notarías</option>
                </select>
              </td>
              <td colspan="4">Acto jurídico:
                &nbsp;
                <select id="cboRecordingActType" class="selectBox" style="width:335px" onchange="return updateUserInterface(this);" runat="server">
                  <option value="">( Seleccionar acto jurídico )</option>
                </select>
              </td>
              <td class="lastCell">
                <input class="button" type="button" value="Agregar" onclick="doOperation('appendRecordingAct')" style="width:70px" runat="server" />
              </td>
            </tr>
            <tr>
              <td>Fundamento:</td>
              <td>
                <select id="cboLawArticle" class="selectBox" style="width:160px" onchange="return updateUserInterface(this);" runat="server">
                  <option value="">( Fundamento )</option>
                </select>
              </td>
              <td>Recibo:</td>
              <td>
                <select id="cboReceipts" class="selectBox" style="width:86px" onchange="return updateUserInterface(this);" runat="server">
                  <option value="">(Recibos)</option>
                </select>
              </td>
              <td>
                Otro recibo:
              </td>
              <td>
                <input id='txtRecordingActReceipt' type="text" class="textBox" onkeypress="return positiveKeyFilter(this);" style="width:71px;" title="" maxlength="8" runat="server" />
              </td>
              <td class="lastCell">&nbsp;</td>
            </tr>
            <tr>
              <td>Valor operación:</td>
              <td><input id='txtOperationValue' type="text" class="textBox" onkeypress="return positiveKeyFilter(this);" style="width:71px;" title="" maxlength="8" runat="server" /></td>
              <td>Derechos de registro:</td>
              <td><input id='txtRecordingRightsFee' type="text" class="textBox" onkeypress="return positiveKeyFilter(this);" style="width:71px;" title="" maxlength="8" runat="server" /></td>
              <td>Cotejo:</td>
              <td><input id='txtSheetsRevisionFee' type="text" class="textBox" onkeypress="return positiveKeyFilter(this);" style="width:71px;" title="" maxlength="8" runat="server" /></td>
            </tr>
            <tr>
              <td>Aclaración:</td>
              <td><input id='txtAclarationFee' type="text" class="textBox" onkeypress="return positiveKeyFilter(this);" style="width:71px;" title="" maxlength="8" runat="server" /></td>
              <td>Usufructo:</td>
              <td><input id='txtUsufructFee' type="text" class="textBox" onkeypress="return positiveKeyFilter(this);" style="width:71px;" title="" maxlength="8" runat="server" /></td>
              <td>Servidumbre:</td>
              <td><input id='txtServidumbreFee' type="text" class="textBox" onkeypress="return positiveKeyFilter(this);" style="width:71px;" title="" maxlength="8" runat="server" /></td>
            </tr>
            <tr>
              <td>Certificación firmas:</td>
              <td><input id='txtSignCertificationFee' type="text" class="textBox" onkeypress="return positiveKeyFilter(this);" style="width:71px;" title="" maxlength="8" runat="server" /></td>
              <td>Foráneo:</td>
              <td><input id='txtForeignRecordFee' type="text" class="textBox" onkeypress="return positiveKeyFilter(this);" style="width:71px;" title="" maxlength="8" runat="server" /></td>
              <td><b>Subtotal:</b></td>
              <td><input id='txtSubtotal' disabled="disabled" type="text" class="textBox" onkeypress="return positiveKeyFilter(this);" style="width:71px;" title="" maxlength="8" runat="server" /></td>
            </tr>
            <tr>
              <td colspan="4">&nbsp;</td>
              <td>Descuento:</td>
              <td><input id='txtDiscount' type="text" class="textBox" onkeypress="return positiveKeyFilter(this);" style="width:71px;" title="" maxlength="8" runat="server" /></td>
            </tr>
            <tr>
              <td colspan="4">&nbsp;</td>
              <td><b>TOTAL:</b></td>
              <td><input id='txtTotal' disabled="disabled" type="text" class="textBox" onkeypress="return positiveKeyFilter(this);" style="width:71px;" title="" maxlength="8" runat="server" /></td>
            </tr>
          </table>
        </td>
      </tr>
    </table>

    <table id="tabStripItemView_2" class="editionTable" style="display:none">
      <tr>
        <td class="lastCell">
          <iframe id="ifraRecordingEditor" style="z-index:99;left:0px;top:0px;" 
                  marginheight="0" marginwidth="0" frameborder="0" scrolling="no"
                  src="../workplace/empty.page.aspx" width="90%" height="1500px" visible="true" >
          </iframe>
        </td>
      </tr>
    </table>

    <table id="tabStripItemView_3" class="editionTable" style="display:none">
      <tr>
        <td class="subTitle">Certificados emitidos</td>
      </tr>
      <tr>
        <td>
          <div style="overflow:auto;width:100%;">
            <table class="details" style="width:97%">
              <tr class="detailsHeader">
                <td>#Certif</td>
                <td>Tipo de certificado</td>
                <td>Predio</td>
                <td>Interesado</td>
                <td>Elaborado por</td>
                <td>Estado</td>
                <td width="40%">Observaciones</td>
              </tr>
            </table>
          </div>
        </td>
      </tr>
    </table>

    <table id="tabStripItemView_4" class="editionTable" style="display:none">
    <tr>
      <td class="subTitle">Historia del trámite</td>
    </tr>
    <tr>
      <td>
        <div style="overflow:auto;width:100%;">
          <table class="details" style="width:97%">
            <tr class="detailsHeader">
              <td>Tipo de movimiento</td>
              <td>Responsable</td>
              <td>Recibido</td>
              <td>Terminado</td>
              <td>Entregado</td>
              <td>Trabajo</td>
              <td>Estado</td>
              <td width="40%">Observaciones</td>
            </tr>
            <%=GetTransactionTrack()%>
          </table>
        </div>
        <br />
        <br />
        <% if (transaction.Status == Empiria.Land.Registration.Transactions.TransactionStatus.Deleted) { %>
        <input id="cmdUndelete" class="button" type="button" value="Reactivar" onclick="doOperation('undelete')" style="height:28px;width:110px" runat="server" />
        <% } %>
      </td>
    </tr>
 </table>
        </div>
      </div> <!-- end divBody !-->  
      <div id="divBottomToolbar" style="display:none">        
      </div> <!-- end divBottomToolbar !-->
    </div> <!-- end divCanvas !-->
  </form>
  <iframe id="ifraCalendar" style="z-index: 99; LEFT: 0px; visibility: hidden; position: absolute; TOP: 0px" 
          hspace="0px" vspace="0" marginheight="0"  marginwidth="0" frameborder="0" scrolling="no" 
          src="../user.controls/calendar.aspx" width="100%">
  </iframe>
</body>
  <script type="text/javascript">
  /* <![CDATA[ */
  
  function doPageCommand(commandName, commandArguments) {
    switch (commandName) {
      default:
        return false;
    }
  }

  function doOperation(command) {
    var success = false;

    if (gbSended) {
      return;
    }
    switch (command) {
      case 'redirectThis':
        success = true;
        break;
      case 'saveTransaction':
        return saveTransaction();
      case 'saveAndReceive':
        return saveAndReceiveTransaction();
      case 'reentryTransaction':
        return reentryTransaction();
      case 'createCopy':
        return createCopy();
      case 'appendRecordingAct':
        return appendRecordingAct();
      case 'deleteRecordingAct':
        return deleteRecordingAct(arguments[1]);
      case 'savePayment':
        return savePayment();
      case 'cancelTransaction':
        success = true;
        break;
      case 'createNew':
        return createNew();
      case 'showRecordingActSelectorControl':
        return showRecordingActSelectorControl();
      case 'printOrderPayment':
        sendPageCommand('printOrderPayment');
        gbSended = true;
        return;
      case 'printTransactionReceipt':
        sendPageCommand('printTransactionReceipt');
        gbSended = true;
        return;
      case 'searchCadastralNumber':
        alert("La búsqueda de claves catastrales no está disponible en este momento.");
        return;
      case 'searchGeographicalItems':
        return searchGeographicalItems();
      case 'setNoNumberLabel':
        getElement("txtExternalNumber").value = "S/N";
        return;
      case 'closeWindow':
        window.parent.execScript("doOperation('refreshRecording')");
        return;
      case 'appendGeographicalItem':
        return appendGeographicalItem();
      case 'undelete':
        sendPageCommand("undeleteTransaction");
        return;
      default:
        alert("La operación '" + command + "' no ha sido definida en el programa.");
        return;
    }
    if (success) {
      sendPageCommand(command);
      gbSended = true;
    }
  }

  function reentryTransaction() {
    var sMsg = "Reingreso de trámites.\n\n";

    sMsg += "Esta operación reinigresará este trámite y lo enviará al distrito o mesa de trabajo correspondiente.\n\n";
    sMsg += "¿Reingreso este trámite";
    if (confirm(sMsg)) {
      sendPageCommand("reentryTransaction");
    }
  }

  function deleteRecordingAct(transactionActId) {
    var sMsg = "Eliminación de actos jurídicos y conceptos de pago.\n\n";

    sMsg += "Esta operación eliminará el siguiente elemento de la lista de actos jurídicos:\n\n";
    sMsg += "Acto:\n";
    sMsg += "Total\n\n";
    sMsg += "¿Elimino el acto jurídico de la lista?";

    if (confirm(sMsg)) {
      sendPageCommand("deleteRecordingAct", "id=" + transactionActId);
      gbSended = true;
    }
  }

  function createNew() {
    window.location.replace("transaction.editor.aspx?id=0&typeId=<%=base.transaction.TransactionType.Id%>");
  }

  function printOrderPayment() {
    var url = "payment.receipt.aspx?id=<%=base.transaction.Id%>";

    createNewWindow(url);
  }

  function printTransactionReceipt() {
    var url = "transaction.receipt.aspx?id=<%=base.transaction.Id%>";

    createNewWindow(url);
  }

  function saveTransaction() {
    if (!doValidation("saveTransaction")) {
      return;
    }
    if (!doSendMsg("saveTransaction")) {
      return;
    }
    sendPageCommand("saveTransaction");
    gbSended = true;
  }

  function saveAndReceiveTransaction() {
    if (!doValidation("saveAndReceiveTransaction")) {
      return;
    }
    if (!doSendMsg("saveAndReceiveTransacion")) {
      return;
    }
    sendPageCommand("saveAndReceiveTransaction");
    gbSended = true;
  }

  function appendRecordingAct() {
    if (!doValidateRecordingAct()) {
      return;
    }
    var sMsg = getComboOptionText(getElement('cboRecordingActType')) + "\n"; 
    sMsg += "Fundamento:\t\t" + getComboOptionText(getElement('cboLawArticle')) + "\n"; 
    sMsg += "Número de recibo:\t\t" + getComboOptionText(getElement('cboReceipts')) + "\n"; 
    sMsg += "Valor de la operación:\t" + formatAsCurrency(getElement('txtOperationValue').value) + "\n\n"; 
    sMsg += "Derechos registrales:\t\t" + formatAsCurrency(getElement('txtRecordingRightsFee').value) + "\n";

    if (convertToNumber(getElement('txtSheetsRevisionFee').value) != 0) {
      sMsg += "Cotejo:\t\t\t" + formatAsCurrency(getElement('txtSheetsRevisionFee').value) + "\n";
    }
    if (convertToNumber(getElement('txtAclarationFee').value) != 0) {
      sMsg += "Aclaración:\t\t" + formatAsCurrency(getElement('txtAclarationFee').value) + "\n";
    }
    if (convertToNumber(getElement('txtUsufructFee').value) != 0) {
      sMsg += "Usufructo:\t\t\t" + formatAsCurrency(getElement('txtUsufructFee').value) + "\n";
    }
    if (convertToNumber(getElement('txtServidumbreFee').value) != 0) {
      sMsg += "Servidumbre:\t\t" + formatAsCurrency(getElement('txtServidumbreFee').value) + "\n";
    }
    if (convertToNumber(getElement('txtSignCertificationFee').value) != 0) {
      sMsg += "Certificación firmas:\t\t" + formatAsCurrency(getElement('txtSignCertificationFee').value) + "\n";
    }
    if (convertToNumber(getElement('txtForeignRecordFee').value) != 0) {
      sMsg += "Foráneo:\t\t\t" + formatAsCurrency(getElement('txtForeignRecordFee').value) + "\n";
    }
    sMsg += "\n";
    if (convertToNumber(getElement('txtDiscount').value) == 0) {
      sMsg += "Total:\t\t\t" + formatAsCurrency(getTotal()) + "\n";
    } else {
      sMsg += "Subtotal:\t\t\t" + formatAsCurrency(getSubTotal()) + "\n";
      sMsg += "Descuento:\t\t" + formatAsCurrency(getElement('txtDiscount').value) + "\n";
      sMsg += "Total:\t\t\t" + formatAsCurrency(getTotal()) + "\n";
    }
    sMsg += "\n";
    sMsg += "¿Agrego el acto jurídico y la información del pago de derechos?";
    if (confirm(sMsg)) {
      sendPageCommand("appendRecordingAct");
      gbSended = true;
    }
  }

  function doValidateRecordingAct() {
    if (getElement('cboRecordingActType').value.length == 0) {
      alert("Requiero se proporcione el acto jurídico.");
      return false;
    }
    if (getElement('cboLawArticle').value.length == 0) {
      alert("Requiero se proporcione el fundamento del cobro.");
      return false;
    }
    if (getElement('cboReceipts').length > 1 && getElement('cboReceipts').value.length == 0 && getElement('txtRecordingActReceipt').value.length == 0) {
      alert("Necesito se introduzca el número de recibo adicional.");
      return false;
    } else if (getElement('cboReceipts').length == 1 && getElement('cboReceipts').value.length == 0 && getElement('txtRecordingActReceipt').value.length == 0) {
      getElement('txtRecordingActReceipt').value = "N/D";
    }
    if (!validateQuantity(getElement('txtOperationValue'), "Valor de la operación")) {
      return false;
    }
    if (!validateQuantity(getElement('txtRecordingRightsFee'), "Derechos de registro")) {
      return false;
    }
    if (!validateQuantity(getElement('txtSheetsRevisionFee'), "Cotejo")) {
      return false;
    }
    if (!validateQuantity(getElement('txtAclarationFee'), "Aclaración")) {
      return false;
    }
    if (!validateQuantity(getElement('txtUsufructFee'), "Usufructo")) {
      return false;
    }
    if (!validateQuantity(getElement('txtServidumbreFee'), "Servidumbre")) {
      return false;
    }
    if (!validateQuantity(getElement('txtSignCertificationFee'), "Certificación de firmas")) {
      return false;
    }
    if (!validateQuantity(getElement('txtForeignRecordFee'), "Trámite foráneo")) {
      return false;
    }
    if (!validateQuantity(getElement('txtDiscount'), "Descuento")) {
      return false;
    }
    getElement('txtSubtotal').value = getSubTotal();
    getElement('txtTotal').value = getTotal();

    if (convertToNumber(getElement('txtTotal').value) < 0) {
      alert("El importe total del acto no puede ser menor que cero.");
      return false;
    }
    return true;
  }

  function getSubTotal() {
    var subtotal = Number();

    subtotal = 0;

    subtotal += convertToNumber(getElement('txtRecordingRightsFee').value);
    subtotal += convertToNumber(getElement('txtSheetsRevisionFee').value);
    subtotal += convertToNumber(getElement('txtAclarationFee').value);
    subtotal += convertToNumber(getElement('txtUsufructFee').value);
    subtotal += convertToNumber(getElement('txtServidumbreFee').value);
    subtotal += convertToNumber(getElement('txtSignCertificationFee').value);
    subtotal += convertToNumber(getElement('txtForeignRecordFee').value);

    return subtotal;    
  }

  function getTotal() {
    return getSubTotal() - convertToNumber(getElement('txtDiscount').value);
  }

  function validateQuantity(oElement, elementName) {
   if (oElement.value.length == 0) {
      oElement.value = "0.00";
      return true;
    }
    if (!isNumeric(oElement)) {
      alert("No reconozco el importe de " + elementName + ".");
      return false;
    }
    if (convertToNumber(oElement.value) < 0) {
      alert("El importe de " + elementName + " debe ser mayor o igual a cero.");
      return false;
    }
    return true;
  }
  
  function doSendMsg(command) {
    var sMsg = "";

    sMsg  = "Número de trámite:\t" + getElement('txtTransactionKey').value + "\n";
    sMsg += "Tipo de documento:\t" + getComboOptionText(getElement('cboDocumentType')) + "\n";
    sMsg += "Núm instrumento:\t" + getElement('txtDocumentNumber').value + "\n\n";
    sMsg += "Número de recibo:\t" + getElement('txtReceiptNumber').value + "\n";
    sMsg += "Pago de derechos:\t" + formatAsCurrency(getElement('txtReceiptTotal').value) + "\n\n";
    sMsg += "Interesado: " + getElement('txtRequestedBy').value + "\n\n";

    if (command == "saveTransaction") {
    <% if (base.transaction.IsNew) { %>
    sMsg = "Crear una nueva solicitud de trámite.\n\n" + sMsg;
    sMsg += "¿Creo este nuevo trámite con la información proporcionada?";
    <% } else { %>
    sMsg = "Modificar la solicitud de trámite " + getElement('txtTransactionKey').value + ".\n\n" + sMsg;
    sMsg += "¿Modifico la información de este trámite?";
    <% } %>
    } else if (command == "saveAndReceiveTransacion") {
    <% if (base.transaction.IsNew) { %>
    sMsg = "Crear y recibir una nueva solicitud de trámite.\n\n" + sMsg;
    sMsg += "¿Creo este nuevo trámite y lo marco como recibido?";
    <% } else { %>
    sMsg = "Recibir la solicitud de trámite " + getElement('txtTransactionKey').value + ".\n\n" + sMsg;
    sMsg += "¿Recibo este trámite?";
    <% } %>
    }

    return confirm(sMsg);
  }

  function createCopy() {
    alert("create Copy")
  }

  function updateUserInterface(oControl) {
    if (oControl == null) {
      return;
    }
    if (oControl == getElement("cboRecordingActTypeCategory")) {
      resetRecordingsTypesCombo();
    } else if (oControl == getElement("cboRecordingActType")) {
      resetLawArticlesCombo();
    }
  }

  function resetRecordingsTypesCombo() {    
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getRecordingTypesStringArrayCmd";
    url += "&recordingActTypeCategoryId=" + getElement("cboRecordingActTypeCategory").value; 

    invokeAjaxComboItemsLoader(url, getElement("cboRecordingActType"));

    resetLawArticlesCombo();
  }

  function resetLawArticlesCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getLawArticlesStringArrayCmd";
    url += "&recordingActTypeId=" + getElement("cboRecordingActType").value; 

    invokeAjaxComboItemsLoader(url, getElement("cboLawArticle"));
  }

  function doValidation(command) {
    var sMsg = "";
    var oPayment = getElement('txtReceiptTotal');

    if (isEmpty(getElement('cboDocumentType'))) {
      alert("Requiero se proporcione el tipo de documento que se desea inscribir."); 
      return false;
    }
    if (command == 'saveAndReceiveTransaction') {
      if (isEmpty(getElement('txtReceiptNumber'))) {
        alert("Requiero se proporcione el número del recibo emitido para este trámite.");
        return false;
      }
    }
    if (oPayment.value.length == 0) {
      alert("Requiero se proporcione el importe total por pago de derechos.");
      return false;
    }
    if (!isNumeric(oPayment)) {
      alert("No reconozco el importe total por pago de derechos.");
      return false;
    }
    if (convertToNumber(oPayment.value) < 0) {
      alert("El importe por pago de derechos debe ser mayor o igual a cero.");
      return false;
    }
    if (isEmpty(getElement('txtRequestedBy'))) {
      alert("Requiero se proporcione el nombre del solicitante."); 
      return false;
    }
    return true;
  }

  function window_onload() {
    setWorkplace();
    <% if (!base.transaction.IsNew && !base.transaction.IsEmptyInstance) { %>
      getElement('ifraRecordingEditor').src = "../land.registration.system/recording.editor.aspx?transactionId=<%=transaction.Id%>";
    <% } else { %>
      getElement('ifraRecordingEditor').src = "../workplace/empty.page.aspx";
    <% } %>
    <%=base.OnloadScript()%>
  }

  function setWorkplace2() {
    resizeWorkplace2();
    setObjectEvents();
    window.defaultStatus = '';
  }

  function resizeWorkplace2() {

  }

  function window_onscroll() {

  }

  function ifraRecordingEditor_onresize() {
    var oFrame = getElement("ifraRecordingEditor");
    var oBody = oFrame.document.body;

    var newHeight = oBody.scrollHeight + oBody.clientHeight;

    oFrame.style.height = oBody.scrollHeight + (oBody.offsetHeight - oBody.clientHeight) + 400;
    oFrame.style.width = oBody.scrollWidth + (oBody.offsetWidth - oBody.clientWidth);
    //alert(oFrame.style.height);
  }

  function window_onresize() {
    ifraRecordingEditor_onresize();
    window_onscroll();
  }

  addEvent(window, 'load', window_onload);
  addEvent(window, 'resize', window_onresize);
  addEvent(getElement("ifraRecordingEditor"), 'resize', ifraRecordingEditor_onresize);
  addEvent(getElement("txtRequestedBy"), 'keypress', upperCaseKeyFilter);

  /* ]]> */
  </script>
</html>
