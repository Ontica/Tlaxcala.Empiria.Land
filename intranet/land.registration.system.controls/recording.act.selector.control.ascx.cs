using System;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Empiria.DataTypes;
using Empiria.Land.Registration;
using Empiria.Land.UI;
using Empiria.Presentation;
using Empiria.Presentation.Web.Content;

namespace Empiria.Web.UI.LRS {

  public partial class LRSRecordingActSelectorControl : System.Web.UI.UserControl {

    #region Fields

    private Recording recording = Recording.Empty;

    #endregion Fields

    protected void Page_Load(object sender, EventArgs e) {

    }

    public Recording Recording {
      get { return recording; }
      set { recording = value; }
    }

    public Money AppraisalAmount {
      get {
        if ((cboAppraisalCurrency.Value.Length != 0) && (txtAppraisalAmount.Value.Length != 0)) {
          return Money.Parse(Currency.Parse(int.Parse(cboAppraisalCurrency.Value)), decimal.Parse(txtAppraisalAmount.Value));
        } else {
          return Money.Unknown;
        }
      }
    }

    public Money OperationAmount {
      get {
        if ((cboOperationCurrency.Value.Length != 0) && (txtOperationAmount.Value.Length != 0)) {
          return Money.Parse(Currency.Parse(int.Parse(cboOperationCurrency.Value)), decimal.Parse(txtOperationAmount.Value));
        } else {
          return Money.Unknown;
        }
      }
    }

    public void LoadEditor() {
      LoadRecordingActTypeCategoriesCombo();
      LoadAnotherPropertyRecorderOfficesCombo();

      AppendOnUpdateUSerInterfaceEvent(cboRecordingActTypeCategory);
      AppendOnUpdateUSerInterfaceEvent(cboProperty);
      AppendOnUpdateUSerInterfaceEvent(cboAnotherRecorderOffice);
      AppendOnUpdateUSerInterfaceEvent(cboAnotherRecordingBook);
      AppendOnUpdateUSerInterfaceEvent(cboAnotherRecording);
    }

    private void LoadAnotherPropertyRecorderOfficesCombo() {
      LRSHtmlSelectControls.LoadRecorderOfficeCombo(this.cboAnotherRecorderOffice, ComboControlUseMode.ObjectCreation,
                                                    this.Recording.RecordingBook.RecorderOffice);

      RecordingSection recordingSection = RecordingSection.Parse(1051);

      FixedList<RecordingBook> booksList = this.Recording.RecordingBook.RecorderOffice.GetRecordingBooks(recordingSection);

      if (booksList.Count != 0) {
        HtmlSelectContent.LoadCombo(this.cboAnotherRecordingBook, booksList, "Id", "FullName",
                                    "( Seleccionar el libro registral donde se encuentra )", String.Empty, String.Empty);
      } else {
        HtmlSelectContent.LoadCombo(this.cboAnotherRecordingBook, "No existen libros de traslativo de dominio para el Distrito",
                                    String.Empty, String.Empty);
      }

      cboAnotherRecording.Items.Clear();
      cboAnotherRecording.Items.Add(new ListItem("¿Libro?", String.Empty));

      cboAnotherProperty.Items.Clear();
      cboAnotherProperty.Items.Add(new ListItem("( ¿Inscripción? )", String.Empty));
    }

    private void AppendOnUpdateUSerInterfaceEvent(HtmlControl control) {
      control.Attributes.Add("onchange", "return " + this.ClientID + "_updateUserInterface(this);");
    }

    public void SaveRecordingMainPayment() {
      //if (!this.Visible) {
      //  return;
      //}
      //RecordingPayment payment = null;

      //if (recording.RecordingPaymentList.Count == 0) {
      //  payment = new RecordingPayment(this.recording);
      //} else {
      //  payment = recording.RecordingPaymentList[0];
      //}
      //if (txtRecordingPayment.Value.Length == 0) {
      //  txtRecordingPayment.Value = "0.00";
      //}
      //payment.PaymentOffice = recording.RecordingBook.RecorderOffice;
      //payment.PaymentTime = recording.AuthorizedTime;
      //Currency currency = null;
      //switch (cboRecordingPaymentCurrency.Value) {
      //  case "NC":
      //    currency = Currency.Unknown;
      //    break;
      //  case "NL":
      //    currency = Currency.NoLegible;
      //    break;
      //  case "ND":
      //    currency = Currency.Empty;
      //    break;
      //  default:
      //    currency = Currency.Parse(int.Parse(cboRecordingPaymentCurrency.Value));
      //    break; ;
      //}
      //payment.FeeAmount = Money.Parse(currency, decimal.Parse(txtRecordingPayment.Value));
      //payment.ReceiptNumber = txtRecordingPaymentReceipt.Value;
      //payment.OtherReceipts = txtRecordingPaymentAdditionalReceipts.Value;

      //if (recording.RecordingPaymentList.Count == 0) {
      //  recording.AppendRecordingPayment(payment);
      //} else {
      //  payment.Save();
      //}
    }

    private void LoadRecordingActTypeCategoriesCombo() {
      LRSHtmlSelectControls.LoadRecordingActTypesCategoriesCombo(this.cboRecordingActTypeCategory);
    }

  } // class RecordingDocumentEditorControl

} // namespace Empiria.Web.UI.LRS
