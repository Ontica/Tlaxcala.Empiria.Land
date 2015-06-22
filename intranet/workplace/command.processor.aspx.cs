/* Empiria® Land 2015 ****************************************************************************************
*																																																						 *
*	 Solution  : Empiria® Land                                    System   : Land Intranet Application         *
*	 Namespace : Empiria.Web.UI.Workplace                         Assembly : Empiria.Land.Intranet.dll         *
*	 Type      : CommandProcessor                                 Pattern  : Command Proccesor Page            *
*	 Date      : 25/Jun/2015                                      Version  : 2.0  License: LICENSE.TXT file    *
*																																																						 *
*  Summary   : Process a HTTP GET command.                                                                   *
*																																																						 *
**************************************************** Copyright © La Vía Óntica SC + Ontica LLC. 1994-2015. **/
using System;

using Empiria.Presentation;
using Empiria.Presentation.Web;

namespace Empiria.Web.UI.Workplace {

  public partial class CommandProcessor : System.Web.UI.Page {

    private string commandName = String.Empty;

    private bool IsSessionAlive {
      get { return (ExecutionServer.CurrentPrincipal != null); }
    }

    protected void Page_Load(object sender, EventArgs e) {
      if (IsPostBack) {
        return;
      }
      VerifySession();
      Initialize();
      try {
        ProcessCommand();
      } catch (Exception innerException) {
        throw new WebPresentationException(WebPresentationException.Msg.CommandProcessingError,
                                           innerException, commandName);
      }
    }

    private void Initialize() {
      if (!String.IsNullOrEmpty(Request.QueryString["commandName"])) {
        commandName = Request.QueryString["commandName"];
      } else {
        throw new WebPresentationException(WebPresentationException.Msg.NullCommandName);
      }
    }

    private void ProcessCommand() {
      switch (commandName) {
        case "loadViewCmd":
          LoadViewCommandHandler();
          return;
        case "createViewCmd":
          CreateViewCommandHandler();
          return;
        case "refreshViewCmd":
          RefreshViewCommandHandler();
          return;
        case "backHistoryCmd":
          BackHistoryCommandHandler();
          return;
        case "forwardHistoryCmd":
          ForwardHistoryCommandHandler();
          return;
        case "createWorkplaceCmd":
          CreateWorkplaceCommandHandler();
          return;
        default:
          throw new WebPresentationException(WebPresentationException.Msg.UnrecognizedCommandName,
                                             commandName);
      }
    }

    #region Private command handlers

    private void BackHistoryCommandHandler() {
      Presentation.Workplace workplace = GetWorkplace();

      string[] history = workplace.NavigationHistory.Back().Split('?');

      WebViewModel viewModel = (WebViewModel) ViewModel.Parse(history[0]);
      if (history.Length == 1) {
        workplace.ActivateView(viewModel);
      } else {
        workplace.ActivateView(viewModel, history[1]);
      }
    }

    private void CreateViewCommandHandler() {
      string viewName = GetCommandParameter("viewName", true);

      WebViewModel viewModel = (WebViewModel) ViewModel.Parse(viewName);

      string viewParameters = String.Empty; // Assign Request.QueryString?

      Presentation.Workplace workplace = WebContext.WorkplaceManager.CreateWorkplace();
      workplace.ActivateView(viewModel, viewParameters);
    }

    private void CreateWorkplaceCommandHandler() {
      Presentation.Workplace sendingWorkplace = GetWorkplace();
      WebViewModel viewModel = (WebViewModel) sendingWorkplace.CurrentViewModel;

      Presentation.Workplace workplace = WebContext.WorkplaceManager.CreateWorkplace();
      workplace.ActivateView(viewModel);
    }

    private void ForwardHistoryCommandHandler() {
      Presentation.Workplace workplace = GetWorkplace();

      string[] history = workplace.NavigationHistory.Forward().Split('?');
      WebViewModel viewModel = (WebViewModel) ViewModel.Parse(history[0]);

      if (history.Length == 1) {
        workplace.ActivateView(viewModel);
      } else {
        workplace.ActivateView(viewModel, history[1]);
      }
    }

    private void LoadViewCommandHandler() {
      string viewName = GetCommandParameter("viewName", true);
      string userInterfaceItemId = GetCommandParameter("userInterfaceItemId", false);
      WebViewModel viewModel = (WebViewModel) ViewModel.Parse(viewName);

      string viewParameters = String.Empty; // Assign Request.QueryString?
      viewParameters += (viewParameters.Length != 0 ? "&" : String.Empty) + "dashboardId=" + userInterfaceItemId;
      Presentation.Workplace workplace = GetWorkplace();
      workplace.ActivateView(viewModel, viewParameters);
    }

    private void RefreshViewCommandHandler() {
      Presentation.Workplace workplace = GetWorkplace();

      workplace.ActivateView(workplace.CurrentViewModel);
    }

    #endregion Private command handlers

    #region Private utility methods

    private string GetCommandParameter(string parameterName, bool required) {
      if (!String.IsNullOrEmpty(Request.QueryString[parameterName])) {
        return Request.QueryString[parameterName];
      } else if (!required) {
        return String.Empty;
      } else {
        throw new WebPresentationException(WebPresentationException.Msg.NullCommandParameter,
                                           commandName, parameterName);
      }
    }

    private Presentation.Workplace GetWorkplace() {
      string workplaceGuidString = GetCommandParameter("workplace", true);

      System.Guid workplaceGuid = new System.Guid(workplaceGuidString);

      return WebContext.WorkplaceManager.GetWorkplace(workplaceGuid);
    }

    private void VerifySession() {
      if (!IsSessionAlive) {
        throw new WebPresentationException(WebPresentationException.Msg.SessionTimeout);
      }
    }

    #endregion Private utility methods

  } // class CommandProcessor

} // namespace Empiria.Web.UI.Workplace
