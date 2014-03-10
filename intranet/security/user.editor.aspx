<%@ Page Language="C#"  EnableViewState="false" MasterPageFile="~/workplace/old.secondary.master" AutoEventWireup="true" Inherits="Empiria.Web.UI.Security.UserEditor" CodeFile="user.editor.aspx.cs" %>
<asp:Content ID="content" ContentPlaceHolderID="contentPlaceHolder" Runat="Server">
<table class="editionTable">
  <tr><td class="subTitle">Información de la persona</td></tr>
  <tr><td>
    <table class="editionTable">
      <tr>
        <td colspan="1" rowspan="1"><div>Nombre del usuario:</div></td>
        <td class="lastCell" colspan="1" rowspan="1">
          <input type="text" class="textBox" id='txtDisplayName' name='txtDisplayName' onkeypress='return alphaSpaceKeyFilter(event);' title="Nombre del usuario" maxlength="32" runat="server" />
        </td>
      </tr>
      <tr>
        <td colspan="1" rowspan="1"><div>Observaciones:<br /></div></td>
        <td class="lastCell" colspan="1" rowspan="1">
          <textarea id='txtObservations' name='txtObservations' class="textArea" cols="60" rows="2" onkeypress='return alphaSpaceKeyFilter(event);' title="Observaciones sobre el usuario" runat="server"></textarea>
        </td>
      </tr>      
      <tr>
        <td colspan="1" rowspan="1"><div>Correo electrónico:</div></td>
        <td class="lastCell" colspan="1" rowspan="1">
          <input type="text" class="textBox" id='txtEmail' name='txtEmail' onkeypress='return eMailAddressKeyFilter(event);' title="Correo electrónico del usuario" maxlength="42" runat="server" />
        </td>
      </tr>
     </table>
    </td></tr>
    <tr><td class="subTitle">Información de acceso</td></tr>
    <tr><td>
      <table class="editionTable">
        <tr>
          <td colspan="1" rowspan="1"><div>Identificador del usuario:</div></td>
          <td class="lastCell" colspan="2" rowspan="1">
            <input type="text" class="textBox" id='txtUserName' name='txtUserName' style="width:180px" onkeypress='return alphaNumericKeyFilter(event);' title="Identificador del usuario" maxlength="32" runat="server" />
          </td>
        </tr>
        <tr>
          <td colspan="1" rowspan="1"><div>Contraseña:</div></td>
          <td class="lastCell" colspan="1" rowspan="1">
            <input type="password" class="textBox" id='txtNewPassword' name='txtNewPassword' onkeypress='return alphaNumericKeyFilter(event, false);' style="width:140px" title="Nueva contraseña del usuario" maxlength="16" runat="server"  />
          </td>
          <td colspan="1" rowspan="2" align="left">
            <div><b>MUY IMPORTANTE:</b>&nbsp;</div>
            Por seguridad, favor de emplear caracteres en mayúsculas<br />
            y minúsculas, números y caracteres especiales como<br />
            ( ) $ = : , ; & / | \ % # - ! _ ? + @ * .
          </td>
        </tr>
        <tr>
          <td colspan="1" rowspan="1"><div>Confirmar contraseña:</div></td>
          <td class="lastCell" colspan="2" rowspan="1">
             <input type="password" class="textBox" id='txtNewPassword2' name='txtNewPassword2' onkeypress='return alphaNumericKeyFilter(event, false);' style="width:140px" title="Confirmación de la nueva contraseña del usuario" maxlength="16"  runat="server" />
          </td>
        </tr>
        <tr>
          <td colspan="1" rowspan="1"><div>¿Activar la cuenta?</div></td>
          <td class="lastCell" colspan="2" rowspan="1">
             <input type="checkbox" id='chkIsActive' name='chkIsActive' title="Indica si la cuenta de usuario está activa" runat="server" />
          </td>
        </tr>
      </table>
   </td></tr>
  <tr><td class="subTitle" colspan="2">Grupos de entidades a los que tiene acceso</td></tr>
  <tr><td>
    <table class="editionTable">
      <tr><td colspan="1" rowspan="1">
        <table class="details">
          <tr class="detailsHeader">
            <td style="width: 10px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td><b>Grupos de entidades</b></td>
            <td align="right">Buscar:
                <input type="text" id='txtgrdMembersIds' name="txtgrdMembersIds" class="textBox" onkeypress='return alphaNumericKeyFilter(event, true);' 
                       maxlength="48" style="width:100px" />
                <img src="~/themes/default/buttons/ellipsis.gif" alt="" title="" 
                     onclick="return updateGrid('grdMembersIds', 563, getElement('txtgrdMembersIds').value, '-1')" />
                <% if (canEditEntitiesGroup) { %>
                <img src="~/themes/default/buttons/edit.gif" 
                     onclick="javascript:doCommand('createViewCmd', '../explorers/object.editor.aspx?id=0&amp;type=ObjectType.NestedObjectType.EntityGroup', 750, 1000, null, false)" alt="" title="" />
                <% } %>
                &nbsp; &nbsp; &nbsp;
            </td></tr>
        </table>
        <div id='divgrdMembersIds' style="overflow:auto; height:100%; width:100%;">
          <table class="details">
            <tr class="detailsSubHeader">
              <td style="width: 1px;">&nbsp;</td>
              <td>Nombre</td>
            </tr>
            <%=grdEntitiesContents%>
          </table>
        </div>
      </td>
   </table>
  </td></tr>
</table>
</asp:Content>
<asp:Content ID="bottomToolbar" ContentPlaceHolderID="bottomToolbarPlaceHolder" Runat="Server">
  <span class="leftItem nowrap">
    <img src="../themes/default/textures/pixel.gif" width="24px" alt="" title="" />
    <input id="btnDeleteObject" name="btnDeleteObject" type="button" class="button" <%=onDeleteButtonAttrs%> onclick="doOperation('deleteObjectCmd')" title="Elimina del sistema la información de este elemento" style="width: 70px" value="Eliminar" />
  </span>
  <span class="rightItem nowrap">
    <input id="btnAcceptChanges" name="btnAcceptChanges" type="button" class="button" <%=onChangesButtonAttrs%> onclick="doOperation('acceptChangesCmd')" title="Acepta los cambios y cierra la página" style="width: 70px" value="<%=btnAcceptChangesText%>" />
    <img src="../themes/default/textures/pixel.gif" width="8px" alt="" title="" />
    <input id="btnCancelEdition" name="btnCancelEdition" type="button" class="button" onclick="doOperation('cancelEditionCmd')" title="Descarta todos los cambios y cierra esta página de edición" style="width: 70px" value="Cancelar" />  
    <img src="../themes/default/textures/pixel.gif" width="12px" alt="" title="" />
    <input id="btnApplyChanges" name="btnApplyChanges" type="button" class="button"  <%=onChangesButtonAttrs%> onclick="doOperation('applyChangesCmd')" title="Aplica los cambios efectuados y mantiene esta página abierta" style="width: 70px" value="<%=btnApplyChangesText%>" />
  </span>
  <script type="text/javascript">
  /* <![CDATA[ */

  function doOperation(operationName) {
    switch (operationName) {
      case 'acceptChangesCmd':
        sendPageCommand("acceptChangesCmd");
        return;
       case 'applyChangesCmd':
        sendPageCommand("applyChangesCmd");
        return;
       case 'cancelEditionCmd':
        sendPageCommand("cancelEditionCmd");
        return;        
      default:
        alert('La operación \'' + operationName + '\' todavía no ha sido definida en el programa.');
        return;
    }
  }
    
  /* ]]> */
  </script>
</asp:Content>
