using System;

namespace Empiria.Web.UI {

  public partial class CalendarControl : System.Web.UI.Page {

    protected string selectedValue = "";
    protected bool isVisible = false;

    private void Page_Load(object sender, System.EventArgs e) {
      if (IsPostBack) {
        if (Request.QueryString.Count != 0) {
          if (txtDate.Value != String.Empty) {
            objCalendar.SelectedDate = EmpiriaString.ToDateTime(txtDate.Value);
            objCalendar.VisibleDate = objCalendar.SelectedDate;
            txtDate.Value = String.Empty;
          } else {
            objCalendar.SelectedDate = DateTime.Today;
            objCalendar.VisibleDate = DateTime.Today;
          }
          isVisible = true;
        } else if (objCalendar.SelectedDate != DateTime.MinValue) {
          selectedValue = objCalendar.SelectedDate.ToString("dd/MMM/yyyy");
        }
      }
    }

    private void OnSelectionChanged(object sender, System.EventArgs e) {
      selectedValue = objCalendar.SelectedDate.ToString("dd/MMM/yyyy");
    }

    private void OnVisibleMonthChanged(object sender, System.Web.UI.WebControls.MonthChangedEventArgs e) {
      selectedValue = String.Empty;
      isVisible = true;
    }

    #region Web Form Designer generated code

    override protected void OnInit(EventArgs e) {
      InitializeComponent();
      base.OnInit(e);
    }

    private void InitializeComponent() {
      this.objCalendar.VisibleMonthChanged += new System.Web.UI.WebControls.MonthChangedEventHandler(this.OnVisibleMonthChanged);
      this.objCalendar.SelectionChanged += new System.EventHandler(this.OnSelectionChanged);
      this.Load += new System.EventHandler(this.Page_Load);

    }

    #endregion Web Form Designer generated code

  } // class CalendarControl

} // namespace Empiria.Web.UI
