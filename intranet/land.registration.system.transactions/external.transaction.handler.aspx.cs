/* Empiria Land **********************************************************************************************
*                                                                                                            *
*  Module   : Land Intranet                                Component : Transaction UI                        *
*  Assembly : Empiria.Land.WebApp.dll                      Pattern   : Web Editor                            *
*  Type     : ExternalTransactionHandler                   License   : Please read LICENSE.txt file          *
*                                                                                                            *
*  Summary  : Handles transactions coming from online systems or other external sources.                     *
*                                                                                                            *
************************* Copyright(c) La Vía Óntica SC, Ontica LLC and contributors. All rights reserved. **/
using System;

using Empiria.Presentation.Web;

using Empiria.Land.Registration.Forms;
using Empiria.Land.Registration.Transactions;

using Empiria.Land.UI;


namespace Empiria.Land.WebApp {

  /// <summary>//Handles transactions coming from online systems or other external sources.</summary>
  public partial class ExternalTransactionHandler : WebPage {

    #region Fields

    private LRSTransaction transaction;

    protected string htmlForm = String.Empty;

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
          Response.Redirect("external.transaction.handler.aspx?transactionId=" + transaction.Id.ToString(), true);
          return;
        default:
          throw new NotImplementedException(base.CommandName);
      }
    }

    private void Initialize() {
      int transactionId = int.Parse(Request.QueryString["transactionId"]);
      if (transactionId != 0) {
        transaction = LRSTransaction.Parse(transactionId);

        PreventiveNoteForm preventiveNoteForm =
                                  (PreventiveNoteForm) transaction.GetForm(LandSystemFormType.PreventiveNoteRegistrationForm);

        var htmlFormTransformer = new LandHtmlFormTransformer(preventiveNoteForm);

        this.htmlForm = htmlFormTransformer.GetHtml();

      } else {
        transaction = LRSTransaction.Empty;
       // preventiveNoteForm = PreventiveNoteForm.Empty;
      }

    }

    private void LoadEditor() {

    }

    #endregion Private methods

  } // class ExternalTransactionHandler

} // namespace Empiria.Land.WebApp
