<%@ Control Language="C#" AutoEventWireup="false" Inherits="Empiria.Web.UI.LRS.RecordingActEditorControl" CodeFile="recording.act.editor.control.ascx.cs" %>
<table class="editionTable">
  <tr id="divRecordingActTypeSelectorTitle"><td class="actionsSeparator">(1) Seleccionar el tipo de acto jurídico</td></tr>
  <tr>
    <td>
      <table class="editionTable">
        <tr id="divRecordingActTypeSelector">
          <td>Tipo de acto:</td>
          <td>
            <select id="cboRecordingActTypeCategory" name="cboRecordingActTypeCategory" class="selectBox"
                    style="width:192px" title="" onchange="return updateUI(this);">
            </select>
          </td>
          <td>
            <select id="cboRecordingActType" class="selectBox" style="width:306px" title=""
                    onchange="return updateUI(this);">
              <option value="">( Primero seleccionar el tipo de acto jurídico )</option>
            </select>
            <input type="button" value="Agregar acto" class="button" style="width:78px;height:28px;vertical-align:middle" onclick='doRecordingActEditorOperation("appendRecordingAct")' />
          </td>
          <td class="lastCell">&nbsp;</td>
        </tr>
        <tr id="divPropertyTypeSelector">
          <td>Del predio:</td>
          <td valign="top">
            <select id="cboPropertyTypeSelector" class="selectBox" style="width:192px" title="" onchange="return updateUI(this);">
              <option value="">( Seleccionar )</option>
            </select>
          </td>
          <td>
            <span id="divNewPropertyRecorderOfficeSection" style="display:none">
              Distrito donde se encuentra:
              <select id="cboNewPropertyRecorderOffice" class="selectBox" style="width:164px" title="" onchange="return updateUI(this);">
                <option value="">( Seleccionar ) </option>
                <option value="101">Hidalgo</option>
                <option value="102">Cuauhtémoc</option>
                <option value="103">Juárez</option>
                <option value="104">Lardizábal y Uribe</option>
                <option value="105">Morelos</option>
                <option value="106">Ocampo</option>
                <option value="107">Xicohténcatl</option>
                <option value="108">Zaragoza</option>
              </select>
            </span>
            <span id="divPrecedentActSection" style="display:none">
            <span id="divFractionSection" style="display:none">
              Sobre:
              <select id="cboPropertySubdivisionType" class="selectBox" style="width:132px" title=""
                      onchange="return updateUI(this);">
                <option value="" title="None">( Seleccionar )</option>
                <option value="whole" title="None">la Totalidad</option>
                <option value="partial" title="Partial">la Fracción</option>
                <option value="last" title="Last">la Fracción Última</option>
                <option value="full" title="Full">el Lote</option>
              </select>
              <span id="divFractionPartXofYSection" style="display:none">
                Número:
                <input id="txtPropertySubdivisionNo" type="text" class="textBox"
                        style="width:24px;margin-right:0px" onblur="return setPropertyPartsTotal();"
                        onkeypress="return integerKeyFilter(this);" title="" maxlength="4" />
                de:
                <input id="txtPropertyTotalLots" name="txtPropertyTotalLots" type="text" class="textBox"
                        style="width:24px;margin-right:0px" onkeypress="return integerKeyFilter(this);"
                        title="" maxlength="4" />
              </span>
              <br />
            </span>
            Folio del predio:
            <input id="txtDocumentKey" class="textBox" type="text" maxlength="18" style="width:152px" />
            <img src="../themes/default/buttons/search.gif" alt="" title="Ejecuta la búsqueda" style="margin-left:-8px"
                  onclick="doRecordingActEditorOperation('lookupProperty')" />
            <a href='javascript:doRecordingActEditorOperation("refreshPrecedentRecordingCombos")' class="button">Buscarlo o agregarlo en libros físicos</a>
            </span>
          </td>
          <td class="lastCell">&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
  <tr id="divPhysicalRecordingSelectorTitle" style="display:none"><td class="actionsSeparator">(2) Seleccionar el antecedente en libros</td></tr>
  <tr id="divPhysicalRecordingSelector" style="display:none">
    <td>
      <table class="editionTable">
        <tr id="divPrecedentRecordingSection" style="display:none">
          <td>Predio<br />registrado en:</td>
          <td>
            <select id="cboPrecedentRecordingSection" class="selectBox" style="width:196px" title=""
                    onchange="return updateUI(this);">
            </select>
          </td>
          <td>Volumen:<br /></td>
          <td>
            <select id="cboPrecedentRecordingBook" class="selectBox" style="width:300px" title=""
                    onchange="return updateUI(this);">
                <option value="">( Primero seleccionar Distrito y sección )</option>
            </select>
          </td>
          <td>Partida:</td>
          <td>
            <select id="cboPrecedentRecording" class="selectBox" style="width:98px" title=""
                    onchange="return updateUI(this);">
              <option value="">¿Libro?</option>
            </select>
            <img src="../themes/default/buttons/search.gif" alt="" title="Ejecuta la búsqueda" style="margin-left:-8px"
                  onclick="doRecordingActEditorOperation('showPrecedentRecording')" />
          </td>
          <td class="lastCell">&nbsp;</td>
        </tr>
        <tr>
          <td colspan="2">&nbsp;</td>
          <td colspan="4">
            <span id="divPropertySelectorSection" style="display:none">
              Predio: &nbsp; &nbsp;
              <select id="cboPrecedentProperty" class="selectBox" style="width:300px" title="">
                <option value="">¿Inscripción?</option>
              </select>
              <img src="../themes/default/buttons/search.gif" alt="" title="Ejecuta la búsqueda" style="margin-left:-8px"
                    onclick="doRecordingActEditorOperation('displayProperty')" />
            </span>
            <span id="divRecordingQuickAddSection" style="display:none">
            Partida donde está registrado el predio:
            <input id="txtQuickAddRecordingNumber" type="text" class="textBox" style="width:32px;margin-right:0px"
                    onkeypress="return integerKeyFilter(this);" title="" maxlength="5" />
            <select id="cboQuickAddRecordingSubNumber" class="selectBox" 
                  style="width:52px;margin-right:0px" title="">
              <option value=""></option>
              <option value="/01">/01</option><option value="/02">/02</option><option value="/03">/03</option><option value="/04">/04</option><option value="/05">/05</option>
              <option value="/06">/06</option><option value="/07">/07</option><option value="/08">/08</option><option value="/09">/09</option><option value="/10">/10</option>
              <option value="/11">/11</option><option value="/12">/12</option><option value="/13">/13</option><option value="/14">/14</option><option value="/15">/15</option>
              <option value="/16">/16</option><option value="/17">/17</option><option value="/18">/18</option><option value="/19">/19</option><option value="/20">/20</option>
              <option value="/21">/21</option><option value="/22">/22</option><option value="/23">/23</option><option value="/24">/24</option><option value="/25">/25</option>
              <option value="/26">/26</option><option value="/27">/27</option><option value="/28">/28</option><option value="/29">/29</option><option value="/30">/30</option>
              <option value="/31">/31</option><option value="/32">/32</option><option value="/33">/33</option><option value="/34">/34</option><option value="/35">/35</option>
              <option value="/36">/36</option><option value="/37">/37</option><option value="/38">/38</option><option value="/39">/39</option><option value="/40">/40</option>
              <option value="/41">/41</option><option value="/42">/42</option><option value="/43">/43</option><option value="/44">/44</option><option value="/45">/45</option>
              <option value="/46">/46</option><option value="/47">/47</option><option value="/48">/48</option><option value="/49">/49</option><option value="/50">/50</option>
              <option value="/51">/51</option><option value="/52">/52</option><option value="/53">/53</option><option value="/54">/54</option><option value="/55">/55</option>
              <option value="/56">/56</option><option value="/57">/57</option><option value="/58">/58</option><option value="/59">/59</option><option value="/60">/60</option>
              <option value="/61">/61</option><option value="/62">/62</option><option value="/63">/63</option><option value="/64">/64</option><option value="/65">/65</option>
              <option value="/66">/66</option><option value="/67">/67</option><option value="/68">/68</option><option value="/69">/69</option><option value="/70">/70</option>
              <option value="/71">/71</option><option value="/72">/72</option><option value="/73">/73</option><option value="/74">/74</option><option value="/75">/75</option>
              <option value="/76">/76</option><option value="/77">/77</option><option value="/78">/78</option><option value="/79">/79</option><option value="/80">/80</option>
              <option value="/81">/81</option><option value="/82">/82</option><option value="/83">/83</option><option value="/84">/84</option><option value="/85">/85</option>
              <option value="/86">/86</option><option value="/87">/87</option><option value="/88">/88</option><option value="/89">/89</option><option value="/90">/90</option>
              <option value="/91">/91</option><option value="/92">/92</option><option value="/93">/93</option><option value="/94">/94</option><option value="/95">/95</option>
              <option value="/96">/96</option><option value="/97">/97</option><option value="/98">/98</option><option value="/99">/99</option><option value="/100">/100</option>
              <option value="/101">/101</option><option value="/102">/102</option><option value="/103">/103</option><option value="/104">/104</option><option value="/105">/105</option>
              <option value="/106">/106</option><option value="/107">/107</option><option value="/108">/108</option><option value="/109">/109</option><option value="/110">/110</option>
              <option value="/111">/111</option><option value="/112">/112</option><option value="/113">/113</option><option value="/114">/114</option><option value="/115">/115</option>
              <option value="/116">/116</option><option value="/117">/117</option><option value="/118">/118</option><option value="/119">/119</option><option value="/120">/120</option>
              <option value="/121">/121</option><option value="/122">/122</option><option value="/123">/123</option><option value="/124">/124</option><option value="/125">/125</option>
              <option value="/126">/126</option><option value="/127">/127</option><option value="/128">/128</option><option value="/129">/129</option><option value="/130">/130</option>
              <option value="/131">/131</option><option value="/132">/132</option><option value="/133">/133</option><option value="/134">/134</option><option value="/135">/135</option>
              <option value="/136">/136</option><option value="/137">/137</option><option value="/138">/138</option><option value="/139">/139</option><option value="/140">/140</option>
              <option value="/141">/141</option><option value="/142">/142</option><option value="/143">/143</option><option value="/144">/144</option><option value="/145">/145</option>
              <option value="/146">/146</option><option value="/147">/147</option><option value="/148">/148</option><option value="/149">/149</option><option value="/150">/150</option>
              <option value="/151">/151</option><option value="/152">/152</option><option value="/153">/153</option><option value="/154">/154</option><option value="/155">/155</option>
              <option value="/156">/156</option><option value="/157">/157</option><option value="/158">/158</option><option value="/159">/159</option><option value="/160">/160</option>
              <option value="/161">/161</option><option value="/162">/162</option><option value="/163">/163</option><option value="/164">/164</option><option value="/165">/165</option>
              <option value="/166">/166</option><option value="/167">/167</option><option value="/168">/168</option><option value="/169">/169</option><option value="/170">/170</option>
              <option value="/171">/171</option><option value="/172">/172</option><option value="/173">/173</option><option value="/174">/174</option><option value="/175">/175</option>
              <option value="/176">/176</option><option value="/177">/177</option><option value="/178">/178</option><option value="/179">/179</option><option value="/180">/180</option>
              <option value="/181">/181</option><option value="/182">/182</option><option value="/183">/183</option><option value="/184">/184</option><option value="/185">/185</option>
              <option value="/186">/186</option><option value="/187">/187</option><option value="/188">/188</option><option value="/189">/189</option><option value="/190">/190</option>
              <option value="/191">/191</option><option value="/192">/192</option><option value="/193">/193</option><option value="/194">/194</option><option value="/195">/195</option>
              <option value="/196">/196</option><option value="/197">/197</option><option value="/198">/198</option><option value="/199">/199</option><option value="/200">/200</option>
              <option value="/201">/201</option><option value="/202">/202</option><option value="/203">/203</option><option value="/204">/204</option><option value="/205">/205</option>
              <option value="/206">/206</option><option value="/207">/207</option><option value="/208">/208</option><option value="/209">/209</option><option value="/210">/210</option>
              <option value="/211">/211</option><option value="/212">/212</option><option value="/213">/213</option><option value="/214">/214</option><option value="/215">/215</option>
              <option value="/216">/216</option><option value="/217">/217</option><option value="/218">/218</option><option value="/219">/219</option><option value="/220">/220</option>
              <option value="/221">/221</option><option value="/222">/222</option><option value="/223">/223</option><option value="/224">/224</option><option value="/225">/225</option>
              <option value="/226">/226</option><option value="/227">/227</option><option value="/228">/228</option><option value="/229">/229</option><option value="/230">/230</option>
              <option value="/231">/231</option><option value="/232">/232</option><option value="/233">/233</option><option value="/234">/234</option><option value="/235">/235</option>
              <option value="/236">/236</option><option value="/237">/237</option><option value="/238">/238</option><option value="/239">/239</option><option value="/240">/240</option>
              <option value="/241">/241</option><option value="/242">/242</option><option value="/243">/243</option><option value="/244">/244</option><option value="/245">/245</option>
              <option value="/246">/246</option><option value="/247">/247</option><option value="/248">/248</option><option value="/249">/249</option><option value="/250">/250</option>
              <option value="/251">/251</option><option value="/252">/252</option><option value="/253">/253</option><option value="/254">/254</option><option value="/255">/255</option>
              <option value="/256">/256</option><option value="/257">/257</option><option value="/258">/258</option><option value="/259">/259</option><option value="/260">/260</option>
              <option value="/261">/261</option><option value="/262">/262</option><option value="/263">/263</option><option value="/264">/264</option><option value="/265">/265</option>
              <option value="/266">/266</option><option value="/267">/267</option><option value="/268">/268</option><option value="/269">/269</option><option value="/270">/270</option>
              <option value="/271">/271</option><option value="/272">/272</option><option value="/273">/273</option><option value="/274">/274</option><option value="/275">/275</option>
              <option value="/276">/276</option><option value="/277">/277</option><option value="/278">/278</option><option value="/279">/279</option><option value="/280">/280</option>
              <option value="/281">/281</option><option value="/282">/282</option><option value="/283">/283</option><option value="/284">/284</option><option value="/285">/285</option>
              <option value="/286">/286</option><option value="/287">/287</option><option value="/288">/288</option><option value="/289">/289</option><option value="/290">/290</option>
              <option value="/291">/291</option><option value="/292">/292</option><option value="/293">/293</option><option value="/294">/294</option><option value="/295">/295</option>
              <option value="/296">/296</option><option value="/297">/297</option><option value="/298">/298</option><option value="/299">/299</option><option value="/300">/300</option>
            </select>
            <select id="cboQuickAddBisRecordingTag" class="selectBox" style="width:60px" title="">
              <option value=""></option>
              <option value="-Bis">-Bis</option>
              <option value="-Bis1">-Bis1</option>
              <option value="-Bis2">-Bis2</option>
            </select>
            <br />
            Acto origen del predio:
            <select id="Select1" class="selectBox" style="width:238px" title=""
                    onchange="return updateUI(this);">
              <option value="">( Acto que originó el antecedente )</option>
              <option value="">Adjudicación</option>
              <option value="">Compraventa</option>
              <option value="">Decreto</option>
              <option value="">Donación en pago</option>
              <option value="">Donación simple y pura</option>
              <option value="">Información Ad Perpetuam</option>
              <option value="">Permuta</option>
              <option value="">Sentencia de usucapión</option>
              <option value="">Título de propiedad</option>
              <option value="">Transmisión de propiedad</option>
            </select>
            <br />
            Fecha de registro de la partida:
            <input id='txtPresentationDate' name='txtPresentationDate' type="text" class="textBox" style="width:66px;margin-right:0" onblur="formatAsDate(this)" title="" />
            <img id='imgPresentationDate' src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('txtPresentationDate'), getElement('imgPresentationDate'));" title="Despliega el calendario" alt="" />
            Hora:
            <input id="txtPresentationTime" name="txtPresentationTime" type="text" class="textBox" style="width:40px;margin-right:2px" maxlength="5" title="" onkeypress='return hourKeyFilter(this);' />Hrs
            </span>
          </td>
          <td class="lastCell">&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
  <tr id="divTargetPrecedentActSectionTitle" style="display:none"><td class="actionsSeparator">(3) Seleccionar el acto jurídico a cancelar o modificar</td></tr>
  <tr id="divTargetPrecedentActSection" style="display:none">
    <td>
      <table class="editionTable">
        <tr>
          <td>Que aplica a:</td>
          <td>                  
            <select id="cboTargetAct" name="cboTargetAct" class="selectBox" style="width:236px" title="" onchange="return updateUI(this);">
              <option value="">( Acto a cancelar o modificar )</option>
              <option value="">Embargo (no registrado)</option>
              <option value="">Hipoteca (no registrada)</option>
              <option value="">Fianza (no registrada)</option>
            </select>
            <img src="../themes/default/buttons/search.gif" alt="" title="Ejecuta la búsqueda" style="margin-left:-8px" onclick="doRecordingActEditorOperation('showPrecedentRecordingAct')" />
          </td>
          <td>
            Inscrito(a) en:
            <select id="cboTargetActDistrict" name="" class="selectBox" style="width:260px" title=""
                    onchange="return updateUI(this);">
              <option value="">( Seleccionar ) </option>
              <option value="101">Hidalgo 2da</option>
              <option value="102">Cuauhtémoc 2da</option>
              <option value="103">Juárez 2da</option>
              <option value="104">Lardizábal y Uribe 2da</option>
              <option value="105">Morelos 2da</option>
              <option value="106">Ocampo 2da</option>
              <option value="107">Xicohténcatl 2da</option>
              <option value="108">Zaragoza 2da</option>
            </select>
          </td>
          <td class="lastCell">&nbsp;</td>
        </tr>
        <tr>
          <td colspan="2"></td>
          <td>Volumen:
            <select id="cboTargetActPhysicalBook" class="selectBox" style="width:286px" title=""
                    onchange="return updateUI(this);">
            </select>
            Partida:
            <select id="cboTargetActRecording" class="selectBox" style="width:98px" title=""
                    onchange="return updateUI(this);">
            </select>
            <img src="../themes/default/buttons/search.gif" alt="" title="Ejecuta la búsqueda" style="margin-left:-8px"
                  onclick="doRecordingActEditorOperation('showPrecedentRecording')" />
            <span id="divTargetActRecordingQuickAddSection" style="display:inline">
            <br />
            Partida donde está registrado el embargo:
            <input id="txtTargetActPhysicalRecordingNo" type="text" class="textBox" style="width:35px;margin-right:0px"
                    onkeypress="return integerKeyFilter(this);" title="" maxlength="5" />
            <select id="cboTargetActPhysicalRecordingNoTag" class="selectBox" style="width:82px" title="">
              <option value=""></option>
              <option value="-Bis">-Bis</option>
              <option value="-Bis1">-Bis1</option>
              <option value="-Bis2">-Bis2</option>
            </select>
            <- CUIDADO: <u>No</u> se refiere al número de fracción
            </span>
          </td>
          <td class="lastCell">&nbsp;</td>
          </tr>
        </table>
      </td>
  </tr>
</table>
<script type="text/javascript">
  /* <![CDATA[ */

  function doRecordingActEditorOperation(command) {
    var success = false;

    if (gbSended) {
      return;
    }
    switch (command) {
      case 'appendRecordingAct':
        return appendRecordingAct();
      case 'lookupProperty':
        return lookupProperty();
      case 'showPrecedentRecording':
        return showPrecedentRecording();
      case 'showPrecedentProperty':
        return showPrecedentProperty();
      default:
        alert("La operación '" + command + "' todavía no ha sido definida en el editor de actos jurídicos.");
        return;
    }
    if (success) {
      sendPageCommand(command);
      gbSended = true;
    }
  }

  function lookupProperty() {
    alert("La búsqueda de predios todavía no está disponible... Gracias por su comprensión.");
    return false;
  }

  function appendRecordingAct() {
    if (!assertBookRecording()) {
      return false;
    }
    if (!validateRecordingAct()) {
      return false;
    }
    if (!validateRecordingActSemantics()) {
      return false;
    }

    var qs = getRecordingActQueryString();
    qs = qs.replace(/&/g, "|");
    if (!showConfirmFormCreateRecordingAct()) {
      return false;
    }
    sendPageCommand("appendRecordingAct", qs);
  }

  function assertBookRecording() {
    <% if (base.Transaction.IsEmptyInstance) { %>
    alert("Este control no está ligado a un trámite válido.");
    return false;
    <% } %>
    <% if (base.Transaction.Document.IsEmptyInstance) { %>
    alert("Primero requiero se ingresen los datos de la escritura o documento que se va a inscribir.");
    return false;
    <% } %>
    <% if (!base.IsReadyForEdition()) { %>
    alert("No es posible inscribir en libros debido a que el trámite no está en un estado válido para ello, o bien, no cuenta con los permisos necesarios para efectuar esta operación.");
    return false;
    <% } %>
    return true;
  }

  var oCurrentRecordingRule = null;
  function setRecordingRule() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getRecordingActRule";
    url += "&recordingActTypeId=" + getElement("cboRecordingActType").value;

    oCurrentRecordingRule = invokeAjaxGetJsonObject(url);
  }

  function updateUI(oControl) {
    if (oControl == null) {
      return;
    }
    if (oControl == getElement("cboRecordingActTypeCategory")) {
      if (!assertBookRecording()) {
        getElement("cboRecordingActTypeCategory").value = '';
        return;
      }
      resetRecordingActTypesCombo();
      setRecordingRule();
    } else if (oControl == getElement("cboRecordingActType")) {
      setRecordingRule();
      resetPropertyTypeSelectorCombo();
    } else if (oControl == getElement("cboPropertyTypeSelector")) {
      showPrecedentRecordingSection();
    } else if (oControl == getElement("cboPropertySubdivisionType")) {
      updatePropertyFractionSection();
    } else if (oControl == getElement("cboPrecedentRecordingSection")) {
      resetPrecedentDomainBooksCombo();
    } else if (oControl == getElement("cboPrecedentRecordingBook")) {
      resetPrecedentRecordingsCombo();
    } else if (oControl == getElement("cboPrecedentRecording")) {
      showPrecedentPropertiesSection();
    }
  }

  function setPropertyPartsTotal() {
    var selectedValue = getElement("cboPropertySubdivisionType").value;

    if (!isNumeric(getElement('txtPropertySubdivisionNo'))) {
      alert("No reconozco el número de lote o fracción proporcionado.");
      return;
    }
    if (selectedValue == 'last') {
      getElement('txtPropertyTotalLots').value = getElement('txtPropertySubdivisionNo').value;
    }
  }

  function updatePropertyFractionSection() {
    var selectedValue = getElement("cboPropertySubdivisionType").value;

    getElement('txtPropertySubdivisionNo').value = '';
    getElement('txtPropertyTotalLots').value = '';
    switch (selectedValue) {
      case '':
      case 'whole':
        getElement('divFractionPartXofYSection').style.display = 'none';
        break;
      case 'partial':
        getElement('divFractionPartXofYSection').style.display = 'inline';
        getElement('txtPropertySubdivisionNo').disabled = false;
        getElement('txtPropertyTotalLots').disabled = true;
        getElement('txtPropertyTotalLots').value = '?';
        break;
      case 'last':
        getElement('divFractionPartXofYSection').style.display = 'inline';
        getElement('txtPropertySubdivisionNo').disabled = false;
        getElement('txtPropertyTotalLots').disabled = true;
        break;
      case 'full':
        getElement('divFractionPartXofYSection').style.display = 'inline';
        getElement('txtPropertySubdivisionNo').disabled = false;
        getElement('txtPropertyTotalLots').disabled = false;
        break;
    }
  }

  function showPrecedentPropertiesSection() {
    var selectedValue = getElement('cboPrecedentRecording').value;

    if (selectedValue != "-1") {
      resetPrecedentPropertiesCombo();
      getElement('divRecordingQuickAddSection').style.display = 'none';
      getElement('divPropertySelectorSection').style.display = 'inline';
    } else {
      getElement('divRecordingQuickAddSection').style.display = 'inline';
      getElement('divPropertySelectorSection').style.display = 'none';
    }
  }

  function resetRecordingActTypesCategoriesCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getRecordingActTypesEditingCategoriesCmd";

    invokeAjaxComboItemsLoader(url, getElement('cboRecordingActTypeCategory'));
  }

  function resetPrecedentRecordingSectionCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getDomainTraslativeSectionsCmd";

    invokeAjaxComboItemsLoader(url, getElement('cboPrecedentRecordingSection'));
  }

  function resetPrecedentDomainBooksCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getDomainBooksStringArrayCmd";
    if (getElement("cboPrecedentRecordingSection").value.length != 0) {
      url += "&sectionFilter=" + getElement('cboPrecedentRecordingSection').value;
    }
    invokeAjaxComboItemsLoader(url, getElement('cboPrecedentRecordingBook'));

    resetPrecedentRecordingsCombo();
  }

  function resetPrecedentRecordingsCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getRecordingNumbersStringArrayCmd";
    if (getElement("cboPrecedentRecordingBook").value.length != 0) {
      url += "&recordingBookId=" + getElement("cboPrecedentRecordingBook").value;
    } else {
      url += "&recordingBookId=0";
    }
    if (getElement("cboRecordingActType").value.length != 0) {
      url += "&recordingActTypeId=" + getElement("cboRecordingActType").value;
    }
    invokeAjaxComboItemsLoader(url, getElement("cboPrecedentRecording"));
    showPrecedentPropertiesSection();
  }

  function resetPropertyTypeSelectorCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getPropertyTypeSelectorComboCmd";
    url += "&recordingActTypeId=" + getElement("cboRecordingActType").value;

    invokeAjaxComboItemsLoader(url, getElement("cboPropertyTypeSelector"));
    showPrecedentRecordingSection();
  }

  function resetPrecedentPropertiesCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getRecordingPropertiesArrayCmd";
    if (getElement("cboPrecedentRecording").value.length != 0) {
      url += "&recordingId=" + getElement("cboPrecedentRecording").value;
    } else {
      url += "&recordingId=0";
    }
    if (getElement("cboRecordingActType").value.length != 0) {
      url += "&recordingActTypeId=" + getElement("cboRecordingActType").value;
    }
    invokeAjaxComboItemsLoader(url, getElement("cboPrecedentProperty"));
  }

  function resetRecordingActTypesCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getRecordingTypesStringArrayCmd";
    url += "&recordingActTypeCategoryId=" + getElement('cboRecordingActTypeCategory').value;
    url += "&filtered=true";

    invokeAjaxComboItemsLoader(url, getElement("cboRecordingActType"));
    resetPropertyTypeSelectorCombo();
  }

  function validateRecordingActSemantics() {
    var ajaxURL = "../ajax/land.registration.system.data.aspx";
    ajaxURL += "?commandName=validateDocumentRecordingActCmd";
    ajaxURL += "&" + getRecordingActQueryString();

    return invokeAjaxValidator(ajaxURL);
  }

  function showPrecedentRecordingSection() {
    getElement("divFractionSection").style.display = "none";
    if (getElement("cboPropertyTypeSelector").value == "selectProperty") {          // Already registered
      getElement("divPrecedentActSection").style.display = "inline";
      getElement("divFractionSection").style.display = oCurrentRecordingRule.AllowsPartitions ? "inline" : "none";
      getElement("divPhysicalRecordingSelectorTitle").style.display = "inline";
      getElement("divPhysicalRecordingSelector").style.display = "inline";
      getElement("divPrecedentRecordingSection").style.display = "inline";
      getElement("divNewPropertyRecorderOfficeSection").style.display = "none";
      getElement("divTargetPrecedentActSectionTitle").style.display = "none";
      getElement("divTargetPrecedentActSection").style.display = "none";
    } else if (getElement("cboPropertyTypeSelector").value == "createProperty") {   // New properties
      getElement("divPrecedentActSection").style.display = "none";
      getElement("divPhysicalRecordingSelectorTitle").style.display = "none";
      getElement("divPhysicalRecordingSelector").style.display = "none";
      getElement("divPrecedentRecordingSection").style.display = "none";
      getElement("divNewPropertyRecorderOfficeSection").style.display = "inline";
      getElement("divTargetPrecedentActSectionTitle").style.display = "none";
      getElement("divTargetPrecedentActSection").style.display = "none";
    } else if (getElement("cboPropertyTypeSelector").value == "searchProperty") {   // Search by property number

    } else if (getElement("cboPropertyTypeSelector").value == "actNotApplyToProperty") {   // Recording act doesn't apply to properties
      getElement("divPrecedentActSection").style.display = "none";
      getElement("divPhysicalRecordingSelectorTitle").style.display = "none";
      getElement("divPhysicalRecordingSelector").style.display = "none";
      getElement("divPrecedentRecordingSection").style.display = "none";
      getElement("divNewPropertyRecorderOfficeSection").style.display = "none";
      getElement("divTargetPrecedentActSectionTitle").style.display = "none";
      getElement("divTargetPrecedentActSection").style.display = "none";
    } else if (getElement("cboPropertyTypeSelector").value == "actAppliesToOtherRecordingAct") {   // Recording act applies to another recording act
      getElement("divPrecedentActSection").style.display = "inline";
      getElement("divPhysicalRecordingSelectorTitle").style.display = "inline";
      getElement("divPhysicalRecordingSelector").style.display = "inline";
      getElement("divPrecedentRecordingSection").style.display = "inline";
      getElement("divNewPropertyRecorderOfficeSection").style.display = "none";
      getElement("divTargetPrecedentActSectionTitle").style.display = "inline";
      getElement("divTargetPrecedentActSection").style.display = "inline";
    } else if (getElement("cboPropertyTypeSelector").value == "actAppliesOnlyToSection") {   // Recording act only needs a district
      getElement("divPrecedentActSection").style.display = "none";
      getElement("divPhysicalRecordingSelectorTitle").style.display = "none";
      getElement("divPrecedentRecordingSection").style.display = "none";
      getElement("divNewPropertyRecorderOfficeSection").style.display = "inline";
      getElement("divTargetPrecedentActSectionTitle").style.display = "none";
      getElement("divTargetPrecedentActSection").style.display = "none";
    } else {
      getElement("divPrecedentActSection").style.display = "none";
      getElement("divPhysicalRecordingSelectorTitle").style.display = "none";
      getElement("divPhysicalRecordingSelector").style.display = "none";
      getElement("divPrecedentRecordingSection").style.display = "none";
      getElement("divNewPropertyRecorderOfficeSection").style.display = "none";
      getElement("divTargetPrecedentActSectionTitle").style.display = "none";
      getElement("divTargetPrecedentActSection").style.display = "none";
    }
  }

  function showPrecedentRecording() {
    var bookId = getElement('cboPrecedentRecordingBook').value;
    var recordingId = getElement('cboPrecedentRecording').value;

    if (bookId.length == 0 || bookId == "-1") {
      alert("Primero necesito se seleccione un libro de la lista de arriba.");
      return;
    }
    if (recordingId.length == 0 || recordingId == "-1") {
      alert("Necesito se seleccione una partida de la lista.");
      return;
    }
    var url = "../land.registration.system/recording.book.analyzer.aspx?bookId=" + bookId +
              "&id=" + recordingId;

    createNewWindow(url);
  }

  function showPrecedentProperty() {
    var propertyId = getElement("cboPrecedentProperty").value;
    if (propertyId.length == 0 || propertyId == "-1" || propertyId == "0") {
      alert("Necesito se seleccione un predio de la lista.");
      return;
    }
    var url = "../land.registration.system/property.editor.aspx?propertyId=" + propertyId +
              "&recordingActId=-1&recordingId=" + getElement('cboPrecedentRecording').value;
    createNewWindow(url);
  }

  function showConfirmFormCreateRecordingAct() {
    var sMsg = "Agregar un acto jurídico al documento:\n\n";

    sMsg += 'Documento:\t<%=base.Transaction.Document.UID%>\n';
    sMsg += 'Trámite:\t\t<%=base.Transaction.UID%>\n';
    sMsg += 'Interesado(s):\t<%=Empiria.EmpiriaString.FormatForScripting(base.Transaction.RequestedBy)%>\n\n';

    sMsg += "Acto jurídico que se agegará:\n\n";
    sMsg += "Acto jurídico:\t" + getComboOptionText(getElement('cboRecordingActType')) + "\n";
    if (getElement('cboPrecedentRecording').value.length == 0) {
      sMsg += "Predio:\t\t" + "Predio sin antecedente registral" + "\n";
      sMsg += "Distrito:\t\t" + getComboOptionText(getElement('cboNewPropertyRecorderOffice')) + "\n\n";
    } else if (getElement('cboPrecedentRecording').value != "-1") {
      if (oCurrentRecordingRule.AllowsPartitions) {
        sMsg += "\t\tSobre " + getComboOptionText(getElement('cboPropertySubdivisionType'));
        if (getElement("txtPropertySubdivisionNo").value.length != 0) {
          sMsg += " número " + getElement("txtPropertySubdivisionNo").value + " de " + getElement("txtPropertyTotalLots").value;
        }
        sMsg += "\n";
      }
      sMsg += "Predio:\t\t" + getComboOptionText(getElement('cboPrecedentProperty')) + "\n";
      sMsg += "Antecedente en:\t" + "Partida " + getComboOptionText(getElement('cboPrecedentRecording')) + "\n";
      sMsg += "\t\t" + getComboOptionText(getElement('cboPrecedentRecordingBook')) + "\n\n";
    } else {
      if (oCurrentRecordingRule.AllowsPartitions) {
        sMsg += "\t\tSobre " + getComboOptionText(getElement('cboPropertySubdivisionType'));
        if (getElement("txtPropertySubdivisionNo").value.length != 0) {
          sMsg += " número " + getElement("txtPropertySubdivisionNo").value + " de " + getElement("txtPropertyTotalLots").value;
        }
        sMsg += "\n\n";
      }
      sMsg += "Antecedente:\t" + "Crear folio único en partida " + getElement('txtQuickAddRecordingNumber').value +
              getComboOptionText(getElement('cboQuickAddRecordingSubNumber')) +
              getComboOptionText(getElement('cboQuickAddBisRecordingTag')) + "\n";
      sMsg += "\t\t" + getComboOptionText(getElement('cboPrecedentRecordingBook')) + "\n\n";
    }
    sMsg += "¿Agrego este acto jurídico al documento";
    if (oCurrentRecordingRule.AllowsPartitions && getElement('txtPropertySubdivisionNo').value != '') {
      sMsg += " y lo aplico a " + getComboOptionText(getElement('cboPropertySubdivisionType')) +
              " " + getElement('txtPropertySubdivisionNo').value + " en el antecedente";
    }
    sMsg += "?";
    return confirm(sMsg);
  }

  function validateRecordingAct() {
    var recordingAct = getComboOptionText(getElement('cboRecordingActType'));

    if (getElement('cboRecordingActTypeCategory').value.length == 0) {
      alert("Necesito se seleccione de la lista la categoría del acto jurídico que va a agregarse al documento.");
      getElement('cboRecordingActTypeCategory').focus();
      return false;
    }
    if (getElement('cboRecordingActType').value == "") {
      alert("Requiero se seleccione de la lista el acto jurídico que va a agregarse al documento.");
      getElement('cboRecordingActType').focus();
      return false;
    }
    if (getElement('cboPropertyTypeSelector').value.length == 0) {
      alert("Requiero se proporcione la información del predio sobre el que se aplicará el acto jurídico " + recordingAct + ".");
      getElement('cboPropertyTypeSelector').focus();
      return false;
    }
    if (getElement('cboPropertyTypeSelector').value == 'actAppliesOnlyToSection') {
      if (getElement('cboNewPropertyRecorderOffice').value.length == 0) {
        alert("Necesito conocer el distrito donde se inscribirá el acto jurídico de " + recordingAct + ".");
        getElement('cboNewPropertyRecorderOffice').focus();
        return false;
      }
    }
    if (getElement('cboPropertyTypeSelector').value == 'createProperty' &&
        getElement('cboNewPropertyRecorderOffice').value.length == 0) {
      alert("Necesito conocer el distrito judicial al que pertenece el predio que va a registrarse por primera vez (no tiene antecedente registral).");
      getElement('cboNewPropertyRecorderOffice').focus();
      return false;
    }

    if (getElement('cboPropertyTypeSelector').value == 'actAppliesOnlyToSection') {
      if (getElement('cboNewPropertyRecorderOffice').value.length == 0) {
        alert("Necesito conocer el distrito donde se inscribirá el acto de " + recordingAct + ".");
        getElement('cboNewPropertyRecorderOffice').focus();
        return false;
      }
    }

    if (oCurrentRecordingRule.AllowsPartitions &&
        getElement('cboPropertyTypeSelector').value != 'createProperty') {
      if (!validateSubdivision()) {
        return false;
      }
    } else {
      // clean partitions data fields
      getElement("cboPropertySubdivisionType").value = '';
      getElement("txtPropertySubdivisionNo").value = '';
      getElement("txtPropertyTotalLots").value = '';
    }

    if (getElement('cboPropertyTypeSelector').value == 'selectProperty') {    // Select precedent property
      if (!validatePrecedentRecording()) {
        return false;
      }
    }
    return true;
  }

  function validatePrecedentRecording() {
    if (getElement('cboPrecedentRecordingSection').value.length == 0) {
      alert("Necesito conocer el distrito o sección donde se encuentra el antecedente registral del predio.");
      getElement('cboPrecedentRecordingSection').focus();
      return false;
    }
    if (getElement('cboPrecedentRecordingBook').value.length == 0) {
      alert("Requiero se seleccione el libro registral donde está inscrito el predio sobre el que se aplicará el acto jurídico " + recordingAct + ".");
      getElement('cboPrecedentRecordingBook').focus();
      return false;
    }
    if (getElement('cboPrecedentRecording').value.length == 0) {
      alert("Necesito se seleccione de la lista el número de partida donde está registrado el antecedente del predio.");
      getElement('cboPrecedentRecording').focus();
      return false;
    }
    if (getElement('cboPrecedentRecording').value == "-1" &&
        getElement('txtQuickAddRecordingNumber').value.length == 0) {
      alert("Necesito se capture el número de partida que se va a agregar y que corresponde al antecedente registral del predio sobre el que se aplicará el acto jurídico.");
      getElement('txtQuickAddRecordingNumber').focus();
      return false;
    }
    if (getElement('cboPrecedentRecording').value == "-1" &&
        getElement('txtQuickAddRecordingNumber').value.length != 0 &&
        !isNumeric(getElement('txtQuickAddRecordingNumber'))) {
      alert("El número de partida tiene un formato que no reconozco.\nDebería ser un número.");
      getElement('txtQuickAddRecordingNumber').focus();
      return false;
    }
    if (getElement('cboPrecedentRecording').value.length != 0 &&
        getElement('cboPrecedentRecording').value != "-1" &&
        getElement('cboPrecedentProperty').value.length == 0) {
      alert("Necesito se seleccione de la lista el folio del predio al que aplicará el acto jurídico " + recordingAct + ".");
      getElement('cboPrecedentProperty').focus();
      return false;
    }
    return true;
  }

  function validateSubdivision() {
    if (!isNumeric(getElement("txtPropertySubdivisionNo"))) {
      getElement("txtPropertySubdivisionNo").value = '';
    }
    if (getElement("txtPropertyTotalLots").value != "?" &&
        !isNumeric(getElement("txtPropertyTotalLots"))) {
      getElement("txtPropertyTotalLots").value = '';
    }

    if (getElement("cboPropertySubdivisionType").value.length == 0) {
      alert("Necesito conocer sobre qué parte del predio se aplicará el acto de " + recordingAct + ".");
      getElement("cboPropertySubdivisionType").focus();
      return false;
    }
    if (getElement("cboPropertySubdivisionType").value == "partial" ||
        getElement("cboPropertySubdivisionType").value == "last" ||
        getElement("cboPropertySubdivisionType").value == "full") {
      if (getElement("txtPropertySubdivisionNo").value.length == 0) {
        alert("Necesito conocer el número de fracción (o lote) del antecedente a la que se le aplicará el acto de " + recordingAct + ".");
        getElement("txtPropertySubdivisionNo").focus();
        return false;
      }
      if (!isNumeric(getElement("txtPropertySubdivisionNo"))) {
        alert("No reconozco el número de fracción o lote proporcionado.");
        getElement("txtPropertySubdivisionNo").focus();
        return false;
      }
    }
    if (getElement("cboPropertySubdivisionType").value == "last" ||
        getElement("cboPropertySubdivisionType").value == "full") {
      if (getElement("txtPropertyTotalLots").value.length == 0) {
        alert("Necesito conocer el número de fracciones o lotes totales que están inscritos en el antecedente.");
        getElement("txtPropertyTotalLots").focus();
        return false;
      }
      if (!isNumeric(getElement("txtPropertyTotalLots"))) {
        alert("No reconozco el número de fracciones o lotes totales que están inscritos en el antecedente.");
        getElement("txtPropertyTotalLots").focus();
        return false;
      }
      if (convertToNumber(getElement("txtPropertyTotalLots").value) <
          convertToNumber(getElement("txtPropertySubdivisionNo").value)) {
        alert("El número total de fracciones (o lotes) no puede ser menor al número de fracción o lote al que se aplicará el acto de " + recordingAct + ".");
        getElement("txtPropertySubdivisionNo").focus();
        return false;
      }
      if (convertToNumber(getElement("txtPropertyTotalLots").value) < 2) {
        alert("El número total de fracciones (o lotes) en que se divide un predio no puede ser menor a dos.");
        getElement("txtPropertyTotalLots").focus();
        return false;
      }
    }
    return true;
  }

  function getRecordingActQueryString() {
    var qs = "transactionId=<%=base.Transaction.Id%>";
    qs += "&documentId=<%=base.Document.Id%>\n";
    qs += "&recordingActTypeCategoryId=" + getElement('cboRecordingActTypeCategory').value;
    qs += "&recordingActTypeId=" + getElement('cboRecordingActType').value;
    qs += "&propertyType=" + getElement('cboPropertyTypeSelector').value;
    qs += "&recorderOfficeId=" + getElement('cboNewPropertyRecorderOffice').value;
    qs += "&precedentRecordingBookId=" + getElement('cboPrecedentRecordingBook').value;
    qs += "&precedentRecordingId=" + getElement('cboPrecedentRecording').value;
    qs += "&quickAddRecordingNumber=" + getElement('txtQuickAddRecordingNumber').value;
    qs += "&quickAddRecordingSubNumber=" + getElement('cboQuickAddRecordingSubNumber').value;
    qs += "&quickAddRecordingSuffixTag=" + getElement('cboQuickAddBisRecordingTag').value;
    qs += "&precedentPropertyId=" + getElement('cboPrecedentProperty').value;
    qs += "&targetRecordingActId=" + getElement('cboTargetAct').value;

    qs += "&lotSubdivisionType=" + getComboSelectedOption('cboPropertySubdivisionType').title;
    qs += "&lotNumber=" + getElement('txtPropertySubdivisionNo').value;
    if (getElement('txtPropertyTotalLots').value.length == 0 ||
        getElement('txtPropertyTotalLots').value == '?') {
      qs += "&totalLots=" + getElement('txtPropertySubdivisionNo').value;
    } else {
      qs += "&totalLots=" + getElement('txtPropertyTotalLots').value;
    }
    return qs;
  }

  function initializeRecordingActEditor() {
    resetRecordingActTypesCategoriesCombo();
    resetPrecedentRecordingSectionCombo();
  }

  initializeRecordingActEditor();

  /* ]]> */
</script>
