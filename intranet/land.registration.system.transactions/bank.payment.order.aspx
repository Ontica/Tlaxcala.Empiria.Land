<%@ Page Language="C#" AutoEventWireup="true" Inherits="Empiria.Land.WebApp.BankPaymentOrder" Codebehind="bank.payment.order.aspx.cs" Async="true" %>
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
        <td nowrap="nowrap" width="100%">
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
                      <h2 style="height:30px; white-space:normal; font-size:18pt">LÍNEA DE CAPTURA</h2>
                    </td>
                  </tr>
                </table>
              </td>
              <td valign="top">
                <table>
                  <tr>
                    <td style="padding-right:20px;">
                      <img class="logo" src="../themes/default/customer/government.seal.right.jpg" alt="" title="" />
                    </td>
                  </tr>
                </table>
              </td>
              <td valign="top" style="white-space:nowrap">
                <table width="100%">
                  <tr>
                    <td valign="bottom" align="right">
                      <h3><%=transaction.UID%></h3>
                    </td>
                  </tr>
                  <tr>
                    <td align="right"><img alt="" title="" src="../user.controls/barcode.aspx?data=<%=transaction.UID%>" /><br /></td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td style="border-top: 3px solid #3a3a3a;padding-top:8pt;padding-bottom:4pt">
          <table style="width:100%;white-space:nowrap" cellpadding="3px" cellspacing="0px">
            <tr>
              <td valign="top" style="white-space:nowrap">Interesado:</td><td style='white-space:normal;border-bottom: 1px solid' colspan="3"><b style='font-size:9pt'><%=transaction.RequestedBy%></b></td>
              <td style="white-space:nowrap">Distrito:</td><td><b><%=transaction.RecorderOffice.Alias%></b></td>
            </tr>
            <tr>
              <td style="white-space:nowrap;">Notaría/Gestor:</td><td style="white-space:nowrap;width:30%"><b><%=transaction.Agency.Alias%></b></td>
              <td style="white-space:nowrap">Tipo de trámite:</td><td style="white-space:nowrap;width:30%"><b><%=transaction.TransactionType.Name%></b></td>
              <td style="white-space:nowrap">Emitió:</td><td style="white-space:nowrap;width:30%"><b><%=transaction.PostedBy.Alias%>&nbsp;&nbsp;&nbsp;&nbsp;</b></td>
            </tr>
            <tr>
              <td style="white-space:nowrap">Instrumento:</td><td><b><%=transaction.DocumentDescriptor%></b></td>
              <td style="white-space:nowrap">Tipo de documento:</td><td style="white-space:nowrap"><b><%=transaction.DocumentType.Name%></b></td>
              <td style="white-space:nowrap">Emisión:</td><td style="white-space:nowrap"><b><%=transaction.PostingTime.ToString("dd/MMM/yyyy HH:mm")%>&nbsp;&nbsp;&nbsp;&nbsp;</b></td>
            </tr>
            <tr style='display:<%=transaction.ExtensionData.RequesterNotes.Length != 0 ? "inline" : "none" %>'>
              <td valign="top" style="white-space:nowrap">Observaciones:</td>
              <td colspan="6" style='white-space:normal;'><%=transaction.ExtensionData.RequesterNotes%></td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td nowrap="nowrap" style="width:100%;height:10px;padding-bottom:6pt">
          <table style="width:100%;" cellpadding="4px" cellspacing="0px">
            <tr class="borderHeaderRow">
              <%=GetHeader()%>
            </tr>
            <%=GetItems()%>
           </table>
         </td>
      </tr>
      <tr>
        <td nowrap="nowrap" style="width:100%;vertical-align:top;border-top: 2px solid #3a3a3a;">
          <table cellpadding="4px" cellspacing="0px">
            <tr>
              <td style="padding-top:8pt;padding-right:10pt;text-align:center;vertical-align:top">
                <img alt="" title="" src="../user.controls/barcode.aspx?data=<%=base.paymentOrderData.RouteNumber%>" /><br />
                <b style="font-size:10pt">Línea de captura</b><br />
                <b style="font-size:12pt"><%=base.paymentOrderData.RouteNumber%></b><br />
                Fecha de vencimiento:<br />
                <b style="font-size:8pt"><%=base.paymentOrderData.DueDate.ToString("dd/MMM/yyyy")%></b>
                <br />
                <b style="font-size:16pt"><%=transaction.Items.TotalFee.Total.ToString("C2")%></b>
              </td>
              <td style="font-size:7pt;margin-left:30pt;vertical-align:top;border-left:2pt solid #3a3a3a">
                <table>
                  <tr><td colspan="2" nowrap="nowrap"><b>PAGO EN SUCURSALES<br />BANCARIAS</b></td></tr>
                  <tr><td>Bancomer:</td><td nowrap="nowrap"><b>CIE 829315</b></td></tr>
                  <tr><td>Banorte:</td><td nowrap="nowrap"><b>CEP 2412</b></td></tr>
                  <tr><td nowrap="nowrap">Citibanamex: &nbsp;</td><td nowrap="nowrap"><b>PA: 4520 01</b> &nbsp;</td></tr>
                  <tr><td>HSBC <sup>*</sup>:</td><td nowrap="nowrap"><b>RAP 2900</b></td></tr>
                  <tr><td>Santander:</td><td nowrap="nowrap"><b>4836</b></td></tr>
                  <tr><td>Scotiabank:</td><td nowrap="nowrap"><b>3701</b></td></tr>
                </table>
              </td>
              <td style="font-size:7pt;vertical-align:top;border-left:2pt solid #3a3a3a">
                <table>
                  <tr><td colspan="2"><b>BANCA ELECTRÓNICA<br />BANCOMER O HSBC</b></td></tr>
                  <tr><td colspan="2">Bancomer:</td></tr>
                  <tr><td>&nbsp;</td><td nowrap="nowrap">Convenio CIE: <b>1168584</b></td></tr>
                  <tr><td colspan="2">HSBC:</td></tr>
                  <tr><td>&nbsp;</td><td nowrap="nowrap">Pago de servicios: <b>RAP 2900</b></td></tr>
                  <tr><td colspan="2" style="border-top: 1px solid #3a3a3a;">Referencia:<br /><b><%=base.paymentOrderData.RouteNumber%></b></td></tr>
                </table>
              </td>
              <td style="font-size:7pt;vertical-align:top;border-left:2pt solid #3a3a3a">
                <table>
                  <tr><td colspan="2"><b>TRANSFERENCIA ELECTRÓNICA</b></td></tr>
                  <tr><td colspan="2">A cuenta Bancomer:</td></tr>
                  <tr><td>&nbsp; &nbsp;</td><td nowrap="nowrap">CLABE: <b>012914002011685842</b></td></tr>
                  <tr><td colspan="2">A cuenta HSBC:</td></tr>
                  <tr><td>&nbsp; &nbsp;</td><td nowrap="nowrap">CLABE: <b>012180550300029004</b></td></tr>
                  <tr><td colspan="2" style="border-top: 1px solid #3a3a3a;">Concepto de pago:<br /><b><%=base.paymentOrderData.RouteNumber%></b></td></tr>
                </table>
              </td>
              <td style="font-size:7pt;vertical-align:top;height:100%;border-left:2pt solid #3a3a3a">
                <table>
                  <tr><td><b>TIENDAS ANTAD</b></td></tr>
                  <tr><td>Chedraui</td></tr>
                  <tr><td>Extra</td></tr>
                  <tr><td>Farmacias del Ahorro</td></tr>
                  <tr><td>Soriana</td></tr>
                  <tr><td><b>TELECOMM</b><sup>*</sup></td></tr>
                </table>
              </td>
            </tr>
          </table>

        </td>
      </tr>
      <tr>
        <td style="font-size:7pt">
          <b>Control Secretaría de Finanzas:</b><br />
          Número de folio de control:  <b><%=transaction.PaymentOrderData.ControlTag%></b>
          <% if (transaction.ExtensionData.RFC.Length != 0) { %>
          &nbsp; &nbsp; &nbsp; | &nbsp; &nbsp; &nbsp;
          RFC para facturación: <b><%=transaction.ExtensionData.RFC%></b>
          <% } %>
          <br />
          <b>Cadena original:</b><br /><%=Empiria.EmpiriaString.DivideLongString(transaction.GetDigitalString(), 100, "&#8203;")%>
          <br />
          <b>Sello electrónico:</b><br /><%=transaction.GetDigitalSign()%>
        </td>
      </tr>
      <tr>
        <td style="border-top: 1px dotted #3a3a3a">
        <br />
        </td>
      </tr>
    </table>

    <div class="breakpage">&nbsp;</div>

    <table cellspacing="0" cellpadding="0" width="100%">
      <tr valign="top">
        <td nowrap="nowrap" width="100%">
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
                      <h2 style="height:30px; white-space:normal; font-size:18pt">BOLETA DE INGRESO</h2>
                    </td>
                  </tr>
                </table>
              </td>
              <td valign="top">
                <table>
                  <tr>
                    <td style="padding-right:20px;">
                      <img class="logo" src="../themes/default/customer/government.seal.right.jpg" alt="" title="" />
                    </td>
                  </tr>
                </table>
              </td>
              <td valign="top" style="white-space:nowrap">
                <table width="100%">
                  <tr>
                    <td valign="bottom" align="right">
                      <h3><%=transaction.UID%></h3>
                    </td>
                  </tr>
                  <tr>
                    <td align="right"><img alt="" title="" src="../user.controls/barcode.aspx?data=<%=transaction.UID%>" /><br /></td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td style="border-top: 3px solid #3a3a3a;padding-top:8pt;padding-bottom:4pt">
          <table style="width:100%;white-space:nowrap" cellpadding="3px" cellspacing="0px">
            <tr>
              <td valign="top" style="white-space:nowrap">Interesado:</td><td style='white-space:normal;border-bottom: 1px solid' colspan="3"><b style='font-size:9pt'><%=transaction.RequestedBy%></b></td>
              <td style="white-space:nowrap">Distrito:</td><td><b><%=transaction.RecorderOffice.Alias%></b></td>
            </tr>
            <tr>
              <td style="white-space:nowrap;">Notaría/Gestor:</td><td style="white-space:nowrap;width:30%"><b><%=transaction.Agency.Alias%></b></td>
              <td style="white-space:nowrap">Tipo de trámite:</td><td style="white-space:nowrap;width:30%"><b><%=transaction.TransactionType.Name%></b></td>
              <td style="white-space:nowrap">Emitió:</td><td style="white-space:nowrap;width:30%"><b><%=transaction.PostedBy.Alias%>&nbsp;&nbsp;&nbsp;&nbsp;</b></td>
            </tr>
            <tr>					
              <td style="white-space:nowrap">Instrumento:</td><td><b><%=transaction.DocumentDescriptor%></b></td>
              <td style="white-space:nowrap">Tipo de documento:</td><td style="white-space:nowrap"><b><%=transaction.DocumentType.Name%></b></td>
              <td style="white-space:nowrap">Emisión:</td><td style="white-space:nowrap"><b><%=transaction.PostingTime.ToString("dd/MMM/yyyy HH:mm")%>&nbsp;&nbsp;&nbsp;&nbsp;</b></td>
            </tr>
            <tr style='display:<%=transaction.ExtensionData.RequesterNotes.Length != 0 ? "inline" : "none" %>'>
              <td valign="top" style="white-space:nowrap">Observaciones:</td>
              <td colspan="6" style='white-space:normal;'><%=transaction.ExtensionData.RequesterNotes%></td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td nowrap="nowrap" style="width:100%;height:10px;padding-bottom:10pt">
          <table style="width:100%" cellpadding="4px" cellspacing="0px">
            <tr class="borderHeaderRow" style="padding-bottom:8pt">
              <%=GetHeader()%>
            </tr>
            <%=GetItems()%>
           </table>
         </td>
      </tr>
      <tr>
        <td>
          <table style="width:100%" cellpadding="4px" cellspacing="0px">
            <tr>
              <td style="border-top: 3px solid #3a3a3a;font-size:7pt">
                <b>Cadena original:</b>
                <br />
                <%=Empiria.EmpiriaString.DivideLongString(transaction.GetDigitalString(), 164, "&#8203;")%>
                <br /><br />
                <b>Sello electrónico:</b>
                <br /><%=transaction.GetDigitalSign()%>
              </td>
              <td valign="top" align="right" style="border-top: 3px solid #3a3a3a;">
                <b>Línea de captura:</b><br />
                <span style="font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;font-size:12pt"><%=base.paymentOrderData.RouteNumber%></span>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td style="border-top: 1px dotted #3a3a3a">
        <br />
        * Este documento deberá <b>ENTREGARSE en la <u>Ventanilla de Recepción de Documentos</u></b> junto con su comprobante de pago.
        (Imprimió: <%=GetCurrentUserInitials()%>, <%=DateTime.Now.ToString("dd/MMM/yyyy HH:mm") %>)
        </td>
      </tr>
    </table>
  </form>
  </body>
</html>
