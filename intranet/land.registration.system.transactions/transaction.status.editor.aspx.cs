/* Empiria Land **********************************************************************************************
*                                                                                                            *
*  Module   : Land Intranet                                Component : Transaction UI                        *
*  Assembly : Empiria.Land.WebApp.dll                      Pattern   : Web Editor                            *
*  Type     : TransactionStatusEditor                      License   : Please read LICENSE.txt file          *
*                                                                                                            *
*  Summary  : Transaction status editor.                                                                     *
*                                                                                                            *
************************* Copyright(c) La Vía Óntica SC, Ontica LLC and contributors. All rights reserved. **/
using System;

using Empiria.Contacts;
using Empiria.Presentation.Web;

using Empiria.Land.Registration.Transactions;

namespace Empiria.Land.WebApp {

  public partial class TransactionStatusEditor : WebPage {

    #region Fields

    protected LRSTransaction transaction = null;

    protected string OnLoadScript = String.Empty;

    #endregion Fields

    #region Constructors and parsers

    protected void Page_Load(object sender, EventArgs e) {
      Initialize();
      if (!IsPostBack) {
        LoadEditor();
      } else {
        ExecuteCommand();
      }
    }

    private void ExecuteCommand() {
      switch (base.CommandName) {
        case "takeTransactionInDeliveryDesk":
          TakeTransactionInDeliveryDesk();
          return;

        case "deliverTransaction":
          DeliverTransaction();
          return;

        case "returnTransaction":
          ReturnTransaction();
          return;

        case "reentryTransaction":
          ReentryTransaction();
          return;

        case "refresh":
          Response.Redirect("transaction.return.editor.aspx?transactionId=" + transaction.Id.ToString(), true);
          return;

        default:
          throw new NotImplementedException(base.CommandName);
      }
    }


    private void Initialize() {
      int transactionId = int.Parse(Request.QueryString["transactionId"]);
      if (transactionId != 0) {
        transaction = LRSTransaction.Parse(transactionId);
      } else {
        transaction = LRSTransaction.Empty;
      }
    }


    private void LoadEditor() {

    }

    #endregion Constructors and parsers

    #region Protected methods


    protected string GetTransactionTrack() {
      const string template = "<tr class='{CLASS}' valign='top'><td>{CURRENT.STATUS}</td>" +
                              "<td style='white-space:nowrap;'>{RESPONSIBLE}</td>" +
                              "<td align='right' style='white-space:nowrap;'>{CHECK.IN}</td>" +
                              "<td align='right' style='white-space:nowrap;'>{END.PROCESS}</td>" +
                              "<td align='right' style='white-space:nowrap;'>{CHECK.OUT}</td>" +
                              "<td align='right' style='white-space:nowrap;'>{ELAPSED.TIME}</td>" +
                              "<td style='white-space:nowrap;'>{STATUS}</td>" +
                              "<td style='white-space:normal;width:40%;'>{NOTES}</td></tr>";

      const string subTotalTemplate = "<tr class='detailsGreenItem'>" +
                                      "<td colspan='5'>&nbsp;</td>" +
                                      "<td  align='right'><b>{WORK.TOTAL.TIME}</b></td>" +
                                      "<td>&nbsp;</td>" +
                                      "<td>Duración total: <b>{TOTAL.TIME}</b></td></tr>";

      const string footer = "<tr class='detailsSuperHeader' valign='middle'>" +
                            "<td colspan='5' style='height:28px'>&nbsp;&nbsp;{NEXT.STATUS}</td>" +
                            "<td  align='right'><b>{WORK.TOTAL.TIME}</b></td>" +
                            "<td>&nbsp;</td>" +
                            "<td>&nbsp;&nbsp;&nbsp;Duración total: <b>{TOTAL.TIME}</b></td></tr>";

      LRSWorkflowTaskList taskList = this.transaction.Workflow.Tasks;

      string html = String.Empty;
      double subTotalWorkTimeSeconds = 0.0d;
      double subTotalElapsedTimeSeconds = 0.0d;
      double workTimeSeconds = 0.0d;
      double elapsedTimeSeconds = 0.0d;

      LRSWorkflowTask task = null;
      bool hasReentries = false;
      for (int i = 0; i < taskList.Count; i++) {
        string temp = String.Empty;
        task = taskList[i];
        if (task.CurrentStatus == LRSTransactionStatus.Reentry) {
          temp = subTotalTemplate.Replace("{WORK.TOTAL.TIME}", EmpiriaString.TimeSpanString(subTotalWorkTimeSeconds));
          temp = temp.Replace("{TOTAL.TIME}", EmpiriaString.TimeSpanString(subTotalElapsedTimeSeconds));
          subTotalWorkTimeSeconds = 0.0d;
          subTotalElapsedTimeSeconds = 0.0d;
          hasReentries = true;
          html += temp;
        }

        temp = template.Replace("{CURRENT.STATUS}", task.CurrentStatus == LRSTransactionStatus.Reentry ?
                                                    "<b>" + task.CurrentStatusName + "</b>" : task.CurrentStatusName);

        temp = temp.Replace("{CLASS}", ((i % 2) == 0) ? "detailsItem" : "detailsOddItem");
        temp = temp.Replace("{RESPONSIBLE}", task.Responsible.Alias);

        string dateFormat = "dd/MMM/yyyy HH:mm";
        if (task.CheckInTime.Year == DateTime.Today.Year) {
          dateFormat = "dd/MMM HH:mm";
        }
        temp = temp.Replace("{CHECK.IN}", task.CheckInTime.ToString(dateFormat));
        temp = temp.Replace("{END.PROCESS}", task.EndProcessTime != ExecutionServer.DateMaxValue ?
                                                      task.EndProcessTime.ToString(dateFormat) : "&nbsp;");
        temp = temp.Replace("{CHECK.OUT}", task.CheckOutTime != ExecutionServer.DateMaxValue ?
                                                      task.CheckOutTime.ToString(dateFormat) : "&nbsp;");

        TimeSpan elapsedTime = task.OfficeWorkElapsedTime;
        temp = temp.Replace("{ELAPSED.TIME}", elapsedTime == TimeSpan.Zero ?
                                                  "&nbsp;" : EmpiriaString.TimeSpanString(elapsedTime));
        temp = temp.Replace("{STATUS}", task.StatusName);

        temp = temp.Replace("{NOTES}", task.Notes);
        html += temp;

        subTotalWorkTimeSeconds += elapsedTime.TotalSeconds;
        subTotalElapsedTimeSeconds += task.ElapsedTime.TotalSeconds;
        workTimeSeconds += elapsedTime.TotalSeconds;
        elapsedTimeSeconds += task.ElapsedTime.TotalSeconds;
      }
      if (hasReentries) {
        string temp = subTotalTemplate.Replace("{WORK.TOTAL.TIME}",
                                               EmpiriaString.TimeSpanString(subTotalWorkTimeSeconds));
        temp = temp.Replace("{TOTAL.TIME}", EmpiriaString.TimeSpanString(subTotalElapsedTimeSeconds));
        html += temp;
      }
      html += footer.Replace("{WORK.TOTAL.TIME}", EmpiriaString.TimeSpanString(workTimeSeconds));
      html = html.Replace("{TOTAL.TIME}", EmpiriaString.TimeSpanString(elapsedTimeSeconds));
      html = html.Replace("{NEXT.STATUS}", (task != null && task.Status == WorkflowTaskStatus.OnDelivery) ?
                                                      "Próximo estado: &nbsp;<b>" + task.NextStatusName + "</b>" : String.Empty);

      return html;
    }


    protected bool IsTransactionReadyForTakeInDeliveryDesk() {
      if (!ExecutionServer.CurrentPrincipal.IsInRole("LRSTransaction.DeliveryDesk")) {
        return false;
      }
      if (transaction.Workflow.NextStatus == LRSTransactionStatus.ToDeliver ||
          transaction.Workflow.NextStatus == LRSTransactionStatus.ToReturn) {
        return true;
      }

      return false;
    }


    protected bool IsTransactionReadyForDelivery() {
      if (!ExecutionServer.CurrentPrincipal.IsInRole("LRSTransaction.DeliveryDesk")) {
        return false;
      }
      if (transaction.Workflow.IsReadyForDelivery &&
          transaction.Workflow.NextStatus == LRSTransactionStatus.Delivered) {
        return true;
      }
      return false;
    }


    protected bool IsTransactionReadyForReturn() {
      if (!ExecutionServer.CurrentPrincipal.IsInRole("LRSTransaction.DeliveryDesk")) {
        return false;
      }
      if (transaction.Workflow.IsReadyForDelivery &&
          transaction.Workflow.NextStatus == LRSTransactionStatus.Returned) {
        return true;
      }
      return false;
    }


    protected bool IsTransactionReadyForReentry() {
      if (!ExecutionServer.CurrentPrincipal.IsInRole("LRSTransaction.ReentryByFails")) {
        return false;
      }
      return transaction.Workflow.IsReadyForReentry;
    }


    #endregion Protected methods


    #region Private methods

    private void TakeTransactionInDeliveryDesk() {
      Assertion.Assert(IsTransactionReadyForTakeInDeliveryDesk(), "La operación no puede ser ejecutada: 'TakeTransactionInDeliveryDesk'.");

      string notes = GetCommandParameter("notes", false);

      transaction.Workflow.Take(notes);
    }


    private void DeliverTransaction() {
      Assertion.Assert(IsTransactionReadyForDelivery(), "La operación no puede ser ejecutada: 'DeliverTransaction'.");

      LRSTransactionStatus status = LRSTransactionStatus.Delivered;
      string notes = GetCommandParameter("notes", false);

      string s = LRSWorkflowRules.ValidateStatusChange(transaction, status);
      if (!String.IsNullOrWhiteSpace(s)) {
        this.ShowAlertBox(s);
        return;
      }
      transaction.Workflow.SetNextStatus(status, Person.Empty, notes);
    }



    private void ReturnTransaction() {
      Assertion.Assert(IsTransactionReadyForReturn(), "La operación no puede ser ejecutada: 'ReturnTransaction'.");

      LRSTransactionStatus status = LRSTransactionStatus.Returned;
      string notes = GetCommandParameter("notes", false);

      string s = LRSWorkflowRules.ValidateStatusChange(transaction, status);
      if (!String.IsNullOrWhiteSpace(s)) {
        this.ShowAlertBox(s);
        return;
      }

      transaction.Workflow.SetNextStatus(status, Person.Empty, notes);
    }


    private void ReentryTransaction() {
      Assertion.Assert(IsTransactionReadyForReentry(), "La operación no puede ser ejecutada: 'ReentryTransaction'.");
      try {
        transaction.Workflow.Reentry();
        this.ShowAlertBox("Este trámite fue reingresado correctamente.");
      } catch (Exception e) {
        this.ShowAlertBox(e.Message);
      }
    }


    private void ShowAlertBox(string message) {
      this.OnLoadScript = "alert('" + EmpiriaString.FormatForScripting(message) + "');doOperation('redirectThis');";
    }


    #endregion Private methods

  } // class TransactionStatusEditor

} // namespace Empiria.Land.WebApp
