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
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td valign="top" style="width:50%;border-top: 3px solid #3a3a3a;padding-top:8pt;padding-bottom:4pt">
          <table style="width:100%;white-space:nowrap;font-size:10pt" cellpadding="3px" cellspacing="0px">
            <tr>
              <td valign="top" colspan="2" style="white-space:nowrap"><b>INFORMACIÓN CATASTRAL</b></td>
            </tr>
            <tr>
              <td valign="top" style="white-space:nowrap">Clave catastral:</td>
              <td style='white-space:normal;border-bottom: 1px solid'><b><%=data.ClaveCatastral%></b></td>
            </tr>
            <tr>
              <td valign="top" style="white-space:nowrap">Clave catastral histórica:</td>
              <td style='white-space:normal;border-bottom: 1px solid'><b><%=data.ClaveCatastralHistorica%></b></td>
            </tr>
            <tr>
              <td valign="top" style="white-space:nowrap">Clave predial:</td>
              <td style='white-space:normal;border-bottom: 1px solid'><b><%=data.ClavePredial%></b></td>
            </tr>
            <tr>
              <td valign="top" style="white-space:nowrap">Clave predial histórica:</td>
              <td style='white-space:normal;border-bottom: 1px solid'><b><%=data.ClavePredialHistorica%></b></td>
            </tr>
            <tr>
              <td valign="top" style="white-space:nowrap">Localidad:</td>
              <td style='white-space:normal;border-bottom: 1px solid'><b><%=data.ClaveLocalidad%></b></td>
            </tr>
            <tr>
              <td valign="top" style="white-space:nowrap">Manzana:</td>
              <td style='white-space:normal;border-bottom: 1px solid'><b><%=data.ClaveManzana%></b></td>
            </tr>
            <tr>
              <td valign="top" style="white-space:nowrap">Municipio:</td>
              <td style='white-space:normal;border-bottom: 1px solid'><b><%=data.ClaveMunicipio%></b></td>
            </tr>
            <tr>
              <td valign="top" style="white-space:nowrap">Región:</td>
              <td style='white-space:normal;border-bottom: 1px solid'><b><%=data.ClaveRegion%></b></td>
            </tr>
            <tr>
              <td valign="top" style="white-space:nowrap">Sector:</td>
              <td style='white-space:normal;border-bottom: 1px solid'><b><%=data.ClaveSector%></b></td>
            </tr>
            <tr>
              <td valign="top" style="white-space:nowrap">Zona:</td>
              <td style='white-space:normal;border-bottom: 1px solid'><b><%=data.ClaveZona%></b></td>
            </tr>
          </table>
        </td>
        <td valign="top" style="width:50%;border-top: 3px solid #3a3a3a;padding-top:8pt;padding-bottom:4pt">
          <table style="width:100%;white-space:nowrap;font-size:10pt" cellpadding="3px" cellspacing="0px">
            <tr>
              <td colspan="2"><b>INFORMACIÓN DE PROPIETARIOS:</b></td>
            </tr>
            <% foreach (var propietario in data.Propietario) { %>
            <tr>
              <td valign="top" style="white-space:nowrap">Ap.Paterno:</td>
              <td style='white-space:normal;border-bottom: 1px solid'><b><%=propietario.ApellidoPaterno%></b></td>
            </tr>
            <tr>
              <td valign="top" style="white-space:nowrap">Ap. Materno:</td>
              <td style='white-space:normal;border-bottom: 1px solid'><b><%=propietario.ApellidoMaterno%></b></td>
            </tr>
            <tr>
              <td valign="top" style="white-space:nowrap">Nombre:</td>
              <td style='white-space:normal;border-bottom: 1px solid'><b><%=propietario.Nombre%></b></td>
            </tr>
            <tr>
              <td valign="top" style="white-space:nowrap">RFC:</td>
              <td style='white-space:normal;border-bottom: 1px solid'><b><%=propietario.Rfc%></b></td>
            </tr>
            <% } %>
          </table>
        </td>
      </tr>
    </table>
    <br /><br />
    <B style="font-size:10pt">UBICACIÓN GEOGRÁFICA</B>
    <br />
      &nbsp;El mapa no está disponible en catastro.

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
