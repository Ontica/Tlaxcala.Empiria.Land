<%@ Control Language="C#" AutoEventWireup="false" Inherits="Empiria.Web.UI.LRS.RecordingActEditorControl" CodeFile="recording.act.editor.control.ascx.cs" %>
<table class="editionTable">
  <tr id="divRecordingActTypeSelectorTitle"><td class="actionsSeparator">(1) Seleccionar el tipo de acto jurídico</td></tr>
  <tr>
    <td>
      <table class="editionTable">
        <tr id="divRecordingActTypeSelector">
          <td>Tipo de acto:</td>
          <td>
            <select id="cboRecordingActTypeCategory" class="selectBox"
                    style="width:192px" title="" onchange="return updateUI(this);">
            </select>
          </td>
          <td>
            <select id="cboRecordingActType" class="selectBox" style="width:306px" title=""
                    onchange="return updateUI(this);">
              <option value="">( Primero seleccionar el tipo de acto jurídico )</option>
            </select>
            <input type="button" value="Agregar acto" class="button" style="width:78px;height:28px;vertical-align:middle"
                   onclick='doRecordingActEditorOperation("appendRecordingAct")' />
          </td>
          <td class="lastCell">&nbsp;</td>
        </tr>
        <tr id="divPropertyTypeSelector">
          <td style="vertical-align:baseline">Del predio:</td>
          <td style="vertical-align:top">
            <select id="cboPropertyTypeSelector" class="selectBox" style="width:192px" onchange="return updateUI(this);">
              <option value="">( Seleccionar )</option>
            </select>
          </td>
          <td>
            <span id="divNewPropertyRecorderOfficeSection" style="display:none">
              Distrito donde se encuentra:
              <select id="cboNewPropertyRecorderOffice" class="selectBox" style="width:164px" onchange="return updateUI(this);">
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
            <span id="divPropertyPartitionSection" style="display:none">
              Sobre:
              <select id="cboPropertyPartitionType" class="selectBox" style="width:188px" title=""
                      onchange="return updateUI(this);">
                <option value="" title="None">( Seleccionar )</option>
                <option value="whole" title="None">la Totalidad</option>
                <option value="partial" title="Partial">la Fracción</option>
                <option value="partialUnknown" title="Partial">la Fracción sin número</option>
                <option value="last" title="Last">la Última Fracción</option>
                <option value="lastUnknown" title="Last">la Última Fracción sin número</option>
              </select>
              <!--<option value="full" title="Full">el Lote</option> !-->
              <span id="divPartitionPartXofYSection" style="display:none">
                Número:
                <input id="txtPropertyPartitionNo" type="text" class="textBox"
                        style="width:24px;margin-right:0px" onblur="return setPropertyPartsTotal();"
                        onkeypress="return integerKeyFilter(this);"
                        maxlength="4" />
                &nbsp; de:
                <input id="txtPropertyTotalPartitions" type="text" class="textBox"
                        style="width:24px;margin-right:0px" onkeypress="return integerKeyFilter(this);"
                        maxlength="4" />
                <br />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                Con superficie de:
                <input id="txtPartitionSize" type="text" class="textBox"
                  style="width:66px;margin-right:0px" onkeypress="return positiveKeyFilter(this);"
                  title="" maxlength="12" /><select id="cboPartitionSizeUnit" class="selectBox"
                  style="width:48px" onchange="return updateUI(this);">
                  <option value="">( ? )</option>
                  <option value="-2" title="No consta">N/C</option>
                  <option value="621" title="metros cuadrados">m2</option>
                  <option value="624" title="hectáreas">ha</option>
                </select>
                &nbsp;de:
                <input id="txtPartitionAvailableSize" type="text" class="textBox"
                  style="width:82px;margin-right:0px" onkeypress="return positiveKeyFilter(this);"
                  maxlength="12" /><select id="cboPartitionAvailableSizeUnit" class="selectBox"
                  style="width:48px" onchange="return updateUI(this);">
                  <option value="">( ? )</option>
                  <option value="-2" title="No consta">N/C</option>
                  <option value="621" title="metros cuadrados">m2</option>
                  <option value="624" title="hectáreas">ha</option>
                </select>disponibles.
              </span>
              <br />
            </span>
            Buscar por folio:
            <input id="txtDocumentKey" class="textBox" disabled="disabled" type="text" maxlength="18" style="width:136px" />
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
            <span style="color:red">Acto origen del predio:</span>
            <select id="Select1" class="selectBox" style="width:238px" title=""
                    onchange="return updateUI(this);">
              <option value="">( Acto que originó el antecedente )</option>
              <option value="">Adjudicación</option>
              <option value="">Compraventa</option>
              <option value="">Decreto</option>
              <option value="">Donación en pago</option>
              <option value="">Donación simple y pura</option>
              <option value="">Información Ad Perpetuam</option>
              <option value="">Lotificación</option>
              <option value="">Permuta</option>
              <option value="">Sentencia de usucapión</option>
              <option value="">Título de propiedad</option>
              <option value="">Transmisión de propiedad</option>
            </select>
            <br />
            <span style="color:red">Fecha de registro de la partida:</span>
            <input id='txtPresentationDate' name='txtPresentationDate' type="text" class="textBox" style="width:66px;margin-right:0" onblur="formatAsDate(this)" title="" />
            <img id='imgPresentationDate' src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('txtPresentationDate'), getElement('imgPresentationDate'));" title="Despliega el calendario" alt="" />
             <span style="color:red">Hora:</span>
            <input id="txtPresentationTime" name="txtPresentationTime" type="text" class="textBox" style="width:40px;margin-right:2px" maxlength="5" title="" onkeypress='return hourKeyFilter(this);' />Hrs
            <br />
            <span style="color:red">* Próximamente</span>
            </span>
            <br />
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
            <select id="cboTargetAct" class="selectBox" style="width:202px" title="" onchange="return updateUI(this);">
              <option value="">( Acto a cancelar o modificar )</option>
              <option value="2250">Crédito hipotecario</option>
              <option value="2729">Embargo</option>
              <option value="2256">Fianza</option>
            </select>
          </td>
          <td>
            Inscrito(a) en:
            <select id="cboTargetActSection" class="selectBox" style="width:267px" title=""
                    onchange="return updateUI(this);">
              <option value="">( Seleccionar ) </option>
              <option value="(RecorderOfficeId = 101) AND (RecordingSectionId = 1052)">Hidalgo Sección Segunda</option>
              <option value="(RecorderOfficeId = 102) AND (RecordingSectionId = 1052)">Cuauhtémoc Sección Segunda</option>
              <option value="(RecorderOfficeId = 103) AND (RecordingSectionId = 1052)">Juárez Sección Segunda</option>
              <option value="(RecorderOfficeId = 104) AND (RecordingSectionId = 1052)">Lardizábal y Uribe Sección Segunda</option>
              <option value="(RecorderOfficeId = 105) AND (RecordingSectionId = 1052)">Morelos Sección Segunda</option>
              <option value="(RecorderOfficeId = 106) AND (RecordingSectionId = 1052)">Ocampo Sección Segunda</option>
              <option value="(RecorderOfficeId = 107) AND (RecordingSectionId = 1052)">Xicohténcatl  Sección Segunda</option>
              <option value="(RecorderOfficeId = 108) AND (RecordingSectionId = 1052)">Zaragoza Sección Segunda</option>
              <option value=""></option>
              <option value="(RecorderOfficeId = 101) AND (RecordingSectionId = 1055)">Hidalgo Sección Quinta</option>
              <option value="(RecorderOfficeId = 102) AND (RecordingSectionId = 1055)">Cuauhtémoc Sección Quinta</option>
              <option value="(RecorderOfficeId = 103) AND (RecordingSectionId = 1055)">Juárez Sección Quinta</option>
              <option value="(RecorderOfficeId = 104) AND (RecordingSectionId = 1055)">Lardizábal y Uribe Sección Quinta</option>
              <option value="(RecorderOfficeId = 105) AND (RecordingSectionId = 1055)">Morelos Sección Quinta</option>
              <option value="(RecorderOfficeId = 106) AND (RecordingSectionId = 1055)">Ocampo Sección Quinta</option>
              <option value="(RecorderOfficeId = 107) AND (RecordingSectionId = 1055)">Xicohténcatl Sección Quinta</option>
              <option value="(RecorderOfficeId = 108) AND (RecordingSectionId = 1055)">Zaragoza Sección Quinta</option>

            </select>
          </td>
          <td class="lastCell">&nbsp;</td>
        </tr>
        <tr>
          <td colspan="2"></td>
          <td>Volumen:
            <select id="cboTargetActPhysicalBook" class="selectBox" style="width:291px" title=""
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
            Partida donde fue registrado el acto:
            <input id="txtTargetActPhysicalRecordingNo" type="text" class="textBox" style="width:35px;margin-right:0px"
                    onkeypress="return integerKeyFilter(this);" maxlength="5" />
            <select id="cboTargetActRecordingSubNumber" class="selectBox" style="width:52px;margin-right:0px" title="">
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
            <select id="cboTargetActBisRecordingTag" class="selectBox" style="width:60px" title="">
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
    } else if (oControl == getElement("cboPropertyPartitionType")) {
      updatePropertyFractionSection();
    } else if (oControl == getElement("cboPartitionSizeUnit")) {
      updateLotSizeContros(getElement("cboPartitionSizeUnit"), getElement("txtPartitionSize"));
    } else if (oControl == getElement("cboPartitionAvailableSizeUnit")) {
      updateLotSizeContros(getElement("cboPartitionAvailableSizeUnit"), getElement("txtPartitionAvailableSize"));
    } else if (oControl == getElement("cboPrecedentRecordingSection")) {
      resetPrecedentDomainBooksCombo();
    } else if (oControl == getElement("cboPrecedentRecordingBook")) {
      resetPrecedentRecordingsCombo();
    } else if (oControl == getElement("cboPrecedentRecording")) {
      showPrecedentPropertiesSection();

    } else if (oControl == getElement("cboTargetAct")) {
      resetTargetActSectionCombo();
    } else if (oControl == getElement("cboTargetActSection")) {
      resetTargetActPhysicalBooksCombo();
    } else if (oControl == getElement("cboTargetActPhysicalBook")) {
      resetTargetActRecordingsCombo();
    } else if (oControl == getElement("cboTargetActRecording")) {
      resetTargetActsGrid();
    }
  }


  function resetTargetActSectionCombo() {
   // alert("resetTargetActSectionCombo");
  }

  function resetTargetActPhysicalBooksCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getDomainBooksStringArrayCmd";
    if (getElement("cboTargetActSection").value.length != 0) {
      url += "&sectionFilter=" + getElement('cboTargetActSection').value;
    }
    invokeAjaxComboItemsLoader(url, getElement('cboTargetActPhysicalBook'));

    resetTargetActRecordingsCombo();
  }

  function resetTargetActRecordingsCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getRecordingNumbersStringArrayCmd";
    if (getElement("cboTargetActPhysicalBook").value.length != 0) {
      url += "&recordingBookId=" + getElement("cboTargetActPhysicalBook").value;
    } else {
      url += "&recordingBookId=0";
    }
    invokeAjaxComboItemsLoader(url, getElement("cboTargetActRecording"));
    resetTargetActsGrid();
  }

  function resetTargetActsGrid() {
    //alert("resetTargetActsGrid");
  }

  function updateLotSizeContros(oUnitCombo, oSizeTextbox) {
    if (oUnitCombo.value == '') {
      oSizeTextbox.disabled = false;
    } else if (oUnitCombo.value == -2) {
      oSizeTextbox.value = 'No consta';
      oSizeTextbox.disabled = true;
    } else {
      oSizeTextbox.disabled = false;
    }
    if (!oSizeTextbox.disabled && oSizeTextbox.value != '' && !isNumeric(oSizeTextbox)) {
      oSizeTextbox.value = '';
    }
  }

  function setPropertyPartsTotal() {
    var selectedValue = getElement("cboPropertyPartitionType").value;

    if (!isNumeric(getElement('txtPropertyPartitionNo'))) {
      alert("No reconozco el número de lote o fracción proporcionado.");
      return;
    }
    if (selectedValue == 'last') {
      getElement('txtPropertyTotalPartitions').value = getElement('txtPropertyPartitionNo').value;
    }
  }

  function updatePropertyFractionSection() {
    var selectedValue = getElement("cboPropertyPartitionType").value;

    getElement('txtPropertyPartitionNo').value = '';
    getElement('txtPropertyTotalPartitions').value = '';
    switch (selectedValue) {
      case '':
      case 'whole':
        getElement('divPartitionPartXofYSection').style.display = 'none';
        break;
      case 'partial':
        getElement('divPartitionPartXofYSection').style.display = 'inline';
        getElement('txtPropertyPartitionNo').disabled = false;
        getElement('txtPropertyTotalPartitions').disabled = true;
        getElement('txtPropertyTotalPartitions').value = '?';
        break;
      case 'partialUnknown':
        getElement('divPartitionPartXofYSection').style.display = 'inline';
        getElement('txtPropertyPartitionNo').disabled = true;
        getElement('txtPropertyTotalPartitions').disabled = true;
        getElement('txtPropertyPartitionNo').value = '?';
        getElement('txtPropertyTotalPartitions').value = '?';
        break;
      case 'last':
        getElement('divPartitionPartXofYSection').style.display = 'inline';
        getElement('txtPropertyPartitionNo').disabled = false;
        getElement('txtPropertyTotalPartitions').disabled = true;
        break;
      case 'lastUnknown':
        getElement('divPartitionPartXofYSection').style.display = 'inline';
        getElement('txtPropertyPartitionNo').disabled = true;
        getElement('txtPropertyTotalPartitions').disabled = true;
        getElement('txtPropertyPartitionNo').value = '?';
        getElement('txtPropertyTotalPartitions').value = '?';
        break;
      case 'full':
        getElement('divPartitionPartXofYSection').style.display = 'inline';
        getElement('txtPropertyPartitionNo').disabled = false;
        getElement('txtPropertyTotalPartitions').disabled = false;
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
    getElement("divPropertyPartitionSection").style.display = "none";
    if (getElement("cboPropertyTypeSelector").value == "selectProperty") {          // Already registered
      getElement("divPrecedentActSection").style.display = "inline";
      getElement("divPropertyPartitionSection").style.display = oCurrentRecordingRule.AllowsPartitions ? "inline" : "none";
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

    sMsg += "Acto jurídico que se registrará:\n\n";
    sMsg += "Acto jurídico:\t" + getComboOptionText(getElement('cboRecordingActType')) + "\n";
    if (getElement('cboPrecedentRecording').value.length == 0) {
      sMsg += "Predio:\t\t" + "Predio sin antecedente registral" + "\n";
      sMsg += "Distrito:\t\t" + getComboOptionText(getElement('cboNewPropertyRecorderOffice')) + "\n\n";
    } else if (getElement('cboPrecedentRecording').value != "-1") {
      if (oCurrentRecordingRule.AllowsPartitions) {
        sMsg += "\t\tSobre " + getComboOptionText(getElement('cboPropertyPartitionType'));
        if (getElement("txtPropertyPartitionNo").value.length != 0) {
          sMsg += " número " + getElement("txtPropertyPartitionNo").value + " de " + getElement("txtPropertyTotalPartitions").value;
        }
        sMsg += "\n";
      }
      sMsg += "Predio:\t\t" + getComboOptionText(getElement('cboPrecedentProperty')) + "\n";
      sMsg += "Antecedente en:\t" + "Partida " + getComboOptionText(getElement('cboPrecedentRecording')) + "\n";
      sMsg += "\t\t" + getComboOptionText(getElement('cboPrecedentRecordingBook')) + "\n\n";
    } else {
      if (oCurrentRecordingRule.AllowsPartitions) {
        sMsg += "\t\tSobre " + getComboOptionText(getElement('cboPropertyPartitionType'));
        if (getElement("txtPropertyPartitionNo").value.length != 0) {
          sMsg += " número " + getElement("txtPropertyPartitionNo").value + " de " + getElement("txtPropertyTotalPartitions").value;
        }
        sMsg += "\n\n";
      }
      sMsg += "Antecedente:\t" + "Crear folio único en partida " + getElement('txtQuickAddRecordingNumber').value +
              getComboOptionText(getElement('cboQuickAddRecordingSubNumber')) +
              getComboOptionText(getElement('cboQuickAddBisRecordingTag')) + "\n";
      sMsg += "\t\t" + getComboOptionText(getElement('cboPrecedentRecordingBook')) + "\n\n";
    }
    if (getElement('cboPropertyTypeSelector').value == 'actAppliesToOtherRecordingAct') {
      sMsg += "Acto jurídico a cancelar o modificar:\n\n";
      sMsg += "Acto involucrado:\t" + getComboOptionText(getElement('cboTargetAct')) + "\n";
      sMsg += "Registrado en:\t" + getComboOptionText(getElement('cboTargetActPhysicalBook')) + "\n" +
              "\t\tpartida " + getElement('txtTargetActPhysicalRecordingNo').value +
              getComboOptionText(getElement('cboTargetActRecordingSubNumber')) +
              getComboOptionText(getElement('cboTargetActBisRecordingTag')) + "\n\n";
    }

    sMsg += "¿Registro este acto jurídico en el documento";
    if (oCurrentRecordingRule.AllowsPartitions && getElement('txtPropertyPartitionNo').value != '') {
      sMsg += " y lo aplico a " + getComboOptionText(getElement('cboPropertyPartitionType')) +
              " " + getElement('txtPropertyPartitionNo').value + " en el antecedente";
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

    if (oCurrentRecordingRule.AllowsPartitions &&
        getElement('cboPropertyTypeSelector').value != 'createProperty') {
      if (!validateSubdivision()) {
        return false;
      }
    } else {
      cleanPartitionDataFields();
    }

    if (getElement('cboPropertyTypeSelector').value == 'selectProperty') {    // Select precedent property
      if (!validatePrecedentRecording()) {
        return false;
      }
    }

    if (getElement('cboPropertyTypeSelector').value == 'actAppliesOnlyToSection') {
      if (getElement('cboNewPropertyRecorderOffice').value.length == 0) {
        alert("Necesito conocer el distrito donde se inscribirá el acto jurídico de " + recordingAct + ".");
        getElement('cboNewPropertyRecorderOffice').focus();
        return false;
      }
    }

    if (getElement('cboPropertyTypeSelector').value == 'actAppliesToOtherRecordingAct') {
      if (!validatePrecedentRecording()) {
        return false;
      }
      if (!validateTargetAct()) {
        return false;
      }
    }
    return true;
  }


  function validateTargetAct() {
    if (targetSelectedFromActsGrid()) {
      return true;
    }
    // Validate data for target act creation
    if (getElement('cboTargetAct').value.length == 0) {
      alert("Necesito se seleccione el acto jurídico a cancelar o modificar.");
      getElement('cboTargetAct').focus();
      return false;
    }
    // Validate data for target act creation
    if (getElement('cboTargetActSection').value.length == 0) {
      alert("Necesito se seleccione el distrito y sección del volumen donde está inscrito el acto jurídico que se va a cancelar o modificar.");
      getElement('cboTargetActSection').focus();
      return false;
    }
    if (getElement('cboTargetActPhysicalBook').value.length == 0) {
      alert("Necesito se seleccione el volumen donde se encuentra inscrito el acto jurídico que se va a cancelar o modificar.");
      getElement('cboTargetActPhysicalBook').focus();
      return false;
    }
    if (getElement('cboTargetActRecording').value.length == 0) {
      alert("Necesito se seleccione la partida donde se encuentra inscrito el acto jurídico que se va a cancelar o modificar.");
      getElement('cboTargetActRecording').focus();
      return false;
    }
    if (getElement('cboTargetActRecording').value == "-1") {    // create physical recording
      if (getElement('txtTargetActPhysicalRecordingNo').value.length == 0) {
        alert("Necesito se capture el número de partida donde está inscrito que se va a cancelar o modificar.");
        getElement('txtTargetActPhysicalRecordingNo').focus();
        return false;
      }
      if (!isNumeric(getElement('txtTargetActPhysicalRecordingNo'))) {
        alert("El número de partida donde está inscrito el acto que se va a cancelar o modificar tiene un formato que no reconozco.\nDebería ser un número.");
        getElement('txtTargetActPhysicalRecordingNo').focus();
        return false;
      }
    }
    return true;
  }

  function targetSelectedFromActsGrid() {
    return false;
  }

  function cleanPartitionDataFields() {
    getElement("cboPropertyPartitionType").value = '';
    getElement("txtPropertyPartitionNo").value = '';
    getElement("txtPropertyTotalPartitions").value = '';
    getElement("cboPartitionSizeUnit").value = '';
    getElement("txtPartitionSize").value = '';
    getElement("cboPartitionAvailableSizeUnit").value = '';
    getElement("txtPartitionAvailableSize").value = '';
  }

  function validatePrecedentRecording() {
    var recordingAct = getComboOptionText(getElement('cboRecordingActType'));

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
    var recordingAct = getComboOptionText(getElement('cboRecordingActType'));

    if (getElement("cboPropertyPartitionType").value.length == 0) {
      alert("Necesito conocer sobre qué parte del predio se aplicará el acto de " + recordingAct + ".");
      getElement("cboPropertyPartitionType").focus();
      return false;
    }

    if (getElement("cboPropertyPartitionType").value == "whole") {
      cleanPartitionDataFields();
      return true;
    }

    if (!isNumeric(getElement("txtPropertyPartitionNo"))) {
      getElement("txtPropertyPartitionNo").value = '';
    }

    if (getElement("txtPropertyPartitionNo").value != "?" &&
        !isNumeric(getElement("txtPropertyPartitionNo"))) {
      getElement("txtPropertyPartitionNo").value = '';
    }
    if (getElement("txtPropertyTotalPartitions").value != "?" &&
        !isNumeric(getElement("txtPropertyTotalPartitions"))) {
      getElement("txtPropertyTotalPartitions").value = '';
    }

    if (getElement("cboPropertyPartitionType").value == "partial" ||
        getElement("cboPropertyPartitionType").value == "last" ||
        getElement("cboPropertyPartitionType").value == "full") {
      if (getElement("txtPropertyPartitionNo").value.length == 0) {
        alert("Necesito conocer el número de fracción (o lote) del antecedente a la que se le aplicará el acto de " + recordingAct + ".");
        getElement("txtPropertyPartitionNo").focus();
        return false;
      }
      if (!isNumeric(getElement("txtPropertyPartitionNo"))) {
        alert("No reconozco el número de fracción o lote proporcionado.");
        getElement("txtPropertyPartitionNo").focus();
        return false;
      }
    }
    if (getElement("cboPropertyPartitionType").value == "last" ||
        getElement("cboPropertyPartitionType").value == "full") {
      if (getElement("txtPropertyTotalPartitions").value.length == 0) {
        alert("Necesito conocer el número de fracciones o lotes totales que están inscritos en el antecedente.");
        getElement("txtPropertyTotalPartitions").focus();
        return false;
      }
      if (!isNumeric(getElement("txtPropertyTotalPartitions"))) {
        alert("No reconozco el número de fracciones o lotes totales que están inscritos en el antecedente.");
        getElement("txtPropertyTotalPartitions").focus();
        return false;
      }
      if (convertToNumber(getElement("txtPropertyTotalPartitions").value) <
          convertToNumber(getElement("txtPropertyPartitionNo").value)) {
        alert("El número total de fracciones (o lotes) no puede ser menor al número de fracción o lote al que se aplicará el acto de " + recordingAct + ".");
        getElement("txtPropertyPartitionNo").focus();
        return false;
      }
      if (convertToNumber(getElement("txtPropertyTotalPartitions").value) < 2) {
        alert("El número total de fracciones (o lotes) en que se divide un predio no puede ser menor a dos.");
        getElement("txtPropertyTotalPartitions").focus();
        return false;
      }
    }

    if (getElement("cboPartitionSizeUnit").value == '') {
      alert("Requiero conocer la unidad de medida de la superficie de la fracción.");
      getElement("cboPartitionSizeUnit").focus();
      return false;
    }
    if (getElement("cboPartitionSizeUnit").value != '-2') {
      if (getElement("txtPartitionSize").value.length == 0) {
        alert("Requiero se proporcione la superficie de la fracción.");
        getElement("txtPartitionSize").focus();
        return false;
      }
      if (!isNumeric(getElement("txtPartitionSize"))) {
        alert("No reconozco la superficie de la fracción.");
        getElement("txtPartitionSize").focus();
        return false;
      }
      if (convertToNumber(getElement("txtPartitionSize").value) <= 0) {
        alert("La superficie de la fracción debe ser mayor a cero.");
        getElement("txtPartitionSize").focus();
        return false;
      }
    }

    if (getElement("cboPartitionAvailableSizeUnit").value == '') {
      alert("Requiero conocer la superficie disponible del predio que se está fraccionando.");
      getElement("cboPartitionAvailableSizeUnit").focus();
      return false;
    }
    if (getElement("cboPartitionAvailableSizeUnit").value != '-2') {
      if (getElement("txtPartitionAvailableSize").value.length == 0) {
        alert("Requiero se proporcione la superficie disponible del predio que se está fraccionando.");
        getElement("txtPartitionAvailableSize").focus();
        return false;
      }
      if (!isNumeric(getElement("txtPartitionAvailableSize"))) {
        alert("No reconozco la superficie disponible del predio que se está fraccionando.");
        getElement("txtPartitionAvailableSize").focus();
        return false;
      }
      if (convertToNumber(getElement("txtPartitionAvailableSize").value) <= 0) {
        alert("La superficie disponible del predio que se está fraccionando debe ser mayor a cero.");
        getElement("txtPartitionAvailableSize").focus();
        return false;
      }
    }
    if (isNumeric(getElement("txtPartitionSize")) &&
        isNumeric(getElement("txtPartitionAvailableSize"))) {
      if (convertToNumber(getElement("txtPartitionAvailableSize").value) < convertToNumber(getElement("txtPartitionSize").value)) {
        alert("La superficie disponible del predio no puede ser menor a la superficie de la fracción.");
        getElement("txtPartitionSize").focus();
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

    // target act values
    qs += "&targetActTypeId=" + getElement('cboTargetAct').value;
    qs += "&targetActPhysicalBookId=" + getElement('cboTargetActPhysicalBook').value;
    qs += "&targetActRecordingId=" + getElement('cboTargetActRecording').value;
    qs += "&targetRecordingNumber=" + getElement('txtTargetActPhysicalRecordingNo').value;
    qs += "&targetRecordingSubNumber=" + getElement('cboTargetActRecordingSubNumber').value;
    qs += "&targetRecordingSuffixTag=" + getElement('cboTargetActBisRecordingTag').value;

    // partition values
    qs += "&partitionType=" + getComboSelectedOption('cboPropertyPartitionType').title;
    if (isNumeric(getElement("txtPropertyPartitionNo"))) {
      qs += "&partitionNo=" + getElement('txtPropertyPartitionNo').value;
    } else {
      qs += "&partitionNo=0";
    }
    if (isNumeric(getElement("txtPropertyTotalPartitions"))) {
      qs += "&totalPartitions=" + getElement('txtPropertyTotalPartitions').value;
    } else {
      qs += "&totalPartitions=0";
    }
    if (isNumeric(getElement("txtPartitionSize"))) {
      qs += "&partitionSize=" + getElement('txtPartitionSize').value;
    } else {
      qs += "&partitionSize=0";
    }
    if (isNumeric(getElement("cboPartitionSizeUnit"))) {
      qs += "&partitionSizeUnitId=" + getElement('cboPartitionSizeUnit').value;
    } else {
      qs += "&partitionSizeUnitId=-1";
    }
    if (isNumeric(getElement("txtPartitionAvailableSize"))) {
      qs += "&partitionAvailableSize=" + getElement('txtPartitionAvailableSize').value;
    } else {
      qs += "&partitionAvailableSize=0";
    }
    if (isNumeric(getElement("cboPartitionAvailableSizeUnit"))) {
      qs += "&partitionAvailableSizeUnitId=" + getElement('cboPartitionAvailableSizeUnit').value;
    } else {
      qs += "&partitionAvailableSizeUnitId=-1";
    }
    //alert(qs);
    return qs;
  }

  function initializeRecordingActEditor() {
    resetRecordingActTypesCategoriesCombo();
    resetPrecedentRecordingSectionCombo();
  }

  initializeRecordingActEditor();

  /* ]]> */
</script>
