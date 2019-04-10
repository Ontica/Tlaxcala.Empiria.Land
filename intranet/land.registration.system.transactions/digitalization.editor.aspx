<%@ Page Language="C#" AutoEventWireup="true" Inherits="Empiria.Land.WebApp.DigitalizationEditor" Codebehind="digitalization.editor.aspx.cs" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>Digitalización de trámites</title>
  <meta http-equiv="Expires" content="-1" />
  <meta http-equiv="Pragma" content="no-cache" />
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <link href="../themes/default/css/secondary.master.page.css" type="text/css" rel="stylesheet" />
  <link href="../themes/default/css/editor.css" type="text/css" rel="stylesheet" />
  <script type="text/javascript" src="../scripts/empiria.ajax.js"></script>
  <script type="text/javascript" src="../scripts/empiria.general.js"></script>
  <script type="text/javascript" src="../scripts/empiria.secondary.master.page.js"></script>
  <script type="text/javascript" src="../scripts/empiria.validation.js"></script>
</head>
<body style="background-color:#fafafa; top:0; margin:0; margin-top:-14px; margin-left:-6px;">
  <form name="aspnetForm" method="post" enctype="multipart/form-data" id="aspnetForm" runat="server">
    <div id="divContentAlwaysVisible">

      <table id="tabStripItemView_0" style="display:inline;">
        <tr>
          <td class="subTitle">Documentos digitalizados asociados al trámite</td>
        </tr>

       <tr>
        <td style="width:100%">
          <div style="overflow:auto;width:100%;">
            <table class="details" style="width:97%">
              <tr class="detailsHeader">
                <td style="white-space:nowrap">Tipo de documento</td>
                <td style="white-space:nowrap">Digitalizado por</td>
                <td style="white-space:nowrap">Fecha</td>
                <td style="white-space:nowrap;width:40%">&nbsp;</td>
              </tr>
              <%=base.GetDocuments()%>
            </table>
          </div>
          <% if (base.CanEditDocuments()) { %>
          <div>
            <br /><br />
            <table>
              <% if (!base.documentSet.HasMainDocument) { %>
              <tr>
                <td>Documento principal:</td>
                <td><input type="file" id="mainDocument" name="mainDocument" style="width:400px" accept="application/pdf" runat="server" /></td>
              </tr>
              <% } %>
              <% if (!base.documentSet.HasAuxiliaryDocument) { %>
              <tr>
                <td>Anexos:</td>
                <td><input type="file" id="auxiliaryDocument" name="auxiliaryDocument" style="width:400px" accept="application/pdf" runat="server" /></td>
              </tr>
              <% } %>
              <% if (!base.documentSet.HasMainDocument || !base.documentSet.HasAuxiliaryDocument) { %>
              <tr>
                <td>&nbsp;</td>
                <td><input class="button" type="button" value="Subir archivos" onclick="doOperation('updloadFiles')" style="height:28px;width:128px" /></td>
              </tr>
              <% } %>
            </table>
          </div>
          <% } %>
        </td>
      </tr>

     </table>

    </div>
  </form>
</body>

<script type="text/javascript">

  function doOperation(command) {
    var success = false;

    if (gbSended) {
      return;
    }
    switch (command) {
      case "updloadFiles":
        updloadFiles();
        return;

      case "viewFile":
        viewFile(arguments[1]);
        return;

      case "deleteFile":
        deleteFile(arguments[1]);
        return;

      case "refresh":
        refresh();
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


  function viewFile(url) {
    createNewWindow(url);
  }

  function deleteFile(id) {
    var msg = "¿Elimino el archivo seleccionado?";

    if (confirm(msg)) {
      sendPageCommand("deleteFile", "documentId=" + id);
    }
  }

  function updloadFiles() {
    sendPageCommand("updloadFiles");
  }

  function refresh() {
    window.location.reload();
  }

  function updateUserInterface(oControl) {
    if (oControl == null) {
      return;
    }
  }

  function window_onload() {
    <%=base.OnLoadScript%>
  }

  function window_onunload() {

  }

  addEvent(window, 'load', window_onload);
  addEvent(window, 'unload', window_onunload);

</script>
</html>
