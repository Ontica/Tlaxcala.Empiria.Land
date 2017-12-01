/* Empiria Governance ****************************************************************************************
*                                                                                                            *
*  Solution : Empiria Treasury                                 System  : Treasury Web API                    *
*  Assembly : Empiria.Payments.WebApi.dll                      Pattern : Web Api Client Proxy                *
*  Type     : TreasuryConnector                                License : Please read LICENSE.txt file        *
*                                                                                                            *
*  Summary  : Contains services that interacts with government's payment systems.                            *
*                                                                                                            *
********************************* Copyright (c) 2014-2017. La Vía Óntica SC, Ontica LLC and contributors.  **/
using System;
using System.Collections;

using System.Threading.Tasks;

using Empiria.Json;
using Empiria.WebApi.Client;

using Empiria.Land.Registration.Transactions;

namespace Empiria.Land.Connectors.Treasury {

  public class TreasuryConnector {

    #region Public methods

    public async Task<PaymentOrderData> RequestPaymentOrderData(LRSTransaction transaction) {
      object body = this.BuildRequestBodyForGenerarFormatoPagoReferenciado(transaction);

      JsonObject response = await this.CallGenerarFormatoPagoReferenciado(body);

      Assertion.Assert(response.Contains("codigo") && response.Contains("mensaje"),
                       $"The server response has an unexpected content:\n {response.ToString()}");

      var responseCode = response.Get<string>("codigo");
      var message = response.Get<string>("mensaje");

      Assertion.Assert(responseCode == "200", $"The server response code was {responseCode}: {message}.");

      if (response.Contains("fechaVencimiento") &&
          response.Contains("folioControlEstado") &&
          response.Contains("lineaCaptura")) {

        return PaymentOrderData.ParseFromWebService(response);

      } else {
        throw new Exception($"The server response has an unexpected content:\n{response.ToString()}");

      }
    }

    public async Task<PaymentStatusData> GetPaymentStatus(PaymentOrderData paymentOrderData) {
      object body = this.BuildRequestBodyForConsultarPagoRealizado(paymentOrderData);

      JsonObject response = await this.CallConsultarPagoRealizado(body);

      Assertion.Assert(response.Contains("codigoEstatus"),
                       $"The server response has an unexpected content:\n {response.ToString()}");

      var responseCode = response.Get<string>("codigoEstatus");
      Assertion.Assert(EmpiriaString.IsInList(responseCode, "201", "202"),
                       $"The server response has an unexpected content:\n {response.ToString()}");

      if (response.Contains("fechaPago") &&
          response.Contains("importePagado") &&
          response.Contains("lineaCaptura") &&
          response.Contains("refereciaPago")) {

        var paymentStatus = PaymentStatusData.ParseFromWebService(response);

        paymentStatus.EnsureValid(paymentOrderData);

        return paymentStatus;

      } else {
        throw new Exception($"The server response has an unexpected content:\n{response.ToString()}");
      }

    }

    #endregion Public methods

    #region Private methods

    private ICollection BuildRequestBodyForArregloConceptos(LRSTransaction transaction) {
      ArrayList array = new ArrayList(transaction.Items.Count);

      foreach (var item in transaction.Items) {
        var o = new {
          noConcepto = item.TreasuryCode.FinancialConceptCode,
          importe = item.Fee.Total.ToString("F0")
        };
        array.Add(o);
      }
      return array;
    }

    private object BuildRequestBodyForConsultarPagoRealizado(PaymentOrderData paymentOrderData) {
      return new {
        folioControlEstado = paymentOrderData.ControlTag
      };
    }

    private object BuildRequestBodyForGenerarFormatoPagoReferenciado(LRSTransaction transaction) {
      return new {
        folioSeguimiento = transaction.UID,
        idTramite = transaction.UID,
        importe = transaction.Items.TotalFee.Total.ToString("F0"),
        nombre = transaction.RequestedBy,
        apaterno = "",
        amaterno = "",
        rfc = "XAXX010101000",
        curp = "XEXX010101HNEXXXA4",
        estado = "",
        municipio = "",
        poblacion = "",
        colonia = "",
        calle = "",
        numeroExterior = "",
        numeroInterior = "",
        codigoPostal = "",
        conceptos = this.BuildRequestBodyForArregloConceptos(transaction)
      };
    }

    private async Task<JsonObject> CallGenerarFormatoPagoReferenciado(object body) {
      var http = new WebApiClient();

      var response = await http.PostAsync<object, JsonObject>(body, "TreasuryConnectors.GenerarFormatoPagoReferenciado");

      if (!response.HasItems) {  // Response content was empty.
                                 // Sometimes the service response is a 200 but without content,
                                 // so retry the call one more time after some time.
        await Task.Delay(1000);

        response = await http.PostAsync<object, JsonObject>(body, "TreasuryConnectors.GenerarFormatoPagoReferenciado");
      }

      Assertion.Assert(response.HasItems,
                       "The server response was successful (200 [OK]) but its content was an empty object.");

      return response;
    }

    private async Task<JsonObject> CallConsultarPagoRealizado(object body) {
      var http = new WebApiClient();

      var response = await http.PostAsync<object, JsonObject>(body, "TreasuryConnectors.ConsultarPagoRealizado");

      if (!response.HasItems) {  // Response content was empty.
                                 // Sometimes the service response is a 200 but without content,
                                 // so retry the call one more time after some time.
        await Task.Delay(1000);

        response = await http.PostAsync<object, JsonObject>(body, "TreasuryConnectors.ConsultarPagoRealizado");
      }

      Assertion.Assert(response.HasItems,
                       "The server response was successful (200 [OK]) but its content was an empty object.");

      return response;
    }

    #endregion Private methods

  }  // class TreasuryConnector

}  // namespace Empiria.Land.Connectors.Treasury
