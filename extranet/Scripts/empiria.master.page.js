/* Empiria ***************************************************************************************************
*																																																						 *
*	 Solution  : Empiria Web																			System   : Javascript Core Library					 *
*	 File      : /workplace/master_page.js											  Pattern  : JavaScript Methods Library				 *
*	 Date      : 25/Jun/2013                                      Version  : 2.0  License: LICENSE.TXT file    *
*																																																						 *
*  Summary   : Contains methods for workplace master page interaction.																			 *
*																																																						 *
********************************** Copyright(c) 1999-2015. La Vía Óntica SC, Ontica LLC and contributors.  **/

// region Global variables

var gContextMenuItemType = "";
var gContextMenuItem = 0;
var gClipboardContextMenuItem = 0;
var gsServerName = "Servidor";
var gsPageTitle = "";
var gsDashboardTitle = "";

// endregion Global variables

// region Public methods

function doMasterPageCommand(commandName, commandArguments) {
	switch (commandName) {
		case 'loadDashboardCmd':
			loadDashboardCommandHandler(commandArguments[1])
			gbSended = false;
			return true;
		case 'expandMenuCmd':
			expandMenu(commandArguments[1]);
			gbSended = false;
			return true;
	  case "showPopupMenuCmd":
	    expandPopupMenu(commandArguments[1]);
      gbSended = false;
      return true;
		case 'displayCalendarCmd':
			displayCalendar(commandArguments[1], commandArguments[2]);
			gbSended = false;
			return true;
		case 'onMouseOverMenuCmd':
		  gbSended = onMouseOverMenuCommandHandler(commandArguments[1]);
		  return true;
		case 'onMouseOutMenuCmd':
		  gbSended = onMouseOutMenuCommandHandler(commandArguments[1]);
		  return true;
		case 'onClickMenuCmd':
		  gbSended = onClickMenuCommandHandler(commandArguments[1]);
		  return true;
		case 'expandNavigationBarCmd':
			expandNavigationBar();
			gbSended = false;
			return true;
		case 'expandLeftToolbarCmd':
			expandLeftToolbar();
			gbSended = false;
			return true;
		case 'createWorkplaceCmd':
			createWorkplaceCommandHandler(commandName);
			gbSended = false;
			return true;
		case 'showAlertMessageBoxCmd':
			showAlertMessageBox();
			gbSended = false;
			return true;
		case 'hideAlertMessageBoxCmd':
			hideAlertMessageBox();
			gbSended = false;
			return true;							
		default:
			return false;
	}
}

function loadDashboardCommandHandler(dashboardId) {
  gsWaitScreenMessage = "Recuperando la página solicitada";

  loadViewCommandHandler('loadViewCmd', 'WebUI.Dashboard.Main', "userInterfaceItemId=" + dashboardId);
}

function onMouseOverMenuCommandHandler(tabStrip) {
  if (tabStrip.className != 'menuOff') {
    return;
  }
  tabStrip.className = "menuHover";
}

function onMouseOutMenuCommandHandler(tabStrip) {
  if (tabStrip.className != 'menuHover') {
    return;
  }
  tabStrip.className = "menuOff";
}

function onClickMenuCommandHandler(menuItem) {
  if (menuItem.className == 'menuDisabled') {
    return;
  }
  var menuPrefix = "masterMenu_";
  var menuIndex = new Number(menuItem.id.substr("masterMenu_".length));

  for (var i = 0; i < 10; i++) {
    var menuItemId = menuPrefix + i.toString();
    if (existsElement(menuItemId)) {
      if (getElement(menuItemId).className != 'menuDisabled') {
        getElement(menuItemId).className = "menuOff";
      }
    } else {
      break;
    }
    var menuItemViewName = 'masterSubMenu_' + i.toString();
    if (existsElement(menuItemViewName)) {
      getElement(menuItemViewName).style.display = 'none';
    }
  }
  menuItem.className = "menuOn";
  if (existsElement('masterSubMenu_' + menuIndex.toString())) {
    getElement('masterSubMenu_' + menuIndex.toString()).style.display = 'inline';
  }
}

function setMenuOption(menuOptionId) {
  var subMenuId = getElement(menuOptionId).parentElement.id;
  var subMenuIndex = new Number(subMenuId.substr("masterSubMenu_".length));

  getElement(menuOptionId).className = "selectedMenu";
  doCommand('onClickMenuCmd', getElement("masterMenu_" + subMenuIndex));

  gsDashboardTitle = getElement(menuOptionId).innerText;
  displayPageTitle();
}

function displayPageTitle() {
  if (gsPageTitle.length != 0) {
    getElement('divMainTitle').innerText = gsDashboardTitle + " » " + gsPageTitle;
  } else {
    getElement('divMainTitle').innerText = gsDashboardTitle;
  }
  if (gsPageTitle.length != 0) {
    window.document.title = gsPageTitle + " » " + gsDashboardTitle + " » " + gsServerName;
  } else {
    window.document.title = gsDashboardTitle + " » " + gsServerName;
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
	var textBox = getElement(textBoxName);
	var calendarImg = getElement(imgCalendarName);
  alert('El calendario está en construcción.')
}

function hideAlertMessageBox() {
	getElement('divAlertMessageBox').style.display = "none";
}

function showPopupMenuCmd(popupMenuName) {
	var menuElement = getElement(popupMenuName);
	
	showMsg("expanding popupMenu"  + popupMenuName);
}

function showAlertMessageBox() {
	var alertMessageBox = getElement('divAlertMessageBox');
	var divContent = getElement('divBody');
	
	alertMessageBox.style.display = "block";	
	alertMessageBox.style.left = (document.documentElement.offsetWidth + (divContent.scrollWidth - divContent.offsetWidth) - alertMessageBox.offsetWidth - 20) + "px";
	alertMessageBox.style.top = (document.documentElement.offsetHeight - 20) + "px";
	
	//var height = alertMessageBox.offsetHeight + 14;
	var maxHeight = calculateTextHeight();
	alertMessageBox.style.height = "0px";
	applyBottomUpMenuEffect('divAlertMessageBox', maxHeight, 6);
}

function applyBottomUpMenuEffect(elementName, maxHeight, increment) {
	var element = getElement(elementName);
	var regEx = /px/g;
	var currentHeight = Number(element.style.height.replace(regEx, "")) + increment;

	element.style.top = (element.offsetTop - increment) + "px";
	element.style.height = currentHeight + "px";
	if (currentHeight < maxHeight) {
		setTimeout("applyBottomUpMenuEffect('" + elementName + "', " + maxHeight + ", " + increment + ");", 20);
	}
}

// endregion Private command handler methods

// region Private methods

function setObjectEvents() {
	setWorkplaceGrayedImages();
	setHelperObjects();
}

function hideDefaultContextMenu() {
  return false;
}

function showContextMenu() {
  return false;
}

function getMenuItemsDisabledPattern() {
  var url = "../ajax/validator.aspx?menuItemsDisabledPattern=true&";
  url += "objectTypeInfoName=" + gContextMenuItemType + "&";
  url += "selectedMenuItem=" + gContextMenuItem + "&";
  url += "clipboardMenuItem=" + gClipboardContextMenuItem;

  return invokeAjaxMethod(false, url, null);
}

function calculateTextHeight() {
	return 136;
}

function setHelperObjects() {
	for (var i = 0; i < document.links.length; i++) {
		var link = document.links[i];			
		addEvent(link, 'mouseover', setStatus);
		addEvent(link, 'mouseout', resetStatus);
	}
}

function showWaitScreen() {
	if (gsWaitScreenMessage == "") {
		gsWaitScreenMessage =  "Ejecutando la operación solicitada";
	}
	setInnerText(getElement('spanWaitScreenMessage'), gsWaitScreenMessage);
	getElement('divContentHeader').style.display = "none";
	getElement('divContent').style.display = "none";
	getElement('divWait').style.display = "block";
}

// endregion Private methods
