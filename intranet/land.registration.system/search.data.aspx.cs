/* Empiria Land **********************************************************************************************
*                                                                                                            *
*  Solution  : Empiria Land                                     System   : Land Intranet Application         *
*  Namespace : Empiria.Land.WebApp                              Assembly : Empiria.Land.Intranet.dll         *
*  Type      : LRSSearchData                                    Pattern  : Editor Page                       *
*  Version   : 3.0                                              License  : Please read license.txt file      *
*                                                                                                            *
*  Summary   :                                                                                               *
*                                                                                                            *
************************* Copyright(c) La Vía Óntica SC, Ontica LLC and contributors. All rights reserved. **/
using System;

using Empiria.Presentation.Web;
using Empiria.Presentation.Web.Content;
using Empiria.Land.Registration.Transactions;

namespace Empiria.Land.WebApp {

  public partial class LRSSearchData : WebPage {

    #region Fields

    private string onloadScript = String.Empty;

    #endregion Fields

    protected void Page_Load(object sender, EventArgs e) {
      Initialize();
      if (!IsPostBack) {
        LoadEditor();
      } else {
        ExecuteCommand();
      }
    }

    private void Initialize() {

    }

    private void ExecuteCommand() {
      switch (base.CommandName) {
        case "redirectThis":
          //RedirectEditor();
          return;
        case "printTransactionReceipt":
          //PrintTransactionReceipt();
          //LoadEditor();
          return;
        case "printOrderPayment":
          //PrintOrderPayment();
          LoadEditor();
          return;
        default:
          throw new NotImplementedException(base.CommandName);
      }
    }

    protected string OnloadScript() {
      return onloadScript;
    }

    private void LoadEditor() {
      HtmlSelectContent.LoadCombo(this.cboManagementAgency, LRSTransaction.GetAgenciesList(),
                                  "Id", "Alias", "( Seleccionar notaría/agencia que tramita )");
    }

    protected string GetTitle() {
      return "Consulta de información registral";
    }

  } // class LRSSearchData

} // namespace Empiria.Land.WebApp
