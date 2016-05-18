using System;

using Empiria.Land.Registration;
using Empiria.Land.UI;

namespace Empiria.Land.WebApp {

  public partial class RecordingPartyViewerControl : System.Web.UI.UserControl {

    #region Fields

    RealEstate property = RealEstate.Empty;
    RecordingAct baseRecordingAct = null;

    #endregion Fields

    protected void Page_Load(object sender, EventArgs e) {

    }

    public RealEstate Property {
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
      RecordingAct antecedent = property.GetRecordingAntecedent(baseRecordingAct, false);

      return LRSGridControls.GetRecordingActPartiesGrid(antecedent, true);
    }

    public void LoadRecordingMainPayment() {

    }

  } // class RecordingPartyViewerControl

} // namespace Empiria.Land.WebApp
