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

    protected string GetDocumentText() {
      if (transaction.Document.Notes.Length > 100) {
        return "DESCRIPCIÓN:<br />" + transaction.Document.Notes + "<br /><br />";
      } else {
        return String.Empty;
      }
    }

    protected string GetRecordingsText() {
      const string docMultiTlax = "Registrado con el número de documento electrónico <b>{DOCUMENT}</b>, " +
                                   "con los siguientes {COUNT} actos jurídicos:<br/><br/>";
      const string docMultiZac = "Registrado bajo los siguientes {COUNT} actos jurídicos:<br/><br/>";

      const string docOneTlax = "Registrado con el número de documento electrónico <b>{DOCUMENT}</b>, con el " +
                                "siguiente acto jurídico:<br/><br/>";
      const string docOneZac = "Registrado bajo la siguiente inscripción:<br/><br/>";

      const string t1Tlax = "{INDEX}.- <b style='text-transform:uppercase'>{RECORDING.ACT}</b> sobre {PROPERTY.DESCRIPTION}." +
                            "<br/>";
      const string t1Zac = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Inscripción <b>{NUMBER}</b> del <b>{VOL}</b> <b>{SECTION}</b> del " +
                           "<b>Distrito Judicial de {DISTRICT}</b>.<br/>";

      string html = String.Empty;


      string docMulti = ExecutionServer.LicenseName == "Tlaxcala" ? docMultiTlax : docMultiZac;
      string docOne = ExecutionServer.LicenseName == "Tlaxcala" ? docOneTlax : docOneZac;

      if (this.recordingActs.Count > 1) {
        html = docMulti.Replace("{DOCUMENT}", transaction.Document.UID);
        html = html.Replace("{COUNT}", this.recordingActs.Count.ToString() +
                            " (" + EmpiriaString.SpeechInteger(this.recordingActs.Count).ToLower() + ")");
      } else if (this.recordingActs.Count == 1) {
        html = docOne.Replace("{DOCUMENT}", transaction.Document.UID);
      } else if (this.recordingActs.Count == 0) {
        throw new Exception("Document does not have recordings.");
      }

      int index = 0;
      foreach (RecordingAct recordingAct in recordingActs) {
        index++;
        string x = (ExecutionServer.LicenseName == "Tlaxcala" ? t1Tlax : t1Zac).Replace("{NUMBER}", recordingAct.Recording.Number);
        var recordingBook = recordingAct.Recording.RecordingBook;

        x = x.Replace("{INDEX}", index.ToString());
        x = x.Replace("{RECORDING.ACT}", recordingAct.RecordingActType.DisplayName);
        if (!recordingAct.RecordingActType.RecordingRule.AllowsPartitions) {
          x = x.Replace("{PROPERTY.DESCRIPTION}", "el predio con folio único {PROPERTY.UID}");
        } else if (recordingAct.TractIndex[0].Property.IsPartitionOf.IsEmptyInstance) {
          x = x.Replace("{PROPERTY.DESCRIPTION}", "la totalidad del predio con folio único {PROPERTY.UID}");
        } else {
          x = x.Replace("{PROPERTY.DESCRIPTION}",
              String.Format("la fracción<b>{0}</b> del predio <u>{1}</u>, misma que se le asignó el folio único {PROPERTY.UID}",
                            recordingAct.TractIndex[0].Property.PartitionNo,
                            recordingAct.TractIndex[0].Property.IsPartitionOf.UID));
        }

        var antecedent = recordingAct.TractIndex[0].Property.GetDomainAntecedent(recordingAct);
        if (!antecedent.Recording.IsEmptyInstance) {
          x = x.Replace("{PROPERTY.UID}", "<b>" + recordingAct.TractIndex[0].Property.UID + "</b>" +
                        ", con antecedente de inscripción en " + antecedent.Recording.AsText);
        } else {
          x = x.Replace("{PROPERTY.UID}", "<b>" + recordingAct.TractIndex[0].Property.UID + "</b>");
        }

        x = x.Replace("{VOL}", recordingBook.AsText);
        x = x.Replace("{SECTION}", recordingBook.RecordingSection.Name);
        x = x.Replace("{DISTRICT}", recordingBook.RecorderOffice.Alias);
        html += x;
      }
      return html;
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
