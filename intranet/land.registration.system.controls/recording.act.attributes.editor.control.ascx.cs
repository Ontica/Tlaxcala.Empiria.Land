using System;
using System.Web.UI.WebControls;

using Empiria.DataTypes;
using Empiria.Geography;
using Empiria.Land.Registration;

namespace Empiria.Web.UI.LRS {

  public partial class RecordingActAttributesEditorControl : System.Web.UI.UserControl {

    #region Fields

    private RecordingAct recordingAct = null;

    #endregion Fields

    #region Public properties

    protected bool BlockAllFields {
      get { return recordingAct.RecordingActType.BlockAllFields; }
    }

    protected bool DisplayCreditFields {
      get { return recordingAct.RecordingActType.UseCreditFields; }
    }

    protected bool DisplayOperationAmount {
      get { return recordingAct.RecordingActType.UseOperationAmount; }
    }

    public RecordingAct RecordingAct {
      get { return recordingAct; }
      set { recordingAct = value; }
    }

    #endregion Public properties

    #region Public methods

    protected void Page_Load(object sender, EventArgs e) {

    }

    public void FillRecordingAct() {
      if (this.BlockAllFields) {
        return;
      }
      if (this.DisplayCreditFields) {
        FillCreditFields();
      }
      if (txtAppraisalAmount.Value.Length == 0) {
        txtAppraisalAmount.Value = "0.00";
      }
      recordingAct.ExtensionData.AppraisalAmount =
                                  Money.Parse(Currency.Parse(int.Parse(cboAppraisalCurrency.Value)),
                                              decimal.Parse(txtAppraisalAmount.Value));
      if (!this.DisplayOperationAmount) {
        return;
      }
      if (txtOperationAmount.Value.Length == 0) {
        txtOperationAmount.Value = "0.00";
      }
      recordingAct.ExtensionData.OperationAmount = 
                                  Money.Parse(Currency.Parse(int.Parse(cboOperationCurrency.Value)),
                                              decimal.Parse(txtOperationAmount.Value));
    }

    private void FillCreditFields() {
      var contract = recordingAct.ExtensionData.Contract;

      if (!String.IsNullOrEmpty(Request.Form[txtContractDate.Name])) {
        contract.Date = EmpiriaString.ToDateTime(txtContractDate.Value);
      } else {
        contract.Date = ExecutionServer.DateMaxValue;
      }
      recordingAct.ExtensionData.Contract.Number = txtContractNumber.Value;
      if (!String.IsNullOrEmpty(Request.Form[cboContractPlace.Name])) {
        contract.Place = GeographicRegionItem.Parse(int.Parse(Request.Form[cboContractPlace.Name]));
      } else {
        contract.Place = GeographicRegionItem.Unknown;
      }
      if (txtTermPeriod.Value.Length == 0) {
        txtTermPeriod.Value = "0";
      }
      if (txtInterestRate.Value.Length == 0) {
        txtInterestRate.Value = "0.00";
      }
      contract.Interest.TermPeriods = int.Parse(txtTermPeriod.Value);
      contract.Interest.TermUnit = DataTypes.Unit.Parse(int.Parse(cboTermUnit.Value));
      contract.Interest.Rate = decimal.Parse(txtInterestRate.Value);
      contract.Interest.RateType = InterestRateType.Parse(int.Parse(cboInterestRateType.Value));
    }

    public void LoadRecordingAct() {
      if (this.DisplayCreditFields) {
        LoadCreditFields();
      } else {
        creditFieldsRow1.Visible = false;
        creditFieldsRow2.Visible = false;
        creditFieldsRow3.Visible = false;
      }
      var data = recordingAct.ExtensionData;

      if (data.AppraisalAmount.Currency.IsEmptyInstance ||
          data.AppraisalAmount.Currency.Equals(Currency.Unknown)) {
        txtAppraisalAmount.Value = String.Empty;
      } else {
        txtAppraisalAmount.Value = data.AppraisalAmount.Amount.ToString("N2");
      }
      cboAppraisalCurrency.Value = data.AppraisalAmount.Currency.Id.ToString();

      if (!this.DisplayOperationAmount) {
        return;
      }
      if (data.OperationAmount.Currency.IsEmptyInstance ||
          data.OperationAmount.Currency.Equals(Currency.Unknown)) {
        txtOperationAmount.Value = String.Empty;
      } else {
        txtOperationAmount.Value = data.OperationAmount.Amount.ToString("0,###.00##");
      }
      cboOperationCurrency.Value = data.OperationAmount.Currency.Id.ToString();
    }

    private void LoadCreditFields() {
      creditFieldsRow1.Visible = true;
      creditFieldsRow2.Visible = true;
      creditFieldsRow3.Visible = true;

      var contract = recordingAct.ExtensionData.Contract;
      var interest = recordingAct.ExtensionData.Contract.Interest;

      if (contract.Date != ExecutionServer.DateMaxValue) {
        txtContractDate.Value = contract.Date.ToString("dd/MMM/yyyy");
      }
      txtContractNumber.Value = contract.Number;

      cboContractPlace.Items.Clear();
      cboContractPlace.Items.Add(new ListItem("( Seleccionar lugar del contrato )", String.Empty));

      cboContractPlace.Items.Add(new ListItem(contract.Place.FullName, contract.Place.Id.ToString()));
      cboContractPlace.Value = contract.Place.Id.ToString();

      if (interest.TermPeriods != 0) {
        txtTermPeriod.Value = interest.TermPeriods.ToString();
      }
      cboTermUnit.Value = interest.TermUnit.Id.ToString();
      if (interest.Rate != 0) {
        txtInterestRate.Value = interest.Rate.ToString("N2");
      }
      cboInterestRateType.Value = interest.RateType.Id.ToString();
    }

    #endregion Public methods

  } // class RecordingActAttributesEditorControl

} // namespace Empiria.Web.UI.LRS
