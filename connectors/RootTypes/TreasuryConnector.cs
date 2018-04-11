﻿/* Empiria Governance ****************************************************************************************
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

using Empiria.OnePoint;

using Empiria.Land.Registration.Transactions;

namespace Empiria.Land.Connectors {

  public class TreasuryConnector : ITreasuryConnector {

    #region Public methods

    public async Task<IPaymentOrderData> GeneratePaymentOrder(IFiling transaction) {
      object body = this.BuildRequestBodyForGenerarFormatoPagoReferenciado((LRSTransaction) transaction);

      JsonObject response = await this.CallGenerarFormatoPagoReferenciado(body)
                                      .ConfigureAwait(false);

      Assertion.Assert(response.Contains("codigo") && response.Contains("mensaje"),
                       $"The server response has an unexpected content:\n {response.ToString()}");

      var responseCode = response.Get<string>("codigo");
      var message = response.Get<string>("mensaje");

      Assertion.Assert(responseCode == "200", $"The server response code was {responseCode}: {message}.");

      if (response.Contains("fechaVencimiento") &&
          response.Contains("folioControlEstado") &&
          response.Contains("lineaCaptura")) {

        return this.ParseOrderDataFromWebService(response);

      } else {
        throw new Exception($"The server response has an unexpected content:\n{response.ToString()}");

      }
    }


    public async Task<IPaymentOrderData> RefreshPaymentOrder(IPaymentOrderData paymentOrderData) {
      object body = this.BuildRequestBodyForConsultarPagoRealizado(paymentOrderData);

      JsonObject response = await this.CallConsultarPagoRealizado(body)
                                      .ConfigureAwait(false);

      Assertion.Assert(response.Contains("codigoEstatus"),
                       $"The server response has an unexpected content:\n {response.ToString()}");

      var responseCode = response.Get<string>("codigoEstatus");
      Assertion.Assert(EmpiriaString.IsInList(responseCode, "201", "202"),
                       $"The server response has an unexpected content:\n {response.ToString()}");

      if (response.Contains("fechaPago") &&
          response.Contains("importePagado") &&
          response.Contains("lineaCaptura") &&
          response.Contains("refereciaPago")) {

        return this.UpdatePaymentDataFromWebService(paymentOrderData, response);

      } else {
        throw new Exception($"The server response has an unexpected content:\n{response.ToString()}");
      }
    }


    private IPaymentOrderData UpdatePaymentDataFromWebService(IPaymentOrderData paymentOrderData,
                                                              JsonObject responseData) {
      Assertion.AssertObject(responseData, "responseData");

      bool isCompleted = (responseData.Get<string>("codigoEstatus") == "200" ||
                          responseData.Get<string>("codigoEstatus") == "201");


      if (!isCompleted) {
        return paymentOrderData;
      }

      var paymentDate = DateTime.Parse(responseData.Get<string>("fechaPago"));
      var paymentTotal = responseData.Get<decimal>("importePagado");
      var paymentReference = responseData.Get<string>("refereciaPago");
      var lineaCaptura = responseData.Get<string>("lineaCaptura");

      Assertion.Assert(paymentOrderData.RouteNumber == lineaCaptura,
                       $"Las líneas de captura del pago referenciado no coinciden: " +
                       $"{lineaCaptura} (finanzas) vs {paymentOrderData.RouteNumber} (rpp).");

      paymentOrderData.SetPaymentData(paymentDate, paymentTotal, paymentReference);

      return paymentOrderData;
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


    private object BuildRequestBodyForConsultarPagoRealizado(IPaymentOrderData paymentOrderData) {
      return new {
        folioControlEstado = paymentOrderData.ControlTag
      };
    }


    private object BuildRequestBodyForGenerarFormatoPagoReferenciado(LRSTransaction transaction) {
      return new {
        usuario = "adminR3gPubT1x",
        password = "R3gPubT1xDrugs",
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


    private PaymentOrderData ParseOrderDataFromWebService(JsonObject responseData) {
      Assertion.AssertObject(responseData, "responseData");

      var routeNumber = responseData.Get<string>("lineaCaptura");
      var dueDate = DateTime.Parse(responseData.Get<string>("fechaVencimiento"));
      var controlTag = responseData.Get<string>("folioControlEstado");

      return new PaymentOrderData(routeNumber, dueDate, controlTag);
    }

    #endregion Private methods

  }  // class TreasuryConnector

}  // namespace Empiria.Land.Connectors