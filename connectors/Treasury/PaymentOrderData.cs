/* Empiria Land **********************************************************************************************
*                                                                                                            *
*  Solution : Empiria Land                                 System  : Land System Connectors                  *
*  Assembly : Empiria.Land.Connectors.dll                  Pattern : Information Holder                      *
*  Version  : 1.0                                          License : Please read license.txt file            *
*                                                                                                            *
*  Summary  : Holds data about payment orders for banks and stores.                                          *
*                                                                                                            *
********************************** Copyright(c) 2016-2017. La Vía Óntica SC, Ontica LLC and contributors.  **/
using System;

using Empiria.Json;

namespace Empiria.Land.Connectors.Treasury {

  /// <summary>Holds data about payment orders for banks and stores.</summary>
  public class PaymentOrderData {

    #region Constructors and parsers

    static public PaymentOrderData Parse(JsonObject json) {
      Assertion.AssertObject(json, "json");

      var data = new PaymentOrderData();

      data.DueDate = json.Get<DateTime>("dueDate");
      data.ControlTag = json.Get<string>("controlTag");
      data.RouteNumber = json.Get<string>("routeNumber");

      return data;
    }


    static internal PaymentOrderData ParseFromWebService(JsonObject responseData) {
      Assertion.AssertObject(responseData, "responseData");

      var data = new PaymentOrderData();

      data.DueDate = DateTime.Parse(responseData.Get<string>("fechaVencimiento"));
      data.ControlTag = responseData.Get<string>("folioControlEstado");
      data.RouteNumber = responseData.Get<string>("lineaCaptura");

      return data;
    }

    #endregion Constructors and parsers

    #region Properties

    public string RouteNumber {
      get;
      private set;
    }


    public DateTime DueDate {
      get;
      private set;
    }


    public string ControlTag {
      get;
      private set;
    }

    #endregion Properties

  }  // class PaymentOrderData

} // namespace Empiria.Land.Connectors.Treasury
