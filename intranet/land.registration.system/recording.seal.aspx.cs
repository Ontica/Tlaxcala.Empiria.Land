/* Empiria® Land 2015 ****************************************************************************************
*																																																						 *
*	 Solution  : Empiria® Land                                    System   : Land Intranet Application         *
*	 Namespace : Empiria.Web.UI                                   Assembly : Empiria.Land.Intranet.dll         *
*	 Type      : ObjectSearcher                                   Pattern  : Explorer Web Page                 *
*	 Date      : 04/Jan/2015                                      Version  : 2.0  License: LICENSE.TXT file    *
*																																																						 *
*  Summary   : Gets user credentials and redirects users to the workplace start page.                        *
*																																																						 *
**************************************************** Copyright © La Vía Óntica SC + Ontica LLC. 2009-2015. **/
using System;

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
      if (transaction.Document.Notes.Length > 100) {
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
      const string act00 = "{INDEX}.- <b style='text-transform:uppercase'>{RECORDING.ACT}</b> sobre un " +
                           "testamento no inscrito.<br/>";
      const string act01 = "{INDEX}.- <b style='text-transform:uppercase'>{RECORDING.ACT}</b> sobre el " +
                           "predio con folio único {PROPERTY.UID}.<br/>";
      const string act02 = "{INDEX}.- <b style='text-transform:uppercase'>{RECORDING.ACT}</b> sobre la " +
                           "totalidad del predio con folio único {PROPERTY.UID}.<br/>";
      const string act03a = "{INDEX}.- <b style='text-transform:uppercase'>{RECORDING.ACT}</b> sobre la fracción " +
                           "<b>{PARTITION.NUMBER}</b> del predio {PARTITION.OF}, misma a la " +
                           "que se le asignó el folio único {PROPERTY.UID}.<br/>";
      const string act03b = "{INDEX}.- <b style='text-transform:uppercase'>{RECORDING.ACT}</b> sobre el lote " +
                           "<b>{PARTITION.NUMBER}</b> del predio {PARTITION.OF}, mismo al que " +
                           "se le asignó el folio único {PROPERTY.UID}.<br/>";
      const string act04 = "{INDEX}.- <b style='text-transform:uppercase'>{CANCELATION.ACT}</b> registrado en " +
                           "{CANCELED.ACT.RECORDING}, sobre el predio con folio único {PROPERTY.UID}.<br/>";
      string html = String.Empty;

      int index = 0;
      foreach (RecordingAct recordingAct in recordingActs) {
        index++;

        string x = String.Empty;

        var property = recordingAct.TractIndex[0].Property;

        if (recordingAct.RecordingActType.Id == 2752) {
          x = act00.Replace("{INDEX}", index.ToString());

        } else if (recordingAct.RecordingActType.RecordingRule.IsCancelation) {
          RecordingAct amendmentOf = recordingAct.AmendmentOf;

          x = act04.Replace("{INDEX}", index.ToString());
          x = x.Replace("{CANCELATION.ACT}", "CANCELACIÓN " +
                        (amendmentOf.RecordingActType.FemaleGenre ? " DE LA " : " DEL ") +
                         amendmentOf.RecordingActType.DisplayName);
          if (recordingAct.AmendmentOf.PhysicalRecording.IsEmptyInstance) {
            x = x.Replace("{CANCELED.ACT.RECORDING}", " el documento electrónico " +
                          "<b>" + recordingAct.AmendmentOf.Document.UID + "</b>");
          } else {
            x = x.Replace("{CANCELED.ACT.RECORDING}", " la " +
                          recordingAct.AmendmentOf.PhysicalRecording.AsText);
          }
        } else if (!recordingAct.RecordingActType.RecordingRule.AllowsPartitions) {
          x = act01.Replace("{INDEX}", index.ToString());
        } else if (property.IsPartitionOf.IsEmptyInstance) {
          x = act02.Replace("{INDEX}", index.ToString());
        } else {
          var partitionAntecedent = property.IsPartitionOf.GetDomainAntecedent(recordingAct);
          var ante = property.IsPartitionOf.GetAntecedent(recordingAct);
          var isLotification = (ante.RecordingActType.Id == 2374) || (partitionAntecedent.RecordingActType.Id == 2374);
          if (isLotification) {
            x = act03b.Replace("{INDEX}", index.ToString());
            x = x.Replace("{PARTITION.NUMBER}", property.PartitionNo);
          } else {
            x = act03a.Replace("{INDEX}", index.ToString());
            x = x.Replace("{PARTITION.NUMBER}", property.PartitionNo +
                         (property.IsPartitionOf.MergedInto.Equals(property) ? " y última" : String.Empty));
          }
          x = x.Replace("{PARTITION.OF}", "<u>" + property.IsPartitionOf.UID + "</u>" +
                        (!partitionAntecedent.PhysicalRecording.IsEmptyInstance ?
                        " con antecedente de inscripción en " + partitionAntecedent.PhysicalRecording.AsText : String.Empty));
        }
        x = x.Replace("{RECORDING.ACT}", recordingAct.RecordingActType.DisplayName);

        var antecedent = property.GetDomainAntecedent(recordingAct);
        if (property.IsPartitionOf.IsEmptyInstance && antecedent.Equals(InformationAct.Empty)) {
          x = x.Replace("{PROPERTY.UID}", "<b>" + property.UID + "</b> sin antecedente registral");
        } else if (!antecedent.PhysicalRecording.IsEmptyInstance) {
          x = x.Replace("{PROPERTY.UID}", "<b>" + property.UID + "</b>" +
                        ", con antecedente de inscripción en " + antecedent.PhysicalRecording.AsText);
        } else {
          x = x.Replace("{PROPERTY.UID}", "<b>" + property.UID + "</b>");
        }
        html += x;
      }
      return html;
    }

    protected string GetRecordingsTextZac() {
      //const string docMultiZac = "Registrado bajo los siguientes {COUNT} actos jurídicos:<br/><br/>";
      //const string docOneZac = "Registrado bajo la siguiente inscripción:<br/><br/>";

      //const string t1Zac = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Inscripción <b>{NUMBER}</b> del <b>{VOL}</b> <b>{SECTION}</b> del " +
      //               "<b>Distrito Judicial de {DISTRICT}</b>.<br/>";

      return String.Empty;
    }

    protected string GetRecordingOfficialsInitials() {
      string temp = String.Empty;

      for (int i = 0; i < recordingActs.Count; i++) {
        string initials = recordingActs[i].RegisteredBy.Nickname;
        if (initials.Length == 0) {
          continue;
        }
        if (!temp.Contains(initials)) {
          temp += initials + " ";
        }
      }
      temp = temp.Trim().ToLowerInvariant();
      return temp.Length != 0 ? "* " + temp : String.Empty;
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
