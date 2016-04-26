/* Empiria Land **********************************************************************************************
*																																																						 *
*  Solution  : Empiria Land                                     System   : Land Intranet Application         *
*  Namespace : Empiria.Land.WebApp                              Assembly : Empiria.Land.Intranet.dll         *
*  Type      : RecordingSeal                                    Pattern  : Explorer Web Page                 *
*  Version   : 2.1                                              License  : Please read license.txt file      *
*																																																						 *
*  Summary   : Prints the recording seal for recordable documents.                                           *
*                                                                                                            *
********************************** Copyright(c) 2009-2016. La Vía Óntica SC, Ontica LLC and contributors.  **/
using System;
using System.Collections.Generic;

using Empiria.Contacts;
using Empiria.Land.Registration;
using Empiria.Land.Registration.Transactions;

namespace Empiria.Land.WebApp {

  public partial class RecordingSeal : System.Web.UI.Page {

    #region Fields

    protected LRSTransaction transaction = null;
    protected RecordingDocument document = null;
    private FixedList<RecordingAct> recordingActs = null;

    #endregion Fields

    #region Constructors and parsers

    protected void Page_Load(object sender, EventArgs e) {
      transaction = LRSTransaction.Parse(int.Parse(Request.QueryString["transactionId"]));
      document = transaction.Document;
      recordingActs = document.RecordingActs;
      Assertion.Assert(recordingActs.Count > 0, "Document does not has recording acts.");
    }

    #endregion Constructors and parsers

    #region Protected methods


    protected string GetDigitalSeal() {
      string s = "||" + transaction.UID + "|" + document.UID;
      for (int i = 0; i < recordingActs.Count; i++) {
        s += "|" + recordingActs[i].Id.ToString();
      }
      s += "||";
      return Empiria.Security.Cryptographer.CreateDigitalSign(s);
    }

    protected string GetDigitalSignature() {
      string s = "||" + transaction.UID + "|" + document.UID;
      for (int i = 0; i < recordingActs.Count; i++) {
        s += "|" + recordingActs[i].Id.ToString();
      }
      return Empiria.Security.Cryptographer.CreateDigitalSign(s + "eSign");
    }

    protected string GetDocumentDescriptionText() {
      if (document.Notes.Length > 30) {
        return "DESCRIPCIÓN:<br />" + document.Notes + "<br /><br />";
      } else {
        return "* SIN DESCRIPCIÓN *";
      }
    }

    protected string GetPaymentText() {
      const string t = "Derechos por <b>{AMOUNT}</b> según recibo <b>{RECEIPT}</b> expedido por " +
                       "la Secretaría de Finanzas del Estado, que se archiva.";

      string x = t.Replace("{AMOUNT}", transaction.Items.TotalFee.Total.ToString("C2"));
      x = x.Replace("{RECEIPT}", transaction.Payments.ReceiptNumbers);

      return x;
    }

    protected string GetPrelationText() {
      const string template =
          "Documento presentado para su examen y registro {REENTRY_TEXT} el <b>{DATE} a las {TIME} horas</b>, " +
          "bajo el número de trámite <b>{NUMBER}</b>, y para el cual se {COUNT}";

      DateTime presentationTime = transaction.IsReentry ? transaction.LastReentryTime : transaction.PresentationTime;

      string x = template.Replace("{DATE}", presentationTime.ToString(@"dd \de MMMM \de yyyy"));

      x = x.Replace("{TIME}", presentationTime.ToString("HH:mm:ss"));
      x = x.Replace("{NUMBER}", transaction.UID);
      x = x.Replace("{REENTRY_TEXT}", transaction.IsReentry ? "(como reingreso)" : String.Empty);

      if (this.recordingActs.Count > 1) {
        x = x.Replace("{COUNT}", "registraron los siguientes " + this.recordingActs.Count.ToString() +
                      " (" + EmpiriaString.SpeechInteger(this.recordingActs.Count).ToLower() + ") " +
                      "actos jurídicos:");

      } else if (this.recordingActs.Count == 1) {
        x = x.Replace("{COUNT}", "registró el siguiente acto jurídico:");

      } else {
        throw Assertion.AssertNoReachThisCode();

      }
      return x;
    }

    protected string GetRecordingActsText() {
      string html = String.Empty;

      int index = 0;
      foreach (RecordingAct recordingAct in recordingActs) {
        index++;

        // If amendment act, process it and continue
        if (recordingAct.RecordingActType.IsAmendmentActType) {
          html += this.GetAmendmentActText(recordingAct, index);
          continue;
        }

        // If not amendment act, process it by resource type application
        switch (recordingAct.RecordingActType.RecordingRule.AppliesTo) {
          case RecordingRuleApplication.RealEstate:
          case RecordingRuleApplication.RecordingAct:
          case RecordingRuleApplication.Structure:
            Resource resource = recordingAct.TractIndex[0].Resource;
            Assertion.Assert(resource is RealEstate,
                             "Type mismatch parsing real estate with id {0}", resource.Id);
            html += this.GetRealEstateActText(recordingAct, (RealEstate) resource, index);
            break;

          case RecordingRuleApplication.Association:
            resource = recordingAct.TractIndex[0].Resource;
            Assertion.Assert(resource is Association,
                             "Type mismatch parsing association with id {0}", resource.Id);
            html += this.GetAssociationActText(recordingAct, (Association) resource, index);
            break;

          case RecordingRuleApplication.NoProperty:
            // For now, we don't display seals with the NoProperty resource identificator
            html += this.GetNoPropertyActText(recordingAct, index);
            break;

          default:
            throw new NotImplementedException("Undefined rule for recording acts text.");
        }
      }
      return html;
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
      return temp.Length != 0 ? "* " + temp : String.Empty;
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
      const string t = "Registrado en {CITY}, a las {TIME} horas del {DATE}. Doy Fe.";

      string x = t.Replace("{DATE}", document.AuthorizationTime.ToString(@"dd \de MMMM \de yyyy"));
      x = x.Replace("{TIME}", document.AuthorizationTime.ToString(@"HH:mm"));
      if (ExecutionServer.LicenseName == "Tlaxcala") {
        x = x.Replace("{CITY}", "Tlaxcala de Xicohténcatl, Tlaxcala");
      } else {
        x = x.Replace("{CITY}", "Zacatecas, Zacatecas");
      }
      return x;
    }

    protected string GetRecordingSignerName() {
      if (ExecutionServer.LicenseName == "Tlaxcala") {
        return "Mtro. Sergio Cuauhtémoc Lima López";
      } else {
        return "Lic. Teresa de Jesús Alvarado Ortiz";
      }
    }

    protected string GetRecordingSignerPosition() {
      if (ExecutionServer.LicenseName == "Tlaxcala") {
        return "Director de Notarías y Registros Públicos";
      } else {
        return "C. Oficial Registrador del Distrito Judicial de Zacatecas";
      }
    }

    #endregion Protected methods

    #region Private methods

    private string GetAmendmentActText(RecordingAct recordingAct, int index) {
      const string template = "{INDEX}.- <b style='text-transform:uppercase'>{AMENDMENT.ACT}</b> " +
                              "{AMENDMENT.ACT.RECORDING}, {RESOURCE.DATA}.<br/>";

      string x = template.Replace("{INDEX}", index.ToString());

      Assertion.Assert(recordingAct.RecordingActType.IsAmendmentActType,
                       "Bad code. Recording act is not an amendment act.");

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

      Resource resource = recordingAct.TractIndex[0].Resource;
      if (resource is RealEstate) {
        var antecedent = ((RealEstate) resource).GetDomainAntecedent(recordingAct);

        x = x.Replace("{RESOURCE.DATA}", "sobre el bien inmueble con folio real electrónico " +
                      this.GetRealEstateTextWithAntecedentAndCadastralKey((RealEstate) resource, antecedent));
      } else if (resource is Association) {
        x = x.Replace("{RESOURCE.DATA}", "sobre la sociedad o asociación denominada '" +
                      ((Association) resource).Name) + "' con folio único <b>" + resource.UID + "</b>";
      } else if (resource is NoPropertyResource) {
        x = x.Replace("{RESOURCE.DATA}", "con identificador de inscripción <b>" + resource.UID + "</b>");
      } else {
        throw Assertion.AssertNoReachThisCode("Unknown rule for resources with type {0}.", resource.GetType());
      }
      return x;
    }

    private string GetAmendmentActTypeDisplayName(RecordingAct amendmentAct) {
      Assertion.Assert(amendmentAct.RecordingActType.IsAmendmentActType,
                       "amendmentAct.IsAmendment should be true.");

      if (!amendmentAct.RecordingActType.RecordingRule.UseDynamicActNaming) {
        return amendmentAct.DisplayName;
      }

      string x = String.Empty;
      x = amendmentAct.RecordingActType.RecordingRule.DynamicActNamePattern + " {AMENDED.ACT}";

      var amendedAct = amendmentAct.AmendmentOf;
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

    private string GetRealEstateActText(RecordingAct recordingAct, RealEstate property, int index) {
      const string notAllowPartitions =
            "{INDEX}.- <b style='text-transform:uppercase'>{RECORDING.ACT}</b> sobre el " +
            "bien inmueble con folio real electrónico {PROPERTY.UID}.<br/>";

      const string overTheWhole =
              "{INDEX}.- <b style='text-transform:uppercase'>{RECORDING.ACT}</b> sobre la " +
              "totalidad del bien inmueble con folio real electrónico {PROPERTY.UID}.<br/>";

      string x = String.Empty;

      if (!recordingAct.RecordingActType.RecordingRule.AllowsPartitions) {
        x = notAllowPartitions.Replace("{INDEX}", index.ToString());

      } else if (property.IsPartitionOf.IsEmptyInstance) {
        x = overTheWhole.Replace("{INDEX}", index.ToString());

      } else if (!property.IsPartitionOf.IsEmptyInstance) {
        x = this.GetRealEstateActTextOverPartition(recordingAct, property, index);

      } else {
        throw Assertion.AssertNoReachThisCode();

      }

      x = x.Replace("{RECORDING.ACT}", recordingAct.RecordingActType.DisplayName);

      var antecedent = property.GetDomainAntecedent(recordingAct);
      x = x.Replace("{PROPERTY.UID}",
                    this.GetRealEstateTextWithAntecedentAndCadastralKey(property, antecedent));

      return x;
    }

    private string GetRealEstateActTextOverPartition(RecordingAct recordingAct,
                                                     RealEstate property, int index) {
      const string overPartition =
          "{INDEX}.- <b style='text-transform:uppercase'>{RECORDING.ACT}</b> sobre la " +
          "fracción <b>{PARTITION.NUMBER}</b> del bien inmueble con folio real {PARTITION.OF}, misma a la " +
           "que se le asignó el folio real electrónico {PROPERTY.UID}.<br/>";

      const string overLot =
          "{INDEX}.- <b style='text-transform:uppercase'>{RECORDING.ACT}</b> sobre el " +
          "<b>{PARTITION.NUMBER}</b> de la lotificación con folio real {PARTITION.OF}, mismo al que " +
          "se le asignó el folio real electrónico {PROPERTY.UID}.<br/>";

      const string overApartment =
          "{INDEX}.- <b style='text-transform:uppercase'>{RECORDING.ACT}</b> sobre el " +
          "<b>{PARTITION.NUMBER}</b> del condominio con folio real {PARTITION.OF}, mismo a la que " +
          "se le asignó el folio real electrónico {PROPERTY.UID}.<br/>";

      const string overHouse =
          "{INDEX}.- <b style='text-transform:uppercase'>{RECORDING.ACT}</b> sobre la " +
          "<b>{PARTITION.NUMBER}</b> del fraccionamiento con folio real {PARTITION.OF}, misma a la que " +
          "se le asignó el folio real electrónico {PROPERTY.UID}.<br/>";

      Assertion.Assert(!property.IsPartitionOf.IsEmptyInstance, "Bad call. Property is not a partition.");

      string x = String.Empty;
      if (property.PartitionNo.StartsWith("Lote")) {
        x = overLot.Replace("{INDEX}", index.ToString());
        x = x.Replace("{PARTITION.NUMBER}", property.PartitionNo);
        if (recordingAct.RecordingActType.IsDomainActType) {
          x = x.Replace("sobre el", "del");
        }
      } else if (property.PartitionNo.StartsWith("Casa")) {
        x = overHouse.Replace("{INDEX}", index.ToString());
        x = x.Replace("{PARTITION.NUMBER}", property.PartitionNo);
        if (recordingAct.RecordingActType.IsDomainActType) {
          x = x.Replace("sobre la", "de la");
        }
      } else if (property.PartitionNo.StartsWith("Departamento")) {
        x = overApartment.Replace("{INDEX}", index.ToString());
        x = x.Replace("{PARTITION.NUMBER}", property.PartitionNo);
        if (recordingAct.RecordingActType.IsDomainActType) {
          x = x.Replace("sobre el", "del");
        }
      } else {
        x = overPartition.Replace("{INDEX}", index.ToString());
        x = x.Replace("{PARTITION.NUMBER}", property.PartitionNo);
      }

      var partitionAntecedent = property.IsPartitionOf.GetDomainAntecedent(recordingAct);

      x = x.Replace("{PARTITION.OF}", "<u>" + property.IsPartitionOf.UID + "</u>" +
                    (!partitionAntecedent.PhysicalRecording.IsEmptyInstance ?
                    " y antecedente de inscripción en " + partitionAntecedent.PhysicalRecording.AsText : String.Empty));
      return x;
    }

    private string GetRealEstateTextWithAntecedentAndCadastralKey(RealEstate property, RecordingAct antecedent) {
      string x = "<b>" + property.UID + "</b>";

      if (property.CadastralKey.Length != 0) {
        x += " (Clave catastral: <b>" + property.CadastralKey + "</b>)";
      }

      if (property.IsPartitionOf.IsEmptyInstance && antecedent.Equals(RecordingAct.Empty)) {
        x += " sin antecedente registral";
      } else if (!antecedent.PhysicalRecording.IsEmptyInstance) {
        x += ", con antecedente de inscripción en " + antecedent.PhysicalRecording.AsText;
      } else {
        // no-op
      }
      return x;
    }

    private string GetAssociationActText(RecordingAct recordingAct, Association association, int index) {
      const string incorporationActText =
            "{INDEX}.- <b style='text-transform:uppercase'>CONSTITUCIÓN</b> de " +
            "la {ASSOCIATION.KIND} denominada <b>{ASSOCIATION.NAME}</b>, " +
            "misma a la que se le asignó el folio único <b>{ASSOCIATION.UID}</b>.<br/>";

      const string overAssociationWithIncorporationActInDigitalRecording =
          "{INDEX}.- <b style='text-transform:uppercase'>{RECORDING.ACT}</b> de " +
          "la {ASSOCIATION.KIND} denominada <b>{ASSOCIATION.NAME}</b>, " +
          "con folio único <b>{ASSOCIATION.UID}</b>.<br/>";

      const string overAssociationWithIncorporationActInPhysicalRecording =
          "{INDEX}.- <b style='text-transform:uppercase'>{RECORDING.ACT}</b> de " +
          "la {ASSOCIATION.KIND} denominada <b>{ASSOCIATION.NAME}</b>, " +
          "con folio único <b>{ASSOCIATION.UID}</b> y " +
          "antecedente de inscripción en {ANTECEDENT}.<br/>";

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
        throw Assertion.AssertNoReachThisCode();

      }

      x = x.Replace("{ASSOCIATION.UID}", association.UID);
      x = x.Replace("{ASSOCIATION.NAME}", association.Name);
      x = x.Replace("{ASSOCIATION.KIND}", association.GetAssociationTypeName().ToLowerInvariant());

      return x;
    }
    #endregion Private methods

  } // class RecordingSeal

} // namespace Empiria.Land.WebApp
