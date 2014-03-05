/***********************************************************************************************************/
/*  Ajax General Validation methods                                                                        */
/***********************************************************************************************************/

function isNoLabourDate(date) {
  var ajaxUrl = "../ajax/general.data.aspx";
  ajaxUrl += "?commandName=isNoLabourDateCmd";
  ajaxUrl += "&date=" + date;
  if (arguments.length == 2) {
    ajaxUrl += "&calendar=" + arguments[1];
  }

  var result = invokeAjaxMethod(false, ajaxUrl, null);
  if (result.toLowerCase() == "true") {
    return true;
  } else {
    return false;
  }
}

function daysBetween(fromDate, toDate) {
  var ajaxUrl = "../ajax/general.data.aspx";
  ajaxUrl += "?commandName=daysBetweenCmd";
  ajaxUrl += "&fromDate=" + fromDate;
  ajaxUrl += "&toDate=" + toDate;
  
  var result = invokeAjaxMethod(false, ajaxUrl, null);

  return Number(result);
}


/***********************************************************************************************************/
/*  Ajax Ontology methods                                                                                  */
/***********************************************************************************************************/

function alreadyExistsObject(objectTypeInfoName, objectId, objectName) {
  var url = "../ajax/ontology.data.aspx";
  url += "?commandName=verifyObjectNameExistenceCmd";
  url += "&objectTypeInfoName=" + objectTypeInfoName;
  url += "&objectId=" + objectId;
  url += "&objectName=" + objectName;
  
  var result = invokeAjaxMethod(false, url, null);
  if (result.toLowerCase() == "true") {
    return true;
  } else {
    return false;
  }
}

function alreadyExistsObjectWithUniqueAttribute(objectTypeInfoName, attributeName, objectId, attributeValue) {
  var url = "../ajax/ontology.data.aspx";
  url += "?commandName=verifyUniqueAttributeCmd";
  url += "&objectTypeInfoName=" + objectTypeInfoName;
  url += "&attributeName=" + attributeName;
  url += "&objectId=" + objectId;
  url += "&attributeValue=" + attributeValue;

  var alreadyExists = invokeAjaxMethod(false, url, null);
  alreadyExists = alreadyExists.toLowerCase();

  if (alreadyExists == "true") {
    return true;
  } else {
    return false;
  }
}

/***********************************************************************************************************/
/*  XMLHttp Javscript Wrapper Class																					                               */
/***********************************************************************************************************/

function invokeAjaxMethod(isAsync, url, callbackMethod) {
  var client = new HttpClient();
  client.isAsync = isAsync;
  if (isAsync) {
    client.callback = callbackMethod;
    client.makeRequest(url, null);
    return true;
  } else {
    var ajaxResult = client.makeRequest(url, null);
    return ajaxResult;
  }
}

function invokeAjaxValidator(url) {
  var client = new HttpClient();
  
  client.isAsync = false;  
  var ajaxResult = client.makeRequest(url, null);

  if (ajaxResult == null) {   // "@ERROR@NULL_COMMAND_NAME" || "@ERROR@NULL_COMMAND_NAME"
    window.close();
    return false;
  }
  if (ajaxResult.length == 0) {
    return true;
  }
  if (ajaxResult.indexOf('¿') != -1 || ajaxResult.indexOf('?') != -1) {
    return confirm(ajaxResult);
  } else {
    alert(ajaxResult);
    return false;
  }
}

function invokeAjaxComboItemsLoader(url, oCombo) {
  var comboOptionsString = invokeAjaxMethod(false, url, null);

  addComboItemsFromJoinString(oCombo, comboOptionsString);
}

function addComboItemsFromJoinString(oCombo, itemsString) {
  var itemsArray = new Array();
  itemsArray = itemsString.split('|');
  
  oCombo.selectedIndex = -1;
  oCombo.options.length = 0;    
  for (var i = 0; i < itemsArray.length; i++) {
    var comboOptionArray = new Array(2);
    comboOptionArray = itemsArray[i].split('~');
    
    var optionItem = document.createElement("option");
    oCombo.options.add(optionItem);
    optionItem.value = comboOptionArray[0];
    optionItem.text = comboOptionArray[1];
  } // for
}

/***********************************************************************************************************/
/*  HttpClient Class																					                                             */
/***********************************************************************************************************/

function HttpClient() { }  

  HttpClient.prototype = {   
    
    // type GET, POST passed to open
    requestType: 'GET',
    
    // when set to true, async calls are made
    isAsync: false,
    
    // where an XMLHttpRequest instance is stored
    xmlhttp: false,
    
    // what is called when a successful async call is made
    callback: false,
    
    onBeforeSend: function() {
      window.status = "Estoy ejecutando la operación. Un momento por favor ...";
      document.body.style.cursor = "wait";
    },
    
    // what is called when send is called on XMLHttpRequest
    // set your own function to onSend to have a custom loading effect
    onSend: function() {

    },
    
    onReceiving: function() {

    },
    
    // what is called when readyState 4 is reached, this is called before your callback
    onLoad: function() {
      window.status = '';
      document.body.style.cursor = "auto";      
    },
    
    // what is called when an http error happens
    onError: function(error) {
      window.status = '';
      document.body.style.cursor = "auto";       
      alert("Ocurrió un problema:\n\n" + error);   
    },
    
    // method to initialize an XMLHttpRequest
    start: function() {
      try {
        this.xmlhttp = new window.XMLHttpRequest();   // Mozilla / Safari / IE7 - 8.0
      } catch (e) {  // Not IE
        var XMLHTTP_IDS = new Array('MSXML2.XMLHTTP.5.0', 'MSXML2.XMLHTTP.4.0', 'MSXML2.XMLHTTP.3.0', 
                                    'MSXML2.XMLHTTP', 'Microsoft.XMLHTTP');
        var success = false;
        for (var i = 0; i < XMLHTTP_IDS.length && !success; i++) {
          try {
            this.xmlhttp = new ActiveXObject(XMLHTTP_IDS[i]);
            success = true;
          } catch (e) {
            //no-op
          }
        }  // for
        if (!success) {
          alert("No puedo crear un objeto de comunicación 'XmlHttpRequest' con el servidor.");
        }
      }  // main-catch
    },

    // method to make a page request
    // @param string url The page to make the request to
    // @param string content What you’re sending if this is a POST request
    makeRequest: function(url, content) {
      if (!this.xmlhttp) {
        this.start();
      }
      this.xmlhttp.open(this.requestType, url, this.isAsync);
      // set onreadystatechange here since it will be reset after a completed call in Mozilla
      var self = this;
      this.xmlhttp.onreadystatechange = function() {
        self.onStateChangeCallback(); 
      }      

      this.xmlhttp.send(content);
      
      if (this.xmlhttp.responseText == "@ERROR@NULL_COMMAND_NAME") {      
        var sMsg = "Tuve un problema al ejecutar la operación.\n\n";
        sMsg += "Se intentó ejecutar una operación mediante Ajax, pero no se indicó\n";
        sMsg += "el nombre de la instrucción correspondiente.\n\n";
        sMsg += "Se trata de un error de programación que puede provocar resultados\n";
        sMsg += "inesperados o fallas en la operación del sistema.";
        sMsg += "Por seguridad de la aplicación, esta página se cerrará automáticamente.";
        document.body.style.cursor = "auto";
        alert(sMsg);
        window.close();
        return null;
      }
      
      if (this.xmlhttp.responseText == "@ERROR@SESSION_TIMEOUT_RESPONSE") {
        var sMsg = "La sessión de trabajo ha caducado.\n\n";      
        
        sMsg += "La sesión de trabajo ha caducado, por lo que se debe ingresar\n";
        sMsg += "nuevamente a la aplicación desde la página de inicio.\n\n";
        sMsg += "Por seguridad de la aplicación, esta página se cerrará automáticamente.";
        document.body.style.cursor = "auto";        
        alert(sMsg);
        window.close();
        return null;
      }
      
      if (!this.isAsync) {
        return this.xmlhttp.responseText;
      }
    },

    // private method used to handle ready state changes
    onStateChangeCallback: function() { 
      switch(this.xmlhttp.readyState) {
        case 0:                   // 0 (Uninitialized): The object has been created, but not initialized (the open method has not been called).
          return;
        case 1:
          this.onBeforeSend();    // 1 (Open) The object has been created, but the send method has not been called.
          return;    
        case 2:
          this.onSend();          // 2 (Sent) The send method has been called. responseText is not available. responseBody is not available. 
          return;
        case 3:                   // 3 (Receiving) Some data has been received. responseText is not available. responseBody is not available. 
          this.onReceiving();
          return;
        case 4:                   // 4 (Loaded) All the data has been received. responseText is available. responseBody is available. 
          this.onLoad();
          if (this.xmlhttp.status == 200) {
            if (this.callback != false) {
              this.callback(this.xmlhttp.responseText);
            }
          } else {
            var sMsg = "Ocurrió un problema al realizar la llamada al servidor:\n\n";
            sMsg += "[" + this.xmlhttp.status + "] " + this.xmlhttp.statusText;
            this.onError(sMsg);
          }
          return;
        default:
          alert("La invocación del método vía Ajax, regresó el estado " + this.xmlhttp.readyState + ", mismo que no reconozco.");
          return;
      } // switch
    }

} // class HttpClient