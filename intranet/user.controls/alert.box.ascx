<%@ Control Language="C#" AutoEventWireup="true" CodeFile="alert.box.ascx.cs" Inherits="controls_alert_box" %>
        <!-- The Modal -->
      <div id="myModal" class="modal">

        <!-- Modal content -->
        <div class="modal-content">
          <div id="mh" class="modal-header">
 
            <h2 id="alertHeader"></h2>
          </div>
          <div id="mb" class="modal-body">
            <p  style="text-align:justify;"  id="alertMsg"></p>
            <button type="button" id="closeBtn" onclick="close_modal()" name="true"  value="none" style="float:right;">Aceptar</button>
            <button type="button" id="okBtn" onclick="capture_click(event)" name="true"  value="none" style="float:right;">Aceptar</button>
            <button type="button" id="cancelBtn"  onclick="capture_click(event)" name="false"  value="none" style="float:right;">Cancelar</button>
            
          </div>
 
          <div id="mf" class="modal-footer">

            <h3 id="alertFooter" style="text-align:right"></h3>
          </div>
        </div>

      </div>
          <!-- end The Modal -->

<script type="text/javascript">
  /* <![CDATA[ */
  var modal = document.getElementById('myModal');

  var msg = "";
  var cbtn = document.getElementById('cancelBtn');
  var okbtn = document.getElementById('okBtn');
  var clbtn = document.getElementById('closeBtn');
  var okbtnr = document.getElementById('okBtnR');
  var clbtnr = document.getElementById('cancelBtnR');
  

  // empty array
  var ElementsClick = new Array();

  var doClick = '';
  var btnClick = '';
  var response;
  var processID;

  function showAlert(msg) {///showAlert 
    // Get the modal
    modal.style.display = "block";
    //Get the button for hidden
    cbtn.style.display = "none";
    okbtn.style.display = "none";
    clbtn.style.display = "block";
    if (arguments[1] != undefined) {
      document.getElementById("alertHeader").innerHTML = arguments[1]; // headerModal;
    }
    document.getElementById("alertMsg").innerHTML = msg;

  }///showAlert 

  function close_modal() {
    modal.style.display = "none";
  }
  
  function showConfirm(msg, hdr, ParamExecuteOp) { ///showConfirm
    response = null;
    clbtn.style.display = "none";
    modal.style.display = "block";
    if (arguments[1] != undefined) {
      document.getElementById("alertHeader").innerHTML = arguments[1]; // hdr headerModal;
    }
    document.getElementById("alertMsg").innerHTML = msg;
   
    cbtn.style.display = "block";
    okbtn.style.display = "block";

    processID = window.setInterval(function () {
      if (response == 'true') {
        window.clearInterval(processID);
        ParamExecuteOp();
      } else if (response == 'false') {
        window.clearInterval(processID);
      }
    }, 2000);
  } ////showConfirm
 
  function answer() {///answer;
   

    doClick = event.srcElement;
    ElementsClick.push(doClick);
    console.log('doClick---- ', doClick);
    console.log('doClick-name---- ', doClick.name);
    if (doClick.name == 'true') {
      modal.style.display = "none";
      return true;
    } else if (doClick.name == 'false') {
      modal.style.display = "none";
      return false;
    } else if (doClick.name == '' || doClick.name == null || doClick.name == undefined) {

     /// answer();
    }
  } ///////////answer;

  function capture_click(e, event) {//capture_click
    if (e == null ) {
      // read click in element
      console.log('elemnto');
      btnClick = event.srcElement;
    } else {
      console.log('objet');
      btnClick = e.target;
    }
    ElementsClick.push(btnClick);
    modal.style.display = "none";
    response = btnClick.name;
    return response;
  } //capture_click

  /* ]]> */
</script>
