/* Empiria® Land 2015 ****************************************************************************************
*																																																						 *
*	 Solution  : Empiria® Land                                    System   : Land Intranet Application         *
*	 Namespace : Empiria.Web.UI.Workplace                         Assembly : Empiria.Land.Intranet.dll         *
*	 Type      : DashboardMasterPage										          Pattern  : Master Web Page                   *
*	 Date      : 25/Jun/2015                                      Version  : 2.0  License: LICENSE.TXT file    *
*																																																						 *
*  Summary   : Master page for dashboard items.                                                              *
*																																																						 *
**************************************************** Copyright © La Vía Óntica SC + Ontica LLC. 1994-2015. **/

using Empiria.Presentation.Web;
using Empiria.Presentation.Web.Content;

namespace Empiria.Web.UI.Workplace {

  public partial class DashboardMasterPage : MasterWebPage {

    #region Fields

    private MasterPageContent masterPageContent = null;

    #endregion Fields

    #region Protected properties

    protected MasterPageContent MasterPageContent {
      get {
        if (masterPageContent == null) {
          masterPageContent = new MasterPageContent(base.Page);
        }
        return masterPageContent;
      }
    }

    #endregion Protected properties

    #region Protected methods

    protected override void Initialize() {

    }

    protected override void LoadMasterPageControls() {

    }

    #endregion Protected methods

  } // class DashboardMasterPage

} // namespace Empiria.Web.UI.Workplace
