/* Empiria® Land 2014 ****************************************************************************************
*																																																						 *
*	 Solution  : Empiria® Land                                    System   : Land Extranet Application         *
*	 Namespace : Empiria.Web.UI.Ajax                              Assembly : Empiria.Land.Extranet.dll         *
*	 Type      : LandRegistrationSystemData                       Pattern  : Ajax Services Web Page            *
*	 Date      : 28/Mar/2014                                      Version  : 1.5  License: CC BY-NC-SA 4.0     *
*																																																						 *
*  Summary   : Gets Empiria control contents through Ajax invocation.                                        *
*																																																						 *
**************************************************** Copyright © La Vía Óntica SC + Ontica LLC. 1994-2014. **/
using System;
using System.Collections.Generic;

using Empiria.Contacts;
using Empiria.Geography;
using Empiria.Land.Registration;
using Empiria.Land.Registration.Transactions;
using Empiria.Ontology;
using Empiria.Presentation.Web;
using Empiria.Presentation.Web.Content;
//using Empiria.Land.Registration.UI;

namespace Empiria.Web.UI.Ajax {

  public partial class LandRegistrationSystemData : AjaxWebPage {

    protected override string ImplementsCommandRequest(string commandName) {
      switch (commandName) {
        case "findAnnotationIdCmd":
          return FindAnnotationIdCommandHandler();
        case "getRecordingBooksStringArrayCmd":
          return GetRecordingBooksStringArrayCommandHandler();
        case "getRecordingNumbersStringArrayCmd":
          return GetRecordingNumbersStringArrayCommandHandler();
        case "getRecordingPropertiesArrayCmd":
          return GetRecordingPropertiesStringArrayCommandHandler();
        case "getAnnotationsOfficialsStringArrayCmd":
          return GetAnnotationsOfficialsStringArrayCommandHandler();
        case "getAnnotationTypesStringArrayCmd":
          return GetAnnotationTypesStringArrayCommandHandler();
        case "getCadastralOfficeMunicipalitiesComboCmd":
          return GetCadastralOfficeMunicipalitiesComboCommandHandler();
        case "getDirectoryImageURL":
          return GetDirectoryImageUrlCommandHandler();
        case "getJudgesInJudicialOfficeStringArrayCmd":
          return GetJudgesInJudicialOfficeStringArrayCommandHandler();
        case "getJudicialOfficeInPlaceStringArrayCmd":
          return GetJudicialOfficeInPlaceStringArrayCommandHandler();
        case "getNotaryOfficesInPlaceStringArrayCmd":
          return GetNotaryOfficesInPlaceStringArrayCommandHandler();
        case "getNotariesInNotaryOfficeStringArrayCmd":
          return GetNotariesInNotaryOfficeStringArrayCommandHandler();
        case "getOverlappingRecordingsCountCmd":
          return GetOverlappingRecordingsCountCommandHandler();
        case "getRecordingIdCmd":
          return GetRecordingIdCommandHandler();
        case "getRecordingBookImageCountCmd":
          return GetRecordingBookImageCountCommandHandler();
        case "getLawArticlesStringArrayCmd":
          return GetLawArticlesStringArrayCommandHandler();
        case "getRecordingRawData":
          return GetRecordingRawDataCommandHandler();
        case "getRecordingDocumentRawData":
          return GetRecordingDocumentRawDataCommandHandler();
        case "getRecordingStartImageIndexCmd":
          return GetRecordingStartImageIndexCommandHandler();
        case "getRecordingTypesStringArrayCmd":
          return GetRecordingTypesStringArrayCommandHandler();

        //case "getRecordingsViewerPageCmd":
        //	return GetRecordingsViewerPageCommandHandler();

        //case "getTransactionFileCmd":
        //  return GetTransactionFileCommandHandler();            
        case "getWitnessInPositionStringArrayCmd":
          return GetWitnessInPositionStringArrayCommandHandler();
        case "searchRecordingActPartiesCmd":
          return SearchRecordingActPartiesCommandHandler();

        case "validateAnnotationSemanticsCmd":
          return ValidateAnnotationSemanticsCommandHandler();
        case "validateDeleteRecordingActCmd":
          return ValidateDeleteRecordingActCommandHandler();
        case "validateDeleteRecordingActPropertyCmd":
          return ValidateDeleteRecordingActPropertyCommandHandler();
        case "validateRecordingSemanticsCmd":
          return ValidateRecordingSemanticsCommandHandler();
        case "validateRecordingActAsCompleteCmd":
          return ValidateRecordingActAsCompleteCommandHandler();

        default:
          throw new WebPresentationException(WebPresentationException.Msg.UnrecognizedCommandName,
                                             commandName);
      }
    }

    #region Private command handlers

    private string GetRecordingPropertiesStringArrayCommandHandler() {
      int recordingId = int.Parse(GetCommandParameter("recordingId", false, "0"));

      if (recordingId == 0) {
        return HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "( ¿Número de partida? )");
      }
      Recording recording = Recording.Parse(recordingId);
      string html = String.Empty;
      if (recording.RecordingActs.Count == 0) {
        html = HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "Sin predios asociados");
      } else if (recording.RecordingActs.Count > 1) {
        html = HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "( ¿Folio del predio? )");
      }
      for (int i = 0; i < recording.RecordingActs.Count; i++) {
        RecordingAct recordingAct = recording.RecordingActs[i];
        for (int j = 0; j < recordingAct.TractIndex.Count; j++) {
          if (html.Contains(recordingAct.TractIndex[j].Property.UniqueCode)) {
            continue;
          }
          if (html.Length != 0) {
            html += "|";
          }
          html += HtmlSelectContent.GetComboAjaxHtmlItem(recordingAct.TractIndex[j].Property.Id.ToString(),
                                                         recordingAct.TractIndex[j].Property.UniqueCode);
        }
      }
      return html;
    }

    private string GetRecordingNumbersStringArrayCommandHandler() {
      int recordingBookId = int.Parse(GetCommandParameter("recordingBookId", false, "0"));

      if (recordingBookId == 0) {
        return HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "( ? )");
      }
      RecordingBook recordingBook = RecordingBook.Parse(recordingBookId);

      return HtmlSelectContent.GetComboAjaxHtml(recordingBook.Recordings, 0, "Id", "Number", "( ? )", String.Empty, String.Empty);
    }

    //private string GetTransactionFileCommandHandler() {
    //  int fileId = int.Parse(GetCommandParameter("id", true));

    //  RecorderOfficeTransactionFile file = RecorderOfficeTransactionFile.Parse(fileId);

    //  return file.VirtualPath;
    //}

    private string GetRecordingRawDataCommandHandler() {
      int recordingId = int.Parse(GetCommandParameter("recordingId", true));
      Recording recording = Recording.Parse(recordingId);

      string rawData = String.Empty;

      rawData += recording.PresentationTime.Date.ToString("dd/MMM/yyyy") + "|";
      rawData += recording.PresentationTime.ToString("HH:mm") + "|";
      rawData += recording.AuthorizedTime.ToString("dd/MMM/yyyy") + "|";

      if (recording.ReceiptTotal > 0) {
        rawData += recording.ReceiptTotal.ToString("N2") + "|";
        rawData += "600" + "|";
        rawData += recording.ReceiptNumber + "|";
        rawData += "" + "|";
      } else {
        rawData += "||||";
      }
      rawData += recording.AuthorizedBy.Id.ToString() + "|";

      if (recording.RecordingDocument != null && !recording.RecordingDocument.IsEmptyInstance) {
        rawData += recording.RecordingDocument.RecordingDocumentType.Id.ToString() + "|";
      } else {
        rawData += "|";
      }
      return rawData;
    }

    private string GetRecordingDocumentRawDataCommandHandler() {
      int recordingId = int.Parse(GetCommandParameter("recordingId", true));
      Recording recording = Recording.Parse(recordingId);

      if (recording.RecordingDocument == null || recording.RecordingDocument.IsEmptyInstance) {
        return String.Empty;
      }

      string rawData = String.Empty;

      switch (recording.RecordingDocument.RecordingDocumentType.Name) {
        case "ObjectType.RecordingDocument.Empty":
          return String.Empty;
        case "ObjectType.RecordingDocument.NotaryDeed":
          return GetNotaryDeedRecordingDocumentRawData(recording.RecordingDocument);
        case "ObjectType.RecordingDocument.PropertyTitle":
          return GetPropertyTitleRecordingDocumentRawData(recording.RecordingDocument);
        case "ObjectType.RecordingDocument.JudicialOrder":
          return GetJudicialOrderRecordingDocumentRawData(recording.RecordingDocument);
        case "ObjectType.RecordingDocument.PrivateContract":
          return GetPrivateContractRecordingDocumentRawData(recording.RecordingDocument);
      }

      return rawData;
    }

    private string GetNotaryDeedRecordingDocumentRawData(RecordingDocument document) {
      string rawData = "oNotaryRecording|";

      rawData += document.IssuePlace.Id.ToString() + "|";
      rawData += document.IssueOffice.Id.ToString() + "|";
      rawData += document.IssuedBy.Id.ToString() + "|";
      rawData += document.BookNumber + "|";
      rawData += document.Number + "|";
      rawData += document.StartSheet + "|";
      rawData += document.EndSheet + "|";
      rawData += document.IssueDate.ToString("dd/MMM/yyyy");

      return rawData;
    }

    private string GetPropertyTitleRecordingDocumentRawData(RecordingDocument document) {
      string rawData = "oTitleRecording|";

      rawData += document.Number + "|";
      rawData += document.IssuedBy.Id.ToString() + "|";
      rawData += document.IssueDate.ToString("dd/MMM/yyyy") + "|";
      rawData += document.IssueOffice.Id + "|";
      rawData += document.StartSheet;

      return rawData;
    }

    private string GetJudicialOrderRecordingDocumentRawData(RecordingDocument document) {
      string rawData = "oJudicialRecording|";

      rawData += document.IssuePlace.Id.ToString() + "|";
      rawData += document.IssueOffice.Id.ToString() + "|";
      rawData += document.IssuedBy.Id.ToString() + "|";
      rawData += document.BookNumber + "|";
      rawData += document.Number + "|";
      rawData += document.IssueDate.ToString("dd/MMM/yyyy");

      return rawData;
    }

    private string GetPrivateContractRecordingDocumentRawData(RecordingDocument document) {
      string rawData = "oPrivateRecording|";

      rawData += document.IssuePlace.Id.ToString() + "|";
      rawData += document.IssueDate.ToString("dd/MMM/yyyy") + "|";
      rawData += document.Number + "|";
      rawData += document.MainWitnessPosition.Id.ToString() + "|";
      rawData += document.MainWitness.Id.ToString();

      return rawData;
    }

    private string SearchRecordingActPartiesCommandHandler() {
      int recordingActId = int.Parse(GetCommandParameter("recordingActId", true));
      int partyTypeId = int.Parse(GetCommandParameter("partyTypeId", false, "0"));
      string partyFilter = GetCommandParameter("filterType", true);
      string keywords = GetCommandParameter("keywords", false, String.Empty);


      RecordingAct recordingAct = RecordingAct.Parse(recordingActId);
      PartyFilterType partyFilterType = (PartyFilterType) System.Enum.Parse(typeof(PartyFilterType), partyFilter);

      ObjectTypeInfo partyTypeInfo = null;
      if (partyTypeId != 0) {
        partyTypeInfo = ObjectTypeInfo.Parse(partyTypeId);
      }
      FixedList<Party> list = Party.GetList(partyFilterType, partyTypeInfo, recordingAct, keywords);

      string html = String.Empty;

      if (partyTypeInfo != null) {
        html = HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, HtmlSelectContent.GetSearchResultHeaderText(partyTypeInfo, list.Count));
      } else {
        html = HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "( " + list.Count.ToString("N0") + " personas u organizaciones encontradas )");
      }
      if (list.Count == 0) {
        if (partyTypeInfo != null && !partyTypeInfo.IsAbstract) {
          html += "|" + HtmlSelectContent.GetComboAjaxHtmlItem("appendParty", "( Agregar " + (partyTypeInfo.FemaleGenre ? "una nueva " : "un nuevo ") +
                                                                                       partyTypeInfo.DisplayName + " )");
        }
      } else {
        if (partyTypeInfo != null && !partyTypeInfo.IsAbstract) {
          html += "|" + HtmlSelectContent.GetComboAjaxHtmlItem("appendParty", "( Agregar " + (partyTypeInfo.FemaleGenre ? "una nueva " : "un nuevo ") +
                                                                                          partyTypeInfo.DisplayName + " )");
        }
        html += "|" + HtmlSelectContent.GetComboAjaxHtml(list, 0, "Id", "ExtendedName", String.Empty);
      }
      return html;
    }

    private string GetJudgesInJudicialOfficeStringArrayCommandHandler() {
      int judicialOfficeId = int.Parse(GetCommandParameter("judicialOfficeId", false, "0"));

      if (judicialOfficeId == 0) {
        return HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "( Primero seleccionar un juzgado )");
      }
      JudicialOffice judicialOffice = JudicialOffice.Parse(judicialOfficeId);
      FixedList<Person> list = judicialOffice.GetJudges();

      return HtmlSelectContent.GetComboAjaxHtml(list, 0, "Id", "FamilyFullName", "( Seleccionar al C. Juez )", String.Empty, "No consta");
    }

    private string GetJudicialOfficeInPlaceStringArrayCommandHandler() {
      int placeId = int.Parse(GetCommandParameter("placeId", false, "0"));

      if (placeId == 0) {
        return HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "( Primero seleccionar una ciudad )");
      }
      GeographicRegionItem place = GeographicRegionItem.Parse(placeId);
      FixedList<JudicialOffice> list = JudicialOffice.GetList(place);

      return HtmlSelectContent.GetComboAjaxHtml(list, 0, "Id", "Number", "( Seleccionar )", String.Empty, "No consta");
    }

    private string GetWitnessInPositionStringArrayCommandHandler() {
      int placeId = int.Parse(GetCommandParameter("placeId", false, "-1"));
      int positionId = int.Parse(GetCommandParameter("positionId", false, "0"));

      if (positionId == 0) {
        return HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "( Primero seleccionar el rol del certificador )");
      } else if (positionId == -2) {
        return HtmlSelectContent.GetComboAjaxHtmlItem("-2", "No consta o no se puede determinar");
      }
      if (placeId == -1) {
        return HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "( Primero seleccionar una ciudad )");
      } else if (placeId == -2) {
        return HtmlSelectContent.GetComboAjaxHtmlItem("-2", "No consta o no se puede determinar");
      }

      GeographicRegionItem place = GeographicRegionItem.Parse(placeId);
      TypeAssociationInfo role = place.ObjectTypeInfo.Associations[positionId];
      FixedList<Person> list = place.GetPeople(role.Name);

      return HtmlSelectContent.GetComboAjaxHtml(list, 0, "Id", "FamilyFullName", "( Seleccionar al certificador del contrato )",
                                            String.Empty, "No consta o no se puede determinar");
    }

    private string FindAnnotationIdCommandHandler() {
      int annotationBookId = int.Parse(GetCommandParameter("annotationBookId", true));
      int annotationTypeId = int.Parse(GetCommandParameter("annotationTypeId", true));
      int number = int.Parse(GetCommandParameter("number", false));
      string bisSuffixNumber = GetCommandParameter("bisSuffixNumber", false, String.Empty);
      int imageStartIndex = int.Parse(GetCommandParameter("imageStartIndex", true));
      int imageEndIndex = int.Parse(GetCommandParameter("imageEndIndex", true));
      int propertyId = int.Parse(GetCommandParameter("propertyId", true));
      DateTime presentationTime = EmpiriaString.ToDateTime(GetCommandParameter("presentationTime", false, ExecutionServer.DateMinValue.ToString("dd/MMM/yyyy")));
      DateTime authorizationDate = EmpiriaString.ToDate(GetCommandParameter("authorizationDate", false, ExecutionServer.DateMaxValue.ToString("dd/MMM/yyyy")));
      int authorizedById = int.Parse(GetCommandParameter("authorizedById", false, "-1"));

      RecordingBook recordingBook = RecordingBook.Parse(annotationBookId);
      RecordingActType annotationType = RecordingActType.Parse(annotationTypeId);
      Person authorizedBy = Person.Parse(authorizedById);
      Property property = Property.Parse(propertyId);

      return LRSValidator.FindAnnotationId(recordingBook, annotationType,
                                           Recording.RecordingNumber(number, bisSuffixNumber),
                                           imageStartIndex, imageEndIndex, presentationTime,
                                           authorizationDate, authorizedBy, property).ToString();
    }

    private string GetRecordingBooksStringArrayCommandHandler() {
      int recorderOfficeId = int.Parse(GetCommandParameter("recorderOfficeId", true));
      int recordingTypeCategoryId = int.Parse(GetCommandParameter("recordingActTypeCategoryId", false, "0"));
      bool digitalized = bool.Parse(GetCommandParameter("digitalized", false, "false"));

      if (recorderOfficeId == 0) {
        return HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "( Primero seleccionar un Distrito )");
      }
      if (recordingTypeCategoryId == 0) {
        return HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "( Primero seleccionar una Sección )");
      }

      RecorderOffice recorderOffice = RecorderOffice.Parse(recorderOfficeId);
      FixedList<RecordingBook> recordingBookList = null;

      RecordingSection recordingSection = RecordingSection.Parse(recordingTypeCategoryId);
      recordingBookList = recorderOffice.GetRecordingBooks(recordingSection);
      List<RecordingBook> theList = null;
      if (digitalized) {
        theList = recordingBookList.FindAll((x) => !x.ImagingFilesFolder.IsEmptyInstance);
      } else {
        theList = recordingBookList.FindAll((x) => !x.IsEmptyInstance);
      }
      if (theList.Count != 0) {
        return HtmlSelectContent.GetComboAjaxHtml(theList, 0, "Id", "FullName", "( Seleccionar el libro registral )");
      } else {
        return HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "( No hay libros digitalizados en esta Sección )");
      }
    }

    private string GetAnnotationsOfficialsStringArrayCommandHandler() {
      int recordingBookId = int.Parse(GetCommandParameter("recordingBookId", false, "-1"));

      RecordingBook recordingBook = RecordingBook.Parse(recordingBookId);
      RecorderOffice office = recordingBook.RecorderOffice;
      FixedList<Person> officers = office.GetRecorderOfficials(recordingBook.RecordingsControlTimePeriod);

      return HtmlSelectContent.GetComboAjaxHtml(officers, 0, "Id", "FamilyFullName", "( Seleccionar al C. Oficial Registrador )",
                                                "No se puede determinar o sólo aparece la firma", String.Empty);
    }

    private string GetAnnotationTypesStringArrayCommandHandler() {
      int annotationTypeCategoryId = int.Parse(GetCommandParameter("annotationTypeCategoryId", false, "0"));

      if (annotationTypeCategoryId != 0) {
        RecordingActTypeCategory recordingActTypeCategory = RecordingActTypeCategory.Parse(annotationTypeCategoryId);
        FixedList<RecordingActType> list = recordingActTypeCategory.GetItems();

        return HtmlSelectContent.GetComboAjaxHtml(list, 0, "Id", "DisplayName", "( Seleccionar el tipo de movimiento que se desea agregar )");
      } else {
        return HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "( Primero seleccionar la categoría del movimiento )");
      }
    }

    private string GetCadastralOfficeMunicipalitiesComboCommandHandler() {
      int cadastralOfficeId = int.Parse(GetCommandParameter("cadastralOfficeId", false, "0"));

      if (cadastralOfficeId != 0) {
        RecorderOffice cadastralOffice = RecorderOffice.Parse(cadastralOfficeId);
        FixedList<GeographicRegionItem> list = cadastralOffice.GetMunicipalities();
        if (list.Count != 0) {
          return HtmlSelectContent.GetComboAjaxHtml(list, 0, "Id", "Name", "( Seleccionar un municipio )");
        } else {
          return HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "( No hay municipios definidos )");
        }
      } else {
        return HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "( Primero seleccionar un Distrito )");
      }
    }

    private string GetDirectoryImageUrlCommandHandler() {
      bool attachment = bool.Parse(GetCommandParameter("attachment", false, "false"));

      if (attachment) {
        return GetAttachmentImageDirectoryCommandHandler();
      }

      string position = GetCommandParameter("position", true);
      int currentPosition = int.Parse(GetCommandParameter("currentPosition", true));

      int recordingId = int.Parse(GetCommandParameter("recordingId", false, "0"));
      RecordBookDirectory directory = null;

      if (recordingId == 0) {
        int directoryId = int.Parse(GetCommandParameter("directoryId", true));
        directory = RecordBookDirectory.Parse(directoryId);
      } else {
        Recording recording = Recording.Parse(recordingId);
        if (currentPosition == -1) {
          currentPosition = recording.StartImageIndex - 1;
        }
        directory = recording.RecordingBook.ImagingFilesFolder;
      }

      if (!EmpiriaString.IsInteger(position)) {
        switch (position) {
          case "first":
            return directory.GetImageURL(0);
          case "previous":
            return directory.GetImageURL(Math.Max(currentPosition - 1, 0));
          case "next":
            return directory.GetImageURL(Math.Min(currentPosition + 1, directory.FilesCount - 1));
          case "last":
            return directory.GetImageURL(directory.FilesCount - 1);
          case "refresh":
            return directory.GetImageURL(currentPosition);
          default:
            return directory.GetImageURL(currentPosition);
        }
      } else {
        return directory.GetImageURL(int.Parse(position));
      }
    }

    private string GetAttachmentImageDirectoryCommandHandler() {
      string position = GetCommandParameter("position", true);
      string folderName = GetCommandParameter("name", false, String.Empty);

      int currentPosition = int.Parse(GetCommandParameter("currentPosition", true));

      int recordingId = int.Parse(GetCommandParameter("recordingId", false, "0"));

      Recording recording = Recording.Parse(recordingId);
      if (currentPosition == -1) {
        currentPosition = 0;
      }
      RecordingAttachmentFolder folder = recording.GetAttachementFolder(folderName);

      if (!EmpiriaString.IsInteger(position)) {
        switch (position) {
          case "first":
            return folder.GetImageURL(0);
          case "previous":
            return folder.GetImageURL(Math.Max(currentPosition - 1, 0));
          case "next":
            return folder.GetImageURL(Math.Min(currentPosition + 1, folder.FilesCount - 1));
          case "last":
            return folder.GetImageURL(folder.FilesCount - 1);
          case "refresh":
            return folder.GetImageURL(currentPosition);
          default:
            return folder.GetImageURL(currentPosition);
        }
      } else {
        return folder.GetImageURL(int.Parse(position));
      }
    }

    private string GetNotaryOfficesInPlaceStringArrayCommandHandler() {
      int placeId = int.Parse(GetCommandParameter("placeId", false, "0"));

      if (placeId == 0) {
        return HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "( Primero seleccionar una ciudad )");
      }
      GeographicRegionItem place = GeographicRegionItem.Parse(placeId);
      FixedList<NotaryOffice> list = NotaryOffice.GetList(place);

      return HtmlSelectContent.GetComboAjaxHtml(list, 0, "Id", "Number", "( ? )", String.Empty, "N/C");
    }

    private string GetNotariesInNotaryOfficeStringArrayCommandHandler() {
      int notaryOfficeId = int.Parse(GetCommandParameter("notaryOfficeId", false, "0"));

      if (notaryOfficeId == 0) {
        return HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "( Primero seleccionar una notaría )");
      }
      NotaryOffice notaryOffice = NotaryOffice.Parse(notaryOfficeId);
      FixedList<Person> list = notaryOffice.GetNotaries();

      return HtmlSelectContent.GetComboAjaxHtml(list, 0, "Id", "FamilyFullName", "( Seleccionar al C. Notario Público )",
                                                String.Empty, "No consta o no se puede determinar");
    }

    private string GetOverlappingRecordingsCountCommandHandler() {
      int recordingBookId = int.Parse(GetCommandParameter("recordingBookId", true));
      int recordingId = int.Parse(GetCommandParameter("recordingId", true));
      int imageStartIndex = int.Parse(GetCommandParameter("imageStartIndex", true));
      int imageEndIndex = int.Parse(GetCommandParameter("imageEndIndex", true));

      RecordingBook recordingBook = RecordingBook.Parse(recordingBookId);
      Recording recording = null;
      if (recordingId != 0) {
        recording = Recording.Parse(recordingId);
      } else {
        recording = Recording.Empty;
      }
      return LRSValidator.GetOverlappingRecordingsCount(recordingBook, recording,
                                                        imageStartIndex, imageEndIndex).ToString();
    }

    private string GetRecordingIdCommandHandler() {
      int recordingBookId = int.Parse(GetCommandParameter("recordingBookId", true));
      int number = int.Parse(GetCommandParameter("number", true));
      string bisSuffixNumber = GetCommandParameter("bisSuffixNumber", false, String.Empty);

      RecordingBook recordingBook = RecordingBook.Parse(recordingBookId);
      Recording recording = recordingBook.FindRecording(Recording.RecordingNumber(number, bisSuffixNumber));
      if (recording != null) {
        return recording.Id.ToString();
      } else {
        return "0";
      }
    }

    private string GetRecordingBookImageCountCommandHandler() {
      bool attachment = bool.Parse(GetCommandParameter("attachment", false, "false"));

      if (attachment) {
        return GetAttachmentImageCountCommandHandler();
      }
      int recordingId = int.Parse(GetCommandParameter("recordingId", false, "0"));
      RecordingBook recordingBook = null;
      if (recordingId == 0) {
        int recordingBookId = int.Parse(GetCommandParameter("recordingBookId", true));
        recordingBook = RecordingBook.Parse(recordingBookId);
      } else {
        Recording recording = Recording.Parse(recordingId);
        recordingBook = recording.RecordingBook;
      }
      return recordingBook.ImagingFilesFolder.FilesCount.ToString();
    }

    private string GetAttachmentImageCountCommandHandler() {
      int recordingId = int.Parse(GetCommandParameter("recordingId", false, "0"));
      string folderName = GetCommandParameter("name", false, String.Empty);

      Recording recording = Recording.Parse(recordingId);

      RecordingAttachmentFolder folder = recording.GetAttachementFolder(folderName);

      return folder.FilesCount.ToString();
    }

    private string GetRecordingStartImageIndexCommandHandler() {
      int recordingId = int.Parse(GetCommandParameter("recordingId", true));
      Recording recording = Recording.Parse(recordingId);

      return recording.StartImageIndex.ToString();
    }

    //private string GetRecordingsViewerPageCommandHandler() {
    //	int recordingBookId = int.Parse(GetCommandParameter("recordingBookId", true));
    //	int page = int.Parse(GetCommandParameter("page", true));
    //	int pageSize = int.Parse(GetCommandParameter("itemsPerPage", true));

    //	RecordingBook recordingBook = RecordingBook.Parse(recordingBookId);

    //	return LRSGridControls.GetRecordingsSummaryTable(recordingBook, pageSize, page);
    //}

    private string GetRecordingTypesStringArrayCommandHandler() {
      int recordingActTypeCategoryId = int.Parse(GetCommandParameter("recordingActTypeCategoryId", false, "0"));

      string items = String.Empty;
      if (recordingActTypeCategoryId != 0) {
        RecordingActTypeCategory recordingActTypeCategory = RecordingActTypeCategory.Parse(recordingActTypeCategoryId);
        FixedList<RecordingActType> list = recordingActTypeCategory.GetItems();

        return HtmlSelectContent.GetComboAjaxHtml(list, 0, "Id", "DisplayName", "( Seleccionar el tipo de acto que se desea agregar)");
      } else {
        return HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "( Primero seleccionar la categoría del acto )");
      }
    }

    private string GetLawArticlesStringArrayCommandHandler() {
      int recordingActTypeId = int.Parse(GetCommandParameter("recordingActTypeId", false, "0"));

      string items = String.Empty;
      if (recordingActTypeId != 0) {
        RecordingActType recordingActType = RecordingActType.Parse(recordingActTypeId);
        FixedList<LRSLawArticle> list = recordingActType.GetFinancialLawArticles();
        if (list.Count == 0) {
          list = LRSLawArticle.GetList();
        }
        if (list.Count == 1) {
          return HtmlSelectContent.GetComboAjaxHtmlItem(list[0].Id.ToString(), list[0].Name);
        } else {
          return HtmlSelectContent.GetComboAjaxHtml(list, 0, "Id", "Name", "( Fundamento )");
        }
      } else {
        return HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "( Fundamento )");
      }
    }

    private string ValidateAnnotationSemanticsCommandHandler() {
      int annotationBookId = int.Parse(GetCommandParameter("annotationBookId", true));
      int annotationTypeId = int.Parse(GetCommandParameter("annotationTypeId", true));
      int number = int.Parse(GetCommandParameter("number", false));
      bool bisSuffixNumber = bool.Parse(GetCommandParameter("bisSuffixNumber", true));
      int imageStartIndex = int.Parse(GetCommandParameter("imageStartIndex", true));
      int imageEndIndex = int.Parse(GetCommandParameter("imageEndIndex", true));
      int propertyId = int.Parse(GetCommandParameter("propertyId", true));
      DateTime presentationTime = EmpiriaString.ToDateTime(GetCommandParameter("presentationTime", false, ExecutionServer.DateMinValue.ToString("dd/MMM/yyyy")));
      DateTime authorizationDate = EmpiriaString.ToDate(GetCommandParameter("authorizationDate", false, ExecutionServer.DateMaxValue.ToString("dd/MMM/yyyy")));
      int authorizedById = int.Parse(GetCommandParameter("authorizedById", false, "-1"));

      RecordingBook recordingBook = RecordingBook.Parse(annotationBookId);
      RecordingActType annotationType = RecordingActType.Parse(annotationTypeId);
      Person authorizedBy = Person.Parse(authorizedById);
      Property property = Property.Parse(propertyId);

      LandRegistrationException exception = null;
      if (presentationTime != ExecutionServer.DateMinValue) {
        exception = LRSValidator.ValidateRecordingDates(recordingBook, Recording.Empty, presentationTime, authorizationDate);
        if (exception != null) {
          return exception.Message;
        }
      }
      exception = LRSValidator.ValidateRecordingAuthorizer(recordingBook, authorizedBy, authorizationDate);
      if (exception != null) {
        return exception.Message;
      }
      return String.Empty;
    }

    private string ValidateDeleteRecordingActCommandHandler() {
      int recordingId = int.Parse(GetCommandParameter("recordingId", true));
      int recordingActId = int.Parse(GetCommandParameter("recordingActId", true));

      Recording recording = Recording.Parse(recordingId);
      RecordingAct recordingAct = recording.GetRecordingAct(recordingActId);

      LandRegistrationException exception = null;
      exception = LRSValidator.ValidateDeleteRecordingAct(recordingAct);

      if (exception != null) {
        return exception.Message;
      }
      return String.Empty;
    }

    private string ValidateDeleteRecordingActPropertyCommandHandler() {
      int recordingId = int.Parse(GetCommandParameter("recordingId", true));
      int recordingActId = int.Parse(GetCommandParameter("recordingActId", true));
      int propertyId = int.Parse(GetCommandParameter("propertyId", true));

      Recording recording = Recording.Parse(recordingId);
      RecordingAct recordingAct = recording.GetRecordingAct(recordingActId);
      Property property = recordingAct.GetPropertyEvent(Property.Parse(propertyId)).Property;

      LandRegistrationException exception = null;
      exception = LRSValidator.ValidateDeleteRecordingActProperty(recordingAct, property);

      if (exception != null) {
        return exception.Message;
      }
      return String.Empty;
    }

    private string ValidateRecordingActAsCompleteCommandHandler() {
      int recordingActId = int.Parse(GetCommandParameter("recordingActId", true));

      RecordingAct recordingAct = RecordingAct.Parse(recordingActId);

      LandRegistrationException exception = null;

      exception = LRSValidator.ValidateRecordingActAsComplete(recordingAct);
      if (exception != null) {
        return exception.Message;
      }
      return String.Empty;
    }

    private string ValidateRecordingSemanticsCommandHandler() {
      int recordingBookId = int.Parse(GetCommandParameter("recordingBookId", true));
      int recordingId = int.Parse(GetCommandParameter("recordingId", true));
      int number = int.Parse(GetCommandParameter("number", false));
      string bisSuffixNumber = GetCommandParameter("bisSuffixNumber", false, String.Empty);
      int imageStartIndex = int.Parse(GetCommandParameter("imageStartIndex", true));
      int imageEndIndex = int.Parse(GetCommandParameter("imageEndIndex", true));
      DateTime presentationTime = EmpiriaString.ToDateTime(GetCommandParameter("presentationTime", false, ExecutionServer.DateMinValue.ToString("dd/MMM/yyyy")));
      DateTime authorizationDate = EmpiriaString.ToDate(GetCommandParameter("authorizationDate", false, ExecutionServer.DateMaxValue.ToString("dd/MMM/yyyy")));
      int authorizedById = int.Parse(GetCommandParameter("authorizedById", false, "-1"));

      RecordingBook recordingBook = RecordingBook.Parse(recordingBookId);
      Recording recording = null;
      Person authorizedBy = Person.Parse(authorizedById);

      if (recordingId != 0) {
        recording = Recording.Parse(recordingId);
      } else {
        recording = new Recording();
      }
      LandRegistrationException exception = null;
      exception = LRSValidator.ValidateRecordingNumber(recordingBook, recording, number,
                                                       bisSuffixNumber, imageStartIndex, imageEndIndex);
      if (exception != null) {
        return exception.Message;
      }
      if (presentationTime != ExecutionServer.DateMinValue) {
        exception = LRSValidator.ValidateRecordingDates(recordingBook, recording, presentationTime, authorizationDate);
        if (exception != null) {
          return exception.Message;
        }
      }
      exception = LRSValidator.ValidateRecordingAuthorizer(recordingBook, authorizedBy, authorizationDate);
      if (exception != null) {
        return exception.Message;
      }
      return String.Empty;
    }

    #endregion Private command handlers

  } // class WorkplaceData

} // namespace Empiria.Web.UI.Ajax