/* Empiria Land **********************************************************************************************
*                                                                                                            *
*  Solution  : Empiria Land                                     System   : Land Intranet Application         *
*  Namespace : Empiria.Web.UI.Ajax                              Assembly : Empiria.Land.Intranet.dll         *
*  Type      : GeneralSystemData                                Pattern  : Ajax Services Web Page            *
*  Version   : 3.0                                              License  : Please read license.txt file      *
*                                                                                                            *
*  Summary   : Gets Empiria control contents through Ajax invocation.                                        *
*                                                                                                            *
********************************** Copyright(c) 1994-2017. La Vía Óntica SC, Ontica LLC and contributors.  **/
using System;

using Empiria.DataTypes.Time;

using Empiria.Presentation.Web;

namespace Empiria.Web.UI.Ajax {

  public partial class GeneralSystemData : AjaxWebPage {

    protected override string ImplementsCommandRequest(string commandName) {
      switch (commandName) {
        case "isNonWorkingDateCmd":
          return IsNonWorkingDateCommandHandler();
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

      return fromDate.DaysTo(toDate)
                     .ToString();
    }


    private string IsNonWorkingDateCommandHandler() {
      DateTime date = EmpiriaString.ToDate(GetCommandParameter("date", false));

      return date.IsNonWorkingDate()
                 .ToString();
    }

    #endregion Private command handlers

  } // class GeneralSystemData

} // namespace Empiria.Web.UI.Ajax
