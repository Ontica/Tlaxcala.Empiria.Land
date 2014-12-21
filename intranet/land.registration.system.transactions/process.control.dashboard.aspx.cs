/* Empiria® Land 2015 ****************************************************************************************
*																																																						 *
*	 Solution  : Empiria® Land                                    System   : Land Intranet Application         *
*	 Namespace : Empiria.Web.UI.Workflow                          Assembly : Empiria.Land.Intranet.dll         *
*	 Type      : TasksDashboard                                   Pattern  : Explorer Web Page                 *
*	 Date      : 04/Jan/2015                                      Version  : 2.0  License: LICENSE.TXT file    *
*																																																						 *
*  Summary   : Multiview dashboard used for workflow task management.                                        *
*																																																						 *
**************************************************** Copyright © La Vía Óntica SC + Ontica LLC. 2009-2015. **/
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using Empiria.Contacts;
using Empiria.Land.Registration.Data;
using Empiria.Land.Registration.Transactions;
using Empiria.Presentation.Web;
using Empiria.Presentation.Web.Content;

namespace Empiria.Web.UI.LRS {

  public partial class ProcessControlDashboard : MultiViewDashboard {

    #region Protected methods

    private string selectedComboFromValue = String.Empty;

    protected void Page_Init(object sender, EventArgs e) {
      cboFrom.ViewStateMode = System.Web.UI.ViewStateMode.Enabled;
      cboFrom.EnableViewState = true;
      cboResponsible.ViewStateMode = System.Web.UI.ViewStateMode.Enabled;
      cboResponsible.EnableViewState = true;

      selectedComboFromValue = String.IsNullOrEmpty(Request.Form[cboFrom.UniqueID]) ? String.Empty : Request.Form[cboFrom.UniqueID];
    }

    public sealed override Repeater ItemsRepeater {
      get { return this.itemsRepeater; }
    }

    protected sealed override bool ExecutePageCommand() {
      switch (base.CommandName) {
        case "receiveLRSTransaction":
          ReceiveLRSTransaction();
          base.LoadRepeater();
          return true;
        case "takeLRSTransaction":
          TakeLRSTransaction();
          base.LoadRepeater();
          return true;
        case "changeTransactionStatus":
          ChangeTransactionStatus();
          base.LoadRepeater();
          return true;
        case "returnDocumentToMe":
          ReturnDocumentToMe();
          base.LoadRepeater();
          return true;
        case "updateUserInterface":
          base.LoadRepeater();
          return true;
        default:
          return false;
      }
    }

    protected sealed override void Initialize() {

    }

    protected sealed override DataView LoadDataSource() {
      Contact me = Contact.Parse(ExecutionServer.CurrentUserId);
      string filter = GetFilter();
      string sort = String.Empty;
      if (base.SelectedTabStrip == 0) {
        if (!ExecutionServer.CurrentPrincipal.IsInRole("LRSTransaction.ReceiveTransaction")) {
          if (filter.Length != 0) {
            filter += " AND ";
          }
          filter += "(TransactionStatus NOT IN ('D','L'))";
          return TransactionData.GetLRSResponsibleTransactionInbox(me, TrackStatus.Pending, filter, sort);
        } else {
          if (filter.Length != 0) {
            filter += " AND ";
          }
          filter += "((ResponsibleId = " + User.Id.ToString() + ") OR (TransactionStatus = 'Y')) AND (TrackStatus = 'P') AND (TransactionStatus NOT IN ('D','L'))";
          return TransactionData.GetLRSTransactionsForUI(filter, sort);
        }
      } else if (base.SelectedTabStrip == 1) {
        return TransactionData.GetLRSResponsibleTransactionInbox(me, TrackStatus.OnDelivery, filter, sort);
      } else if (base.SelectedTabStrip == 2) {
        // CORRECT THIS
        return TransactionData.GetLRSResponsibleTransactionInbox(me, TrackStatus.Closed, filter, sort);
      } else if (base.SelectedTabStrip == 3) {
        if (filter.Length != 0) {
          filter += " AND ";
        }
        filter += "NextTransactionStatus NOT IN ('R','C','Q','H')";
        if (!String.IsNullOrWhiteSpace(selectedComboFromValue)) {
          return TransactionData.GetLRSResponsibleTransactionInbox(Contact.Parse(int.Parse(selectedComboFromValue)), TrackStatus.OnDelivery, filter, sort);
        }
      } else if (base.SelectedTabStrip == 4) {
        if (filter.Length != 0) {
          filter += " AND ";
        }
        filter += "(TransactionStatus IN ('D','L'))";
        return TransactionData.GetLRSTransactionsForUI(filter, sort);
      } else if (base.SelectedTabStrip == 5) {
        // CORRECT THIS
        return TransactionData.GetLRSTransactionsForUI(filter, sort);
      } else if (base.SelectedTabStrip == 6) {
        return TransactionData.GetLRSTransactionsForUI(filter, sort);
      }
      return new DataView();
    }

    protected sealed override void LoadPageControls() {
      if (!IsPostBack) {
        LoadCombos();
      }
      if (txtFromDate.Value == String.Empty) {
        txtFromDate.Value = DateTime.Parse("01/Jun/2013").ToString("dd/MMM/yyyy");
      }
      if (txtToDate.Value == String.Empty) {
        txtToDate.Value = DateTime.Today.ToString("dd/MMM/yyyy");
      }
      cboFrom.Value = selectedComboFromValue;
      if (!IsPostBack) {
        cboStatus.SelectedIndex = 1;
      }
    }

    private void LoadCombos() {
      FixedList<Contact> list = TransactionData.GetContactsWithOutboxDocuments();
      HtmlSelectContent.LoadCombo(this.cboFrom, list, "Id", "Alias",
                                  "( ¿Quién le está entregando? )", String.Empty, String.Empty);
      DataView view = TransactionData.GetContactsWithActiveTransactions();

      HtmlSelectContent.LoadCombo(this.cboResponsible, view, "ResponsibleId", "Responsible",
                                  "( Todos los responsables )", String.Empty, String.Empty);
    }

    protected sealed override void SetRepeaterTemplates() {
      if (base.SelectedTabStrip == 0) {
        Func<DataRowView, string> Id = (x => Convert.ToString(x["ResponsibleId"]));
        itemsRepeater.HeaderTemplate = Page.LoadTemplate("~/templates/transactions/process.control.header.ascx");
        itemsRepeater.ItemTemplate = Page.LoadTemplate("~/templates/transactions/process.control.item.ascx");
        base.ViewColumnsCount = 4;
        base.LoadInboxesInQuickMode = true;
      } else if (base.SelectedTabStrip == 1) {
        itemsRepeater.HeaderTemplate = Page.LoadTemplate("~/templates/transactions/process.control.header.ascx");
        itemsRepeater.ItemTemplate = Page.LoadTemplate("~/templates/transactions/process.delivery.item.ascx");
        base.ViewColumnsCount = 4;
        base.LoadInboxesInQuickMode = true;
      } else if (base.SelectedTabStrip == 2) {
        itemsRepeater.HeaderTemplate = Page.LoadTemplate("~/templates/transactions/process.control.header.ascx");
        itemsRepeater.ItemTemplate = Page.LoadTemplate("~/templates/transactions/process.close.item.ascx");
        base.ViewColumnsCount = 4;
        base.LoadInboxesInQuickMode = true;
      } else if (base.SelectedTabStrip == 3) {
        itemsRepeater.HeaderTemplate = Page.LoadTemplate("~/templates/transactions/process.control.header.ascx");
        itemsRepeater.ItemTemplate = Page.LoadTemplate("~/templates/transactions/process.receive.item.ascx");
        base.ViewColumnsCount = 4;
        base.LoadInboxesInQuickMode = true;
      } else if (base.SelectedTabStrip == 4) {
        itemsRepeater.HeaderTemplate = Page.LoadTemplate("~/templates/transactions/process.control.header.ascx");
        itemsRepeater.ItemTemplate = Page.LoadTemplate("~/templates/transactions/process.control.item.ascx");
        base.ViewColumnsCount = 4;
        base.LoadInboxesInQuickMode = false;
      } else if (base.SelectedTabStrip == 5) {
        itemsRepeater.HeaderTemplate = Page.LoadTemplate("~/templates/transactions/process.search.header.ascx");
        itemsRepeater.ItemTemplate = Page.LoadTemplate("~/templates/transactions/process.search.item.ascx");
        base.ViewColumnsCount = 5;
        base.LoadInboxesInQuickMode = false;
      } else if (base.SelectedTabStrip == 6) {
        itemsRepeater.HeaderTemplate = Page.LoadTemplate("~/templates/transactions/process.search.header.ascx");
        itemsRepeater.ItemTemplate = Page.LoadTemplate("~/templates/transactions/process.search.item.ascx");
        base.ViewColumnsCount = 5;
        base.LoadInboxesInQuickMode = false;
      } else {
        itemsRepeater.HeaderTemplate = Page.LoadTemplate("~/templates/empty.header.ascx");
      }
    }

    private void ChangeTransactionStatus() {
      LRSTransaction transaction = LRSTransaction.Parse(int.Parse(GetCommandParameter("id")));
      TransactionStatus status = (TransactionStatus) Convert.ToChar(GetCommandParameter("state"));
      string note = GetCommandParameter("notes", false);

      string s = transaction.ValidateStatusChange(status);
      if (!String.IsNullOrWhiteSpace(s)) {
        base.SetOKScriptMsg(s);
        return;
      }
      transaction.SetNextStatus(status, Person.Empty, note);

      base.SetOKScriptMsg();
      txtSearchExpression.Value = "";
      txtSearchExpression.Focus();
    }

    private void ReceiveLRSTransaction() {
      int transactionId = int.Parse(GetCommandParameter("id"));
      string notes = GetCommandParameter("notes", false);

      LRSTransaction transaction = LRSTransaction.Parse(transactionId);

      string s = transaction.ValidateStatusChange(TransactionStatus.Received);
      if (!String.IsNullOrWhiteSpace(s)) {
        base.SetOKScriptMsg(s);
        return;
      }
      transaction.Receive(notes);

      base.SetOKScriptMsg();
      txtSearchExpression.Value = "";
      txtSearchExpression.Focus();
    }

    private void TakeLRSTransaction() {
      int transactionId = int.Parse(GetCommandParameter("id"));
      string notes = GetCommandParameter("notes", false);

      LRSTransaction transaction = LRSTransaction.Parse(transactionId);
      transaction.Take(notes);

      base.SetOKScriptMsg();
      txtSearchExpression.Value = "";
      txtSearchExpression.Focus();
    }

    private void ReturnDocumentToMe() {
      int transactionId = int.Parse(GetCommandParameter("id"));

      LRSTransaction transaction = LRSTransaction.Parse(transactionId);
      transaction.ReturnToMe();

      base.SetOKScriptMsg();
      txtSearchExpression.Value = "";
      txtSearchExpression.Focus();
    }

    private string GetFilter() {
      string filter = String.Empty;
      if (cboProcessType.Value.Length != 0) {
        filter = "(TransactionTypeId = " + cboProcessType.Value + ")";
      }
      if (cboStatus.Value.Length != 0 && base.SelectedTabStrip != 3 && base.SelectedTabStrip != 4) {
        if (filter.Length != 0) {
          filter += " AND ";
        }
        filter += cboStatus.Value;
      }
      if (cboRecorderOffice.Value.Length != 0) {
        if (filter.Length != 0) {
          filter += " AND ";
        }
        filter += "(RecorderOfficeId = " + cboRecorderOffice.Value + ")";
      }
      if (cboResponsible.Value.Length != 0 && base.SelectedTabStrip == 5) {
        if (filter.Length != 0) {
          filter += " AND ";
        }
        filter += "(ResponsibleId = " + cboResponsible.Value + ")";
      }
      if (txtSearchExpression.Value.Length != 0) {
        string parseAndLike = String.Empty;
        if (cboSearch.Value.Length != 0) {
          parseAndLike = SearchExpression.ParseAndLike(cboSearch.Value, txtSearchExpression.Value);
        } else {
          parseAndLike = SearchExpression.ParseAndLike("TransactionKeywords", txtSearchExpression.Value);
        }
        if (parseAndLike.Length != 0) {
          if (filter.Length != 0) {
            filter += " AND ";
          }
          filter += parseAndLike;
        }
      }
      if (cboElapsedTime.Value.Length != 0) {
        if (filter.Length != 0) {
          filter += " AND ";
        }
        filter += cboElapsedTime.Value;
      }
      if (cboDate.Value.Length != 0 && txtFromDate.Value.Length != 0) {
        if (filter.Length != 0) {
          filter += " AND ";
        }
        filter += "([" + cboDate.Value + "] >= '" + EmpiriaString.ToDate(txtFromDate.Value).ToString("yyyy-MM-dd") + "') AND " +
                  "([" + cboDate.Value + "] < '" + EmpiriaString.ToDate(txtToDate.Value).ToString("yyyy-MM-dd 23:59") + "')";
      }
      return filter;
    }

    #endregion Protected methods

  } // class ProcessControlDashboard

} // namespace Empiria.Web.UI.LRS
