using System;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Routing;

using Empiria.Presentation.Web;

namespace EmpiriaWeb.Government.LandRegistration {

  // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
  // visit http://go.microsoft.com/?LinkId=9394801

  public class MvcApplication : MVCGlobal {

    protected override void Application_Start(object sender, EventArgs e) {
      base.Application_Start(sender, e);

      //AreaRegistration.RegisterAllAreas();
      //WebApiConfig.Register(GlobalConfiguration.Configuration);
      ////FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
      //RouteConfig.RegisterRoutes(RouteTable.Routes);
      //BundleConfig.RegisterBundles(BundleTable.Bundles);
    }

    protected override void Session_Start(object sender, EventArgs e) {
      base.Session_Start(sender, e);
    }

  }  // class MvcApplication


  //public class BundleConfig {
  //  // For more information on Bundling, visit http://go.microsoft.com/fwlink/?LinkId=254725

  //  //public static void RegisterBundles(BundleCollection bundles) {
  //  //  bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
  //  //              "~/Scripts/jquery-{version}.js"));

  //  //  bundles.Add(new ScriptBundle("~/bundles/jqueryui").Include(
  //  //              "~/Scripts/jquery-ui-{version}.js"));

  //  //  bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
  //  //              "~/Scripts/jquery.unobtrusive*",
  //  //              "~/Scripts/jquery.validate*"));

  //  //  // Use the development version of Modernizr to develop with and learn from. Then, when you're
  //  //  // ready for production, use the build tool at http://modernizr.com to pick only the tests you need.
  //  //  bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
  //  //              "~/Scripts/modernizr-*"));

  //  //  //bundles.Add(new ScriptBundle("~/bundles/kendo").Include(
  //  //  //						"~/Scripts/kendo.web.min.js",
  //  //  //						"~/Scripts/jquery.validate*"));



  //  //  //bundles.Add(new StyleBundle("~/Content/kendo.css").Include(
  //  //  //						"~/Content/kendo.common.min.css", 
  //  //  //						"~/Content/kendo.default.min.css"));

  //  //  bundles.Add(new StyleBundle("~/Content/css").Include("~/Content/site.css"));

  //  //  bundles.Add(new StyleBundle("~/Content/themes/base/css").Include(
  //  //              "~/Content/themes/base/jquery.ui.core.css",
  //  //              "~/Content/themes/base/jquery.ui.resizable.css",
  //  //              "~/Content/themes/base/jquery.ui.selectable.css",
  //  //              "~/Content/themes/base/jquery.ui.accordion.css",
  //  //              "~/Content/themes/base/jquery.ui.autocomplete.css",
  //  //              "~/Content/themes/base/jquery.ui.button.css",
  //  //              "~/Content/themes/base/jquery.ui.dialog.css",
  //  //              "~/Content/themes/base/jquery.ui.slider.css",
  //  //              "~/Content/themes/base/jquery.ui.tabs.css",
  //  //              "~/Content/themes/base/jquery.ui.datepicker.css",
  //  //              "~/Content/themes/base/jquery.ui.progressbar.css",
  //  //              "~/Content/themes/base/jquery.ui.theme.css"));
  //  }
  //}

  //public class FilterConfig {

  //  public static void RegisterGlobalFilters(GlobalFilterCollection filters) {
  //    filters.Add(new HandleErrorAttribute());
  //  }

  //} // class FilterConfig

 // public class RouteConfig {

  //  public static void RegisterRoutes(RouteCollection routes) {
  //    routes.IgnoreRoute("{resource}.axd/{*pathInfo}");
  //    routes.IgnoreRoute("{resource}.aspx/{*pathInfo}");

  //    routes.MapRoute(
  //        name: "Default",
  //        url: "{controller}/{action}/{id}",
  //        defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
  //    );
  //  }
  //}		// class RouteConfig


  //public static class WebApiConfig {

  //  public static void Register(HttpConfiguration config) {
  //    config.Routes.MapHttpRoute(
  //        name: "DefaultApi",
  //        routeTemplate: "api/{controller}/{id}",
  //        defaults: new { id = RouteParameter.Optional }
  //    );
  //  }

  //}	//WebApiConfig

}  // EmpiriaWeb.Government.LandRegistration