/* Empiria® Land 2014 ****************************************************************************************
*																																																						 *
*	 Solution  : Empiria® Land                                    System   : Land Intranet Application         *
*	 Namespace : Empiria.Web.UI.Workflow                          Assembly : Empiria.Land.Intranet.dll         *
*	 Type      : TasksDashboard                                   Pattern  : Explorer Web Page                 *
*	 Date      : 28/Mar/2014                                      Version  : 1.5  License: CC BY-NC-SA 4.0     *
*																																																						 *
*  Summary   : Multiview dashboard used for workflow task management.                                        *
*																																																						 *
**************************************************** Copyright © La Vía Óntica SC + Ontica LLC. 1994-2014. **/
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

using Empiria.Presentation.Web;

namespace Empiria.Web.UI.Workflow {

  public partial class MessagesDashboard : MultiViewDashboard {

    #region Fields

    private string selectedUnitValue = String.Empty;

    #endregion Fields

    #region Protected methods

    protected void Page_Init(object sender, EventArgs e) {
      //selectedUnitValue = String.IsNullOrEmpty(Request.Form[cboTransportUnit.UniqueID]) ? String.Empty : Request.Form[cboTransportUnit.UniqueID];
    }

    public sealed override Repeater ItemsRepeater {
      get { return this.itemsRepeater; }
    }

    protected sealed override bool ExecutePageCommand() {
      switch (base.CommandName) {
        case "updateUserInterface":
          base.LoadEmptyRepeater();
          return true;
        default:
          return false;
      }
    }

    protected sealed override void Initialize() {
      if (!IsPostBack) {

      }
    }

    protected sealed override DataView LoadDataSource() {
      return new DataView();
    }

    protected sealed override void LoadPageControls() {
      if (txtFromDate.Value == String.Empty) {
        txtFromDate.Value = DateTime.Today.AddDays(-30).ToString("dd/MMM/yyyy");
      }
      if (txtToDate.Value == String.Empty) {
        txtToDate.Value = DateTime.Today.ToString("dd/MMM/yyyy");
      }
    }

    protected sealed override void SetRepeaterTemplates() {
      if (base.SelectedTabStrip == -1) {
        itemsRepeater.HeaderTemplate = Page.LoadTemplate("~/templates/scm/production.header.ascx");
        itemsRepeater.ItemTemplate = Page.LoadTemplate("~/templates/scm/production.items.ascx");
      } else {
        itemsRepeater.HeaderTemplate = Page.LoadTemplate("~/templates/empty.header.ascx");
      }
    }

    #endregion Protected methods

    #region Private methods

    #endregion Private methods

  } // class Inboxes

} // namespace Empiria.Web.UI.Workflow