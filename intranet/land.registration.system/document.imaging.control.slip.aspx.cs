/* Empiria Land **********************************************************************************************
*                                                                                                            *
*  Solution  : Empiria Land                                     System   : Land Intranet Application         *
*  Namespace : Empiria.Land.WebApp                              Assembly : Empiria.Land.Intranet.dll         *
*  Type      : DocumentImagingControlSlip                       Pattern  : Explorer Web Page                 *
*  Version   : 3.0                                              License  : Please read license.txt file      *
*                                                                                                            *
*  Summary   : Prints a slip for document imaging control.                                                   *
*                                                                                                            *
********************************** Copyright(c) 2009-2017. La Vía Óntica SC, Ontica LLC and contributors.  **/
using System;

using Empiria.Land.Registration;
using Empiria.Land.Registration.Transactions;

namespace Empiria.Land.WebApp {

  public partial class DocumentImagingControlSlip : System.Web.UI.Page {

    #region Fields

    protected LRSTransaction transaction = null;
    protected RecordingDocument document = null;
    private FixedList<RecordingAct> recordingActs = null;

    #endregion Fields

    #region Constructors and parsers

    protected void Page_Load(object sender, EventArgs e) {
      Initialize();
    }

    #endregion Constructors and parsers

    #region Private methods

    private void Initialize() {
      document = RecordingDocument.Parse(int.Parse(Request.QueryString["id"]));
      recordingActs = document.RecordingActs;
      transaction = document.GetTransaction();
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

    protected string GetRecordingActsDescriptionText() {
      var temp = String.Empty;

      foreach (var recordingAct in this.recordingActs) {
        if (temp.Length != 0) {
          temp += "; ";
        }
        temp += recordingAct.DisplayName + " sobre " + recordingAct.Resource.UID;
      }
      return EmpiriaString.TrimIfLongThan(temp, 800);
    }

    protected string GetDocumentDescriptionText() {
      int maxLength = 3500 - GetRecordingActsDescriptionText().Length;

      return EmpiriaString.TrimIfLongThan(transaction.Document.Notes, maxLength);
    }

    #endregion Private methods

  } // class DocumentImagingControlSlip

} // namespace Empiria.Land.WebApp
