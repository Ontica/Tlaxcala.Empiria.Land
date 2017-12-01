/* Empiria Land **********************************************************************************************
*                                                                                                            *
*  Solution : Empiria Land                                 System  : Land System Connectors                  *
*  Assembly : Empiria.Land.Connectors.dll                  Pattern : Information Holder                      *
*  Version  : 1.0                                          License : Please read license.txt file            *
*                                                                                                            *
*  Summary  : Holds data about the status of payment orders for banks and stores.                            *
*                                                                                                            *
********************************** Copyright(c) 2016-2017. La Vía Óntica SC, Ontica LLC and contributors.  **/
using System;

using Empiria.Json;

namespace Empiria.Land.Connectors.Treasury {

  /// <summary>Holds data about the status of payment orders for banks and stores.</summary>
  public class PaymentStatusData {

    #region Constructors and parsers

    static public PaymentStatusData Parse(JsonObject json) {
      Assertion.AssertObject(json, "json");

      var data = new PaymentStatusData();

      data.IsCompleted = json.Get<Boolean>("isCompleted");

      if (data.IsCompleted) {
        data.PaymentDate = json.Get<DateTime>("paymentDate");
        data.Total = json.Get<decimal>("total");
      }
      data.RouteNumber = json.Get<string>("routeNumber", String.Empty);
      data.ReferenceTag = json.Get<string>("referenceTag", String.Empty);

      return data;
    }


    static internal PaymentStatusData ParseFromWebService(JsonObject responseData) {
      Assertion.AssertObject(responseData, "responseData");

      var data = new PaymentStatusData();

      data.IsCompleted = (responseData.Get<string>("codigoEstatus") == "200" ||
                          responseData.Get<string>("codigoEstatus") == "201");

      if (data.IsCompleted) {
        data.PaymentDate = DateTime.Parse(responseData.Get<string>("fechaPago"));
        data.Total = responseData.Get<decimal>("importePagado");
      }
      data.RouteNumber = responseData.Get<string>("lineaCaptura");
      data.ReferenceTag = responseData.Get<string>("refereciaPago");

      return data;
    }

    #endregion Constructors and parsers

    #region Properties

    public bool IsCompleted {
      get;
      private set;
    } = false;


    public DateTime PaymentDate {
      get;
      private set;
    } = ExecutionServer.DateMinValue;


    public decimal Total {
      get;
      private set;
    } = 0m;


    public string RouteNumber {
      get;
      private set;
    } = String.Empty;


    public string ReferenceTag {
      get;
      private set;
    } = String.Empty;


    #endregion Properties

    #region Methods

    internal void EnsureValid(PaymentOrderData paymentOrderData) {

      Assertion.Assert(this.RouteNumber == paymentOrderData.RouteNumber,
                       $"Las líneas de captura del pago referenciado no coinciden: " +
                       $"{this.RouteNumber} (finanzas) vs {paymentOrderData.RouteNumber} (rpp).");

    }

    #endregion Methods

  }  // class PaymentStatusData

} // namespace Empiria.Land.Connectors.Treasury
