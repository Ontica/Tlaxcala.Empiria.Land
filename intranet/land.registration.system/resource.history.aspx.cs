/* Empiria Land **********************************************************************************************
*																																																						 *
*  Solution  : Empiria Land                                     System   : Land Intranet Application         *
*  Namespace : Empiria.Land.WebApp                              Assembly : Empiria.Land.Intranet.dll         *
*  Type      : RecordingEditor                                  Pattern  : Explorer Web Page                 *
*  Version   : 2.1                                              License  : Please read license.txt file      *
*                                                                                                            *
*  Summary   : Gets user credentials and redirects users to the workplace start page.                        *
*                                                                                                            *
********************************** Copyright(c) 2009-2016. La Vía Óntica SC, Ontica LLC and contributors.  **/
using System;
using System.Web.UI;

using Empiria.Land.Registration;
using Empiria.Land.UI;
using Empiria.Presentation.Web;

namespace Empiria.Land.WebApp {

  public partial class ResourceHistory : WebPage {

    #region Fields

    protected Resource resource = null;

    protected AppendRecordingActEditorControlBase oRecordingActEditor = null;
    protected string OnLoadScript = String.Empty;

    #endregion Fields

    #region Protected methods

    protected void Page_Init(object sender, EventArgs e) {
      LoadControls();
    }

    private void LoadControls() {
      oRecordingActEditor = (AppendRecordingActEditorControlBase)
                             Page.LoadControl(AppendRecordingActEditorControlBase.ControlVirtualPath);
      //spanRecordingActEditor.Controls.Add(oRecordingActEditor);
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

    protected string GetLegacyDataViewerUrl() {
      return ConfigurationData.GetString("LegacyDataViewer.Url");
    }

    #endregion Protected methods

    #region Private methods

    private void ExecuteCommand() {
      switch (base.CommandName) {
        case "appendRecordingAct":
          oRecordingActEditor.CreateRecordingActs();
          SetRefreshPageScript();
          return;
        case "redirectMe":
          Response.Redirect("recording.history.aspx?resourceId=" + resource.Id.ToString(), true);
          return;
        default:
          throw new NotImplementedException(base.CommandName);
      }
    }

    private void Initialize() {
      resource = Resource.Parse(int.Parse(Request.QueryString["resourceId"]));

      //oRecordingActEditor.Initialize(transaction, transaction.Document);
    }

    protected string GetHistoryGrid() {
      FixedList<RecordingAct> resourceTract = resource.GetFullRecordingActsTract();

      const string template =
          "<tr class='{{CLASS}}'>" +
            "<td>{{PRESENTATION.DATE}}</td>" +
            "<td style='white-space:normal'>{{RECORDING.ACT}}</td>" +
            "<td style='white-space:normal;'>{{PARTITION}}</td>" +
            "<td style='white-space:{{WHITE-SPACE}};'>" +
              "<a href='javascript:doOperation(\"onSelectDocument\", {{DOCUMENT.ID}}, {{RECORDING.ACT.ID}});'>" +
                  "{{DOCUMENT.OR.RECORDING}}</a>" +
              "<br>{{TRANSACTION}}</td>" +
            "<td>{{RECORDED.BY}}</td>" +
          "</tr>";

      //"<td style='white-space:normal'>" +
      //  "<a href='javascript:doOperation(\"editRecordingAct\", {{ID}});'>" +
      //    "{{RECORDING.ACT.URL}}</a></td>" +
      //"<td style='white-space:normal'>" +
      //  "<a href='javascript:doOperation(\"editRecordingAct\", {{ID}});'>" +
      //    "{{RECORDING.DOCUMENT}}</a></td>" +
      //"<td style='white-space:nowrap'>{{TRANSACTION.UID}}</a></td>" +
      //"</tr>";

      string grid = String.Empty;
      for (int i = resourceTract.Count - 1; 0 <= i; i--) {
        var recordingAct = resourceTract[i];

        string row = template.Replace("{{CLASS}}", (i % 2 == 0) ? "detailsItem" : "detailsOddItem");

        row = row.Replace("{{RECORDING.ACT}}", recordingAct.DisplayName);
        row = row.Replace("{{PARTITION}}", this.GetPartitionOrAntecedentCell(recordingAct));
        if (!recordingAct.PhysicalRecording.IsEmptyInstance) {
          row = row.Replace("{{DOCUMENT.OR.RECORDING}}", recordingAct.PhysicalRecording.AsText);
          row = row.Replace("{{TRANSACTION}}", "&nbsp;");
          row = row.Replace("{{WHITE-SPACE}}", "normal");
        } else {
          row = row.Replace("{{DOCUMENT.OR.RECORDING}}", recordingAct.Document.UID);
          row = row.Replace("{{TRANSACTION}}", "Trámite:" + recordingAct.Document.GetTransaction().UID);
          row = row.Replace("{{WHITE-SPACE}}", "nowrap");
        }

        row = row.Replace("{{PRESENTATION.DATE}}", GetDateAsText(recordingAct.Document.PresentationTime));
        row = row.Replace("{{RECORDED.BY}}", recordingAct.RegisteredBy.Nickname);

        row = row.Replace("{{DOCUMENT.ID}}", recordingAct.Document.Id.ToString());
        row = row.Replace("{{RECORDING.ACT.ID}}", recordingAct.Id.ToString());

        grid += row;
      }
      return grid;
    }

    private string GetPartitionOrAntecedentCell(RecordingAct recordingAct) {
      if (Resource.IsCreationalRole(recordingAct.ResourceRole)) {

        var realEstate = (RealEstate) recordingAct.Resource;

        if (recordingAct.ResourceRole == ResourceRole.Created) {
          return "Sin antecedente registral";
        } else if (realEstate.Equals(this.resource)) {
          return "Creado como <b>" + realEstate.PartitionNo +
                 "</b> del predio " + NoWrap(recordingAct.RelatedResource.UID);
        } else {
          return "Sobre <b>" + realEstate.PartitionNo + "</b> con folio real " + NoWrap(realEstate.UID);
        }
      }
      return "&nbsp;";
    }

    private string GetDateAsText(DateTime date) {
      if (date == ExecutionServer.DateMinValue || date == ExecutionServer.DateMaxValue) {
        return "No consta";
      } else {
        return date.ToString(@"dd/MMM/yyyy");
      }
    }

    private string NoWrap(string text) {
      return "<span style='white-space:nowrap;'>" + text + "</span>";
    }

    private void SetMessageBox(string msg) {
      OnLoadScript += "alert('" + msg + "');";
    }

    private void SetRefreshPageScript() {
      OnLoadScript += "sendPageCommand('redirectMe');";
    }

    #endregion Private methods

  } // class ResourceHistory

} // namespace Empiria.Land.WebApp
