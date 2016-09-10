/* Empiria Land **********************************************************************************************
*																																																						 *
*  Solution  : Empiria Land                                     System   : Land Intranet Application         *
*  Namespace : Empiria.Land.WebApp                              Assembly : Empiria.Land.Intranet.dll         *
*  Type      : ByResourceAnalyzer                               Pattern  : Explorer Web Page                 *
*  Version   : 2.1                                              License  : Please read license.txt file      *
*																																																						 *
*  Summary   :                                                                                               *
*                                                                                                            *
********************************** Copyright(c) 2009-2016. La Vía Óntica SC, Ontica LLC and contributors.  **/
using System;

using Empiria.Land.Registration;
using Empiria.Presentation.Web;

namespace Empiria.Land.WebApp {

  public enum TabStrip {
    DocumentEditor = 0,
    RecordingActEditor = 1,
    ResourceEditor = 2,
    ResourceHistory = 3,
    GlobalSearch = 4,
  }

  public partial class ByResourceAnalyzer : WebPage {

    #region Fields

    protected Resource resource = null;
    protected RecordingAct recordingAct = null;

    #endregion Fields

    #region Constructors and parsers

    protected void Page_Init(object sender, EventArgs e) {
      LoadDocumentEditorControl();
    }

    private void LoadDocumentEditorControl() {

    }

    protected void Page_Load(object sender, EventArgs e) {
      Initialize();
      if (IsPostBack) {
        DoCommand();
      } else {
        LoadControls();
      }
    }

    private void LoadControls() {

    }

    private void DoCommand() {
      switch (base.CommandName) {
        case "refresh":
          RefreshPage();
          return;
        default:
          throw new NotImplementedException(base.CommandName);
      }
    }

    #endregion Constructors and parsers

    #region Public methods

    protected bool IsRecordingActSelected {
      get {
        return (!recordingAct.IsEmptyInstance);
      }
    }

    protected bool IsResourceSelected {
      get {
        return (!resource.IsEmptyInstance && resource is RealEstate);
      }
    }

    private void RefreshPage() {
      Response.Redirect("by.resource.analyzer.aspx?resourceId=" + resource.Id.ToString() +
                        "&recordingActId=" + recordingAct.Id.ToString(), true);
    }

    private void Initialize() {
      if (!String.IsNullOrEmpty(Request.QueryString["resourceId"])) {
        resource = Resource.Parse(int.Parse(Request.QueryString["resourceId"]));
      } else {
        resource = RealEstate.Empty;
      }

      if (!String.IsNullOrEmpty(Request.QueryString["recordingActId"])) {
        int recordingActId = int.Parse(Request.QueryString["recordingActId"]);
        if (recordingActId != -1) {
          recordingAct = RecordingAct.Parse(recordingActId);
        } else {
          recordingAct = resource.LastRecordingAct;
        }
      } else {
        recordingAct = RecordingAct.Empty;
      }
    }

    protected string TabStripClass(TabStrip tabStrip) {
      switch (tabStrip) {
        case TabStrip.DocumentEditor:
          return "tabDisabled";

        case TabStrip.GlobalSearch:
          return this.IsResourceSelected ? "tabOff" : "tabOn";

        case TabStrip.RecordingActEditor:
          return this.IsRecordingActSelected ? "tabOff" : "tabDisabled";

        case TabStrip.ResourceEditor:
          return this.IsResourceSelected ? "tabOff" : "tabDisabled";

        case TabStrip.ResourceHistory:
          return this.IsResourceSelected ? "tabOn" : "tabDisabled";

        default:
          throw Assertion.AssertNoReachThisCode();
      }
    }

    protected string TabStripDisplayView(TabStrip tabStrip) {
      if (tabStrip == TabStrip.GlobalSearch && !this.IsResourceSelected) {
        return "display:inline";
      }
      if (tabStrip == TabStrip.ResourceHistory && this.IsResourceSelected) {
        return "display:inline";
      }
      return "display:none";
    }

    protected string TabStripSource(TabStrip tabStrip) {
      string source = String.Empty;

      switch (tabStrip) {
        case TabStrip.DocumentEditor:
          source = "document.editor.aspx?documentId={{DOCUMENT.ID}}&selectedRecordingActId={{RECORDING.ACT.ID}}>";
          break;
        case TabStrip.GlobalSearch:
          source = "document.search.aspx?resourceId={{RESOURCE.ID}}&id={{RECORDING.ACT.ID}}";
          break;
        case TabStrip.RecordingActEditor:
          source = "recording.act.editor.aspx?propertyId={{RESOURCE.ID}}&id={{RECORDING.ACT.ID}}";
          break;
        case TabStrip.ResourceEditor:
          source = "real.estate.editor.aspx?propertyId={{RESOURCE.ID}}&recordingActId={{RECORDING.ACT.ID}}";
          break;
        case TabStrip.ResourceHistory:
          source = "resource.history.aspx?resourceId={{RESOURCE.ID}}&id={{RECORDING.ACT.ID}}";
          break;
        default:
            throw Assertion.AssertNoReachThisCode();
      }
      source = source.Replace("{{RECORDING.ACT.ID}}", this.recordingAct.Id.ToString());
      source = source.Replace("{{DOCUMENT.ID}}", this.recordingAct.Document.Id.ToString());
      source = source.Replace("{{RESOURCE.ID}}", this.resource.Id.ToString());

      return source;
    }

    #endregion Public methods

  } // class ByResourceAnalyzer

} // namespace Empiria.Land.WebApp
