/* Empiria® Land 2014 ****************************************************************************************
*																																																						 *
*	 Solution  : Empiria® Land                                    System   : Land Intranet Application         *
*	 Namespace : Empiria.Web.UI.Ajax                              Assembly : Empiria.Land.Intranet.dll         *
*	 Type      : LandRegistrationSystemData                       Pattern  : Ajax Services Web Page            *
*	 Date      : 28/Mar/2014                                      Version  : 1.5  License: CC BY-NC-SA 4.0     *
*																																																						 *
*  Summary   : Gets Empiria control contents through Ajax invocation.                                        *
*																																																						 *
**************************************************** Copyright © La Vía Óntica SC + Ontica LLC. 1994-2014. **/
using System;

using Empiria.Presentation.Web;

namespace Empiria.Web.UI.Ajax {

  public partial class GeneralSystemData : AjaxWebPage {

    protected override string ImplementsCommandRequest(string commandName) {
      switch (commandName) {
        case "isNoLabourDateCmd":
          return IsNoLabourDateCommandHandler();
        case "daysBetweenCmd":
          return DaysBetweenCommandHandler();
        default:
          throw new WebPresentationException(WebPresentationException.Msg.UnrecognizedCommandName,
                                             commandName);
      }
    }

    #region Private command handlers

    private string DaysBetweenCommandHandler() {
      DateTime fromDate = EmpiriaString.ToDate(GetCommandParameter("fromDate", false));
      DateTime toDate = EmpiriaString.ToDate(GetCommandParameter("toDate", false));

      return Empiria.DataTypes.Calendar.DaysBetween(fromDate, toDate).ToString();
    }

    private string IsNoLabourDateCommandHandler() {
      DateTime date = EmpiriaString.ToDate(GetCommandParameter("date", false));

      bool result = (Empiria.DataTypes.Calendar.IsWeekendDate(date) || Empiria.DataTypes.Calendar.IsNoLabourDate(date));

      return result.ToString();
    }

    #endregion Private command handlers

  } // class WorkplaceData

} // namespace Empiria.Web.UI.Ajax