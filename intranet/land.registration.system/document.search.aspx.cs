/* Empiria Land **********************************************************************************************
*																																																						 *
*  Solution  : Empiria Land                                     System   : Land Intranet Application         *
*  Namespace : Empiria.Land.WebApp                              Assembly : Empiria.Land.Intranet.dll         *
*  Type      : DocumentSearch                                   Pattern  : Explorer Web Page                 *
*  Version   : 2.1                                              License  : Please read license.txt file      *
*                                                                                                            *
*  Summary   : Search tool for recording documents, recordable resources, certificates and physical books.   *
*                                                                                                            *
********************************** Copyright(c) 2009-2016. La Vía Óntica SC, Ontica LLC and contributors.  **/
using System;

using Empiria.Presentation.Web;

using Empiria.Land.Certification;
using Empiria.Land.Registration;
using Empiria.Land.Registration.Transactions;

namespace Empiria.Land.WebApp {

  public partial class DocumentSearch : WebPage {

    #region Fields

    private Resource _resource = null;

    private string _searchResultsGrid = "";

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

        case "certificates":
          LoadCertificatesGrid(SearchService.Certificates(keywords));
          return;

        case "recordingBook":
          LoadRecordingBooksGrid(SearchService.RecordingBooks(keywords));
          return;

        case "party":
          LoadPartiesGrid(SearchService.Parties(keywords));
          return;

        case "transaction":
          LoadTransactionsGrid(SearchService.Transactions(keywords));
          return;

        case "imagingControl":
          LoadImagingControlIDsGrid(SearchService.ImagingControlIDs(keywords));
          return;

        default:
          throw Assertion.AssertNoReachThisCode("Unrecognized search combo option.");
      }
    }

    private void LoadCertificatesGrid(FixedList<Certificate> certificates) {
      string html = ReadHeaderTemplate(typeof(RecordingDocument));

      for (int i = 0; i < certificates.Count; i++) {
        var item = certificates[i];

        string row = ReadRowTemplate(typeof(RecordingDocument), i);
        row = row.Replace("{{ON.SELECT.OPERATION}}", "onSelectCertificate");
        row = row.Replace("{{ITEM.ID}}", item.Id.ToString());
        row = row.Replace("{{ITEM.DISPLAY.TEXT}}", item.UID);

        html += row;
      }
      _searchResultsGrid = html;
    }

    private void LoadImagingControlIDsGrid(FixedList<RecordingDocument> documents) {
      string html = ReadHeaderTemplate(typeof(RecordingDocument));

      for (int i = 0; i < documents.Count; i++) {
        var item = documents[i];

        string row = ReadRowTemplate(typeof(RecordingDocument), i);
        row = row.Replace("{{ON.SELECT.OPERATION}}", "onSelectDocument");
        row = row.Replace("{{ITEM.ID}}", item.Id.ToString());
        row = row.Replace("{{ITEM.DISPLAY.TEXT}}", item.ImagingControlID);

        html += row;
      }
      _searchResultsGrid = html;
    }

    private void LoadPartiesGrid(FixedList<RecordingActParty> parties) {
      string html = ReadHeaderTemplate(typeof(RecordingDocument));

      for (int i = 0; i < parties.Count; i++) {
        var item = parties[i];

        string row = ReadRowTemplate(typeof(RecordingActParty), i);
        row = row.Replace("{{ON.SELECT.OPERATION}}", "onSelectParty");
        row = row.Replace("{{ITEM.ID}}", item.Id.ToString());
        row = row.Replace("{{ITEM.DISPLAY.TEXT}}", item.Party.FullName);

        html += row;
      }
      _searchResultsGrid = html;
    }

    private void LoadRecordingBooksGrid(FixedList<RecordingBook> books) {
      string html = ReadHeaderTemplate(typeof(RecordingDocument));

      for (int i = 0; i < books.Count; i++) {
        var item = books[i];

        string row = ReadRowTemplate(typeof(RecordingDocument), i);
        row = row.Replace("{{ON.SELECT.OPERATION}}", "onSelectRecordingBook");
        row = row.Replace("{{ITEM.ID}}", item.Id.ToString());
        row = row.Replace("{{ITEM.DISPLAY.TEXT}}", item.AsText);

        html += row;
      }
      _searchResultsGrid = html;
    }

    private void LoadRecordingDocumentsGrid(FixedList<RecordingDocument> documents) {
      string html = ReadHeaderTemplate(typeof(RecordingDocument));

      for (int i = 0; i < documents.Count; i++) {
        var item = documents[i];

        string row = ReadRowTemplate(typeof(RecordingDocument), i);
        row = row.Replace("{{ON.SELECT.OPERATION}}", "onSelectDocument");
        row = row.Replace("{{ITEM.ID}}", item.Id.ToString());
        row = row.Replace("{{ITEM.DISPLAY.TEXT}}", item.UID);

        html += row;
      }
      _searchResultsGrid = html;
    }


    private void LoadResourcesGrid(FixedList<Resource> resources) {
      string html = ReadHeaderTemplate(typeof(Resource));

      for (int i = 0; i < resources.Count; i++) {
        var item = resources[i];

        string row = ReadRowTemplate(typeof(RecordingDocument), i);
        row = row.Replace("{{ON.SELECT.OPERATION}}", "onSelectResource");
        row = row.Replace("{{ITEM.ID}}", item.Id.ToString());
        row = row.Replace("{{ITEM.DISPLAY.TEXT}}", item.UID);

        html += row;
      }
      _searchResultsGrid = html;
    }

    private void LoadTransactionsGrid(FixedList<LRSTransaction> transactions) {
      string html = ReadHeaderTemplate(typeof(RecordingDocument));

      for (int i = 0; i < transactions.Count; i++) {
        var item = transactions[i];

        string row = ReadRowTemplate(typeof(RecordingDocument), i);
        row = row.Replace("{{ON.SELECT.OPERATION}}", "onSelectTransaction");
        row = row.Replace("{{ITEM.ID}}", item.Id.ToString());
        row = row.Replace("{{ITEM.DISPLAY.TEXT}}", item.UID);

        html += row;
      }
      _searchResultsGrid = html;
    }

    #endregion Private methods

    #region Auxiliar methods

    static private string ReadHeaderTemplate(Type type) {
      const string template =
          "<tr class='detailsHeader'>" +
            "<td>Resultado de la búsqueda</td>" +
          "</tr>";

      return template;
    }

    static private string ReadRowTemplate(Type type) {
      const string template =
        "<tr class='{{CLASS}}'>" +
        "<td>" +
          "<a href='javascript:doOperation(\"{{ON.SELECT.OPERATION}}\", {{ITEM.ID}});'>" +
          "{{ITEM.DISPLAY.TEXT}}</a>" +
        "</td></tr>";

      return template;
    }

    static private string ReadRowTemplate(Type type, int rowIndex) {
      return ReadRowTemplate(type).Replace("{{CLASS}}",
                                          (rowIndex % 2 == 0) ? "detailsItem" : "detailsOddItem");
    }

    #endregion Auxiliar methods

  } // class DocumentSearch

} // namespace Empiria.Land.WebApp
