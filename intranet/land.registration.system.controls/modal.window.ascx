<%@ Control Language="C#" AutoEventWireup="false" Inherits="Empiria.WebApp.ModalWindowControl" CodeFile="modal.window.ascx.cs" %>
<div id='<%=this.ClientID%>_Window' class="modalWindow" style="height:300px;width:610px;display:none">
  <div class="modalHeader">
    <span id='<%=this.ClientID%>_Title'>Historia del predio XXXX</span>

   <img class="modalCloseIcon" src="../themes/default/buttons/close.png"
        onclick="<%=this.ClientID%>_close()" alt="Cerrar" />

	</div>  <!-- divHeader !-->
   
	<div class="modalBody">

    <div id='<%=this.ClientID%>_Content' class="modalContent" style="overflow:auto;max-height:440px;">
      <!-- Contenido !-->
    </div>
  </div>
</div>

<script type="text/javascript">
  /* <![CDATA[ */

  function <%=this.ClientID%>_close() {
    var oModalWindow  = getElement("<%=this.ClientID%>_Window");
    oModalWindow.style.display = 'none';
  }

  function <%=this.ClientID%>_show(title, innerHtml) {
    getElement('<%=this.ClientID%>_Title').innerText = title;
    getElement('<%=this.ClientID%>_Content').innerHTML = innerHtml;

    <%=this.ClientID%>_center();

    getElement('<%=this.ClientID%>_Window').style.display = 'inline';
  }

  function <%=this.ClientID%>_center() {
    var modalWindow = getElement("<%=this.ClientID%>_Window");
    var x = (document.body.clientWidth - modalWindow.style.width.replace("px", "")) / 2;
    //var y = (document.body.clientHeight - modalWindow.currentStyle.height.replace("px", "")) / 2;
    var y = 110;

    modalWindow.style.left = x + "px";
    modalWindow.style.top = y + "px";
  }

  /* ]]> */
</script>
