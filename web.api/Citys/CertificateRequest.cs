﻿/* Empiria Land **********************************************************************************************
*                                                                                                            *
*  Solution  : Empiria Land                                   System   : Land Services                       *
*  Namespace : Empiria.Land.WebApi.Models                     Assembly : Empiria.Land.WebApi.dll             *
*  Type      : CertificateRequest                             Pattern  : External Interfacer                 *
*  Version   : 3.0                                            License  : Please read license.txt file        *
*                                                                                                            *
*  Summary   : Model that holds information about a certificate request from an external transaction system. *
*                                                                                                            *
************************* Copyright(c) La Vía Óntica SC, Ontica LLC and contributors. All rights reserved. **/
using System;

using Empiria.Json;
using Empiria.Land.Registration;
using Empiria.Land.Registration.Transactions;

namespace Empiria.Land.WebApi.Citys {

  /// <summary>Model that holds information about a certificate request
  /// from an external transaction system.</summary>
  public class CertificateRequest : LRSExternalTransaction {

    #region Public properties

    /// <summary>The certificate type to be issued.</summary>
    public ExternalCertificateType CertificateType {
      get;
      set;
    } = ExternalCertificateType.Undefined;

    /// <summary>The real property unique ID.</summary>
    public string RealPropertyUID {
      get;
      set;
    } = String.Empty;

    protected override LRSTransactionType TransactionType {
      get {
        return LRSTransactionType.Parse(702);
      }
    }

    protected override LRSDocumentType DocumentType {
      get {
        switch (this.CertificateType) {
          case ExternalCertificateType.NoEncumbrance:
            return LRSDocumentType.Parse(713);
          case ExternalCertificateType.Property:
            return LRSDocumentType.Parse(710);
          case ExternalCertificateType.Registration:
            return LRSDocumentType.Parse(711);
          default:
            throw Assertion.EnsureNoReachThisCode("Tipo de certificado desconocido.");
        }
      }
    }

    #endregion Public properties

    #region Public methods

    public override void AssertIsValid() {
      base.AssertIsValid();

      this.RealPropertyUID = EmpiriaString.TrimAll(this.RealPropertyUID).ToUpperInvariant();

      Assertion.Require(this.CertificateType != ExternalCertificateType.Undefined,
        $"No reconozco el tipo de certificado: '{this.CertificateType}'");
      Assertion.Require(this.RealPropertyUID,
        "No se ha proporcionado el folio electrónico del predio.");
      Assertion.Require(RealEstate.TryParseWithUID(this.RealPropertyUID),
        $"No tengo registrado ningún predio con folio electrónico '{this.RealPropertyUID}'.");
    }

    /// <summary>Creates a Land Transaction using the data of this certificate request.</summary>
    /// <returns>The Land Transaction created instance.</returns>
    internal LRSTransaction CreateTransaction() {
      AssertIsValid();

      return base.CreateLRSTransaction();
    }

    public override JsonObject ToJson() {
      var json = base.ToJson();

      json.Add("CertificateType", this.CertificateType);
      json.Add("PropertyUID", this.RealPropertyUID);

      return json;
    }

    #endregion Public methods

  }  // class CertificateRequest

}  // namespace Empiria.Land.WebApi.Models
