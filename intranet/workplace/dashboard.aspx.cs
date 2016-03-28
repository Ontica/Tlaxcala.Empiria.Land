/* Empiria Land **********************************************************************************************
*																																																						 *
*	 Solution  : Empiria Land                                     System   : Land Intranet Application         *
*	 Namespace : Empiria.Web.UI.Workplace                         Assembly : Empiria.Land.Intranet.dll         *
*	 Type      : Dashboard                                        Pattern  : Dashboard Web Page                *
*  Version   : 2.1                                              License  : Please read license.txt file      *
*																																																						 *
*  Summary   : Web page that serves as a canvas for display DashboardItem type elements.                     *
*																																																						 *
********************************** Copyright(c) 1994-2016. La Vía Óntica SC, Ontica LLC and contributors.  **/
using System;

using Empiria.Presentation.Web;

namespace Empiria.Web.UI.Workplace {

  public partial class Dashboard : WebPage {

    #region Fields

    protected WebViewModel dashboardWebViewModel = null;

    #endregion Fields

    protected void Page_Load(object sender, EventArgs e) {
      Initialize();
      if (!IsPostBack) {
        //LoadDashboard();
      } else {
        ExecuteCommand();
      }
      //base.Master.SetEndLoadScript("showTabStrip(" + "0" + ");");			
    }

    private void Initialize() {
      if (!String.IsNullOrEmpty(Request.QueryString["dashboardId"])) {
        dashboardWebViewModel = WebViewModel.Parse(Convert.ToInt32(Request.QueryString["dashboardId"]));
      } else {
        dashboardWebViewModel = WebViewModel.Parse(101);
      }
      PrepareAjaxPage();
    }

    private void PrepareAjaxPage() {
      if (base.Session["AjaxWebPage"] == null) {
        base.Session.Add("AjaxWebPage", this);
      }
    }

    private void ExecuteCommand() {

    }

  } // class Dashboard

} // namespace Empiria.Web.UI.Workplace
