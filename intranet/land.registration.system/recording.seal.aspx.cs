/* Empiria Land **********************************************************************************************
*																																																						 *
*	 Solution  : Empiria Land                                     System   : Land Intranet Application         *
*	 Namespace : Empiria.Web.UI                                   Assembly : Empiria.Land.Intranet.dll         *
*	 Type      : ObjectSearcher                                   Pattern  : Explorer Web Page                 *
*  Version   : 2.0                                              License  : Please read license.txt file      *
*																																																						 *
*  Summary   : Gets user credentials and redirects users to the workplace start page.                        *
*																																																						 *
********************************** Copyright(c) 2009-2015. La Vía Óntica SC, Ontica LLC and contributors.  **/
using System;
using System.Collections.Generic;

using Empiria.Contacts;
using Empiria.Land.Registration;
using Empiria.Land.Registration.Transactions;

namespace Empiria.Web.UI.FSM {

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

    protected bool ShowAllRecordings {
      get {
        return (int.Parse(Request.QueryString["id"]) == -1);
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
      const string t = "Presentado para su examen y registro en	{CITY}, el <b>{DATE} a las {TIME} horas</b>, " +
                       "bajo el número de trámite <b>{NUMBER}</b> - Conste";

      DateTime presentationTime = transaction.LastReentryTime == ExecutionServer.DateMaxValue ?
                                          transaction.PresentationTime : transaction.LastReentryTime;

      string x = t.Replace("{DATE}", presentationTime.ToString(@"dd \de MMMM \de yyyy"));
      x = x.Replace("{TIME}", presentationTime.ToString("HH:mm:ss"));
      x = x.Replace("{NUMBER}", transaction.UID);
      if (ExecutionServer.LicenseName == "Tlaxcala") {
        x = x.Replace("{CITY}", "Tlaxcala de Xicohténcatl, Tlaxcala");
      } else {
        x = x.Replace("{CITY}", "Zacatecas, Zacatecas");
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

    protected string GetDocumentHeaderText() {
      const string docMultiTlax = "Registrado con el número de documento electrónico <b>{DOCUMENT}</b>, " +
                                  "con los siguientes {COUNT} actos jurídicos:<br/><br/>";
      const string docOneTlax = "Registrado con el número de documento electrónico <b>{DOCUMENT}</b>, con el " +
                                "siguiente acto jurídico:<br/><br/>";
      string html = String.Empty;
      if (this.recordingActs.Count > 1) {
        html = docMultiTlax.Replace("{DOCUMENT}", transaction.Document.UID);
        html = html.Replace("{COUNT}", this.recordingActs.Count.ToString() +
                            " (" + EmpiriaString.SpeechInteger(this.recordingActs.Count).ToLower() + ")");
      } else if (this.recordingActs.Count == 1) {
        html = docOneTlax.Replace("{DOCUMENT}", transaction.Document.UID);
      } else if (this.recordingActs.Count == 0) {
        throw new Exception("Document doesn't have recordings.");
      }
      return html;
    }

    protected string GetRecordingActsText() {
      string html = String.Empty;

      int index = 0;
      foreach (RecordingAct recordingAct in recordingActs) {
        index++;

        switch (recordingAct.RecordingActType.RecordingRule.AppliesTo) {
          case RecordingRuleApplication.Property:
          case RecordingRuleApplication.RecordingAct:
          case RecordingRuleApplication.Structure:
            Resource resource = ((ResourceTarget) recordingAct.Targets[0]).Resource;
            Assertion.Assert(resource is Property,
                             "Type mistmatch parsing property with id = " + resource.Id);
            html += this.GetPropertyActText(recordingAct, (Property) resource, index);
            break;
          case RecordingRuleApplication.Association:
            resource = ((ResourceTarget) recordingAct.Targets[0]).Resource;
            Assertion.Assert(resource is Association,
                             "Type mistmatch parsing resource with id = " + resource.Id);
            html += this.GetAssociationActText(recordingAct,
                                              (Association) resource, index);
            break;
          case RecordingRuleApplication.Document:
            html += this.GetDocumentActText(recordingAct, index);
            break;
          default:
            throw new NotImplementedException("Undefined rule for recording acts text.");
        }
      }
      return html;
    }

    private string GetDocumentActText(RecordingAct recordingAct, int index) {
      const string act00 = "{INDEX}.- <b style='text-transform:uppercase'>{RECORDING.ACT}</b><br/>";

      string x = act00.Replace("{INDEX}", index.ToString());

      return x.Replace("{RECORDING.ACT}", recordingAct.DisplayName);
    }

    private string GetPropertyActText(RecordingAct recordingAct, Property property, int index) {
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
      const string act04 = "{INDEX}.- {CANCELATION.ACT} {CANCELED.ACT.RECORDING}, " +
                           "sobre el bien inmueble con folio real electrónico {PROPERTY.UID}.<br/>";

      string x = String.Empty;

      if (recordingAct.RecordingActType.RecordingRule.IsModification ||
          recordingAct.RecordingActType.RecordingRule.IsCancelation) {
        RecordingAct amendmentOf = recordingAct.AmendmentOf;

        x = act04.Replace("{INDEX}", index.ToString());

        if (recordingAct.RecordingActType.RecordingRule.IsModification && amendmentOf.RecordingActType.FemaleGenre) {
          x = x.Replace("{CANCELATION.ACT}", "<b style='text-transform:uppercase'>MODIFICACIÓN DE LA " +
                        amendmentOf.RecordingActType.DisplayName + "</b> registrada");
        } else if (recordingAct.RecordingActType.RecordingRule.IsModification && !amendmentOf.RecordingActType.FemaleGenre) {
          x = x.Replace("{CANCELATION.ACT}", "<b style='text-transform:uppercase'>MODIFICACIÓN DEL " +
                        amendmentOf.RecordingActType.DisplayName + "</b> registrado");
        } else if (recordingAct.RecordingActType.RecordingRule.IsCancelation && amendmentOf.RecordingActType.FemaleGenre) {
          x = x.Replace("{CANCELATION.ACT}", "<b style='text-transform:uppercase'>CANCELACIÓN DE LA " +
                        amendmentOf.RecordingActType.DisplayName + "</b> registrada");
        } else {
          x = x.Replace("{CANCELATION.ACT}", "<b style='text-transform:uppercase'>CANCELACIÓN DEL " +
                        amendmentOf.RecordingActType.DisplayName + "</b> registrado");
        }
        if (recordingAct.AmendmentOf.PhysicalRecording.IsEmptyInstance) {
          x = x.Replace("{CANCELED.ACT.RECORDING}", " bajo el documento " +
                        "<b>" + recordingAct.AmendmentOf.Document.UID + "</b>");
        } else {
          x = x.Replace("{CANCELED.ACT.RECORDING}", " en la " +
                        recordingAct.AmendmentOf.PhysicalRecording.AsText);
        }
      } else if (!recordingAct.RecordingActType.RecordingRule.AllowsPartitions) {
        x = act01.Replace("{INDEX}", index.ToString());
      } else if (property.IsPartitionOf.IsEmptyInstance) {
        x = act02.Replace("{INDEX}", index.ToString());
      } else {
        var partitionAntecedent = property.IsPartitionOf.GetDomainAntecedent(recordingAct);
        var ante = property.IsPartitionOf.GetAntecedent(recordingAct);
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
        }
        x = x.Replace("{PARTITION.OF}", "<u>" + property.IsPartitionOf.UID + "</u>" +
                      (!partitionAntecedent.PhysicalRecording.IsEmptyInstance ?
                      " y antecedente de inscripción en " + partitionAntecedent.PhysicalRecording.AsText : String.Empty));
      }
      x = x.Replace("{RECORDING.ACT}", recordingAct.RecordingActType.DisplayName);

      var antecedent = property.GetDomainAntecedent(recordingAct);
      if (property.IsPartitionOf.IsEmptyInstance && antecedent.Equals(RecordingAct.Empty)) {
        if (property.CadastralKey.Length != 0) {
          x = x.Replace("{PROPERTY.UID}", "<b>" + property.UID + "</b> (Clave catastral: <b>" +
                                          property.CadastralKey + "</b>) sin antecedente registral");
        } else {
          x = x.Replace("{PROPERTY.UID}", "<b>" + property.UID + "</b> sin antecedente registral");
        }
      } else if (!antecedent.PhysicalRecording.IsEmptyInstance) {
        if (property.CadastralKey.Length != 0) {
          x = x.Replace("{PROPERTY.UID}", "<b>" + property.UID + "</b> (Clave catastral: <b>" +
                        property.CadastralKey + "</b>), con antecedente de inscripción en " +
                        antecedent.PhysicalRecording.AsText);
        } else {
          x = x.Replace("{PROPERTY.UID}", "<b>" + property.UID + "</b>" +
                        ", con antecedente de inscripción en " + antecedent.PhysicalRecording.AsText);
        }
      } else {
        if (property.CadastralKey.Length != 0) {
          x = x.Replace("{PROPERTY.UID}", "<b>" + property.UID + "</b>(Clave catastral: " +
                        "<b>" + property.CadastralKey + "</b>)");
        } else {
          x = x.Replace("{PROPERTY.UID}", "<b>" + property.UID + "</b>");
        }
      }
      return x;
    }

    private string GetAssociationActText(RecordingAct recordingAct, Association association, int index) {
      const string actSC0 = "{INDEX}.- <b style='text-transform:uppercase'>CONSTITUCIÓN</b> de la {PROPERTY.KIND} " +
                            "denominada <b>{ASSOCIATION.NAME}</b>, misma a la que se le asignó el folio único <b>{PROPERTY.UID}</b>.<br/>";
      const string actSC1 = "{INDEX}.- <b style='text-transform:uppercase'>{RECORDING.ACT}</b> de " +
                            "la {PROPERTY.KIND} denominada <b>{ASSOCIATION.NAME}</b>, con folio único <b>{PROPERTY.UID}</b>.<br/>";
      const string actSC2 = "{INDEX}.- <b style='text-transform:uppercase'>{RECORDING.ACT}</b> de " +
                            "la {PROPERTY.KIND} denominada <b>{ASSOCIATION.NAME}</b>, con folio único <b>{PROPERTY.UID}</b> y " +
                            "antecedente de inscripción en {ANTECEDENT}.<br/>";

      var antecedent = association.GetDomainAntecedent(recordingAct);
      string x = String.Empty;
      if (antecedent.Equals(RecordingAct.Empty)) {
        x = actSC0.Replace("{INDEX}", index.ToString());
      } else if (antecedent.PhysicalRecording.IsEmptyInstance) {
        x = actSC1.Replace("{INDEX}", index.ToString());
        x = x.Replace("{RECORDING.ACT}", recordingAct.DisplayName);
      } else {
        x = actSC2.Replace("{INDEX}", index.ToString());
        x = x.Replace("{RECORDING.ACT}", recordingAct.DisplayName);
        x = x.Replace("{ANTECEDENT}", antecedent.PhysicalRecording.AsText);
      }
      x = x.Replace("{PROPERTY.UID}", association.UID);
      x = x.Replace("{ASSOCIATION.NAME}", association.Name);
      x = x.Replace("{PROPERTY.KIND}", GetAssociationType(association));

      return x;
    }

    private string GetAssociationType(Association association) {
      if (association.Name.EndsWith("S.C.") || association.Name.EndsWith("SC")) {
        return "sociedad civil";
      } else if (association.Name.EndsWith("A.C.") || association.Name.EndsWith("AC")) {
        return "asociación civil";
      } else if (association.Name.EndsWith("A.R.") || association.Name.EndsWith("AR")) {
        return "asociación religiosa";
      } else {
        return "sociedad";
      }
    }

    protected string GetRecordingsTextZac() {
      //const string docMultiZac = "Registrado bajo los siguientes {COUNT} actos jurídicos:<br/><br/>";
      //const string docOneZac = "Registrado bajo la siguiente inscripción:<br/><br/>";

      //const string t1Zac = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Inscripción <b>{NUMBER}</b> del <b>{VOL}</b> <b>{SECTION}</b> del " +
      //               "<b>Distrito Judicial de {DISTRICT}</b>.<br/>";

      return String.Empty;
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
        return "Lic. Sergio Cuauhtémoc Lima López";
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

    protected string GetUpperMarginPoints() {
      decimal centimeters = 5.0m;
      if (ExecutionServer.LicenseName == "Tlaxcala") {
        return (28.3464657m).ToString("G4");
      } else {
        return (centimeters * 28.3464657m).ToString("G4");
      }
    }

    protected string GetLeftMargin() {
      if (ExecutionServer.LicenseName == "Tlaxcala") {
        return "padding-left:1.7cm;padding-right:1cm";
      } else {
        return String.Empty;
      }
    }

    #endregion Private methods

  } // class RecordingSeal

} // namespace Empiria.Web.UI.FSM
