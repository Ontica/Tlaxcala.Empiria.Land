﻿/* Empiria Land ***********************************************************************************************
*                                                                                                             *
*  Solution  : Empiria Land                                    System   : Land Registration System            *
*  Namespace : Empiria.Land.UI                                 Assembly : Empiria.Land.UI                     *
*  Type      : LRSHtmlSelectControls                           Pattern  : Static Class                        *
*  Version   : 3.0                                             License  : Please read license.txt file        *
*                                                                                                             *
*  Summary   : Static class that generates predefined HtmlSelect controls content for Empiria Government      *
*              Land Registration System.                                                                      *
*                                                                                                             *
************************** Copyright(c) La Vía Óntica SC, Ontica LLC and contributors. All rights reserved. **/
using System;
using System.Collections.Generic;
using System.Web.UI.HtmlControls;

using Empiria.Contacts;
using Empiria.DataTypes;
using Empiria.Geography;

using Empiria.Presentation;
using Empiria.Presentation.Web;
using Empiria.Presentation.Web.Content;

using Empiria.Land.Registration;
using Empiria.Land.Registration.Transactions;

namespace Empiria.Land.UI {

  /// <summary>Static class that generates predefined HtmlSelect controls content for
  /// Empiria Government Land Registration System.</summary>
  static public class LRSHtmlSelectControls {

    #region Public methods

    static public void LoadLegacyAnnotationActTypesCategoriesCombo(HtmlSelect comboControl) {
      var list = RecordingActTypeCategory.GetList("LegacyAnnotationActTypesCategories.List");

      HtmlSelectContent.LoadCombo(comboControl, list, "Id", "Name", "( Tipo de limitación )");
    }


    static public void LoadLegacyTraslativeActTypesCategoriesCombo(HtmlSelect comboControl) {
      var list = RecordingActTypeCategory.GetList("LegacyTraslativeActTypesCategories.List");

      HtmlSelectContent.LoadCombo(comboControl, list, "Id", "Name", "( Tipo de acto jurídico )");
    }


    static public void LoadRecordingActTypesCategoriesCombo(HtmlSelect comboControl) {
      var list = RecordingActTypeCategory.GetList("RecordingActTypesCategories.List");

      HtmlSelectContent.LoadCombo(comboControl, list, "Id", "Name", "( Tipo de acto jurídico )");
    }


    static public void LoadTransactionActTypesCategoriesCombo(HtmlSelect comboControl) {
      var list = RecordingActTypeCategory.GetList("TransactionActTypesCategories.List");

      HtmlSelectContent.LoadCombo(comboControl, list, "Id", "Name");
    }


    static public void LoadRecordingBookClassesCombo(HtmlSelect comboControl, string headerItemText,
                                                     RecordingActTypeCategory defaultItem) {
      var list = RecordingActTypeCategory.GetList("RecordingBookClasses.List");

      HtmlSelectContent.LoadCombo(comboControl, list, "Id", "Name", headerItemText);
      if (defaultItem != null && !defaultItem.IsEmptyInstance) {
        comboControl.Value = defaultItem.Id.ToString();
      }
    }


    static public string GetTransactionNewStatusComboItems(int typeId, int docTypeId,
                                                          LRSTransactionStatus currentStatus) {
      var rules = new Transactions.Workflow.WorkflowRules();

      List<LRSTransactionStatus> list = rules.NextStatusList(LRSTransactionType.Parse(typeId),
                                                             LRSDocumentType.Parse(docTypeId),
                                                             currentStatus);
      string html = String.Empty;
      for (int i = 0; i < list.Count; i++) {
        string statusValue = Convert.ToString((char) list[i]);
        string statusName = LRSWorkflowRules.GetStatusName(list[i]);

        html += HtmlSelectContent.GetComboHtmlItem(statusValue, statusName);
      }
      return html;
    }


    static public string GetControlDeskTransactionNewStatusComboItems(int typeId, int docTypeId,
                                                                      LRSTransactionStatus currentStatus,
                                                                      LRSTransactionStatus nextStatus) {
      if (currentStatus == LRSTransactionStatus.Archived) {
        return HtmlSelectContent.GetComboHtmlItem("Unarchive", "Desarchivarlo y ponerlo en la mesa de control");

      } else if (currentStatus == LRSTransactionStatus.Payment || currentStatus == LRSTransactionStatus.Returned ||
                 currentStatus == LRSTransactionStatus.Delivered || currentStatus == LRSTransactionStatus.Deleted) {
        return HtmlSelectContent.GetComboHtmlItem("Nothing", "No se puede hacer nada con este trámite");

      } else if (currentStatus == LRSTransactionStatus.Control && nextStatus == LRSTransactionStatus.EndPoint) {
        return GetTransactionNewStatusComboItems(typeId, docTypeId, currentStatus);

      } else if (currentStatus == LRSTransactionStatus.Control && nextStatus != LRSTransactionStatus.EndPoint) {
        return HtmlSelectContent.GetComboHtmlItem("AssignTo", "Asignar este trámite") +
               HtmlSelectContent.GetComboHtmlItem("ReturnToControlDesk", "Dejar pendiente el 'Siguiente estado'");

      } else if (currentStatus == LRSTransactionStatus.Received && nextStatus != LRSTransactionStatus.Control
                                                                && nextStatus != LRSTransactionStatus.EndPoint) {
        return HtmlSelectContent.GetComboHtmlItem("AssignTo", "Asignar este trámite") +
               HtmlSelectContent.GetComboHtmlItem("PullToControlDesk", "Traerlo a la mesa de control");

      } else if (currentStatus != LRSTransactionStatus.Control && nextStatus == LRSTransactionStatus.Control) {
        return HtmlSelectContent.GetComboHtmlItem("ReceiveInControlDesk", "Listo para recibirse en mesa de control");

      } else if (currentStatus != LRSTransactionStatus.Control && nextStatus != LRSTransactionStatus.Control) {
        return HtmlSelectContent.GetComboHtmlItem("PullToControlDesk", "Traerlo a la mesa de control");

      } else {
        return HtmlSelectContent.GetComboHtmlItem("Undefined", "Opción no definida. Informar a soporte.");

      }
    }


    static public FixedList<Contact> GetAsigneeComboItems(LRSTransaction transaction,
                                                          LRSTransactionStatus operation) {
      string[] contacts;

      switch (operation) {
        case LRSTransactionStatus.Recording:
          contacts = ConfigurationData.GetString("Empiria.Security",
                                                 "User.Operation.Tag.LRSTransaction.Register").Split('|');
          return LoadContactsList(contacts);

        case LRSTransactionStatus.Elaboration:
          contacts = ConfigurationData.GetString("Empiria.Security",
                                                 "User.Operation.Tag.LRSTransaction.Certificates").Split('|');
          return LoadContactsList(contacts);

        case LRSTransactionStatus.Juridic:
          contacts = ConfigurationData.GetString("Empiria.Security",
                                                 "User.Operation.Tag.LRSTransaction.Juridic").Split('|');

          return LoadContactsList(contacts);

        default:
          return new FixedList<Contact>();
      }
    }


    static public string GetRecordingBookClassesComboItems(string headerItemText) {
      var list = RecordingActTypeCategory.GetList("RecordingBookClasses.List");

      return HtmlSelectContent.GetComboHtml(list, "Id", "Name", headerItemText);
    }


    static public string GetBookImageClippersComboItems(RecorderOffice recorderOffice,
                                                        ComboControlUseMode comboControlUseMode,
                                                        Contact defaultBookImageClipper) {
      throw new NotImplementedException("GetBookImageClippersComboItems()");

      //FixedList<Contact> contacts = recorderOffice.GetContactsInRole<Contact>("RecorderOffice->ImageClippers");
      //return GetContactsInRoleComboItems(contacts, defaultBookImageClipper, comboControlUseMode,
      //                                   "( Seleccionar al cortador del libro )",
      //                                   "( Todos los cortadores de libros )",
      //                                   "No hay cortadores definidos");
    }


    static public string GetBookImageDigitalizersComboItems(RecorderOffice recorderOffice,
                                                            ComboControlUseMode comboControlUseMode,
                                                            Contact defaultBookImageDigitalizer) {
      throw new NotImplementedException("GetBookImageDigitalizersComboItems()");


      //FixedList<Contact> contacts = recorderOffice.GetContactsInRole<Contact>("RecorderOffice->ImageDigitalizers");

      //return GetContactsInRoleComboItems(contacts, defaultBookImageDigitalizer, comboControlUseMode,
      //                                   "( Seleccionar al digitalizador del libro )",
      //                                   "( Todos los digitalizadores )",
      //                                   "No hay digitalizadores definidos");
    }


    static public string GetRecordingsBatchAnalystComboItems(ComboControlUseMode comboControlUseMode,
                                                             Contact defaultBookBatchRecorderUser) {
      throw new NotImplementedException("GetRecordingsBatchAnalystComboItems()");

      //FixedList<Contact> contacts =
      //          RecorderOffice.MainRecorderOffice.GetContactsInRole<Contact>("RecorderOffice->RecordingsBatchAnalysts");
      //contacts.Sort((x, y) => x.Alias.CompareTo(y.Alias));

      //return GetContactsInRoleComboItems(contacts, defaultBookBatchRecorderUser, comboControlUseMode,
      //                                   "( Seleccionar al analista del libro )",
      //                                   "( Todos los analistas de libros )",
      //                                   "No hay analistas definidos");
    }


    static public void LoadRecordingActTypesCombo(RecordingActTypeCategory recordingActTypeCategory,
                                                  HtmlSelect comboControl, ComboControlUseMode comboControlUseMode,
                                                  RecordingActType defaultRecordingActType) {
      FixedList<RecordingActType> recordingActTypeList = recordingActTypeCategory.RecordingActTypes;

      string header = (comboControlUseMode == ComboControlUseMode.ObjectCreation)
                              ? "( Primero seleccionar la categoría de la inscripción )" : "( Todos  los actos jurídicos )";

      HtmlSelectContent.LoadCombo(comboControl, recordingActTypeList, "Id", "DisplayName", header);
      if (defaultRecordingActType != null && defaultRecordingActType != RecordingActType.Empty) {
        comboControl.Value = defaultRecordingActType.Id.ToString();
      }
    }


    static public void LoadRecorderOfficeCombo(HtmlSelect comboControl, ComboControlUseMode comboControlUseMode,
                                               RecorderOffice defaultOffice) {
      FixedList<RecorderOffice> officeList = RecorderOffice.GetList();


      string header = (comboControlUseMode == ComboControlUseMode.ObjectCreation)
                              ? "( Distrito )" : "( Todos los Distritos )";

      HtmlSelectContent.LoadCombo(comboControl, officeList, "Id", "Alias", header);
      if (defaultOffice != null && !defaultOffice.IsEmptyInstance) {
        comboControl.Value = defaultOffice.Id.ToString();
      }
    }


    static public void LoadDomainRecordingSections(HtmlSelect comboControl, ComboControlUseMode comboControlUseMode,
                                                   string defaultValue = "") {
      string header = (comboControlUseMode == ComboControlUseMode.ObjectCreation) ?
                              "( Distrito / Sección )" : "( Todos los Distritos )";

      var list = GeneralList.Parse("LRSDomainTraslativeSection.Combo.List");

      HtmlSelectContent.LoadCombo(comboControl, list.GetItems<NameValuePair>(), "Value", "Name", header);

      if (defaultValue != null) {
        comboControl.Value = defaultValue;
      }
    }


    static public void LoadRecorderOfficeMunicipalitiesCombo(HtmlSelect comboControl, ComboControlUseMode comboControlUseMode,
                                                             RecorderOffice recorderOffice, GeographicRegion defaultItem) {
      FixedList<Municipality> list = recorderOffice.GetMunicipalities();

      string header = (comboControlUseMode == ComboControlUseMode.ObjectCreation)
                              ? "( Seleccionar un municipio )" : "( Todos los municipios )";

      HtmlSelectContent.LoadCombo(comboControl, list, "Id", "Name", header);
      if (defaultItem != null && !defaultItem.IsEmptyInstance) {
        comboControl.Value = defaultItem.Id.ToString();
      }
    }


    static public void LoadRecorderOfficersCombo(HtmlSelect comboControl, ComboControlUseMode comboControlUseMode,
                                                 RecordingBook recordingBook, Contact defaultRecorderOfficer) {
      RecorderOffice office = recordingBook.RecorderOffice;
      FixedList<Person> officers = office.GetRecorderOfficials(recordingBook.RecordingsControlTimePeriod);

      string header = (comboControlUseMode == ComboControlUseMode.ObjectCreation)
                        ? "( Seleccionar al C. Oficial Registrador )" : "( Todos los C. Oficiales Registradores )";

      HtmlSelectContent.LoadCombo(comboControl, officers, "Id", "FamilyFullName", header,
                                  "No se puede determinar o sólo aparece la firma", String.Empty);
      if (defaultRecorderOfficer != null && defaultRecorderOfficer != RecorderOffice.Empty) {
        comboControl.Value = defaultRecorderOfficer.Id.ToString();
      }
    }


    static public RecorderOffice ParseRecorderOffice(WebPage webPage, string controlUniqueID) {
      string selectedValue = webPage.GetControlState(controlUniqueID);
      if (!String.IsNullOrEmpty(selectedValue)) {
        return RecorderOffice.Parse(int.Parse(selectedValue));
      } else {
        return RecorderOffice.Empty;
      }
    }


    static public RecordingActTypeCategory ParseRecordingActTypeCategory(WebPage webPage,
                                                                         string controlUniqueID) {
      string selectedValue = webPage.GetControlState(controlUniqueID);
      if (!String.IsNullOrEmpty(selectedValue)) {
        return RecordingActTypeCategory.Parse(int.Parse(selectedValue));
      } else {
        return RecordingActTypeCategory.Empty;
      }
    }

    #endregion Public methods

    #region Private methods

    static private string GetContactsInRoleComboItems(FixedList<Contact> contacts,
                                                      Contact selectedContact,
                                                      ComboControlUseMode comboControlUseMode,
                                                      string objectCreationFirstItem,
                                                      string objectSearchFirstItem,
                                                      string noItemsFirstItem) {
      if (contacts.Count == 0) {
        return HtmlSelectContent.GetComboHtmlItem(String.Empty, noItemsFirstItem);
      }

      string xhtml = String.Empty;
      if (contacts.Count != 1) {
        if (comboControlUseMode == ComboControlUseMode.ObjectCreation) {
          xhtml = HtmlSelectContent.GetComboHtmlItem(String.Empty, objectCreationFirstItem);
        } else {
          xhtml = HtmlSelectContent.GetComboHtmlItem(String.Empty, objectSearchFirstItem);
        }
      }
      xhtml += HtmlSelectContent.GetComboHtml(contacts, "Id", "Alias", String.Empty);
      if (!selectedContact.IsEmptyInstance) {
        xhtml.Replace("value='" + selectedContact.Id.ToString() + "'>",
                      "value='" + selectedContact.Id.ToString() + " selected'>");
      }
      return xhtml;
    }


    private static FixedList<Contact> LoadContactsList(string[] contactIdsArray) {
      List<Contact> contactsList = new List<Contact>(contactIdsArray.Length);

      foreach (var contactId in contactIdsArray) {
        var contact = Contact.Parse(int.Parse(contactId.Trim()));

        contactsList.Add(contact);
      }

      contactsList.Sort((x, y) => x.ShortName.CompareTo(y.ShortName));

      return contactsList.ToFixedList();
    }

    #endregion Private methods

  } // class LRSHtmlSelectControls

} // namespace Empiria.Land.UI
