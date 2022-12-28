/* Empiria Land **********************************************************************************************
*                                                                                                            *
*  Solution  : Empiria Land                                     System   : Land Intranet Application         *
*  Namespace : Empiria.Web.UI.Ajax                              Assembly : Empiria.Land.Intranet.dll         *
*  Type      : ControlBuilder                                   Pattern  : Ajax Services Web Page            *
*  Version   : 3.0                                              License  : Please read license.txt file      *
*                                                                                                            *
*  Summary   : Gets Empiria control contents through Ajax invocation.                                        *
*                                                                                                            *
********************************** Copyright(c) 1994-2023. La Vía Óntica SC, Ontica LLC and contributors.  **/
using System;

using Empiria.Presentation.Web;

namespace Empiria.Web.UI.Ajax {

  public partial class WorkplaceData : AjaxWebPage {

    protected override string ImplementsCommandRequest(string commandName) {
      switch (commandName) {
        case "resetSystemCacheCmd":
          ResetSystemCacheHandler();
          return "true";
        case "windowFeaturesCmd":
          return WindowFeaturesCommandHandler();
        default:
          throw new WebPresentationException(WebPresentationException.Msg.UnrecognizedCommandName,
                                             commandName);
      }
    }

    #region Private command handlers

    private void ResetSystemCacheHandler() {
      //ObjectType.ResetCache();
      //ObjectTypeInfo.ResetCache();
    }

    private string WindowFeaturesCommandHandler() {
      string options = "status=yes,scrollbars=yes,fullscreen=no,location=no,menubar=no,resizable=yes";
      options += ",height=" + "520" + "px,width=" + "720" + "px";

      return options;
    }

    #endregion Private command handlers

    public WebPage GetPage() {
      return base.Session["AjaxWebPage"] as WebPage;
    }

  } // class WorkplaceData

} // namespace Empiria.Web.UI.Ajax
