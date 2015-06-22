/* Empiria® Land 2015 ****************************************************************************************
*																																																						 *
*	 Solution  : Empiria® Land                                    System   : Land Intranet Application         *
*	 Namespace : Empiria.Web.UI.Ajax                              Assembly : Empiria.Land.Intranet.dll         *
*	 Type      : LandRegistrationSystemData                       Pattern  : Ajax Services Web Page            *
*	 Date      : 25/Jun/2015                                      Version  : 2.0  License: LICENSE.TXT file    *
*																																																						 *
*  Summary   : Gets Empiria control contents through Ajax invocation.                                        *
*																																																						 *
**************************************************** Copyright © La Vía Óntica SC + Ontica LLC. 2009-2015. **/
using System;

using Empiria.DataTypes;
using Empiria.Contacts;
using Empiria.Geography;
using Empiria.Json;

using Empiria.Land.Registration;
using Empiria.Land.Registration.Transactions;
using Empiria.Land.UI;
using Empiria.Ontology;
using Empiria.Presentation.Web;
using Empiria.Presentation.Web.Content;

namespace Empiria.Web.UI.Ajax {

  public partial class LandRegistrationSystemData : AjaxWebPage {

    protected override string ImplementsCommandRequest(string commandName) {
      switch (commandName) {
        case "getTargetPrecedentActsTableCmd":
          return GetTargetPrecedentActsTableCommandHandler();
        case "getTargetActSectionsStringArrayCmd":
          return TargetActSectionsCommandHandler();
        case "getDomainTraslativeSectionsCmd":
          return DomainTraslativeSectionsCommandHandler();
        case "getRecordingActTypesEditingCategoriesCmd":
          return RecordingActTypesEditingCategoriesCommandHandler();
        case "getRecordingActRule":
          return GetRecordingActRuleCommandHandler();
        case "lookupResource":
          return GetResourceCommandHandler();
        case "getTargetRecordingActTypesCmd":
          return GetTargetRecordingActTypesCommandHandler();
        case "getTargetRecordingSectionsCmd":
          return GetTargetRecordingSectionsCommandHandler();
        case "getRecordingBooksStringArrayCmd":
          return GetRecordingBooksStringArrayCommandHandler();
        case "getDomainBooksStringArrayCmd":
          return GetDomainBooksStringArrayCommandHandler();
        case "getRecordingActPropertiesComboCmd":
          return GetRecordingNumbersStringArrayCommandHandler();
        case "getPropertyTypeSelectorComboCmd":
          return GetPropertyTypeSelectorComboCommandHandler();
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
        //case "getDirectoryImageURL":
        //  return GetDirectoryImageUrlCommandHandler();
        case "getIssueEntitiesForDocumentTypeStringArrayCmd":
          return GetIssueEntitiesForDocumentTypeCommandHandler();
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
        //case "getRecordingBookImageCountCmd":
        //  return GetRecordingBookImageCountCommandHandler();
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
        case "getRecordingsViewerPageCmd":
          return GetRecordingsViewerPageCommandHandler();
        case "getWitnessInPositionStringArrayCmd":
          return GetWitnessInPositionStringArrayCommandHandler();
        case "searchRecordingActPartiesCmd":
          return SearchRecordingActPartiesCommandHandler();
        case "validateDocumentRecordingActCmd":
          return ValidateDocumentRecordingActCommandHandler();
        case "validateAnnotationSemanticsCmd":
          return ValidateAnnotationSemanticsCommandHandler();
        case "validateDeleteRecordingActCmd":
          return ValidateDeleteRecordingActCommandHandler();
        case "validateDeleteRecordingActPropertyCmd":
          return ValidateDeleteRecordingActPropertyCommandHandler();
        case "validateNextTransactionStateCmd":
          return ValidateNextTransactionStateCommandHandler();
        case "validateRecordingSemanticsCmd":
          return ValidateRecordingSemanticsCommandHandler();
        case "validateRecordingActAsCompleteCmd":
          return ValidateRecordingActAsCompleteCommandHandler();
        default:
          throw new WebPresentationException(WebPresentationException.Msg.UnrecognizedCommandName,
                                             commandName);
      }
    }

    private string GetResourceCommandHandler() {
      string resourceUID = GetCommandParameter<string>("resourceUID");

      var resource = Resource.TryParseWithUID(resourceUID);

      if (resource != null) {
        return new JsonObject() { new JsonItem("Id", resource.Id) }.ToString();
      } else {
        return new JsonObject() { new JsonItem("Id", -1) }.ToString();
      }
    }

    private string GetIssueEntitiesForDocumentTypeCommandHandler() {
      int documentTypeId = GetCommandParameter<int>("documentTypeId");

      var documentType = LRSDocumentType.Parse(documentTypeId);

      return HtmlSelectContent.GetComboAjaxHtml(documentType.IssuedByEntities, 0,
                                                "Id", "FullName", "( Documento expedido por )");
    }

    private string TargetActSectionsCommandHandler() {
      int recordingActTypeId = GetCommandParameter<int>("recordingActTypeId");
      var recordingActType = RecordingActType.Parse(recordingActTypeId);

      var section = recordingActType.RecordingRule.RecordingSection;

      string html =HtmlSelectContent.GetComboAjaxHtmlItem("", "( Seleccionar el distrito y sección )");
      if (recordingActType.RecordingRule.IsAnnotation) {
        html += "|" + HtmlSelectContent.GetComboAjaxHtmlItem("annotation", "Registrado al margen");
      }
      if (section != RecordingSection.Empty && section.Id == 1051) {
        var list = GeneralList.Parse("LRSDomainTraslativeSection.Combo.List");
        html += "|" + HtmlSelectContent.GetComboAjaxHtml(list.GetItems<NameValuePair>(), 0,
                                                         "Value", "Name");

      } else if (section != RecordingSection.Empty && section.Id == 1052) {
        var list = GeneralList.Parse("LRSLimitationSection.Combo.List");
        html += "|" + HtmlSelectContent.GetComboAjaxHtml(list.GetItems<NameValuePair>(), 0,
                                                         "Value", "Name");
      }
      return html;
    }

    private string GetTargetPrecedentActsTableCommandHandler() {
      int recordingActTypeId = GetCommandParameter<int>("recordingActTypeId");
      int resourceId = GetCommandParameter<int>("resourceId");

      var recordingActType = RecordingActType.Parse(recordingActTypeId);
      var resource = Property.Parse(resourceId);

      var appliesTo = recordingActType.GetAppliesToRecordingActTypesList();

      var list = resource.GetRecordingActsTract();

      return HtmlSelectContent.GetComboAjaxHtml<RecordingAct>(list.FindAll((x) => appliesTo.Contains(x.RecordingActType)),
                                "Id", (x)=> x.RecordingActType.DisplayName + " " + x.Document.UID + " " +
                                       x.Document.AuthorizationTime + " " + x.AmendedBy.Id + " " + x.StatusName,
                                "( Seleccionar el acto jurídico )");
      //return "<tr id='tblTargetPrecedentActsTable' class='totalsRow' style='display:inline'><td>&nbsp;</td><td colspan='5'>Hello world</td></tr>";
    }

    private string GetTargetRecordingSectionsCommandHandler() {
      var list = RecordingActTypeCategory.GetList("RecordingActTypesCategories.List");

      return HtmlSelectContent.GetComboAjaxHtml(list, 0, "Id", "Name", "( Tipo de acto jurídico )");
    }

    private string GetTargetRecordingActTypesCommandHandler() {
      int id = GetCommandParameter<int>("recordingActTypeId");
      var recordingActType = RecordingActType.Parse(id);

      var list = recordingActType.GetAppliesToRecordingActTypesList();

      return HtmlSelectContent.GetComboAjaxHtml(list, 0, "Id", "DisplayName",
                                      recordingActType.IsCancelationType ? "( Acto jurídico a cancelar )" :
                                                                           "( Acto jurídico a modificar )");
    }

    private string RecordingActTypesEditingCategoriesCommandHandler() {
      var list = RecordingActTypeCategory.GetList("RecordingActTypesCategories.List");

      return HtmlSelectContent.GetComboAjaxHtml(list, 0, "Id", "Name", "( Tipo de acto jurídico )");
    }

    private string DomainTraslativeSectionsCommandHandler() {
      var list = GeneralList.Parse("LRSDomainTraslativeSection.Combo.List");

      return HtmlSelectContent.GetComboAjaxHtml(list.GetItems<NameValuePair>(), 0,
                                                "Value", "Name", "( Distrito / Sección )");
    }

    private string GetRecordingActRuleCommandHandler() {
      int recordingActTypeId = GetCommandParameter<int>("recordingActTypeId", -1);
      var recordingActType = RecordingActType.Parse(recordingActTypeId);

      JsonObject jsonRule = recordingActType.RecordingRule.ToJson();

      return jsonRule.ToString();
    }

    #region Private command handlers

    private string GetPropertyTypeSelectorComboCommandHandler() {
      int recordingActTypeId = GetCommandParameter<int>("recordingActTypeId", -1);
      int recordingId = GetCommandParameter<int>("recordingId", -1);

      if (recordingActTypeId == -1) {
        return HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "( Seleccionar el acto jurídico )");
      }

      var recordingActType = RecordingActType.Parse(recordingActTypeId);
      var rule = recordingActType.RecordingRule;

      string html = String.Empty;
      int counter = 0;

      switch (rule.AppliesTo) {
        case RecordingRuleApplication.Association:
        case RecordingRuleApplication.Property:
        case RecordingRuleApplication.Structure:
          if (rule.PropertyRecordingStatus == PropertyRecordingStatus.Unregistered ||
              rule.PropertyRecordingStatus == PropertyRecordingStatus.Both) {
            html = HtmlSelectContent.GetComboAjaxHtmlItem("createProperty", "Sin antecedente registral");
            counter++;
          }
          if (rule.AppliesTo == RecordingRuleApplication.Structure ||
              rule.PropertyRecordingStatus == PropertyRecordingStatus.Registered ||
              rule.PropertyRecordingStatus == PropertyRecordingStatus.Both) {
            if (html.Length != 0) {
              html += "|";
            }
            html += HtmlSelectContent.GetComboAjaxHtmlItem("selectProperty", "Ya registrado");
            counter++;
          }
          break;
        case RecordingRuleApplication.RecordingAct:
          html += HtmlSelectContent.GetComboAjaxHtmlItem("actAppliesToOtherRecordingAct", "Ya registrado");
          counter++;
          break;
        case RecordingRuleApplication.Document:
          html += HtmlSelectContent.GetComboAjaxHtmlItem("actAppliesToDocument", "No es aplicable a predios");
          counter++;
          break;
        default:
          break;
          // actNotApplyToProperty  // actAppliesOnlyToSection  // undefinedRule
      }
      if (counter > 1) {
        return HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "( ¿A qué predio se aplicará? )") + "|" + html;
      } else if (counter == 1) {
        return html;
      } else {
        return HtmlSelectContent.GetComboAjaxHtmlItem("undefinedRule", "**REGLA NO DEFINIDA**");
      }
    }

    private string GetRecordingPropertiesStringArrayCommandHandler() {
      int recordingId = int.Parse(GetCommandParameter("recordingId", false, "0"));
      int recordingActTypeId = GetCommandParameter<int>("recordingActTypeId", 0);

      if (recordingId == 0) {
        return HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "( Seleccionar partida )");
      }
      var recording = Recording.Parse(recordingId);
      string html = String.Empty;

      var recordingResources = recording.GetResources();

      if (recordingResources.Count == 0) {
        html = HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "Sin predios asociados");
      } else if (recordingResources.Count >= 2) {
        html = HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "( Seleccionar el predio )");
      }
      foreach (Resource resource in recordingResources) {
        if (html.Contains(resource.UID)) {
          continue;
        }
        if (html.Length != 0) {
          html += "|";
        }
        html += HtmlSelectContent.GetComboAjaxHtmlItem(resource.Id.ToString(), resource.UID);
      }
      return html;
    }

    private string GetRecordingNumbersStringArrayCommandHandler() {
      int recordingBookId = GetCommandParameter<int>("recordingBookId", 0);

      if (recordingBookId == 0) {
        return HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "( ¿Libro? )");
      }
      var recordingBook = RecordingBook.Parse(recordingBookId);

      var recordings = recordingBook.GetRecordings();

      return HtmlSelectContent.GetComboAjaxHtml(recordings, 0, "Id", "Number",
                                                recordings.Count == 0 ? "(Libro vacío)" : "(Seleccionar)",
                                                (true || recordingBook.IsAvailableForManualEditing) ? "Crear nueva" : "",
                                                String.Empty);
    }

    private string GetRecordingRawDataCommandHandler() {
      int recordingId = int.Parse(GetCommandParameter("recordingId", true));
      Recording recording = Recording.Parse(recordingId);

      string rawData = String.Empty;

      rawData += recording.Document.PresentationTime.Date.ToString("dd/MMM/yyyy") + "|";
      rawData += recording.Document.PresentationTime.ToString("HH:mm") + "|";
      rawData += recording.AuthorizationTime.ToString("dd/MMM/yyyy") + "|";

      if (recording.Payments.Total > 0) {
        rawData += recording.Payments.Total.ToString("N2") + "|";
        rawData += "600" + "|";
        rawData += recording.Payments.ReceiptNumbers + "|";
        rawData += "" + "|";
      } else {
        rawData += "||||";
      }
      rawData += recording.AuthorizedBy.Id.ToString() + "|";

      if (recording.Document != null && !recording.Document.IsEmptyInstance) {
        rawData += recording.Document.DocumentType.Id.ToString() + "|";
      } else {
        rawData += "|";
      }
      return rawData;
    }

    private string GetRecordingDocumentRawDataCommandHandler() {
      int recordingId = int.Parse(GetCommandParameter("recordingId", true));
      Recording recording = Recording.Parse(recordingId);

      if (recording.Document.IsEmptyInstance) {
        return String.Empty;
      }

      string rawData = String.Empty;

      switch (recording.Document.DocumentType.Name) {
        case "ObjectType.RecordingDocument.Empty":
          return String.Empty;
        case "ObjectType.RecordingDocument.NotaryDeed":
          return GetNotaryDeedRecordingDocumentRawData(recording.Document);
        case "ObjectType.RecordingDocument.PropertyTitle":
          return GetPropertyTitleRecordingDocumentRawData(recording.Document);
        case "ObjectType.RecordingDocument.JudicialOrder":
          return GetJudicialOrderRecordingDocumentRawData(recording.Document);
        case "ObjectType.RecordingDocument.PrivateContract":
          return GetPrivateContractRecordingDocumentRawData(recording.Document);
      }

      return rawData;
    }

    private string GetNotaryDeedRecordingDocumentRawData(RecordingDocument document) {
      string rawData = "oNotaryPublicDeed|";

      rawData += document.IssuePlace.Id.ToString() + "|";
      rawData += document.IssueOffice.Id.ToString() + "|";
      rawData += document.IssuedBy.Id.ToString() + "|";
      rawData += document.ExtensionData.BookNo + "|";
      rawData += document.AsText + "|";
      rawData += document.ExtensionData.StartSheet + "|";
      rawData += document.ExtensionData.EndSheet + "|";
      rawData += document.IssueDate.ToString("dd/MMM/yyyy");

      return rawData;
    }

    private string GetPropertyTitleRecordingDocumentRawData(RecordingDocument document) {
      string rawData = "oEjidalSystemTitle|";

      rawData += document.Number + "|";
      rawData += document.IssuedBy.Id.ToString() + "|";
      rawData += document.IssueDate.ToString("dd/MMM/yyyy") + "|";
      rawData += document.IssueOffice.Id + "|";
      rawData += document.ExtensionData.StartSheet;

      return rawData;
    }

    private string GetJudicialOrderRecordingDocumentRawData(RecordingDocument document) {
      string rawData = "oJudgeOfficialLetter|";

      rawData += document.IssuePlace.Id.ToString() + "|";
      rawData += document.IssueOffice.Id.ToString() + "|";
      rawData += document.IssuedBy.Id.ToString() + "|";
      rawData += document.ExtensionData.BookNo + "|";
      rawData += document.Number + "|";
      rawData += document.IssueDate.ToString("dd/MMM/yyyy");

      return rawData;
    }

    private string GetPrivateContractRecordingDocumentRawData(RecordingDocument document) {
      string rawData = "oPrivateContract|";

      rawData += document.IssuePlace.Id.ToString() + "|";
      rawData += document.IssueDate.ToString("dd/MMM/yyyy") + "|";
      rawData += document.Number + "|";
      rawData += document.ExtensionData.MainWitnessPosition.Id.ToString() + "|";
      rawData += document.ExtensionData.MainWitness.Id.ToString();

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

      return HtmlSelectContent.GetComboAjaxHtml(list, 0, "Id", "FamilyFullName",
                                                "( Seleccionar al C. Juez )", String.Empty, "No consta");
    }

    private string GetJudicialOfficeInPlaceStringArrayCommandHandler() {
      int placeId = int.Parse(GetCommandParameter("placeId", false, "0"));

      if (placeId == 0) {
        return HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "( Primero seleccionar una ciudad )");
      }
      var place = GeographicRegion.Parse(placeId);
      FixedList<JudicialOffice> list = JudicialOffice.GetList(place);

      return HtmlSelectContent.GetComboAjaxHtml(list, 0, "Id", "Number",
                                                "( Seleccionar )", String.Empty, "No consta");
    }

    private string GetWitnessInPositionStringArrayCommandHandler() {
      int placeId = int.Parse(GetCommandParameter("placeId", false, "-1"));
      int positionId = int.Parse(GetCommandParameter("positionId", false, "0"));

      if (positionId == 0) {
        return HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty,
                                                      "( Primero seleccionar el rol del certificador )");
      } else if (positionId == -2) {
        return HtmlSelectContent.GetComboAjaxHtmlItem("-2", "No consta o no se puede determinar");
      }
      if (placeId == -1) {
        return HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "( Primero seleccionar una ciudad )");
      } else if (placeId == -2) {
        return HtmlSelectContent.GetComboAjaxHtmlItem("-2", "No consta o no se puede determinar");
      }

      var roleType = RoleType.Parse(positionId);
      var place = GeographicRegion.Parse(placeId);
      FixedList<Person> list = roleType.GetActors<Person>(place);

      return HtmlSelectContent.GetComboAjaxHtml(list, 0, "Id", "FamilyFullName", "( Seleccionar al certificador del contrato )",
                                                String.Empty, "No consta o no se puede determinar");
    }

    private string GetRecordingBooksStringArrayCommandHandler() {
      int recorderOfficeId = int.Parse(GetCommandParameter("recorderOfficeId", true));
      int recordingSectionId = int.Parse(GetCommandParameter("recordingActTypeCategoryId", false, "0"));

      if (recorderOfficeId == 0) {
        return HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "Primero seleccionar un Distrito");
      }
      if (recordingSectionId != 0) {
        RecorderOffice recorderOffice = RecorderOffice.Parse(recorderOfficeId);
        FixedList<RecordingBook> recordingBookList = null;

        RecordingSection recordingSection = RecordingSection.Parse(recordingSectionId);
        recordingBookList = recorderOffice.GetRecordingBooks(recordingSection);
        if (recordingBookList.Count != 0) {
          return HtmlSelectContent.GetComboAjaxHtml(recordingBookList, 0, "Id", "AsText", "( Seleccionar el libro registral donde se encuentra )");
        } else {
          return HtmlSelectContent.GetComboAjaxHtml("No existen libros registrales para el Distrito", String.Empty, String.Empty);
        }
      } else {
        return HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "( Seleccionar una sección registral )");
      }
    }

    private string GetDomainBooksStringArrayCommandHandler() {
      string sectionFilter = GetCommandParameter("sectionFilter", false, String.Empty);

      if (sectionFilter.Length == 0) {
        return HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "( Seleccionar un distrito o sección registral )");
      }
      FixedList<RecordingBook> booksList = RecordingBook.GetList(sectionFilter);
      if (booksList.Count != 0) {
        return HtmlSelectContent.GetComboAjaxHtml(booksList, 0, "Id", "AsText", "( Seleccionar el libro registral )");
      } else {
        return HtmlSelectContent.GetComboAjaxHtml("No existen libros registrales para el Distrito", String.Empty, String.Empty);
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
        FixedList<RecordingActType> list = recordingActTypeCategory.RecordingActTypes;

        return HtmlSelectContent.GetComboAjaxHtml(list, 0, "Id", "DisplayName", "( Seleccionar el tipo de movimiento que se desea agregar )");
      } else {
        return HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "( Primero seleccionar la categoría del movimiento )");
      }
    }

    private string GetCadastralOfficeMunicipalitiesComboCommandHandler() {
      int cadastralOfficeId = int.Parse(GetCommandParameter("cadastralOfficeId", false, "0"));

      if (cadastralOfficeId != 0) {
        RecorderOffice cadastralOffice = RecorderOffice.Parse(cadastralOfficeId);
        FixedList<Municipality> list = cadastralOffice.GetMunicipalities();
        if (list.Count != 0) {
          return HtmlSelectContent.GetComboAjaxHtml(list, 0, "Id", "Name", "( Seleccionar un municipio )");
        } else {
          return HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "( No hay municipios definidos )");
        }
      } else {
        return HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "( Primero seleccionar un Distrito )");
      }
    }

    //private string GetDirectoryImageUrlCommandHandler() {
    //  bool attachment = bool.Parse(GetCommandParameter("attachment", false, "false"));

    //  if (attachment) {
    //    return GetAttachmentImageDirectoryCommandHandler();
    //  }

    //  string position = GetCommandParameter("position", true);
    //  int currentPosition = int.Parse(GetCommandParameter("currentPosition", true));

    //  int recordingId = int.Parse(GetCommandParameter("recordingId", false, "0"));
    //  RecordBookDirectory directory = null;

    //  if (recordingId == 0) {
    //    int directoryId = int.Parse(GetCommandParameter("directoryId", true));
    //    directory = RecordBookDirectory.Parse(directoryId);
    //  } else {
    //    Recording recording = Recording.Parse(recordingId);
    //    if (currentPosition == -1) {
    //      currentPosition = recording.StartImageIndex - 1;
    //    }
    //    directory = recording.RecordingBook.ImagingFilesFolder;
    //  }

    //  if (!EmpiriaString.IsInteger(position)) {
    //    switch (position) {
    //      case "first":
    //        return directory.GetImageURL(0);
    //      case "previous":
    //        return directory.GetImageURL(Math.Max(currentPosition - 1, 0));
    //      case "next":
    //        return directory.GetImageURL(Math.Min(currentPosition + 1, directory.FilesCount - 1));
    //      case "last":
    //        return directory.GetImageURL(directory.FilesCount - 1);
    //      case "refresh":
    //        return directory.GetImageURL(currentPosition);
    //      default:
    //        return directory.GetImageURL(currentPosition);
    //    }
    //  } else {
    //    return directory.GetImageURL(int.Parse(position));
    //  }
    //}

    //private string GetAttachmentImageDirectoryCommandHandler() {
    //  string position = GetCommandParameter("position", true);
    //  string folderName = GetCommandParameter("name", false, String.Empty);

    //  int currentPosition = int.Parse(GetCommandParameter("currentPosition", true));

    //  int recordingId = int.Parse(GetCommandParameter("recordingId", false, "0"));

    //  Recording recording = Recording.Parse(recordingId);
    //  if (currentPosition == -1) {
    //    currentPosition = 0;
    //  }
    //  RecordingAttachmentFolder folder = recording.GetAttachementFolder(folderName);

    //  if (!EmpiriaString.IsInteger(position)) {
    //    switch (position) {
    //      case "first":
    //        return folder.GetImageURL(0);
    //      case "previous":
    //        return folder.GetImageURL(Math.Max(currentPosition - 1, 0));
    //      case "next":
    //        return folder.GetImageURL(Math.Min(currentPosition + 1, folder.FilesCount - 1));
    //      case "last":
    //        return folder.GetImageURL(folder.FilesCount - 1);
    //      case "refresh":
    //        return folder.GetImageURL(currentPosition);
    //      default:
    //        return folder.GetImageURL(currentPosition);
    //    }
    //  } else {
    //    return folder.GetImageURL(int.Parse(position));
    //  }
    //}

    private string GetNotaryOfficesInPlaceStringArrayCommandHandler() {
      int placeId = int.Parse(GetCommandParameter("placeId", false, "0"));

      if (placeId == 0) {
        return HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "( Primero seleccionar una ciudad )");
      }
      var place = GeographicRegion.Parse(placeId);
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
      string number = GetCommandParameter("number", true);
      string subNumber = GetCommandParameter("subNumber", false, String.Empty);
      string bisSuffixNumber = GetCommandParameter("bisSuffixNumber", false, String.Empty);

      var recordingBook = RecordingBook.Parse(recordingBookId);
      var recording = recordingBook.FindRecording(int.Parse(number), subNumber, bisSuffixNumber);
      if (recording != null) {
        return recording.Id.ToString();
      } else {
        return "0";
      }
    }

    //private string GetRecordingBookImageCountCommandHandler() {
    //  bool attachment = bool.Parse(GetCommandParameter("attachment", false, "false"));

    //  if (attachment) {
    //    return GetAttachmentImageCountCommandHandler();
    //  }
    //  int recordingId = int.Parse(GetCommandParameter("recordingId", false, "0"));
    //  RecordingBook recordingBook = null;
    //  if (recordingId == 0) {
    //    int recordingBookId = int.Parse(GetCommandParameter("recordingBookId", true));
    //    recordingBook = RecordingBook.Parse(recordingBookId);
    //  } else {
    //    Recording recording = Recording.Parse(recordingId);
    //    recordingBook = recording.RecordingBook;
    //  }
    //  return recordingBook.ImagingFilesFolder.FilesCount.ToString();
    //}

    //private string GetAttachmentImageCountCommandHandler() {
    //  int recordingId = int.Parse(GetCommandParameter("recordingId", false, "0"));
    //  string folderName = GetCommandParameter("name", false, String.Empty);

    //  Recording recording = Recording.Parse(recordingId);

    //  RecordingAttachmentFolder folder = recording.GetAttachementFolder(folderName);

    //  return folder.FilesCount.ToString();
    //}

    private string GetRecordingStartImageIndexCommandHandler() {
      int recordingId = int.Parse(GetCommandParameter("recordingId", true));
      Recording recording = Recording.Parse(recordingId);

      return recording.StartImageIndex.ToString();
    }

    private string GetRecordingsViewerPageCommandHandler() {
      int recordingBookId = int.Parse(GetCommandParameter("recordingBookId", true));
      int page = int.Parse(GetCommandParameter("page", true));
      int pageSize = int.Parse(GetCommandParameter("itemsPerPage", true));

      RecordingBook recordingBook = RecordingBook.Parse(recordingBookId);

      return LRSGridControls.GetRecordingsSummaryTable(recordingBook, pageSize, page);
    }

    private string GetRecordingTypesStringArrayCommandHandler() {
      int recordingActTypeCategoryId = int.Parse(GetCommandParameter("recordingActTypeCategoryId", false, "0"));
      bool filtered = base.GetCommandParameter<bool>("filtered", false);

      string items = String.Empty;
      if (recordingActTypeCategoryId != 0) {
        RecordingActTypeCategory recordingActTypeCategory = RecordingActTypeCategory.Parse(recordingActTypeCategoryId);

        FixedList<RecordingActType> list = null;
        if (filtered) {
          list = recordingActTypeCategory.RecordingActTypes.FindAll((x) => x.RecordingRule.IsActive).ToFixedList();
        } else {
          list = recordingActTypeCategory.RecordingActTypes;
        }
        return HtmlSelectContent.GetComboAjaxHtml(list, 0, "Id", "DisplayName",
                                                  "( ¿Qué acto jurídico se agregará al documento? )");
      } else {
        return HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "( Primero seleccionar el tipo de acto )");
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
      int annotationBookId = base.GetCommandParameter<int>("annotationBookId");
      int annotationTypeId = base.GetCommandParameter<int>("annotationTypeId");
      int number = int.Parse(GetCommandParameter("number", false));
      bool bisSuffixNumber = bool.Parse(GetCommandParameter("bisSuffixNumber", true));
      int imageStartIndex = int.Parse(GetCommandParameter("imageStartIndex", true));
      int imageEndIndex = int.Parse(GetCommandParameter("imageEndIndex", true));
      int propertyId = int.Parse(GetCommandParameter("propertyId", true));
      DateTime presentationTime = EmpiriaString.ToDateTime(GetCommandParameter("presentationTime", false,
                                                           ExecutionServer.DateMinValue.ToString("dd/MMM/yyyy")));
      DateTime authorizationDate = EmpiriaString.ToDate(GetCommandParameter("authorizationDate", false,
                                                        ExecutionServer.DateMaxValue.ToString("dd/MMM/yyyy")));
      int authorizedById = int.Parse(GetCommandParameter("authorizedById", false, "-1"));

      RecordingBook recordingBook = RecordingBook.Parse(annotationBookId);
      RecordingActType annotationType = RecordingActType.Parse(annotationTypeId);
      Person authorizedBy = Person.Parse(authorizedById);
      Property property = Property.Parse(propertyId);

      LandRegistrationException exception = null;
      if (presentationTime != ExecutionServer.DateMinValue) {
        exception = LRSValidator.ValidateRecordingDates(recordingBook, Recording.Empty,
                                                        presentationTime, authorizationDate);
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
      throw new NotImplementedException();

      //int recordingId = int.Parse(GetCommandParameter("recordingId", true));
      //int recordingActId = int.Parse(GetCommandParameter("recordingActId", true));
      //int propertyId = int.Parse(GetCommandParameter("propertyId", true));

      //Recording recording = Recording.Parse(recordingId);
      //RecordingAct recordingAct = recording.GetRecordingAct(recordingActId);
      //Resource resource = recordingAct.GetPropertyEvent(Property.Parse(propertyId)).Resource;

      //LandRegistrationException exception = null;
      //exception = LRSValidator.ValidateDeleteRecordingActProperty(recordingAct, resource);

      //if (exception != null) {
      //  return exception.Message;
      //}
      //return String.Empty;
    }

    private string ValidateNextTransactionStateCommandHandler() {
      int transactionId = int.Parse(GetCommandParameter("transactionId", true));
      TransactionStatus nextStatus = (TransactionStatus) char.Parse(GetCommandParameter("newState", true));

      LRSTransaction transaction = LRSTransaction.Parse(transactionId);

      return transaction.ValidateStatusChange(nextStatus);
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
      string subNumber = GetCommandParameter("subNumber", false, String.Empty);
      string bisSuffixNumber = GetCommandParameter("bisSuffixNumber", false, String.Empty);
      int imageStartIndex = int.Parse(GetCommandParameter("imageStartIndex", false, "-1"));
      int imageEndIndex = int.Parse(GetCommandParameter("imageEndIndex", false, "-1"));
      DateTime presentationTime = EmpiriaString.ToDateTime(GetCommandParameter("presentationTime", false,
                                                           ExecutionServer.DateMinValue.ToString("dd/MMM/yyyy")));
      DateTime authorizationDate = EmpiriaString.ToDate(GetCommandParameter("authorizationDate", false,
                                                        ExecutionServer.DateMaxValue.ToString("dd/MMM/yyyy")));
      int authorizedById = int.Parse(GetCommandParameter("authorizedById", false, "-1"));

      RecordingBook recordingBook = RecordingBook.Parse(recordingBookId);
      Recording recording = null;
      Person authorizedBy = Person.Parse(authorizedById);

      if (recordingId != 0) {
        recording = Recording.Parse(recordingId);
      } else {
        recording = Recording.Empty;
      }
      LandRegistrationException exception = null;
      exception = LRSValidator.ValidateRecordingNumber(recordingBook, recording, number, subNumber, bisSuffixNumber,
                                                       imageStartIndex, imageEndIndex);
      if (exception != null) {
        return exception.Message;
      }
      if (presentationTime != ExecutionServer.DateMinValue) {
        exception = LRSValidator.ValidateRecordingDates(recordingBook, recording,
                                                        presentationTime, authorizationDate);
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

    private string ValidateDocumentRecordingActCommandHandler() {
      try {
        RecordingTask task = ParseRecordingTaskParameters();
        task.AssertValid();
      } catch (Exception e) {
        return e.Message;
      }
      return String.Empty;
    }

    private RecordingTask ParseRecordingTaskParameters() {
      var task = new RecordingTask(
         transactionId: GetCommandParameter<int>("transactionId", -1),
         documentId: GetCommandParameter<int>("documentId", -1),
         recordingActTypeCategoryId: GetCommandParameter<int>("recordingActTypeCategoryId", -1),
         recordingActTypeId: GetCommandParameter<int>("recordingActTypeId"),
         propertyType: (PropertyRecordingType) Enum.Parse(typeof(PropertyRecordingType),
                                                          GetCommandParameter<string>("propertyType")),
         precedentRecordingBookId: GetCommandParameter<int>("precedentRecordingBookId", -1),
         precedentRecordingId: GetCommandParameter<int>("precedentRecordingId", -1),
         precedentResourceId: GetCommandParameter<int>("precedentPropertyId", -1),
         quickAddRecordingNumber: GetCommandParameter<int>("quickAddRecordingNumber", -1),
         quickAddRecordingSubnumber: GetCommandParameter<string>("quickAddRecordingSubNumber", String.Empty),
         quickAddRecordingSuffixTag: GetCommandParameter<string>("quickAddRecordingSuffixTag", String.Empty)
      );
      return task;
    }

    #endregion Private command handlers

  } // class WorkplaceData

} // namespace Empiria.Web.UI.Ajax
