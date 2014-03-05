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
      recordingAct.AppraisalAmount = Money.Parse(Currency.Parse(int.Parse(cboAppraisalCurrency.Value)),
                                                 decimal.Parse(txtAppraisalAmount.Value));
      if (!this.DisplayOperationAmount) {
        return;
      }
      if (txtOperationAmount.Value.Length == 0) {
        txtOperationAmount.Value = "0.00";
      }
      recordingAct.OperationAmount = Money.Parse(Currency.Parse(int.Parse(cboOperationCurrency.Value)),
                                                 decimal.Parse(txtOperationAmount.Value));
    }

    private void FillCreditFields() {
      if (!String.IsNullOrEmpty(Request.Form[txtContractDate.Name])) {
        recordingAct.ContractDate = EmpiriaString.ToDateTime(txtContractDate.Value);
      } else {
        recordingAct.ContractDate = ExecutionServer.DateMaxValue;
      }
      recordingAct.ContractNumber = txtContractNumber.Value;
      if (!String.IsNullOrEmpty(Request.Form[cboContractPlace.Name])) {
        recordingAct.ContractPlace = GeographicRegionItem.Parse(int.Parse(Request.Form[cboContractPlace.Name]));
      } else {
        recordingAct.ContractPlace = GeographicRegionItem.Unknown;
      }
      if (txtTermPeriod.Value.Length == 0) {
        txtTermPeriod.Value = "0";
      }
      if (txtInterestRate.Value.Length == 0) {
        txtInterestRate.Value = "0.00";
      }
      recordingAct.TermPeriods = int.Parse(txtTermPeriod.Value);
      recordingAct.TermUnit = DataTypes.Unit.Parse(int.Parse(cboTermUnit.Value));
      recordingAct.InterestRate = decimal.Parse(txtInterestRate.Value);
      recordingAct.InterestRateType = InterestRateType.Parse(int.Parse(cboInterestRateType.Value));
    }

    public void LoadRecordingAct() {
      if (this.DisplayCreditFields) {
        LoadCreditFields();
      } else {
        creditFieldsRow1.Visible = false;
        creditFieldsRow2.Visible = false;
        creditFieldsRow3.Visible = false;
      }
      if (recordingAct.AppraisalAmount.Currency.IsEmptyInstance || recordingAct.AppraisalAmount.Currency.Equals(Currency.Unknown)) {
        txtAppraisalAmount.Value = String.Empty;
      } else {
        txtAppraisalAmount.Value = recordingAct.AppraisalAmount.Amount.ToString("N2");
      }
      cboAppraisalCurrency.Value = recordingAct.AppraisalAmount.Currency.Id.ToString();

      if (!this.DisplayOperationAmount) {
        return;
      }
      if (recordingAct.OperationAmount.Currency.IsEmptyInstance || recordingAct.OperationAmount.Currency.Equals(Currency.Unknown)) {
        txtOperationAmount.Value = String.Empty;
      } else {
        txtOperationAmount.Value = recordingAct.OperationAmount.Amount.ToString("0,###.00##");
      }
      cboOperationCurrency.Value = recordingAct.OperationAmount.Currency.Id.ToString();
    }

    private void LoadCreditFields() {
      creditFieldsRow1.Visible = true;
      creditFieldsRow2.Visible = true;
      creditFieldsRow3.Visible = true;

      if (recordingAct.ContractDate != ExecutionServer.DateMaxValue) {
        txtContractDate.Value = recordingAct.ContractDate.ToString("dd/MMM/yyyy");
      }
      txtContractNumber.Value = recordingAct.ContractNumber;

      cboContractPlace.Items.Clear();
      cboContractPlace.Items.Add(new ListItem("( Seleccionar lugar del contrato )", String.Empty));
      cboContractPlace.Items.Add(new ListItem(recordingAct.ContractPlace.FullName, recordingAct.ContractPlace.Id.ToString()));
      cboContractPlace.Value = recordingAct.ContractPlace.Id.ToString();

      if (recordingAct.TermPeriods != 0) {
        txtTermPeriod.Value = recordingAct.TermPeriods.ToString();
      }
      cboTermUnit.Value = recordingAct.TermUnit.Id.ToString();
      if (recordingAct.InterestRate != 0) {
        txtInterestRate.Value = recordingAct.InterestRate.ToString("N2");
      }
      cboInterestRateType.Value = recordingAct.InterestRateType.Id.ToString();
    }

    #endregion Public methods

  } // class RecordingActAttributesEditorControl

} // namespace Empiria.Web.UI.LRS