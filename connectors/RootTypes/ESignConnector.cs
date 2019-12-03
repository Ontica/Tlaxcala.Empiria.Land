/* Empiria Land **********************************************************************************************
*                                                                                                            *
*  Module   : Land Connectors                              Component : Electronic Sign Connectors            *
*  Assembly : Empiria.Land.Connectors.dll                  Pattern   : Web Api Client Proxy                  *
*  Type     : ESignConnector                               License   : Please read LICENSE.txt file          *
*                                                                                                            *
*  Summary  : Provides services to connect with the electronic-sign system.                                  *
*                                                                                                            *
************************* Copyright(c) La Vía Óntica SC, Ontica LLC and contributors. All rights reserved. **/
using System;
using System.Collections;

using System.Threading.Tasks;

using Empiria.Json;
using Empiria.WebApi.Client;

using Empiria.OnePoint;

using Empiria.Land.Registration.Transactions;

namespace Empiria.Land.Integration {

  public class SignRequest {

    public string UID {
      get;
      set;
    }

    public string RequestedBy {
      get;
      set;
    }

    public DateTime RequestedTime {
      get;
      set;
    }

    public string SignStatus {
      get;
      set;
    }

    public string SignatureKind {
      get;
      set;
    }


    public string DigitalSignature {
      get;
      set;
    }

  }

  public interface ISignableDocument {

    string UID {
      get;
    }

    string RequestedBy {
      get;
    }

    DateTime RequestedTime {
      get;
    }

    string SignStatus {
      get;
    }

    string SignatureKind {
      get;
    }

    string DigitalSignature {
      get;
    }

  }

  public interface IESignConnector {

    Task<SignRequest> GetRequestByDocumentNumber(string documentNo);

    Task<SignRequest> RequestRevocation(ISignableDocument document);

    Task<SignRequest> RequestSign(ISignableDocument document);

  }

  public class ESignConnector : IESignConnector {

    #region Public methods

    public async Task<SignRequest> GetRequestByDocumentNumber(string documentNo) {
      var http = new WebApiClient();

      SignRequest signRequest = await http.GetAsync<SignRequest>("ESignConnector.GetRequestByDocumentNumber", documentNo);

      return signRequest;
    }

    public async Task<SignRequest> RequestRevocation(ISignableDocument document) {
      var http = new WebApiClient();

      SignRequest signRequest = await http.PostAsync<SignRequest>(document, "ESignConnector.RequestRevocation");

      return signRequest;
    }

    public async Task<SignRequest> RequestSign(ISignableDocument document) {
      var http = new WebApiClient();

      SignRequest signRequest = await http.PostAsync<SignRequest>(document, "ESignConnector.RequestSign");

      return signRequest;
    }


    #endregion Public methods

  }  // class ESignConnector

}  // namespace Empiria.Land.Connectors
