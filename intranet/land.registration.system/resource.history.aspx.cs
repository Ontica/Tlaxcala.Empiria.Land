/* Empiria Land **********************************************************************************************
*																																																						 *
*  Solution  : Empiria Land                                     System   : Land Intranet Application         *
*  Namespace : Empiria.Land.WebApp                              Assembly : Empiria.Land.Intranet.dll         *
*  Type      : RecordingEditor                                  Pattern  : Explorer Web Page                 *
*  Version   : 2.1                                              License  : Please read license.txt file      *
*                                                                                                            *
*  Summary   : Gets user credentials and redirects users to the workplace start page.                        *
*                                                                                                            *
********************************** Copyright(c) 2009-2016. La Vía Óntica SC, Ontica LLC and contributors.  **/
using System;

using Empiria.Presentation.Web;

using Empiria.Land.Registration;
using Empiria.Land.UI;

namespace Empiria.Land.WebApp {

  public partial class ResourceHistory : WebPage {

    #region Fields

    protected Resource resource = null;

    protected string OnLoadScript = String.Empty;

    #endregion Fields

    #region Protected methods

    protected void Page_Init(object sender, EventArgs e) {
      LoadControls();
    }

    private void LoadControls() {

    }

    protected void Page_Load(object sender, EventArgs e) {
      Initialize();
      if (!IsPostBack) {
        LoadEditor();
      } else {
        ExecuteCommand();
      }
    }

    private void LoadEditor() {

    }

    #endregion Protected methods

    #region Private methods

    private void ExecuteCommand() {
      switch (base.CommandName) {
        default:
          throw new NotImplementedException(base.CommandName);
      }
    }

    private void Initialize() {
      resource = Resource.Parse(int.Parse(Request.QueryString["resourceId"]));
    }

    protected string GetHistoryGrid() {
      return ResourceHistoryGrid.Parse(this.resource);
    }

    #endregion Private methods

  } // class ResourceHistory

} // namespace Empiria.Land.WebApp
