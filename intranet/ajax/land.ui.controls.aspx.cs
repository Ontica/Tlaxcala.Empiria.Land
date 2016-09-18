/* Empiria Land *********************************************************************************************
*                                                                                                           *
* Solution  : Empiria Land                                     System   : Land Intranet Application         *
* Namespace : Empiria.Web.UI.Ajax                              Assembly : Empiria.Land.Intranet.dll         *
* Type      : LandRegistrationSystemData                       Pattern  : Ajax Services Web Page            *
* Version   : 2.1                                              License  : Please read license.txt file      *
* 																																																					*
* Summary   : Gets Empiria control contents through Ajax invocation.                                        *
*																																																						*
********************************** Copyright(c) 2009-2016. La Vía Óntica SC, Ontica LLC and contributors.  **/
using System;

using Empiria.Land.Registration;
using Empiria.Land.Registration.Transactions;
using Empiria.Land.UI;
using Empiria.Presentation.Web;

namespace Empiria.Web.UI.Ajax {

  public partial class LandUserInterfaceControls : AjaxWebPage {

    protected override string ImplementsCommandRequest(string commandName) {
      switch (commandName) {

        case "getResourceHistoryGridCmd":
          return GetResourceHistoryGrid();

        case "getDocumentRecordingActsGridCmd":
          return GetDocumentRecordingActsGrid();

        case "getPhysicalRecordingsWithRecordingActsGridCmd":
          return GetPhysicalRecordingsWithRecordingActsGrid();

        case "getPartyRecordingActsGridCmd":
          return GetPartyRecordingActsGrid();

        case "getTransactionDocumentAndCertificatesGridCmd":
          return GetTransactionDocumentAndCertificatesGrid();

        default:
          throw new WebPresentationException(WebPresentationException.Msg.UnrecognizedCommandName,
                                             commandName);
      }
    }

    #region Private command handlers

    private string GetDocumentRecordingActsGrid() {
      int documentId = GetCommandParameter<int>("documentId");

      var document = RecordingDocument.Parse(documentId);

      return DocumentRecordingActsGrid.Parse(document);
    }

    private string GetPartyRecordingActsGrid() {
      int partyId = GetCommandParameter<int>("partyId");

      var party = Party.Parse(partyId);

      return PartyRecordingActsGrid.Parse(party);
    }

    private string GetPhysicalRecordingsWithRecordingActsGrid() {
      int recordingBookId = GetCommandParameter<int>("recordingBookId");

      var recordingBook = RecordingBook.Parse(recordingBookId);

      return PhysicalRecordingsWithRecordingActsGrid.Parse(recordingBook);
    }

    private string GetResourceHistoryGrid() {
      int resourceId = GetCommandParameter<int>("resourceId");
      int selectedDocumentId = GetCommandParameter<int>("selectedDocumentId");

      var resource = Resource.Parse(resourceId);
      var selectedDocument  = RecordingDocument.Parse(selectedDocumentId);

      return ResourceHistoryGrid.Parse(resource, selectedDocument);
    }

    private string GetTransactionDocumentAndCertificatesGrid() {
      int transactionId = GetCommandParameter<int>("transactionId");

      var transaction = LRSTransaction.Parse(transactionId);

      return TransactionDocumentAndCertificatesGrid.Parse(transaction);
    }

    #endregion Private command handlers

  } // class LandUserInterfaceControls

} // namespace Empiria.Web.UI.Ajax
