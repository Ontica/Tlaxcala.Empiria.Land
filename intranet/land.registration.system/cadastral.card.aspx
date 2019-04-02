<%@ Page Language="C#" AutoEventWireup="true" Inherits="Empiria.Land.WebApp.CadastralCard" Codebehind="cadastral.card.aspx.cs" Async="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es-mx">
<head id="Head1" runat="server">
  <title>Orden de pago</title>
  <meta http-equiv="Expires" content="-1" />
  <meta http-equiv="Pragma" content="no-cache" />
  <link href="../themes/default/css/to.printer.css" type="text/css" rel="stylesheet" />
</head>
<body topmargin="0">
  <form id="frmEditor" method="post" runat="server">
    <table cellspacing="0" cellpadding="0" width="100%">
      <tr valign="top">
        <td nowrap="nowrap" width="100%" colspan="2">
          <table style="WIDTH: 100%" cellspacing="0" cellpadding="2">
            <tr>
              <td valign="top">
                <table>
                  <tr>
                    <td>
                      <img src="<%=GetDocumentLogo()%>" alt="" title="" />
                    </td>
                  </tr>
                </table>
              </td>
              <td valign="top" width="80%" style="white-space:nowrap">
                <table width="100%" cellpadding="0" cellspacing="0">
                  <tr>
                    <td align="center">
                      <h1><%=CustomerOfficeName()%></h1>
                    </td>
                  </tr>
                  <% if (base.DistrictName.Length != 0) { %>
                  <tr>
                    <td align="center" style="line-height:22pt">
                      <h2 style="height:30px; white-space:normal; font-size:10pt"><%=base.DistrictName%></h2>
                    </td>
                  </tr>
                  <% } %>
                  <tr>
                    <td align="center" style="line-height:22pt">
                      <h2 style="height:30px; white-space:normal; font-size:18pt">FICHA CATASTRAL REGISTRAL</h2>
                    </td>
                  </tr>
                </table>
              </td>
              <td valign="top" style="white-space:nowrap">
                <table width="100%">
                  <tr>
                    <td valign="bottom" align="right">
                       <img style="margin-left:-22pt" class="logo" src="../themes/default/customer/government.seal.right.jpg" alt="" title="" />
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td valign="top" style="width:48%;border-top: 3px solid #3a3a3a;padding-top:8pt;padding-bottom:4pt">
          <table style="width:100%;white-space:nowrap;font-size:8pt" cellpadding="4pt" cellspacing="4pt">
            <tr>
              <td valign="top" colspan="2" style="text-align:center;white-space:nowrap;font-size:10pt"><u>INFORMACIÓN CATASTRAL</u></td>
            </tr>
            <tr>
              <td valign="top" style="white-space:nowrap">Clave catastral:</td>
              <td style='white-space:normal;width:90%;font-size:10pt'><b><%=data.ClaveCatastral%></b></td>
            </tr>
            <tr>
              <td valign="top" style="white-space:nowrap">Región:</td>
              <td style='white-space:normal;'><b><%=data.ClaveRegion%></b></td>
            </tr>
            <tr>
              <td valign="top" style="white-space:nowrap">Municipio:</td>
              <td style='white-space:normal;'><b><%=data.ClaveMunicipio%></b></td>
            </tr>
            <tr>
              <td valign="top" style="white-space:nowrap">Zona:</td>
              <td style='white-space:normal;'><b><%=data.ClaveZona%></b></td>
            </tr>
            <tr>
              <td valign="top" style="white-space:nowrap">Sector:</td>
              <td style='white-space:normal;'><b><%=data.ClaveSector%></b></td>
            </tr>
            <tr>
              <td valign="top" style="white-space:nowrap">Localidad:</td>
              <td style='white-space:normal;'><b><%=data.ClaveLocalidad%></b></td>
            </tr>
            <tr>
              <td valign="top" style="white-space:nowrap">Manzana:</td>
              <td style='white-space:normal;'><b><%=data.ClaveManzana%></b></td>
            </tr>
            <tr>
              <td valign="top" style="white-space:nowrap">Clave catastral histórica:</td>
              <td style='white-space:normal;'><b><%=data.ClaveCatastralHistorica%></b></td>
            </tr>
            <tr>
              <td valign="top" style="white-space:nowrap">Clave predial:</td>
              <td style='white-space:normal;'><b><%=data.ClavePredial%></b></td>
            </tr>
            <tr>
              <td valign="top" style="white-space:nowrap">Clave predial histórica:</td>
              <td style='white-space:normal;'><b><%=data.ClavePredialHistorica%></b></td>
            </tr>
            <tr>
              <td valign="top" colspan="2" style="text-align:center;white-space:nowrap;font-size:10pt"><u>Propietarios registrados en Catastro</u></td>
            </tr>
            <% foreach (var propietario in data.Propietario) { %>
            <tr>
              <td valign="top" style="white-space:nowrap">Propietario: &nbsp; </td>
              <td style='white-space:normal;width:90%;'><b><%=$"{propietario.Nombre} {propietario.ApellidoPaterno} {propietario.ApellidoMaterno}"%></b></td>
            </tr>
            <% } %>
          </table>
        </td>
        <td valign="top" style="width:48%;border-top: 3px solid #3a3a3a;padding-top:8pt;padding-bottom:4pt">
          <table style="width:100%;white-space:nowrap;font-size:8pt" cellpadding="4pt" cellspacing="4pt">
            <tr>
              <td valign="top" colspan="2" style="text-align:center;white-space:nowrap;font-size:10pt"><u>INFORMACIÓN REGISTRAL</u></td>
            </tr>
            <tr>
              <td valign="top" style="white-space:nowrap">Folio Real:</td>
              <td style='white-space:normal;width:90%;font-size:10pt'><b><%=realEstate.UID%></b></td>
            </tr>
            <tr>
              <td valign="top" style="white-space:nowrap">Distrito:</td>
              <td style='white-space:normal;'><b><%=realEstate.District.FullName%></b></td>
            </tr>
            <tr>
              <td valign="top" style="white-space:nowrap">Municipio:</td>
              <td style='white-space:normal;'><b><%=$"{realEstate.Municipality.Name} ({realEstate.Municipality.Code})"%></b></td>
            </tr>
            <tr>
              <td valign="top" style="white-space:nowrap">Tipo de predio:</td>
              <td style='white-space:normal;'><b><%=realEstate.RealEstateType.Name%></b></td>
            </tr>
            <tr>
              <td valign="top" style="white-space:nowrap">Denominado:</td>
              <td style='white-space:normal;'><b><%=realEstate.Name%></b></td>
            </tr>
            <tr>
              <td valign="top" style="white-space:nowrap">Ubicado en:</td>
              <td style='white-space:normal;'><b><%=realEstate.LocationReference%></b></td>
            </tr>
            <tr>
              <td valign="top" style="white-space:nowrap">Superficie:</td>
              <td style='white-space:normal;'><b><%=realEstate.LotSize.ToString()%></b></td>
            </tr>
            <tr>
              <td valign="top" style="white-space:nowrap" colspan="2">Medidas y colindancias:</td>
            </tr>
            <tr>
              <td style='white-space:normal;' colspan="2"><b><%=realEstate.MetesAndBounds%></b></td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
    <div id="cadastral-data" style="width:50%;height:500px;"></div>
    <div id="map" style="width:50%;height:500px"></div>
   </form>
  </body>
  <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDmZ0xlayVI95lKwyAidWbPwrQxlbwVzk0&callback=initMap"></script>
  <script src="../scripts/google.maps.integration.js"></script>
  <script type="text/javascript">
      function getMessage() {
          return '<p>Avenida Juarez Num. 13 <hr> ' +
            '<strong>Folio Real:</strong>TLX23947-98M </p>';
          }
          function initMap() {
                      //Avenida Juarez 13, Col Miraflores, Tlaxcala, Tlax
                        var centroid = new google.maps.LatLng(19.321889, -97.925531);
                        var polygon = [new google.maps.LatLng(19.321942, -97.925500),
                                      new google.maps.LatLng(19.321936, -97.925591),
                                      new google.maps.LatLng(19.321802, -97.925582),
                                      new google.maps.LatLng(19.321804, -97.925535),
                                      new google.maps.LatLng(19.321839, -97.925532),
                                      new google.maps.LatLng(19.321842, -97.925494)];


                        drawUbication(polygon[0], polygon, "map", getMessage(), 'titulo');
                      //drawUbication(ubication);

            /*
    //huamantla
      Domicilio: Yancuitlalpan 113
      Colonia: Centro, Huamantla,tlax.
     var polygon = [ new google.maps.LatLng(19.321942, -97.925500),
                                      new google.maps.LatLng(19.321936, -97.925591),
                                      new google.maps.LatLng(19.321802, -97.925582),
                                      new google.maps.LatLng(19.321804, -97.925535),
                                      new google.maps.LatLng(19.321839, -97.925532),
                                      new google.maps.LatLng(19.321842, -97.925494)];

    */

          }

  </script>
</html>
