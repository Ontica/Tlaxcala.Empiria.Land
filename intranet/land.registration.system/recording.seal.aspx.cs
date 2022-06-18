﻿/* Empiria Land **********************************************************************************************
*                                                                                                            *
*  Solution  : Empiria Land                                     System   : Land Intranet Application         *
*  Namespace : Empiria.Land.WebApp                              Assembly : Empiria.Land.Intranet.dll         *
*  Type      : RecordingSeal                                    Pattern  : Explorer Web Page                 *
*  Version   : 3.0                                              License  : Please read license.txt file      *
*                                                                                                            *
*  Summary   : Prints the recording seal for recordable documents.                                           *
*                                                                                                            *
************************* Copyright(c) La Vía Óntica SC, Ontica LLC and contributors. All rights reserved. **/
using System;
using System.Collections.Generic;

using Empiria.Contacts;
using Empiria.Land.Registration;
using Empiria.Land.Registration.Transactions;

namespace Empiria.Land.WebApp {

  public partial class RecordingSeal : System.Web.UI.Page {

    #region Fields
    protected static readonly string SEARCH_SERVICES_SERVER_BASE_ADDRESS =
                                          ConfigurationData.Get<string>("SearchServicesServerBaseAddress");

    private static readonly bool DISPLAY_VEDA_ELECTORAL_UI =
                                          ConfigurationData.Get<bool>("DisplayVedaElectoralUI", false);

    protected RecordingDocument document = null;
    protected LRSTransaction transaction = null;

    private FixedList<RecordingAct> recordingActs = null;
    private RecordingAct selectedRecordingAct = null;
    private bool isMainDocument = false;

    #endregion Fields

    #region Constructors and parsers

    protected void Page_Load(object sender, EventArgs e) {
      string documentUID = Request.QueryString["uid"];
      int documentId = int.Parse(Request.QueryString["id"] ?? "-1");

      int selectedRecordingActId = int.Parse(Request.QueryString["selectedRecordingActId"] ?? "-1");
      isMainDocument = bool.Parse(Request.QueryString["main"] ?? "false");

      if (!String.IsNullOrWhiteSpace(documentUID)) {
        document = RecordingDocument.TryParse(documentUID);
        transaction = document.GetTransaction();

      } else if (documentId != -1) {
        document = RecordingDocument.Parse(documentId);
        transaction = document.GetTransaction();

      } else {
        int transactionId = int.Parse(Request.QueryString["transactionId"]);
        transaction = LRSTransaction.Parse(transactionId);
        document = transaction.Document;

      }

      selectedRecordingAct = RecordingAct.Parse(selectedRecordingActId);
      recordingActs = document.RecordingActs;
    }

    #endregion Constructors and parsers

    #region Protected methods


    protected string GetDigitalSeal() {
      if (document.IsHistoricDocument) {
        return AsWarning("Los documentos históricos no tienen sello digital.");
      } else if (document.Status != RecordableObjectStatus.Closed) {
        return AsWarning("El documento está ABIERTO por lo que no tiene sello digital.");
      } else {
        return document.Security.GetDigitalSeal().Substring(0, 64);
      }
    }


    protected string GetDigitalSignature() {
      if (document.IsHistoricDocument) {
        return AsWarning("Los documentos históricos no tienen firma digital.");
      }
      if (document.Status != RecordableObjectStatus.Closed) {
        return AsWarning("El documento está incompleto. No tiene validez.");
      }
      if (!document.Security.UseESign) {
        return "Documento firmado de forma autógrafa. Requiere también sello oficial.";

      } else if (document.Security.UseESign && document.Security.Unsigned()) {
        return AsWarning("Este documento NO HA SIDO FIRMADO digitalmente. No tiene valor oficial.");

      } else if (document.Security.UseESign && document.Security.Signed()) {
        return document.Security.GetDigitalSignature();

      } else {
        throw Assertion.EnsureNoReachThisCode();
      }
    }


    protected bool CanBePrinted() {
      if (document.Status != RecordableObjectStatus.Closed) {
        return false;
      }
      if (document.Security.UseESign && document.Security.Unsigned()) {
        return false;
      }
      if (transaction.Workflow.IsFinished) {
        return true;
      }
      if (!ExecutionServer.IsAuthenticated && !String.IsNullOrWhiteSpace(Request.QueryString["msg"])) {
        return true;
      }

      return false;
    }


    protected string GetDocumentDescriptionText() {
      if (document.Notes.Length > 30) {
        return "DESCRIPCIÓN:<br />" + document.Notes + "<br /><br />";
      } else if (document.IsHistoricDocument) {
        return "* PARTIDA HISTÓRICA SIN DESCRIPCIÓN *";
      } else {
        return "* SIN DESCRIPCIÓN *";
      }
    }


    protected string GetDocumentLogo() {
      if (DISPLAY_VEDA_ELECTORAL_UI) {
        return "../themes/default/customer/government.seal.veda.png";
      }
      return "../themes/default/customer/government.seal.png";
    }


    protected string GetPaymentText() {
      if (document.IsHistoricDocument) {
        return String.Empty;
      }

      string template = String.Empty;

      if (!this.transaction.FormerPaymentOrderData.IsEmptyInstance) {
        template = "Derechos por <b>{AMOUNT}</b> según la línea de captura <b>{RECEIPT}</b> expedida por " +
                   "la Secretaría de Finanzas del Estado, y cuyo comprobante se archiva.";
        template = template.Replace("{RECEIPT}", transaction.FormerPaymentOrderData.RouteNumber);

      } else {
        template = "Derechos por <b>{AMOUNT}</b> según recibo <b>{RECEIPT}</b> expedido por " +
                   "la Secretaría de Finanzas del Estado, que se archiva.";
        template = template.Replace("{RECEIPT}", transaction.Payments.ReceiptNumbers);
      }

      template = template.Replace("{AMOUNT}", transaction.Items.TotalFee.Total.ToString("C2"));

      return template;
    }


    protected string GetPrelationText() {
      if (document.IsHistoricDocument) {
        return PrelationTextForHistoricDocuments();
      } else {
        return PrelationTextForDocumentsWithTransaction();
      }
    }


    private string PrelationTextForDocumentsWithTransaction() {
      const string template =
           "Documento presentado para su examen y registro {REENTRY_TEXT} el <b>{DATE} a las {TIME} horas</b>, " +
           "bajo el número de trámite <b>{NUMBER}</b>, y para el cual {COUNT}";

      DateTime presentationTime = transaction.IsReentry ? transaction.LastReentryTime : transaction.PresentationTime;

      string x = template.Replace("{DATE}", GetDateAsText(presentationTime));

      x = x.Replace("{TIME}", presentationTime.ToString("HH:mm:ss"));
      x = x.Replace("{NUMBER}", transaction.UID);
      x = x.Replace("{REENTRY_TEXT}", transaction.IsReentry ? "(como reingreso)" : String.Empty);

      if (this.recordingActs.Count > 1) {
        x = x.Replace("{COUNT}", "se registraron los siguientes " + this.recordingActs.Count.ToString() +
                      " (" + EmpiriaString.SpeechInteger(this.recordingActs.Count).ToLower() + ") " +
                      "actos jurídicos:");

      } else if (this.recordingActs.Count == 1) {
        x = x.Replace("{COUNT}", "se registró el siguiente acto jurídico:");

      } else {
        x = x.Replace("{COUNT}", AsWarning("<u>NO SE HAN REGISTRADO</u> actos jurídicos."));
      }
      return x;
    }


    private string PrelationTextForHistoricDocuments() {
      return "<h3>" + this.recordingActs[0].PhysicalRecording.AsText + "</h3>";
    }


    protected string GetRecordingActsText() {
      string html = String.Empty;

      int index = 0;
      foreach (RecordingAct recordingAct in recordingActs) {
        string temp = String.Empty;

        index++;

        // If amendment act, process it and continue
        if (recordingAct.RecordingActType.IsAmendmentActType) {
          temp = this.GetAmendmentActText(recordingAct, index);
          html += this.Decorate(recordingAct, temp);
          continue;
        }

        // If not amendment act, then process it by resource type application

        if (recordingAct.Resource is RealEstate) {
          temp = this.GetRealEstateActText(recordingAct, index);
        } else if (recordingAct.Resource is Association) {
          temp = this.GetAssociationActText(recordingAct, (Association) recordingAct.Resource, index);
        } else if (recordingAct.Resource is NoPropertyResource) {
          temp = this.GetNoPropertyActText(recordingAct, index);
        } else {
          throw Assertion.EnsureNoReachThisCode();
        }
        html += this.Decorate(recordingAct, temp);
      }
      return html;
    }


    private string Decorate(RecordingAct recordingAct, string text) {
      if (this.selectedRecordingAct.IsEmptyInstance) {
        return text;
      }
      if (recordingAct.Equals(this.selectedRecordingAct)) {
        if (this.isMainDocument) {
          return "<span class='selectedItem'> " + text + "</span>";
        } else {
          return "<span class='markedItem'> " + text + "</span>";
        }
      } else {
        return text;
      }
    }


    protected string GetRecordingOfficialsInitials() {
      string temp = String.Empty;

      List<Contact> recordingOfficials = document.GetRecordingOfficials();

      foreach (Contact official in recordingOfficials) {
        if (temp.Length != 0) {
          temp += " ";
        }
        temp += official.Nickname;
      }
      return temp;
    }


    protected string GetCurrentUserInitials() {
      if (ExecutionServer.IsAuthenticated) {
        var user = Security.EmpiriaUser.Current.AsContact();

        return user.Nickname;
      }
      return String.Empty;
    }


    // For future use
    protected string GetRecordingOfficialsNames() {
      string temp = String.Empty;

      List<Contact> recordingOfficials = document.GetRecordingOfficials();

      foreach (Contact official in recordingOfficials) {
        if (temp.Length != 0) {
          temp += ", ";
        }
        temp += official.FullName;
      }
      return temp;
    }


    protected string GetRecordingPlaceAndDate() {
      if (document.IsHistoricDocument) {
        return PlaceAndDateTextForHistoricDocuments();
      } else {
        return PlaceAndDateTextForDocumentsWithTransaction();
      }
    }


    private string PlaceAndDateTextForDocumentsWithTransaction() {
      const string t = "Registrado en {CITY}, a las {TIME} horas del {DATE}. Doy Fe.";

      string x = t.Replace("{DATE}", GetDateAsText(document.AuthorizationTime));
      x = x.Replace("{TIME}", document.AuthorizationTime.ToString(@"HH:mm"));
      x = x.Replace("{CITY}", "Tlaxcala de Xicohténcatl, Tlaxcala");

      return x;
    }


    private string PlaceAndDateTextForHistoricDocuments() {
      const string template =
            "De acuerdo a lo que consta en libros físicos y en documentos históricos:<br/>" +
            "Fecha de presentación: <b>{PRESENTATION.DATE}</b>. " +
            "Fecha de registro: <b>{AUTHORIZATION.DATE}</b>.<br/><br/>" +
            "Fecha de la captura histórica: <b>{RECORDING.DATE}<b>.<br/>";

      string x = template.Replace("{PRESENTATION.DATE}", GetDateAsText(document.PresentationTime));
      x = x.Replace("{AUTHORIZATION.DATE}", GetDateAsText(document.AuthorizationTime));
      x = x.Replace("{RECORDING.DATE}", GetDateAsText(document.PostingTime));

      return x;
    }


    private string GetDateAsText(DateTime date) {
      if (date == ExecutionServer.DateMinValue || date == ExecutionServer.DateMaxValue) {
        return "No consta";
      } else {
        return date.ToString(@"dd \de MMMM \de yyyy");
      }
    }


    protected string GetRecordingSignerName() {
      if (document.IsHistoricDocument) {
        return String.Empty;
      }
      if (!CanBePrinted()) {
        return AsWarning("ESTE DOCUMENTO NO ES VÁLIDO EN EL ESTADO ACTUAL.");
      } else {
        return document.Security.GetSignedBy().FullName;
      }
    }


    protected string GetRecordingSignerJobTitle() {
      if (document.IsHistoricDocument) {
        return String.Empty;
      }
      return document.Security.GetSignedBy().JobTitle;
    }


    private Resource _uniqueInvolvedResource = null;
    protected Resource UniqueInvolvedResource {
      get {
        if (_uniqueInvolvedResource == null) {
          _uniqueInvolvedResource = document.GetUniqueInvolvedResource();
        }
        return _uniqueInvolvedResource;
      }
    }

    #endregion Protected methods


    #region Private methods

    private string GetAmendmentActText(RecordingAct recordingAct, int index) {
      const string template = "{INDEX}.- <b style='text-transform:uppercase'>{AMENDMENT.ACT}</b> " +
                              "{AMENDMENT.ACT.RECORDING}, {RESOURCE.DATA}.<br/>";

      string x = template.Replace("{INDEX}", index.ToString());

      Assertion.Require(recordingAct.RecordingActType.IsAmendmentActType,
                       "Recording act is not an amendment act.");

      x = x.Replace("{AMENDMENT.ACT}", this.GetAmendmentActTypeDisplayName(recordingAct));

      RecordingAct amendedAct = recordingAct.AmendmentOf;
      if (amendedAct.IsEmptyInstance) {
        x = x.Replace(" {AMENDMENT.ACT.RECORDING},", " ");
      } else {
        var legend = amendedAct.RecordingActType.FemaleGenre ? "inscrita": "inscrito";
        if (amendedAct.PhysicalRecording.IsEmptyInstance) {
          x = x.Replace("{AMENDMENT.ACT.RECORDING}",
                        legend + " bajo el documento " + "<b>" + amendedAct.Document.UID + "</b>");
        } else {
          x = x.Replace("{AMENDMENT.ACT.RECORDING}",
                        legend + " en la " + amendedAct.PhysicalRecording.AsText);
        }
      }

      Resource resource = recordingAct.Resource;
      if (resource is RealEstate) {
        x = x.Replace("{RESOURCE.DATA}", "sobre el bien inmueble con folio electrónico " +
                      this.GetRealEstateTextWithAntecedentAndCadastralKey(recordingAct));
      } else if (resource is Association) {
        x = x.Replace("{RESOURCE.DATA}", "sobre la sociedad o asociación denominada '" +
                      ((Association) resource).Name) + "' con folio único <b class='bigger'>" + resource.UID + "</b>";
      } else if (resource is NoPropertyResource) {
        x = x.Replace("{RESOURCE.DATA}", "con identificador de inscripción <b class='bigger'>" + resource.UID + "</b>");
      } else {
        throw Assertion.EnsureNoReachThisCode($"Unknown rule for resources with type {resource.GetType()}.");
      }
      return x;
    }

    private string GetAmendmentActTypeDisplayName(RecordingAct amendmentAct) {
      Assertion.Require(amendmentAct.RecordingActType.IsAmendmentActType,
                       "amendmentAct.IsAmendment should be true.");

      if (!amendmentAct.RecordingActType.RecordingRule.UseDynamicActNaming) {
        return amendmentAct.DisplayName;
      }


      string x = String.Empty;
      x = amendmentAct.RecordingActType.RecordingRule.DynamicActNamePattern + " {AMENDED.ACT}";

      var amendedAct = amendmentAct.AmendmentOf;

      if (!amendmentAct.RecordingActType.AppliesToARecordingAct) {
        return x.Replace(" {AMENDED.ACT}", String.Empty);
      }

      if (amendedAct.RecordingActType.FemaleGenre) {
        return x.Replace("{AMENDED.ACT}", "DE LA " + amendedAct.RecordingActType.DisplayName);
      } else {
        return x.Replace("{AMENDED.ACT}", "DEL " + amendedAct.RecordingActType.DisplayName);
      }
    }

    private string GetNoPropertyActText(RecordingAct recordingAct, int index) {
      const string template =
            "{INDEX}.- <b style='text-transform:uppercase'>{RECORDING.ACT}</b><br/>";

      string x = template.Replace("{INDEX}", index.ToString());

      return x.Replace("{RECORDING.ACT}", recordingAct.DisplayName);
    }

    private string GetRealEstateActText(RecordingAct recordingAct, int index) {
      Assertion.Require(recordingAct.Resource is RealEstate,
                       $"Type mismatch parsing real estate with id {recordingAct.Resource.Id}.");

      RealEstate property = (RealEstate) recordingAct.Resource;

      if (!property.IsPartitionOf.IsEmptyInstance &&
           property.IsInTheRankOfTheFirstDomainAct(recordingAct)) {
        return this.GetRealEstateActTextOverNewPartition(recordingAct, property, index);
      } else {
        return this.GetRealEstateActOverTheWhole(recordingAct, index);
      }
    }

    private string GetRealEstateActOverTheWhole(RecordingAct recordingAct, int index) {
      const string overTheWhole =
          "{INDEX}.- <b style='text-transform:uppercase'>{RECORDING.ACT}</b> sobre el " +
          "bien inmueble con folio electrónico {PROPERTY.UID}.<br/>";

      string x = String.Empty;

      x = overTheWhole.Replace("{INDEX}", index.ToString());
      x = x.Replace("{RECORDING.ACT}", this.GetRecordingActDisplayName(recordingAct));

      var antecedent = recordingAct.Resource.Tract.GetRecordingAntecedent(recordingAct);
      x = x.Replace("{PROPERTY.UID}",
                    this.GetRealEstateTextWithAntecedentAndCadastralKey(recordingAct));

      return x;
    }

    private string GetRecordingActDisplayName(RecordingAct recordingAct) {
      var temp = recordingAct.RecordingActType.DisplayName;

      if (recordingAct.Percentage != decimal.One) {
        return temp + " del " + (recordingAct.Percentage * 100).ToString("N2") + " por ciento";
      } else {
        return temp;
      }
    }

    private string GetRealEstateActTextOverNewPartition(RecordingAct recordingAct,
                                                        RealEstate newPartition, int index) {
      const string overPartition =
      "{INDEX}.- {RECORDING.ACT} sobre la " +
      "<b>{PARTITION.TEXT}</b> del bien inmueble con folio {PARTITION.OF}, misma a la que " +
      "se le asignó el folio electrónico {PROPERTY.UID}.<br/>";

      const string overPartitionMale =
          "{INDEX}.- {RECORDING.ACT} sobre el " +
          "<b>{PARTITION.TEXT}</b> del bien inmueble con folio {PARTITION.OF}, mismo al que " +
          "se le asignó el folio electrónico {PROPERTY.UID}.<br/>";

      const string overLot =
          "{INDEX}.- {RECORDING.ACT} sobre el " +
          "<b>{PARTITION.TEXT}</b> de la lotificación con folio {PARTITION.OF}, mismo al que " +
          "se le asignó el folio electrónico {PROPERTY.UID}.<br/>";

      const string overApartment =
          "{INDEX}.- {RECORDING.ACT} sobre el " +
          "<b>{PARTITION.TEXT}</b> del condominio con folio {PARTITION.OF}, mismo a la que " +
          "se le asignó el folio electrónico {PROPERTY.UID}.<br/>";

      const string overHouse =
          "{INDEX}.- {RECORDING.ACT} sobre la " +
          "<b>{PARTITION.TEXT}</b> del fraccionamiento con folio {PARTITION.OF}, misma a la que " +
          "se le asignó el folio electrónico {PROPERTY.UID}.<br/>";

      Assertion.Require(!newPartition.IsPartitionOf.IsEmptyInstance, "Property is not a partition.");

      string x = String.Empty;

      string partitionText;

      if (newPartition.Kind.Length == 0 && newPartition.PartitionNo.Length == 0) {
        partitionText = $"FRACCIÓN O PARTE SIN IDENTIFICAR";

      } else if (newPartition.Kind.Length != 0 && newPartition.PartitionNo.Length == 0) {
        partitionText = $"{newPartition.Kind} SIN IDENTIFICAR";

      } else if (newPartition.Kind.Length == 0 && newPartition.PartitionNo.Length != 0) {
        partitionText = $"FRACCIÓN O PARTE {newPartition.PartitionNo}";

      } else {
        partitionText = $"{newPartition.Kind} {newPartition.PartitionNo}";
      }

      if (newPartition.Kind.StartsWith("Fracción") ||
          newPartition.Kind.StartsWith("Bodega")) {
        x = overPartition.Replace("{INDEX}", index.ToString());
        x = x.Replace("{PARTITION.TEXT}", partitionText);
        if (recordingAct.RecordingActType.IsDomainActType) {
          x = x.Replace("sobre la", "de la");
        }

      } else if (newPartition.Kind.StartsWith("Estacionamiento") ||
                 newPartition.Kind.StartsWith("Local")) {
        x = overPartitionMale.Replace("{INDEX}", index.ToString());
        x = x.Replace("{PARTITION.TEXT}", partitionText);
        if (recordingAct.RecordingActType.IsDomainActType) {
          x = x.Replace("sobre el", "del");
        }

      } else if (newPartition.Kind.StartsWith("Lote")) {
        x = overLot.Replace("{INDEX}", index.ToString());
        x = x.Replace("{PARTITION.TEXT}", partitionText);
        if (recordingAct.RecordingActType.IsDomainActType) {
          x = x.Replace("sobre el", "del");
        }

      } else if (newPartition.Kind.StartsWith("Casa")) {
        x = overHouse.Replace("{INDEX}", index.ToString());
        x = x.Replace("{PARTITION.TEXT}", partitionText);
        if (recordingAct.RecordingActType.IsDomainActType) {
          x = x.Replace("sobre la", "de la");
        }

      } else if (newPartition.Kind.StartsWith("Departamento")) {
        x = overApartment.Replace("{INDEX}", index.ToString());
        x = x.Replace("{PARTITION.TEXT}", partitionText);
        if (recordingAct.RecordingActType.IsDomainActType) {
          x = x.Replace("sobre el", "del");
        }

      } else {
        x = overPartition.Replace("{INDEX}", index.ToString());
        x = x.Replace("{PARTITION.TEXT}", partitionText);

      }

      var parentAntecedent =
              newPartition.IsPartitionOf.Tract.GetRecordingAntecedent(recordingAct.Document.PresentationTime);

      if (!parentAntecedent.PhysicalRecording.IsEmptyInstance) {
        x = x.Replace("{PARTITION.OF}", "<u>" + newPartition.IsPartitionOf.UID + "</u> " +
                      "y antecedente registral en " + parentAntecedent.PhysicalRecording.AsText);
      } else {
        x = x.Replace("{PARTITION.OF}", "<u>" + newPartition.IsPartitionOf.UID + "</u>");
      }

      x = x.Replace("{RECORDING.ACT}", GetRecordingActDisplayName(recordingAct));
      x = x.Replace("{PROPERTY.UID}", this.GetRealEstateTextWithCadastralKey(newPartition));

      return x;
    }

    private string GetRealEstateTextWithCadastralKey(RealEstate property) {
      string x = "<b class='bigger'>" + property.UID + "</b>";

      if (property.CadastralKey.Length != 0) {
        x += " (Clave catastral: <b>" + property.CadastralKey + "</b>)";
      }
      return x;
    }

    private string GetRealEstateTextWithAntecedentAndCadastralKey(RecordingAct recordingAct) {
      var domainAntecedent = recordingAct.Resource.Tract.GetRecordingAntecedent(recordingAct);
      var property = (RealEstate) recordingAct.Resource;

      string x = GetRealEstateTextWithCadastralKey(property);
      if (property.IsPartitionOf.IsEmptyInstance && domainAntecedent.Equals(RecordingAct.Empty)) {
        x += " sin antecedente registral";
      } else if (!property.IsPartitionOf.IsEmptyInstance && domainAntecedent.Equals(RecordingAct.Empty)) {

      } else if (!domainAntecedent.PhysicalRecording.IsEmptyInstance) {
        if (!recordingAct.AmendmentOf.PhysicalRecording.Equals(domainAntecedent.PhysicalRecording)) {
          x += ", con antecedente registral en " + domainAntecedent.PhysicalRecording.AsText;
        }
      } else if (domainAntecedent.Document.Equals(recordingAct.Document)) {
        x += ", registrado en este documento";
      } else if (!(domainAntecedent is DomainAct)) {   // TODO: this is very strange, is a special case
        x += String.Format(" el {0} bajo el número de documento electrónico {1}",
                           this.GetDateAsText(domainAntecedent.Document.AuthorizationTime),
                           domainAntecedent.Document.UID);
      } else {
        x += String.Format(", con antecedente inscrito el {0} bajo el número de documento electrónico {1}",
                           this.GetDateAsText(domainAntecedent.Document.AuthorizationTime),
                           domainAntecedent.Document.UID);
      }
      return x;
    }

    private string GetAssociationActText(RecordingAct recordingAct, Association association, int index) {
      const string incorporationActText =
            "{INDEX}.- <b style='text-transform:uppercase'>CONSTITUCIÓN</b> de " +
            "la {ASSOCIATION.KIND} denominada <b>{ASSOCIATION.NAME}</b>, " +
            "misma a la que se le asignó el folio único <b class='bigger'>{ASSOCIATION.UID}</b>.<br/>";

      const string overAssociationWithIncorporationActInDigitalRecording =
          "{INDEX}.- <b style='text-transform:uppercase'>{RECORDING.ACT}</b> de " +
          "la {ASSOCIATION.KIND} denominada <b>{ASSOCIATION.NAME}</b>, " +
          "con folio único <b class='bigger'>{ASSOCIATION.UID}</b>.<br/>";

      const string overAssociationWithIncorporationActInPhysicalRecording =
          "{INDEX}.- <b style='text-transform:uppercase'>{RECORDING.ACT}</b> de " +
          "la {ASSOCIATION.KIND} denominada <b>{ASSOCIATION.NAME}</b>, " +
          "con folio único <b class='bigger'>{ASSOCIATION.UID}</b> y " +
          "antecedente registral en {ANTECEDENT}.<br/>";

      RecordingAct incorporationAct = association.GetIncorporationAct();

      string x = String.Empty;
      if (recordingAct.Equals(incorporationAct)) {
        x = incorporationActText.Replace("{INDEX}", index.ToString());

      } else if (incorporationAct.PhysicalRecording.IsEmptyInstance) {
        x = overAssociationWithIncorporationActInDigitalRecording.Replace("{INDEX}", index.ToString());
        x = x.Replace("{RECORDING.ACT}", recordingAct.DisplayName);

      } else if (!incorporationAct.PhysicalRecording.IsEmptyInstance) {
        x = overAssociationWithIncorporationActInPhysicalRecording.Replace("{INDEX}", index.ToString());
        x = x.Replace("{RECORDING.ACT}", recordingAct.DisplayName);
        x = x.Replace("{ANTECEDENT}", incorporationAct.PhysicalRecording.AsText);

      } else {
        throw Assertion.EnsureNoReachThisCode();

      }

      x = x.Replace("{ASSOCIATION.UID}", association.UID);
      x = x.Replace("{ASSOCIATION.NAME}", association.Name);
      x = x.Replace("{ASSOCIATION.KIND}", association.Kind);

      return x;
    }

    private string AsWarning(string text) {
      return "<span style='color:red;'><strong>*****" + text + "*****</strong></span>";
    }

    #endregion Private methods

  } // class RecordingSeal

} // namespace Empiria.Land.WebApp
