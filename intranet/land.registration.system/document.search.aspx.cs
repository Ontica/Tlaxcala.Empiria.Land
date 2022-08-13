/* Empiria Land **********************************************************************************************
*                                                                                                            *
*  Solution  : Empiria Land                                     System   : Land Intranet Application         *
*  Namespace : Empiria.Land.WebApp                              Assembly : Empiria.Land.Intranet.dll         *
*  Type      : DocumentSearch                                   Pattern  : Explorer Web Page                 *
*  Version   : 3.0                                              License  : Please read license.txt file      *
*                                                                                                            *
*  Summary   : Search tool for recording documents, recordable resources, certificates and physical books.   *
*                                                                                                            *
************************* Copyright(c) La Vía Óntica SC, Ontica LLC and contributors. All rights reserved. **/
using System;
using System.Linq;

using Empiria.Presentation.Web;

using Empiria.Land.Certification;
using Empiria.Land.Registration;
using Empiria.Land.Registration.Transactions;
using Empiria.Land.UI;

namespace Empiria.Land.WebApp {

  public partial class DocumentSearch : WebPage {

    #region Fields

    private Resource _resource = null;

    private string _searchResultsGrid = "";
    private string _searchResultsGridMaxHeight = "260px";

    protected string OnLoadScript = String.Empty;

    #endregion Fields

    #region Protected methods

    protected void Page_Init(object sender, EventArgs e) {
      LoadControls();
    }

    private void LoadControls() {

    }

    protected void Page_Load(object sender, EventArgs e) {
      Initialize();
      if (!IsPostBack) {
        LoadEditor();
      } else {
        ExecuteCommand();
      }
    }

    private void LoadEditor() {

    }

    protected string GetSearchResultsGrid() {
      return this._searchResultsGrid;
    }

    protected string GetGridMaxHeight() {
      return _searchResultsGridMaxHeight;
    }

    #endregion Protected methods

    #region Private methods

    private void ExecuteCommand() {
      switch (base.CommandName) {
        case "searchData":
          SearchData();
          return;
        default:
          throw new NotImplementedException(base.CommandName);
      }
    }

    private void Initialize() {
      _resource = Resource.Parse(int.Parse(Request.QueryString["resourceId"]));
    }

    private void SearchData() {
      string keywords = txtSearchBox.Value;
      string sort = String.Empty;

      switch (cboSearchBy.Value) {
        case "resource":
          LoadResourcesGrid(SearchService.Resources(keywords));
          return;

        case "document":
          LoadRecordingDocumentsGrid(SearchService.Documents(keywords));
          return;

        case "certificate":
          LoadCertificatesGrid(SearchService.Certificates(keywords));
          return;

        case "recordingBook":
          LoadRecordingBooksGrid(SearchService.RecordingBooks(keywords));
          return;

        case "physicalRecording":
          LoadPhysicalRecordingsGrid(SearchService.PhysicalRecordings(keywords));
          return;

        case "party":
          LoadPartiesGrid(SearchService.Parties(keywords));
          return;

        case "partyLegacy":
          LoadLegacyPartiesGrid(SearchService.LegacyParties(keywords));
          return;

        case "transaction":
          LoadTransactionsGrid(SearchService.Transactions(keywords));
          return;

        case "imagingControl":
          LoadImagingControlIDsGrid(SearchService.ImagingControlIDs(keywords));
          return;

        default:
          throw Assertion.EnsureNoReachThisCode("Unrecognized search combo option.");
      }
    }

    private void LoadCertificatesGrid(FixedList<FormerCertificate> certificates) {
      _searchResultsGrid = CertificatesGrid.Parse(certificates);
      _searchResultsGridMaxHeight = "600px";
    }

    private void LoadImagingControlIDsGrid(FixedList<RecordingDocument> documents) {
      string html = ReadImagingControlIDHeaderTemplate();

      for (int i = 0; i < documents.Count; i++) {
        var item = documents[i];

        string row = ReadImagingControlIDRowTemplate(i);
        row = row.Replace("{{ON.SELECT.OPERATION}}", "onSelectDocumentFromSearchGrid");
        row = row.Replace("{{ITEM.ID}}", item.Id.ToString());
        row = row.Replace("{{ITEM.DISPLAY.TEXT}}", item.Imaging.ImagingControlID);
        var transaction = item.GetTransaction();
        row = row.Replace("{{TRANSACTION.UID}}", transaction.UID);
        row = row.Replace("{{TRANSACTION.REQUESTED.BY}}", transaction.RequestedBy);
        row = row.Replace("{{IMAGING.LINKS}}", HtmlFormatters.GetImagingLinks(item));
        html += row;
      }
      _searchResultsGrid = TableWrapper(html);
    }


    private void LoadPartiesGrid(FixedList<RecordingActParty> recordingActParties) {
      string html = ReadHeaderTemplate(typeof(Party));

      //Gets unique parties (Party) from the recording acts parties
      var parties = recordingActParties.Select((x) => x.Party).Distinct().ToList();

      for (int i = 0; i < parties.Count; i++) {
        var item = parties[i];

        string row = ReadRowTemplate(typeof(Party), i);
        row = row.Replace("{{ON.SELECT.OPERATION}}", "onSelectParty");
        row = row.Replace("{{ITEM.ID}}", item.Id.ToString());
        row = row.Replace("{{ITEM.DISPLAY.TEXT}}", item.FullName);
        row = row.Replace("{{IMAGING.LINKS}}", "&nbsp;");

        html += row;
      }
      _searchResultsGrid = TableWrapper(html);
    }



    private void LoadLegacyPartiesGrid(FixedList<LegacyParty> legacyParties) {
      string html = ReadLegacyPartiesHeaderTemplate();


      for (int i = 0; i < Math.Min(legacyParties.Count, 250); i++) {
        var item = legacyParties[i];

        string row = ReadLegacyPartiesRow(i);

        row = row.Replace("{{FULL.NAME}}", item.FullName);
        row = row.Replace("{{DISTRITO}}", item.Distrito);
        row = row.Replace("{{SECCION}}", item.Seccion);
        row = row.Replace("{{VOLUMEN}}", item.Volumen);
        row = row.Replace("{{PARTIDA}}", item.Partida);
        row = row.Replace("{{FECHA}}", item.Fecha);

        html += row;
      }
      _searchResultsGrid = "<table class='details' style='width:675px'>" + html + "</table>";
      _searchResultsGridMaxHeight = "700px";
    }


    private void LoadPhysicalRecordingsGrid(FixedList<PhysicalRecording> physicalRecordings) {
      string html = ReadHeaderTemplate(typeof(PhysicalRecording));

      for (int i = 0; i < physicalRecordings.Count; i++) {
        var item = physicalRecordings[i];

        string row = ReadRowTemplate(typeof(PhysicalRecording), i);
        row = row.Replace("{{ON.SELECT.OPERATION}}", "onSelectDocumentFromSearchGrid");
        row = row.Replace("{{ITEM.ID}}", item.MainDocument.Id.ToString());
        row = row.Replace("{{ITEM.DISPLAY.TEXT}}", item.AsText);
        row = row.Replace("{{IMAGING.LINKS}}", HtmlFormatters.GetImagingLinks(item.RecordingBook));

        html += row;
      }
      _searchResultsGrid = TableWrapper(html);
    }


    private void LoadRecordingBooksGrid(FixedList<RecordingBook> books) {
      string html = ReadHeaderTemplate(typeof(RecordingBook));

      for (int i = 0; i < books.Count; i++) {
        var item = books[i];

        string row = ReadRowTemplate(typeof(RecordingBook), i);
        row = row.Replace("{{ON.SELECT.OPERATION}}", "onSelectRecordingBook");
        row = row.Replace("{{ITEM.ID}}", item.Id.ToString());
        row = row.Replace("{{ITEM.DISPLAY.TEXT}}", item.AsText);
        row = row.Replace("{{IMAGING.LINKS}}", HtmlFormatters.GetImagingLinks(item));

        html += row;
      }
      _searchResultsGrid = TableWrapper(html);
    }


    private void LoadRecordingDocumentsGrid(FixedList<RecordingDocument> documents) {
      string html = ReadHeaderTemplate(typeof(RecordingDocument));

      for (int i = 0; i < documents.Count; i++) {
        var item = documents[i];

        string row = ReadRowTemplate(typeof(RecordingDocument), i);
        row = row.Replace("{{ON.SELECT.OPERATION}}", "onSelectDocumentFromSearchGrid");
        row = row.Replace("{{ITEM.ID}}", item.Id.ToString());
        row = row.Replace("{{ITEM.DISPLAY.TEXT}}", item.UID);
        row = row.Replace("{{IMAGING.LINKS}}", HtmlFormatters.GetImagingLinks(item));

        html += row;
      }
      _searchResultsGrid = TableWrapper(html);
    }


    private void LoadResourcesGrid(FixedList<Resource> resources) {
      string html = ReadHeaderTemplate(typeof(Resource));

      for (int i = 0; i < resources.Count; i++) {
        var item = resources[i];

        string row = ReadRowTemplate(typeof(Resource), i);
        row = row.Replace("{{ON.SELECT.OPERATION}}", "onSelectResource");
        row = row.Replace("{{ITEM.ID}}", item.Id.ToString());
        row = row.Replace("{{ITEM.DISPLAY.TEXT}}", item.UID);
        row = row.Replace("{{IMAGING.LINKS}}", "&nbsp;");

        html += row;
      }
      _searchResultsGrid = TableWrapper(html);
    }


    private void LoadTransactionsGrid(FixedList<LRSTransaction> transactions) {
      string html = ReadHeaderTemplate(typeof(LRSTransaction));

      for (int i = 0; i < transactions.Count; i++) {
        var item = transactions[i];

        string row = ReadRowTemplate(typeof(LRSTransaction), i);
        row = row.Replace("{{ON.SELECT.OPERATION}}", "onSelectTransaction");
        row = row.Replace("{{ITEM.ID}}", item.Id.ToString());
        row = row.Replace("{{ITEM.DISPLAY.TEXT}}", item.UID);
        row = row.Replace("{{IMAGING.LINKS}}", "&nbsp;");

        html += row;
      }
      _searchResultsGrid = TableWrapper(html);
    }

    #endregion Private methods

    #region Auxiliar methods

    static private string ReadHeaderTemplate(Type type) {
      const string template =
          "<tr class='detailsHeader'>" +
            "<td colspan='2'>Resultado de la búsqueda</td>" +
          "</tr>";

      return template;
    }

    private string ReadLegacyPartiesHeaderTemplate() {
      return "<tr class='detailsHeader'>" +
                "<td>Nombre</td>" +
                "<td>Distrito</td>" +
                "<td>Sección</td>" +
                "<td>Volumen</td>" +
                "<td>Partida</td>" +
                "<td>Fecha</td>" +
             "</tr>";
    }


    private string ReadLegacyPartiesRow(int rowIndex) {
      const string row = "<tr class='{{CLASS}}'>" +
                            "<td style='white-space:normal;width:70%'>{{FULL.NAME}}</td>" +
                            "<td>{{DISTRITO}}</td>" +
                            "<td style='white-space:normal'>{{SECCION}}</td>" +
                            "<td>{{VOLUMEN}}</td>" +
                            "<td>{{PARTIDA}}</td>" +
                            "<td>{{FECHA}}</td>" +
                         "</tr>";

      return row.Replace("{{CLASS}}", (rowIndex % 2 == 0) ? "detailsItem" : "detailsOddItem");
    }


    static private string ReadImagingControlIDHeaderTemplate() {
      const string template =
          "<tr class='detailsHeader'>" +
            "<td>Núm. de control</td>" +
            "<td>Núm. de trámite</td>" +
            "<td>Interesado</td>" +
            "<td>Img</td>" +
          "</tr>";
      return template;
    }

    static private string ReadRowTemplate(Type type) {
      const string template =
        "<tr class='{{CLASS}}'>" +
        "<td style='white-space:normal'>" +
          "<a href='javascript:doOperation(\"{{ON.SELECT.OPERATION}}\", {{ITEM.ID}});'>" +
          "{{ITEM.DISPLAY.TEXT}}</a>" +
        "<td style='white-space:nowrap'>{{IMAGING.LINKS}}</td>" +
        "</td></tr>";

      return template;
    }

    static private string ReadImagingControlIDRowTemplate(int rowIndex) {
      const string template =
        "<tr class='{{CLASS}}'>" +
        "<td style='vertical-align:top;white-space:normal'>" +
          "<a href='javascript:doOperation(\"{{ON.SELECT.OPERATION}}\", {{ITEM.ID}});'>" +
          "{{ITEM.DISPLAY.TEXT}}</a>" +
        "<td style='vertical-align:top;white-space:nowrap'>{{TRANSACTION.UID}}</td>" +
        "<td style='valign:top;white-space:normal;width:95%'>{{TRANSACTION.REQUESTED.BY}}</td>" +
        "<td style='vertical-align:top;white-space:nowrap'>{{IMAGING.LINKS}}</td>" +
        "</td></tr>";

      return template.Replace("{{CLASS}}",
                              (rowIndex % 2 == 0) ? "detailsItem" : "detailsOddItem");

    }

    static private string ReadRowTemplate(Type type, int rowIndex) {
      return ReadRowTemplate(type).Replace("{{CLASS}}",
                                          (rowIndex % 2 == 0) ? "detailsItem" : "detailsOddItem");
    }

    static private string TableWrapper(string html) {
      return "<table class='details' style='width:96%'>" + html + "</table>";
    }

    #endregion Auxiliar methods

  } // class DocumentSearch

} // namespace Empiria.Land.WebApp
