/* Empiria® **************************************************************************************************
*																																																						 *
*	 Solution  : Empiria® Web																			System   : Javascript Core Library					 *
*	 File      : /workplace/master_page.js											  Pattern  : JavaScript Methods Library				 *
*	 Date      : 28/Mar/2014                                      Version  : 1.5  License: CC BY-NC-SA 4.0     *
*																																																						 *
*  Summary   : Contains methods for workplace master page interaction.																			 *
*																																																						 *
**************************************************** Copyright © La Vía Óntica SC + Ontica LLC. 1994-2014. **/

// region Public methods	

var gbIsDirty = false;

function doMasterPageCommand(commandName, commandArguments) {
  switch (commandName) {
    case "showPopupMenuCmd":
      expandPopupMenu(commandArguments[1]);
      gbSended = false;
      return true;
    case 'displayCalendarCmd':
      displayCalendar(commandArguments[1], commandArguments[2]);
      gbSended = false;
      return true;
    case 'createWorkplaceCmd':
      createWorkplace();
      gbSended = false;
      return true;
    default:
      return false;
  }
}

// endregion Public methods

// region Private command handler methods

function createWorkplaceCommandHandler(commandName) {
  var commandPage = "../workplace/command.processor.aspx";  
  commandPage += "?commandName=" + commandName;
   if (getElement('hdnEmpiriaWorkplace').value != "") {
    commandPage += "&workplace=" + getElement('hdnEmpiriaWorkplace').value;
  }
  
  window.open(commandPage);
}

function displayCalendar(textBoxName, imgCalendarName) {
  var dateTextBox = getElement(textBoxName);
  var calendarImg = getElement(imgCalendarName);
  
  showCalendar(dateTextBox, calendarImg);
}

function showPopupMenuCmd(popupMenuName) {
  var menuElement = getElement(popupMenuName);

  showMsg("expanding popupMenu"  + popupMenuName);
}

// endregion Private command handler methods

// region Private methods

function setObjectEvents() {
  setWorkplaceGrayedImages();
  setHelperObjects();
  setEditionObjects();
}

function setWorkplace() {
  //hideControlDivisions();
  resizeWorkplace();
  addEvent(window, 'resize', resizeWorkplace);
  setObjectEvents();
  window.defaultStatus = ""; //"Sistema Empiria® 2014. Copyright © La Vía Óntica SC + Ontica LLC. 1994-2014.";
}

function hideControlDivisions() {
  var elements = document.forms[0].childNodes;
  
  for (var i = 0; i < elements.length; i++) {
    var tagName = String(elements[i].tagName).toLowerCase();
    if (tagName == "div") {
      if (elements[i].id == "" && elements[i].className == "") {
        elements[i].style.display = "none";
      }
    }
  }
}

function resizeWorkplace() {
  var divBody = getElement('divBody');
  var divHeader = getElement('divHeader');
  var divContent = getElement('divContent');
  var divBottomToolbar = getElement('divBottomToolbar');

  var height = document.documentElement.offsetHeight - divHeader.offsetHeight - divBottomToolbar.offsetHeight;
  var width = document.documentElement.offsetWidth;
  if (height > 0) {
    divBody.style.height = height + "px";
    divContent.style.height = height - 18 + "px";
  }
  divContent.style.width = width - 28 + "px";
}

function setHelperObjects() {
  for (var i = 0; i < document.links.length; i++) {
    var link = document.links[i];			
    addEvent(link, 'mouseover', setStatus);
    addEvent(link, 'mouseout', resetStatus);
  }
  
  var elements = document.forms[0].getElementsByTagName('input');	
  for (var i = 0; i < elements.length; i++) {
    addEvent(elements[i], 'mouseover', setStatus);
    addEvent(elements[i], 'mouseout', resetStatus);		
  }
  
  elements = document.forms[0].getElementsByTagName('textarea');	
  for (var i = 0; i < elements.length; i++) {
    addEvent(elements[i], 'mouseover', setStatus);
    addEvent(elements[i], 'mouseout', resetStatus);
  }
  
  elements = document.forms[0].getElementsByTagName('select');	
  for (var i = 0; i < elements.length; i++) {
    addEvent(elements[i], 'mouseover', setStatus);
    addEvent(elements[i], 'mouseout', resetStatus);
  }
}

function setEditionObjects() {
  if (arguments.length == 1) {
    var elements = arguments[0];
    for (var i = 0; i < elements.length; i++) {
      addEvent(elements[i], 'keypress', setDirtyFlag);
      addEvent(elements[i], 'click', setDirtyFlag);
    }
    return;
  }
  
  var elements = document.forms[0].getElementsByTagName('input');
  for (var i = 0; i < elements.length; i++) {
    addEvent(elements[i], 'keypress', setDirtyFlag);
    addEvent(elements[i], 'click', setDirtyFlag);
  }
  
  elements = document.forms[0].getElementsByTagName('textarea');
  for (var i = 0; i < elements.length; i++) {
    addEvent(elements[i], 'keypress', setDirtyFlag);
    addEvent(elements[i], 'click', setDirtyFlag);    
  }
  
  elements = document.forms[0].getElementsByTagName('select');
  for (var i = 0; i < elements.length; i++) {
    addEvent(elements[i], 'change', setDirtyFlag);
  }
}
  
function setWorkplaceGrayedImages() {
  for (var i = 0; i < document.images.length; i++) {
    var image = document.images[i];
    if ((image.className == "grayedImage") || (image.className == "navButton") || 
        (image.className == "newWindowImage") || (image.className == "expandHeaderImg")) {
      addEvent(image, 'mouseover', ungrayImage);
      addEvent(image, 'mouseout', grayImage);
    }
  }
}

function setDirtyFlag() {
  gbIsDirty = true;
  
  //alert('setdirty');
  //var oApplyButton = getElement('btnApplyChanges');
  //if (oApplyButton == null || oApplyButton == 'undefined') {
  //  // no-op
  //} else {
  //  if (oApplyButton.disabled && oApplyButton.tabIndex != -1) {
  //    oApplyButton.disabled = false;
  //  }
  //}
  //var oAcceptChangesButton = getElement('btnAcceptChanges');
  //if (oAcceptChangesButton == null || oAcceptChangesButton == 'undefined') {
  //  // no-op
  //} else {
  //  if (oAcceptChangesButton.disabled && oAcceptChangesButton.tabIndex != -1) {
  //    oAcceptChangesButton.disabled = false;
  //  }
  //}
}

function showWaitScreen() {
  if (gsWaitScreenMessage == "") {
    gsWaitScreenMessage =  "Ejecutando la operación solicitada";
  }
  setInnerText(getElement('spanWaitScreenMessage'), gsWaitScreenMessage);
  getElement('divWait').style.display = "block";
  getElement('divContent').style.display = "none";
}

// endregion Private methods