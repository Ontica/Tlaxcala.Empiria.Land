/* Empiria Land *********************************************************************************************
*                                                                                                           *
*  Solution  : Empiria Land                                     System   : Land Intranet Application        *
*  Namespace : Empiria.Web.UI.Ajax                              Assembly : Empiria.Land.Intranet.dll        *
*  Type      : LandRegistrationSystemData                       Pattern  : Ajax Services Web Page           *
*  Version   : 3.0                                              License  : Please read license.txt file     *
*                                                                                                           *
*  Summary   : Gets Empiria control contents through Ajax invocation.                                       *
*                                                                                                           *
************************* Copyright(c) La Vía Óntica SC, Ontica LLC and contributors. All rights reserved. **/
using System;

using Empiria.DataTypes;
using Empiria.Contacts;
using Empiria.Geography;
using Empiria.Json;

using Empiria.Documents;
using Empiria.Land.Certification;
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
        case "getAssigneeComboStringArrayCmd":
          return GetAssigneeComboStringArrayCommandHandler();
        case "getImageSetImageURL":
          return GetImageSetImageURLCommandHandler();
        case "getRecordingBookImageSetId":
          return GetRecordingBookImageSetIdCommandHandler();
        case "getTargetPrecedentActsTableCmd":
          return GetTargetPrecedentActsTableCommandHandler();
        case "getTargetActSectionsStringArrayCmd":
          return TargetActSectionsCommandHandler();
        case "getDomainTraslativeSectionsCmd":
          return DomainTraslativeSectionsCommandHandler();
        case "getRecordingActTypesEditingCategoriesCmd":
          return RecordingActTypesEditingCategoriesCommandHandler();
        case "getRecordingActRuleCmd":
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
        case "getRecordingIdCmd":
          return GetRecordingIdCommandHandler();
        case "getLawArticlesStringArrayCmd":
          return GetLawArticlesStringArrayCommandHandler();
        case "getRecordingRawData":
          return GetRecordingRawDataCommandHandler();
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


        case "validateIfCertificateCanBeEditedCmd":
          return ValidateIfCertificateCanBeEditedCommandHandler();

        case "validateIfDocumentCanBeCloseCmd":
          // Very rare: If use 'validateIfDocumentCanBeClosedCmd' then ajax never dispatches the call
          return ValidateIfDocumentCanBeClosedCommandHandler();
        case "validateIfDocumentCanBeOpenedCmd":
          return ValidateIfDocumentCanBeOpenedCommandHandler();
        case "validateDocumentRecordingActCmd":
          return ValidateDocumentRecordingActCommandHandler();
        case "validateAnnotationSemanticsCmd":
          return ValidateAnnotationSemanticsCommandHandler();
        case "validateNextTransactionStateCmd":
          return ValidateNextTransactionStateCommandHandler();
        case "validateRecordingSemanticsCmd":
          return ValidateRecordingSemanticsCommandHandler();
        case "validateRecordingActAsCompleteCmd":
          return ValidateRecordingActAsCompleteCommandHandler();

        case "validateTakeTransactionCmd":
          return ValidateTakeTransactionCommandHandler();

        default:
          throw new WebPresentationException(WebPresentationException.Msg.UnrecognizedCommandName,
                                             commandName);
      }
    }


    private string GetAssigneeComboStringArrayCommandHandler() {
      int transactionId = GetCommandParameter<int>("transactionId");
      var transaction = LRSTransaction.Parse(transactionId);


      string operationString = GetCommandParameter<string>("operation");

      FixedList<Contact> list;

      if (operationString == "AssignTo") {
        list = LRSHtmlSelectControls.GetAsigneeComboItems(transaction, transaction.Workflow.NextStatus);
      } else {
        char operation = Convert.ToChar(operationString);
        list = LRSHtmlSelectControls.GetAsigneeComboItems(transaction, (LRSTransactionStatus) operation);
      }

      return HtmlSelectContent.GetComboAjaxHtml(list, 0, "Id", "Alias",
                                                "( Seleccionar )", String.Empty, String.Empty);
    }


    private string GetResourceCommandHandler() {
      string resourceUID = GetCommandParameter<string>("resourceUID");

      var resource = Resource.TryParseWithUID(resourceUID, false);

      var json = new JsonObject();

      if (resource != null) {
        json.Add("Id", resource.Id);
      } else {
        json.Add("Id", -1);
      }

      return json.ToString();
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

      string html = HtmlSelectContent.GetComboAjaxHtmlItem("", "( Seleccionar el distrito y sección )");
      if (recordingActType.IsInformationActType || section.IsEmptyInstance) {
        html += "|" + HtmlSelectContent.GetComboAjaxHtmlItem("annotation", "Registrado al margen");
      }
      if (section != RecordingSection.Empty && section.Id == 1051) {
        var list = GeneralList.Parse("LRSDomainTraslativeSection.Combo.List");
        html += "|" + HtmlSelectContent.GetComboAjaxHtml(list.GetItems<NameValuePair>(), 0,
                                                         "Value", "Name");

      } else if (section != RecordingSection.Empty && section.Id == 1052) {
        var list = GeneralList.Parse("LRSLimitationSection.Combo.List");
        html += "|" + HtmlSelectContent.GetComboAjaxHtmlItem("annotation", "Registrado al margen");
        html += "|" + HtmlSelectContent.GetComboAjaxHtml(list.GetItems<NameValuePair>(), 0,
                                                         "Value", "Name");
      } else if (section != RecordingSection.Empty && section.Id == 1054) {
        var list = GeneralList.Parse("LRSSectionFourth.Combo.List");
        html += "|" + HtmlSelectContent.GetComboAjaxHtml(list.GetItems<NameValuePair>(), 0,
                                                         "Value", "Name");
      } else if (section != RecordingSection.Empty && section.Id == 1055) {
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
      var resource = RealEstate.Parse(resourceId);

      var appliesTo = recordingActType.GetAppliesToRecordingActTypesList();

      var list = resource.Tract.GetRecordingActs();

      return HtmlSelectContent.GetComboAjaxHtml<RecordingAct>(list.FindAll((x) => appliesTo.Contains(x.RecordingActType)),
                                "Id", (x) => x.RecordingActType.DisplayName + " " + x.Document.UID + " " +
                                       x.Document.AuthorizationTime + " " + x.AmendedBy.Id + " " + x.StatusName,
                                "( Seleccionar el acto jurídico )");
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
                                      recordingActType.IsCancelationActType ? "( Acto jurídico a cancelar )" :
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

      if (!rule.IsActive) {
        return HtmlSelectContent.GetComboAjaxHtmlItem("undefinedRule", "**REGLA NO DEFINIDA**");
      }
      switch (rule.AppliesTo) {
        case RecordingRuleApplication.Association:
          if (rule.ResourceRecordingStatus == ResourceRecordingStatus.Unregistered ||
              rule.ResourceRecordingStatus == ResourceRecordingStatus.Both) {
            html = HtmlSelectContent.GetComboAjaxHtmlItem("createProperty", "Nueva Sociedad/Asociación");
            counter++;
          }
          if (rule.ResourceRecordingStatus == ResourceRecordingStatus.Registered ||
              rule.ResourceRecordingStatus == ResourceRecordingStatus.Both) {
            if (html.Length != 0) {
              html += "|";
            }
            html += HtmlSelectContent.GetComboAjaxHtmlItem("selectProperty", "Sociedad/Asoc ya registrada");
            counter++;
          }
          break;
        case RecordingRuleApplication.RealEstate:
        case RecordingRuleApplication.Structure:
          if (rule.ResourceRecordingStatus == ResourceRecordingStatus.Unregistered ||
              rule.ResourceRecordingStatus == ResourceRecordingStatus.Both) {
            html = HtmlSelectContent.GetComboAjaxHtmlItem("createProperty", "Predio sin antecedente registral");
            counter++;
          }
          if (rule.AppliesTo == RecordingRuleApplication.Structure ||
              rule.ResourceRecordingStatus == ResourceRecordingStatus.Registered ||
              rule.ResourceRecordingStatus == ResourceRecordingStatus.Both) {
            if (html.Length != 0) {
              html += "|";
            }
            html += HtmlSelectContent.GetComboAjaxHtmlItem("selectProperty", "Predio ya registrado");
            counter++;
          }
          if (rule.AllowPartitions) {
            if (html.Length != 0) {
              html += "|";
            }
            html += HtmlSelectContent.GetComboAjaxHtmlItem("createPartition", "Fracción de predio ya registrado");
            counter++;
          }
          break;
        case RecordingRuleApplication.AssociationAct:
        case RecordingRuleApplication.NoPropertyAct:
        case RecordingRuleApplication.RealEstateAct:
          html += HtmlSelectContent.GetComboAjaxHtmlItem("actAppliesToOtherRecordingAct", "Ya registrado");
          counter++;
          break;
        case RecordingRuleApplication.NoProperty:
          html += HtmlSelectContent.GetComboAjaxHtmlItem("actAppliesToDocument", "No aplica a predios o asoc");
          counter++;
          break;
        default:
          break;
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
      var recording = PhysicalRecording.Parse(recordingId);
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

      PhysicalRecording recording = PhysicalRecording.Parse(recordingId);
      RecordingDocument mainDocument = recording.MainDocument;

      string rawData = String.Empty;

      rawData += mainDocument.PresentationTime.Date.ToString("dd/MMM/yyyy") + "|";
      rawData += mainDocument.PresentationTime.ToString("HH:mm") + "|";
      rawData += mainDocument.AuthorizationTime.ToString("dd/MMM/yyyy") + "|";

      rawData += "||||";

      rawData += recording.AuthorizedBy.Id.ToString() + "|";

      if (!mainDocument.IsEmptyInstance) {
        rawData += mainDocument.DocumentType.Id.ToString() + "|";
      } else {
        rawData += "|";
      }
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

    private string GetRecordingBookImageSetIdCommandHandler() {
      int recordingBookId = int.Parse(GetCommandParameter("recordingBookId", true));

      var recordingBook = RecordingBook.Parse(recordingBookId);

      return recordingBook.ImageSetId.ToString();
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


    private string GetImageSetImageURLCommandHandler() {
      int imageSetId = int.Parse(GetCommandParameter("imageSetId", true));
      int index = int.Parse(GetCommandParameter("index", true));

      var imageSet = ImageSet.Parse(imageSetId);

      return imageSet.UrlRelativePath + imageSet.ImagesNamesArray[index];
    }


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


    private string GetRecordingIdCommandHandler() {
      int recordingBookId = int.Parse(GetCommandParameter("recordingBookId", true));
      string recordingNumber = GetCommandParameter("recordingNumber", true);

      var recordingBook = RecordingBook.Parse(recordingBookId);
      var recording = recordingBook.TryGetRecording(recordingNumber);
      if (recording != null) {
        return recording.Id.ToString();
      } else {
        return "0";
      }
    }


    private string GetRecordingStartImageIndexCommandHandler() {
      int recordingId = int.Parse(GetCommandParameter("recordingId", true));
      PhysicalRecording recording = PhysicalRecording.Parse(recordingId);

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

      string items = String.Empty;
      if (recordingActTypeCategoryId != 0) {
        RecordingActTypeCategory recordingActTypeCategory = RecordingActTypeCategory.Parse(recordingActTypeCategoryId);

        FixedList<RecordingActType> list = recordingActTypeCategory.RecordingActTypes;

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
      RealEstate property = RealEstate.Parse(propertyId);

      LandRegistrationException exception = null;
      if (presentationTime != ExecutionServer.DateMinValue) {
        exception = LRSValidator.ValidateRecordingDates(recordingBook, PhysicalRecording.Empty,
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


    private string ValidateNextTransactionStateCommandHandler() {
      int transactionId = int.Parse(GetCommandParameter("transactionId", true));
      LRSTransactionStatus nextStatus = (LRSTransactionStatus) char.Parse(GetCommandParameter("newState", true));

      LRSTransaction transaction = LRSTransaction.Parse(transactionId);

      return LRSWorkflowRules.ValidateStatusChange(transaction, nextStatus);
    }


    private string ValidateTakeTransactionCommandHandler() {
      int transactionId = int.Parse(GetCommandParameter("transactionId", true));
      LRSTransaction transaction = LRSTransaction.Parse(transactionId);

      return LRSWorkflowRules.ValidateTakeTransaction(transaction);
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
      string recordingNumber = GetCommandParameter("recordingNumber", String.Empty);
      int imageStartIndex = int.Parse(GetCommandParameter("imageStartIndex", false, "-1"));
      int imageEndIndex = int.Parse(GetCommandParameter("imageEndIndex", false, "-1"));
      DateTime presentationTime = EmpiriaString.ToDateTime(GetCommandParameter("presentationTime", false,
                                                           ExecutionServer.DateMinValue.ToString("dd/MMM/yyyy")));
      DateTime authorizationDate = EmpiriaString.ToDate(GetCommandParameter("authorizationDate", false,
                                                        ExecutionServer.DateMaxValue.ToString("dd/MMM/yyyy")));
      int authorizedById = int.Parse(GetCommandParameter("authorizedById", false, "-1"));

      RecordingBook recordingBook = RecordingBook.Parse(recordingBookId);
      PhysicalRecording recording = null;
      Person authorizedBy = Person.Parse(authorizedById);

      if (recordingId != 0) {
        recording = PhysicalRecording.Parse(recordingId);
      } else {
        recording = PhysicalRecording.Empty;
      }
      LandRegistrationException exception = null;

      exception = LRSValidator.ValidateRecordingNumber(recordingBook, recording, recordingNumber);
      if (exception != null) {
        return exception.Message;
      }

      exception = ValidateRecordingImageRange(recordingBook, imageStartIndex, imageEndIndex);
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


    private string ValidateIfCertificateCanBeEditedCommandHandler() {
      try {
        string certificateUID = GetCommandParameter<string>("certificateUID");
        var certificate = FormerCertificate.TryParse(certificateUID);

        if (certificate.Signed()) {
          return "El certificado no puede ser editado debido a que ya tiene firma electrónica.\n\n" +
                 "Para editarlo, por favor solicite la revocación de la firma en la Dirección.";
        }
        return String.Empty;

      } catch (Exception e) {
        return e.Message;
      }
    }


    private string ValidateIfDocumentCanBeClosedCommandHandler() {
      try {
        int documentId = GetCommandParameter<int>("documentId");
        var document = RecordingDocument.Parse(documentId);

        document.Security.AssertCanBeClosed();
      } catch (Exception e) {
        return e.Message;
      }
      return String.Empty;
    }


    private string ValidateIfDocumentCanBeOpenedCommandHandler() {
      try {
        int documentId = GetCommandParameter<int>("documentId");
        var document = RecordingDocument.Parse(documentId);

        document.Security.AssertCanBeOpened();
      } catch (Exception e) {
        return e.Message;
      }
      return String.Empty;
    }


    private LandRegistrationException ValidateRecordingImageRange(RecordingBook recordingBook,
                                                                  int imageStartIndex, int imageEndIndex) {
      var imageSet = Land.Documentation.RecordingBookImageSet.Parse(recordingBook.ImageSetId);

      if ((imageStartIndex == 0) || (imageEndIndex == 0) ||
          (imageStartIndex > imageEndIndex) || (imageEndIndex > imageSet.FilesCount)) {
        return new LandRegistrationException(LandRegistrationException.Msg.InvalidRecordingImageRange,
                                             recordingBook.AsText, imageStartIndex, imageEndIndex, imageSet.FilesCount);
      }
      return null;
    }


    private RecordingTask ParseRecordingTaskParameters() {
      var task = new RecordingTask(
         documentId: GetCommandParameter<int>("documentId", -1),
         recordingActTypeId: GetCommandParameter<int>("recordingActTypeId"),
         recordingTaskType: (RecordingTaskType) Enum.Parse(typeof(RecordingTaskType),
                                                          GetCommandParameter<string>("recordingTaskType")),
         precedentRecordingId: GetCommandParameter<int>("precedentRecordingId", -1),
         precedentResourceId: GetCommandParameter<int>("precedentPropertyId", -1)
      );
      return task;
    }

    #endregion Private command handlers

  } // class WorkplaceData

} // namespace Empiria.Web.UI.Ajax
