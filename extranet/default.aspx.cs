using System;

namespace EmpiriaWeb.Government.LandRegistration {

  public partial class RedirectPage : System.Web.UI.Page {

    protected void Page_Load(object sender, EventArgs e) {
      base.Response.Redirect("~/Home/", true);
    }
  }
}