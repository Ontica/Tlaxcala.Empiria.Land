/* Empiria Land **********************************************************************************************
*																																																						 *
*	 Solution  : Empiria Land                                     System   : Land Intranet Application         *
*	 Namespace : Empiria.Web.UI.Workplace                         Assembly : Empiria.Land.Intranet.dll         *
*	 Type      : DashboardMasterPage										          Pattern  : Master Web Page                   *
*  Version   : 2.0                                              License  : Please read license.txt file      *
*																																																						 *
*  Summary   : Master page for dashboard items.                                                              *
*																																																						 *
********************************** Copyright(c) 1994-2015. La Vía Óntica SC, Ontica LLC and contributors.  **/

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
