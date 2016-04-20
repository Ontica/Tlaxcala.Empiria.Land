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
    private FixedList<RecordingAct> recordingActs = null;

    #endregion Fields

    #region Constructors and parsers

    protected void Page_Load(object sender, EventArgs e) {
      Initialize();
    }

    #endregion Constructors and parsers

    #region Private methods

    private void Initialize() {
      transaction = LRSTransaction.Parse(int.Parse(Request.QueryString["transactionId"]));
      recordingActs = transaction.Document.RecordingActs;
      Assertion.Assert(recordingActs.Count > 0, "Document does not has recording acts.");
    }

    protected string CustomerOfficeName() {
      if (ExecutionServer.LicenseName == "Tlaxcala") {
        return "Dirección de Notarías y Registros Públicos";
      } else {
        return "Dirección de Catastro y Registro Público";
      }
    }

    protected string DistrictName {
      get {
        if (ExecutionServer.LicenseName == "Zacatecas") {
          return "Registro Público del Distrito de Zacatecas";
        }
        return String.Empty;
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
      const string t = "Documento presentado para su examen y registro el <b>{DATE} a las {TIME} horas</b>, " +
                       "bajo el número de trámite <b>{NUMBER}</b>, y para el cual se {COUNT}";

      DateTime presentationTime = transaction.LastReentryTime == ExecutionServer.DateMaxValue ?
                                          transaction.PresentationTime : transaction.LastReentryTime;

      string x = t.Replace("{DATE}", presentationTime.ToString(@"dd \de MMMM \de yyyy"));
      x = x.Replace("{TIME}", presentationTime.ToString("HH:mm:ss"));
      x = x.Replace("{NUMBER}", transaction.UID);
      if (this.recordingActs.Count > 1) {
        x = x.Replace("{COUNT}", "registraron los siguientes " + this.recordingActs.Count.ToString() +
                      " (" + EmpiriaString.SpeechInteger(this.recordingActs.Count).ToLower() + ") " +
                      "actos jurídicos:");
      } else if (this.recordingActs.Count == 1) {
        x = x.Replace("{COUNT}", "registró el siguiente acto jurídico:");
      } else {

      }
      return x;
    }

    protected string GetDocumentDescriptionText() {
      if (transaction.Document.Notes.Length > 30) {
        return "DESCRIPCIÓN:<br />" + transaction.Document.Notes + "<br /><br />";
      } else {
        return String.Empty;
      }
    }

    protected string GetRecordingActsText() {
      string html = String.Empty;

      int index = 0;
      foreach (RecordingAct recordingAct in recordingActs) {
        index++;

        if (recordingAct.RecordingActType.IsAmendmentActType) {
          html += this.GetAmendmentActText(recordingAct, index);
          continue;
        }

        switch (recordingAct.RecordingActType.RecordingRule.AppliesTo) {
          case RecordingRuleApplication.RealEstate:
          case RecordingRuleApplication.RecordingAct:
          case RecordingRuleApplication.Structure:
            Resource resource = recordingAct.TractIndex[0].Resource;
            Assertion.Assert(resource is RealEstate,
                             "Type mistmatch parsing real estate with id {0}", resource.Id);
            html += this.GetPropertyActText(recordingAct, (RealEstate) resource, index);
            break;
          case RecordingRuleApplication.Association:
            resource = recordingAct.TractIndex[0].Resource;
            Assertion.Assert(resource is Association,
                             "Type mistmatch parsing association with id {0}", resource.Id);
            html += this.GetAssociationActText(recordingAct,
                                              (Association) resource, index);
            break;
          case RecordingRuleApplication.NoProperty:
            html += this.GetDocumentActText(recordingAct, index);
            break;
          default:
            throw new NotImplementedException("Undefined rule for recording acts text.");
        }
      }
      return html;
    }

    private string GetAmendmentActText(RecordingAct recordingAct, int index) {
      const string template = "{INDEX}.- <b style='text-transform:uppercase'>{AMENDMENT.ACT}" +
                              "{AMENDMENT.ACT.RECORDING}, {RESOURCE.DATA}.<br/>";

      string x = template.Replace("{INDEX}", index.ToString());

      RecordingAct amendmentOf = recordingAct.AmendmentOf;
      if (!recordingAct.RecordingActType.RecordingRule.UseDynamicActNaming) {
        x = x.Replace("{AMENDMENT.ACT}", recordingAct.DisplayName + "</b>");
      } else {
        if (recordingAct.RecordingActType.IsCancelationActType) {
          x = x.Replace("{AMENDMENT.ACT}", "CANCELACIÓN {AMENDMENT.ACT}");
        } else if (recordingAct.RecordingActType.IsModificationActType) {
          if (recordingAct.RecordingActType.Id != 2702) {
            x = x.Replace("{AMENDMENT.ACT}", "MODIFICACIÓN {AMENDMENT.ACT}");
          } else {
            x = x.Replace("{AMENDMENT.ACT}", "REVERSIÓN DE PROPIEDAD {AMENDMENT.ACT}");
          }

        }
        if (amendmentOf.RecordingActType.FemaleGenre) {
          x = x.Replace("{AMENDMENT.ACT}", "DE LA " + amendmentOf.RecordingActType.DisplayName + "</b> inscrita");
        } else {
          x = x.Replace("{AMENDMENT.ACT}", "DEL " + amendmentOf.RecordingActType.DisplayName + "</b> inscrito");
        }
      }
      if (amendmentOf.IsEmptyInstance) {
        x = x.Replace("{AMENDMENT.ACT.RECORDING}", String.Empty);
      } else if (amendmentOf.PhysicalRecording.IsEmptyInstance) {
        x = x.Replace("{AMENDMENT.ACT.RECORDING}", " bajo el documento " +
                      "<b>" + amendmentOf.Document.UID + "</b>");
      } else {
        x = x.Replace("{AMENDMENT.ACT.RECORDING}", " en la " +
                      amendmentOf.PhysicalRecording.AsText);
      }

      Resource resource = recordingAct.TractIndex[0].Resource;
      if (resource is RealEstate) {
        var antecedent = ((RealEstate) resource).GetDomainAntecedent(recordingAct);

        x = x.Replace("{RESOURCE.DATA}", "sobre el bien inmueble con folio real electrónico " +
                      GetRealEstateText((RealEstate) resource, antecedent));
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

    private string GetDocumentActText(RecordingAct recordingAct, int index) {
      const string act00 = "{INDEX}.- <b style='text-transform:uppercase'>{RECORDING.ACT}</b><br/>";

      string x = act00.Replace("{INDEX}", index.ToString());

      return x.Replace("{RECORDING.ACT}", recordingAct.DisplayName);
    }

    private string GetPropertyActText(RecordingAct recordingAct, RealEstate property, int index) {
      const string act01 = "{INDEX}.- <b style='text-transform:uppercase'>{RECORDING.ACT}</b> sobre el " +
                           "bien inmueble con folio real electrónico {PROPERTY.UID}.<br/>";
      const string act02 = "{INDEX}.- <b style='text-transform:uppercase'>{RECORDING.ACT}</b> sobre la " +
                           "totalidad del bien inmueble con folio real electrónico {PROPERTY.UID}.<br/>";
      const string act03a = "{INDEX}.- <b style='text-transform:uppercase'>{RECORDING.ACT}</b> sobre la " +
                            "fracción <b>{PARTITION.NUMBER}</b> del bien inmueble con folio real {PARTITION.OF}, misma a la " +
                            "que se le asignó el folio real electrónico {PROPERTY.UID}.<br/>";
      const string act03Lot = "{INDEX}.- <b style='text-transform:uppercase'>{RECORDING.ACT}</b> sobre el " +
                            "<b>{PARTITION.NUMBER}</b> de la lotificación con folio real {PARTITION.OF}, mismo al que " +
                            "se le asignó el folio real electrónico {PROPERTY.UID}.<br/>";
      const string act03Apartment = "{INDEX}.- <b style='text-transform:uppercase'>{RECORDING.ACT}</b> sobre el " +
                            "<b>{PARTITION.NUMBER}</b> del condominio con folio real {PARTITION.OF}, mismo a la que " +
                            "se le asignó el folio real electrónico {PROPERTY.UID}.<br/>";
      const string act03House = "{INDEX}.- <b style='text-transform:uppercase'>{RECORDING.ACT}</b> sobre la " +
                            "<b>{PARTITION.NUMBER}</b> del fraccionamiento con folio real {PARTITION.OF}, misma a la que " +
                            "se le asignó el folio real electrónico {PROPERTY.UID}.<br/>";

      string x = String.Empty;

      if (!recordingAct.RecordingActType.RecordingRule.AllowsPartitions) {
        x = act01.Replace("{INDEX}", index.ToString());
      } else if (property.IsPartitionOf.IsEmptyInstance) {
        x = act02.Replace("{INDEX}", index.ToString());
      } else {
        var partitionAntecedent = property.IsPartitionOf.GetDomainAntecedent(recordingAct);

        //var isLotification = (ante.RecordingActType.Id == 2374) || (partitionAntecedent.RecordingActType.Id == 2374);
        //isLotification = ;
        if (property.PartitionNo.StartsWith("Lote")) {
          x = act03Lot.Replace("{INDEX}", index.ToString());
          x = x.Replace("{PARTITION.NUMBER}", property.PartitionNo);
          if (recordingAct.RecordingActType.IsDomainActType) {
            x = x.Replace("sobre el", "del");
          }
        } else if (property.PartitionNo.StartsWith("Casa")) {
          x = act03House.Replace("{INDEX}", index.ToString());
          x = x.Replace("{PARTITION.NUMBER}", property.PartitionNo);
          if (recordingAct.RecordingActType.IsDomainActType) {
            x = x.Replace("sobre la", "de la");
          }
        } else if (property.PartitionNo.StartsWith("Departamento")) {
          x = act03Apartment.Replace("{INDEX}", index.ToString());
          x = x.Replace("{PARTITION.NUMBER}", property.PartitionNo);
          if (recordingAct.RecordingActType.IsDomainActType) {
            x = x.Replace("sobre el", "del");
          }
        } else {
          x = act03a.Replace("{INDEX}", index.ToString());
          x = x.Replace("{PARTITION.NUMBER}", property.PartitionNo +
                       (property.IsPartitionOf.MergedInto.Equals(property) ? " y última" : String.Empty));
          x = x.Replace("fracción <b>Fracción", "<b>Fracción");
        }
        x = x.Replace("{PARTITION.OF}", "<u>" + property.IsPartitionOf.UID + "</u>" +
                      (!partitionAntecedent.PhysicalRecording.IsEmptyInstance ?
                      " y antecedente de inscripción en " + partitionAntecedent.PhysicalRecording.AsText : String.Empty));
      }
      x = x.Replace("{RECORDING.ACT}", recordingAct.RecordingActType.DisplayName);

      var antecedent = property.GetDomainAntecedent(recordingAct);

      x = x.Replace("{PROPERTY.UID}", GetRealEstateText(property, antecedent));

      return x;
    }

    private string GetRealEstateText(RealEstate property, RecordingAct antecedent) {
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
      const string actSC0 = "{INDEX}.- <b style='text-transform:uppercase'>CONSTITUCIÓN</b> de la {ASSOCIATION.KIND} " +
                            "denominada <b>{ASSOCIATION.NAME}</b>, misma a la que se le asignó el folio único <b>{ASSOCIATION.UID}</b>.<br/>";
      const string actSC1 = "{INDEX}.- <b style='text-transform:uppercase'>{RECORDING.ACT}</b> de " +
                            "la {ASSOCIATION.KIND} denominada <b>{ASSOCIATION.NAME}</b>, con folio único <b>{ASSOCIATION.UID}</b>.<br/>";
      const string actSC2 = "{INDEX}.- <b style='text-transform:uppercase'>{RECORDING.ACT}</b> de " +
                            "la {ASSOCIATION.KIND} denominada <b>{ASSOCIATION.NAME}</b>, con folio único <b>{ASSOCIATION.UID}</b> y " +
                            "antecedente de inscripción en {ANTECEDENT}.<br/>";

      RecordingAct incorporationAct = association.GetIncorporationAct();

      string x = String.Empty;
      if (recordingAct.Equals(incorporationAct)) {
        x = actSC0.Replace("{INDEX}", index.ToString());

      } else if (incorporationAct.PhysicalRecording.IsEmptyInstance) {
        x = actSC1.Replace("{INDEX}", index.ToString());
        x = x.Replace("{RECORDING.ACT}", recordingAct.DisplayName);

      } else if (!incorporationAct.PhysicalRecording.IsEmptyInstance) {
        x = actSC2.Replace("{INDEX}", index.ToString());
        x = x.Replace("{RECORDING.ACT}", recordingAct.DisplayName);
        x = x.Replace("{ANTECEDENT}", incorporationAct.PhysicalRecording.AsText);
      }

      x = x.Replace("{ASSOCIATION.UID}", association.UID);
      x = x.Replace("{ASSOCIATION.NAME}", association.Name);
      x = x.Replace("{ASSOCIATION.KIND}", association.GetAssociationTypeName());

      return x;
    }

    protected string GetRecordingOfficialsNames() {
      string temp = String.Empty;
      foreach (Contact official in this.GetRecordingOfficials()) {
        if (temp.Length != 0) {
          temp += ", ";
        }
        temp += official.FullName;
      }
      return temp;
    }

    protected string GetRecordingOfficialsPositions() {
      int officialsCount = this.GetRecordingOfficials().Count;

      if (officialsCount > 1) {
        return "Responsables del registro";
      } else if (officialsCount == 1) {
        return "Responsable del registro";
      } else {
        return String.Empty;
      }
    }

    protected string GetRecordingOfficialsInitials() {
      string temp = String.Empty;
      foreach (Contact official in this.GetRecordingOfficials()) {
        if (temp.Length != 0) {
          temp += " ";
        }
        temp += official.Nickname;
      }
      return temp.Length != 0 ? "* " + temp : String.Empty;
    }

    protected List<Contact> GetRecordingOfficials() {
      var recordingOfficials = new List<Contact>();

      string temp = String.Empty;

      for (int i = 0; i < recordingActs.Count; i++) {
        if (!recordingOfficials.Contains(recordingActs[i].RegisteredBy)) {
          recordingOfficials.Add(recordingActs[i].RegisteredBy);
        }
      }
      return recordingOfficials;
    }

    protected string GetRecordingPlaceAndDate() {
      const string t = "Registrado en {CITY}, a las {TIME} horas del {DATE}. Doy Fe.";

      string x = t.Replace("{DATE}", transaction.Document.AuthorizationTime.ToString(@"dd \de MMMM \de yyyy"));
      x = x.Replace("{TIME}", transaction.Document.AuthorizationTime.ToString(@"HH:mm"));
      if (ExecutionServer.LicenseName == "Tlaxcala") {
        x = x.Replace("{CITY}", "Tlaxcala de Xicohténcatl, Tlaxcala");
      } else {
        x = x.Replace("{CITY}", "Zacatecas, Zacatecas");
      }
      return x;
    }

    protected string GetRecordingSignerPosition() {
      if (ExecutionServer.LicenseName == "Tlaxcala") {
        return "Director de Notarías y Registros Públicos";
      } else {
        return "C. Oficial Registrador del Distrito Judicial de Zacatecas";
      }
    }

    protected string GetRecordingSignerName() {
      if (ExecutionServer.LicenseName == "Tlaxcala") {
        return "Mtro. Sergio Cuauhtémoc Lima López";
      } else {
        return "Lic. Teresa de Jesús Alvarado Ortiz";
      }
    }

    protected string GetDigitalSeal() {
      string s = "||" + transaction.UID + "|" + transaction.Document.UID;
      for (int i = 0; i < recordingActs.Count; i++) {
        s += "|" + recordingActs[i].Id.ToString();
      }
      s += "||";
      return Empiria.Security.Cryptographer.CreateDigitalSign(s);
    }

    protected string GetDigitalSignature() {
      string s = "||" + transaction.UID + "|" + transaction.Document.UID;
      for (int i = 0; i < recordingActs.Count; i++) {
        s += "|" + recordingActs[i].Id.ToString();
      }
      return Empiria.Security.Cryptographer.CreateDigitalSign(s + "eSign");
    }

    #endregion Private methods

  } // class RecordingSeal

} // namespace Empiria.Land.WebApp
