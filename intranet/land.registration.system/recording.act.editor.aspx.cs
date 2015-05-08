/* Empiria® Land 2015 ****************************************************************************************
*																																																						 *
*	 Solution  : Empiria® Land                                    System   : Land Intranet Application         *
*	 Namespace : Empiria.Web.UI                                   Assembly : Empiria.Land.Intranet.dll         *
*	 Type      : ObjectSearcher                                   Pattern  : Explorer Web Page                 *
*	 Date      : 04/Jan/2015                                      Version  : 2.0  License: LICENSE.TXT file    *
*																																																						 *
*  Summary   : Gets user credentials and redirects users to the workplace start page.                        *
*																																																						 *
**************************************************** Copyright © La Vía Óntica SC + Ontica LLC. 2009-2015. **/
using System;
using System.Web.UI.WebControls;
using Empiria.Land.Registration;
using Empiria.Land.UI;
using Empiria.Presentation.Web;

namespace Empiria.Web.UI.LRS {

  public partial class RecordingActEditor : WebPage {

    #region Fields

    protected RecordingAct recordingAct = null;

    #endregion Fields

    #region Protected methods

    protected void Page_Load(object sender, EventArgs e) {
      Initialize();
      if (IsPostBack) {
        DoCommand();
      } else {
        LoadControls();
      }
    }

    #endregion Protected methods

    #region Private methods

    private void DoCommand() {
      switch (base.CommandName) {
        case "saveRecordingAct":
          SaveRecordingAct();
          Response.Redirect("recording.act.editor.aspx?id=" + recordingAct.Id.ToString(), true);
          return;
        case "saveRecordingActAsComplete":
          SaveRecordingActAsComplete();
          Response.Redirect("recording.act.editor.aspx?id=" + recordingAct.Id.ToString(), true);
          return;
        case "saveParty":
          SaveParty();
          return;
        case "selectParty":
          SelectParty();
          return;
        case "appendParty":
          AppendParty();
          Response.Redirect("recording.act.editor.aspx?id=" + recordingAct.Id.ToString(), true);
          return;
        case "deleteParty":
          DeleteParty();
          Response.Redirect("recording.act.editor.aspx?id=" + recordingAct.Id.ToString(), true);
          return;
        default:
          throw new NotImplementedException(base.CommandName);
      }
    }

    private void AppendParty() {
      oPartyEditorControl.SaveRecordingParty();
    }

    private void DeleteParty() {
      int partyId = int.Parse(base.GetCommandParameter("partyId"));
      RecordingActParty party = RecordingActParty.Parse(partyId);
      party.Delete();
    }

    private void SaveParty() {
      int partyId = int.Parse(base.GetCommandParameter("partyId"));
      oPartyEditorControl.SaveParty(partyId);
      oPartyEditorControl.SelectParty(partyId);
    }

    private void SelectParty() {
      int partyId = int.Parse(base.GetCommandParameter("partyId"));
      oPartyEditorControl.SelectParty(partyId);

      this.oAntecedentParties.BaseRecordingAct = this.recordingAct;
      this.oAntecedentParties.Property = Property.Parse(int.Parse(cboProperty.Value));
    }

    protected string GetRecordingActPartiesGrid() {
      return LRSGridControls.GetRecordingActPartiesGrid(this.recordingAct, false);
    }

    private void SaveRecordingAct() {
      oRecordingActAttributes.FillRecordingAct();
      recordingAct.Notes = txtObservations.Value;
      recordingAct.ChangeStatusTo((RecordableObjectStatus) Convert.ToChar(cboStatus.Value));
    }

    private void SaveRecordingActAsComplete() {
      recordingAct.ChangeStatusTo(RecordableObjectStatus.Registered);
    }

    private void Initialize() {
      recordingAct = RecordingAct.Parse(int.Parse(Request.QueryString["id"]));
      oRecordingActAttributes.RecordingAct = this.recordingAct;
      oPartyEditorControl.RecordingAct = this.recordingAct;

      this.oAntecedentParties.BaseRecordingAct = this.recordingAct;
    }

    private void LoadControls() {
      txtRecordingActName.Value = "(" + recordingAct.Index.ToString("00") + ") " + recordingAct.RecordingActType.DisplayName;
      txtObservations.Value = recordingAct.Notes;
      cboStatus.Value = ((char) recordingAct.Status).ToString();
      FillPropertiesCombo();
      if (this.recordingAct.RecordingActType.Name.StartsWith("ObjectType.RecordingAct.DomainAct")) {
        this.oAntecedentParties.BaseRecordingAct = this.recordingAct;
        this.oAntecedentParties.Property = Property.Parse(int.Parse(cboProperty.Value));
      } else {
        this.oAntecedentParties.Visible = false;
      }
      oPartyEditorControl.LoadEditor();
      oRecordingActAttributes.LoadRecordingAct();
    }

    private void FillPropertiesCombo() {
      throw new NotImplementedException();

      //this.oAntecedentParties.Visible = false;
      //cboProperty.Items.Clear();
      //foreach(Property property in recordingAct.GetProperties()) {
      //  if (!property.IsFirstRecordingAct(recordingAct)) {
      //    this.oAntecedentParties.Visible = true;
      //  }
      //  cboProperty.Items.Add(new ListItem(property.UID, property.Id.ToString()));
      //}
    }

    #endregion Private methods

  } // class PropertyEditor

} // namespace Empiria.Web.UI.LRS
