/* Empiria Land **********************************************************************************************
*                                                                                                            *
*  Module   : Land Intranet                                Component : Transaction UI                        *
*  Assembly : Empiria.Land.WebApp.dll                      Pattern   : Web Editor                            *
*  Type     : TransactionReturnEditor                      License   : Please read LICENSE.txt file          *
*                                                                                                            *
*  Summary  : Transaction return editor.                                                                     *
*                                                                                                            *
************************* Copyright(c) La Vía Óntica SC, Ontica LLC and contributors. All rights reserved. **/
using System;

using Empiria.Presentation.Web;

using Empiria.Land.Registration.Transactions;

namespace Empiria.Land.WebApp {

  public partial class TransactionReturnEditor : WebPage {

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

    #endregion Constructors and parsers

    #region Private methods

    private void ExecuteCommand() {
      switch (base.CommandName) {
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

    #endregion Private methods

  } // class TransactionReturnEditor

} // namespace Empiria.Land.WebApp
