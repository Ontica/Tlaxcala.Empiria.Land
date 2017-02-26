/* Empiria Land **********************************************************************************************
*                                                                                                            *
*  Solution  : Empiria Land                                     System   : Land Intranet Application         *
*  Namespace : Empiria.Land.WebApp                              Assembly : Empiria.Land.Intranet.dll         *
*  Type      : RecordingActEditor                               Pattern  : Explorer Web Page                 *
*  Version   : 3.0                                              License  : Please read license.txt file      *
*                                                                                                            *
*  Summary   : Allows the edition of recording acts.                                                         *
*                                                                                                            *
********************************** Copyright(c) 2009-2017. La Vía Óntica SC, Ontica LLC and contributors.  **/
using System;

using Empiria.DataTypes;
using Empiria.Presentation.Web;

using Empiria.Land.Registration;
using Empiria.Land.UI;

namespace Empiria.Land.WebApp {

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

    protected bool IsReadyForEdition() {
      return recordingAct.Document.IsReadyForEdition();
    }

    protected bool EditOperationAmount {
      get {
        return recordingAct.RecordingActType.RecordingRule.EditOperationAmount;
      }
    }

    protected bool EditAppraisalAmount {
      get {
        return recordingAct.RecordingActType.RecordingRule.EditAppraisalAmount;
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
        case "selectParty":
          SelectParty();
          return;
        case "appendParty":
          AppendParty();
          Response.Redirect("recording.act.editor.aspx?id=" + recordingAct.Id.ToString(), true);
          return;
        case "saveParty":
          SaveParty();
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
      this.oAntecedentParties.Property = recordingAct.Resource;
    }

    protected string GetRecordingActPartiesGrid() {
      return LRSGridControls.GetRecordingActPartiesGrid(this.recordingAct, false);
    }

    private void SaveRecordingAct() {
      Money? operationAmount = Money.Empty;
      Money? appraisalAmount = Money.Empty;

      if (this.EditOperationAmount) {
        if (txtOperationAmount.Value.Length == 0) {
          txtOperationAmount.Value = "0.00";
        }
        operationAmount = Money.Parse(Currency.Parse(int.Parse(cboOperationCurrency.Value)),
                                      decimal.Parse(txtOperationAmount.Value));
      }

      if (this.EditAppraisalAmount) {
        if (txtAppraisalAmount.Value.Length == 0) {
          txtAppraisalAmount.Value = "0.00";
        }
        appraisalAmount = Money.Parse(Currency.Parse(int.Parse(cboAppraisalCurrency.Value)),
                                      decimal.Parse(txtAppraisalAmount.Value));
      }

      if (this.EditOperationAmount || this.EditAppraisalAmount) {
        var recordingActExtData = new RecordingActExtData(appraisalAmount, operationAmount);
        recordingAct.SetExtensionData(recordingActExtData);
      }
      recordingAct.Notes = txtObservations.Value;
      recordingAct.Save();
    }

    private void SaveRecordingActAsComplete() {
      recordingAct.ChangeStatusTo(RecordableObjectStatus.Registered);
    }

    private void Initialize() {
      recordingAct = RecordingAct.Parse(int.Parse(Request.QueryString["id"]));

      oPartyEditorControl.RecordingAct = this.recordingAct;
      oPartyEditorControl.LoadEditor();

      oAntecedentParties.BaseRecordingAct = this.recordingAct;
    }

    private void LoadControls() {
      txtRecordingActName.Value = "(" + recordingAct.Index.ToString("00") + ") " + recordingAct.DisplayName;
      txtObservations.Value = recordingAct.Notes;
      FillPropertiesCombo();
      if (this.recordingAct.RecordingActType.Name.StartsWith("ObjectType.RecordingAct.DomainAct")) {
      } else {
        this.oAntecedentParties.Visible = false;
      }
      if (recordingAct.ExtensionData.AppraisalAmount != Money.Empty) {
        txtAppraisalAmount.Value = recordingAct.ExtensionData.AppraisalAmount.Amount.ToString("N2");
        cboAppraisalCurrency.Value = recordingAct.ExtensionData.AppraisalAmount.Currency.Id.ToString();
      }
      if (recordingAct.ExtensionData.OperationAmount != Money.Empty) {
        txtOperationAmount.Value = recordingAct.ExtensionData.OperationAmount.Amount.ToString("N2");
        cboOperationCurrency.Value = recordingAct.ExtensionData.OperationAmount.Currency.Id.ToString();
      }
    }

    private void FillPropertiesCombo() {
      this.oAntecedentParties.Visible = false;

      if (!recordingAct.Resource.Tract.IsFirstRecordingAct(recordingAct)) {
        this.oAntecedentParties.Visible = true;
      }
      txtProperty.Value = recordingAct.Resource.UID;
    }

    #endregion Private methods

  } // class RecordingActEditor

} // namespace Empiria.Land.WebApp
