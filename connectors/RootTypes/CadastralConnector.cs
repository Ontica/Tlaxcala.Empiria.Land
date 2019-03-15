/* Empiria Land **********************************************************************************************
*                                                                                                            *
*  Solution  : Empiria Land                                System   : Land System Connectors                 *
*  Namespace : Empiria.Land.Connectors                     Assembly : Empiria.Land.Connectors.dll            *
*  Type      : CadastralConnector                          Pattern  : System Interface                       *
*  Version   : 3.0                                         License  : Please read license.txt file           *
*                                                                                                            *
*  Summary   : Cadastral System web service interface used to verify real estate in Empiria Land.            *
*                                                                                                            *
********************************* Copyright (c) 2016-2017. La Vía Óntica SC, Ontica LLC and contributors.  **/
using System;
using System.Threading.Tasks;

using Empiria.Json;

using Empiria.WebApi;
using Empiria.WebApi.Client;

namespace Empiria.Land.Connectors {

  /// <summary>Cadastral System web service interface used to verify real estate in Empiria Land.</summary>
  public class CadastralConnector {

    #region Public methods

    public async Task<CadastralData> VerifyRealEstateRegistered(string cadastralKey) {
      Assertion.AssertObject(cadastralKey, "cadastralKey");
      Assertion.Assert(cadastralKey.Length == 31, "La clave catastral tiene un tamaño diferente a 31 dígitos.");
      Assertion.Assert(EmpiriaString.IsInteger(cadastralKey), "La clave catastral tiene caracteres que no reconozco.");

      JsonObject response = await this.CallVerifyRealEstateRegisteredWebService(cadastralKey)
                                      .ConfigureAwait(false);

      Assertion.Assert(response.Contains("claveCatastral") && response.Contains("propietario"),
                       $"El servidor de Catastro regresó una respuesta inesperada:\n {response.ToString()}");

      return this.ParseCadastralDataFromWebService(response);
    }


    #endregion Public methods

    #region Private methods


    private async Task<JsonObject> CallVerifyRealEstateRegisteredWebService(string cadastralKey) {
      try {
        var http = new WebApiClient();

        JsonObject response = await http.GetAsync<JsonObject>("CadastralConnectors.ObtenerPredio", cadastralKey);

        if (!response.HasItems) {  // Response content was empty.
                                   // Sometimes the service response is a 200 but without content,
                                   // so retry the call one more time after some time.
          await Task.Delay(1000);

          response = await http.GetAsync<JsonObject>("CadastralConnectors.ObtenerPredio", cadastralKey);
        }

        Assertion.Assert(response.HasItems,
                         "The server response was successful (200 [OK]) but its content was an empty object.");

        return response;

      } catch (WebApiClientException err) {
        if (err.Response == null) {
          throw err;
        } else if (!err.Response.IsSuccessStatusCode) {
          throw new Exception("El servidor de Catastro tuvo un problema al proveer el servicio de verificación de claves catastrales.");
        } else {
          throw new Exception($"La clave catastral {cadastralKey} NO es válida. No está registrada en el Sistema de Catastro.");
        }
      } catch (Exception err) {
        throw err;
      }
    }



    private CadastralData ParseCadastralDataFromWebService(JsonObject responseData) {
      return Json.JsonConverter.ToObject<CadastralData>(responseData.ToString());
    }


    #endregion Private methods

  }  // class CadastralConnector

}  // namespace Empiria.Land.Connectors
