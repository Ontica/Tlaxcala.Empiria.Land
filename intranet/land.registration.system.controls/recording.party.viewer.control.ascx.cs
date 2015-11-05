using System;

using Empiria.Land.Registration;
using Empiria.Land.UI;

namespace Empiria.Web.UI.LRS {

  public partial class RecordingPartyViewerControl : System.Web.UI.UserControl {

    #region Fields

    Property property = Property.Empty;
    RecordingAct baseRecordingAct = null;

    #endregion Fields

    protected void Page_Load(object sender, EventArgs e) {

    }

    public Property Property {
      get { return property; }
      set { property = value; }
    }

    public RecordingAct BaseRecordingAct {
      get { return baseRecordingAct; }
      set { baseRecordingAct = value; }
    }

    protected string GetAntecedentRecordingActPartiesGrid() {
      if (baseRecordingAct.IsAnnotation) {
        this.Visible = false;
        return string.Empty;
      }
      RecordingAct antecedent = property.GetDomainAntecedent(baseRecordingAct);

      return LRSGridControls.GetRecordingActPartiesGrid(antecedent, true);
    }

    public void LoadRecordingMainPayment() {

    }

  } // class RecordingPartyViewerControl

} // namespace Empiria.Web.UI.LRS
