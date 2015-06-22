/* Empiria® Land 2015 ****************************************************************************************
*																																																						 *
*	 Solution  : Empiria® Land                                    System   : Land Intranet Application         *
*	 Namespace : Empiria.Web.UI                                   Assembly : Empiria.Land.Intranet.dll         *
*	 Type      : ObjectSearcher                                   Pattern  : Explorer Web Page                 *
*	 Date      : 25/Jun/2015                                      Version  : 2.0  License: LICENSE.TXT file    *
*																																																						 *
*  Summary   : Gets user credentials and redirects users to the workplace start page.                        *
*																																																						 *
**************************************************** Copyright © La Vía Óntica SC + Ontica LLC. 2009-2015. **/
using System;
using Empiria.Land.Registration;
using Empiria.Presentation.Web;

namespace Empiria.Web.UI.LRS {

  public partial class DirectoryImageViewer : WebPage {

    #region Fields

    protected RecordBookDirectory directory = null;

    protected string pageTitle = "Title";
    protected int currentImagePosition = 0;

    protected int currentImageWidth = 254;
    protected int currentImageHeight = 189;

    #endregion Fields

    #region Constructors and parsers

    protected void Page_Load(object sender, EventArgs e) {
      Initialize();
      if (IsPostBack) {
        DoCommand();
      } else {
        LoadControls();
      }
      hdnCurrentImagePosition.Value = currentImagePosition.ToString();
    }

    private void LoadControls() {

    }

    private void DoCommand() {
      switch (base.CommandName) {
        case "gotoImage":
          MoveToImage(txtGoToImage.Value);
          return;
        default:
          throw new NotImplementedException(base.CommandName);
      }
    }

    #endregion Constructors and parsers

    #region Public properties

    #endregion Public properties

    #region Private methods

    private void MoveToImage(string position) {
      switch (position) {
        case "First":
          currentImagePosition = 0;
          break;
        case "Previous":
          currentImagePosition = Math.Max(currentImagePosition - 1, 0);
          break;
        case "Next":
          currentImagePosition = Math.Min(currentImagePosition + 1, directory.FilesCount - 1);
          break;
        case "Last":
          currentImagePosition = directory.FilesCount - 1;
          break;
        default:
          currentImagePosition = int.Parse(position) - 1;
          break;
      }
    }

    private void SetImageZoom() {
      decimal zoomFactor = decimal.Parse(cboZoomLevel.Value);

      currentImageWidth = Convert.ToInt32(Math.Round(1336m * zoomFactor, 0));
      currentImageHeight = Convert.ToInt32(Math.Round(994m * zoomFactor, 0));
    }

    protected string GetCurrentImagePath() {
      return directory.GetImageURL(currentImagePosition);
    }

    private void Initialize() {
      directory = RecordBookDirectory.Empty;
      if (!String.IsNullOrEmpty(Request.QueryString["id"])) {
        throw new NotImplementedException();

        //RecordingBook book = RecordingBook.Parse(int.Parse(Request.QueryString["id"]));
        //directory = book.ImagingFilesFolder;
        //pageTitle = book.FullName;

      } else if (!String.IsNullOrEmpty(Request.QueryString["directoryId"])) {
        directory = RecordBookDirectory.Parse(int.Parse(Request.QueryString["directoryId"]));
        pageTitle = "Directorio " + directory.DisplayName;
      }

      if (!String.IsNullOrEmpty(Request.QueryString["image"])) {
        currentImagePosition = int.Parse(Request.QueryString["image"]);
      }
      if (IsPostBack && !String.IsNullOrEmpty(hdnCurrentImagePosition.Value)) {
        currentImagePosition = int.Parse(hdnCurrentImagePosition.Value);
      }
      if (!IsPostBack && !String.IsNullOrEmpty(Request.QueryString["gotoImage"])) {
        currentImagePosition = int.Parse(Request.QueryString["gotoImage"]) - 1;
      }
      if (!IsPostBack && !String.IsNullOrEmpty(Request.QueryString["goLast"]) && bool.Parse(Request.QueryString["goLast"])) {
        currentImagePosition = directory.FilesCount - 1;
      } else if (!IsPostBack && !String.IsNullOrEmpty(Request.QueryString["goLast"]) && !bool.Parse(Request.QueryString["goLast"])) {
        currentImagePosition = 0;
      }

      if (!IsPostBack) {
        cboZoomLevel.Value = "1.00";
      }
      SetImageZoom();
    }

    protected string GetCurrentImageHeight() {
      return currentImageHeight.ToString() + "em";
    }

    protected string GetCurrentImageWidth() {
      return currentImageWidth.ToString() + "em";
    }

    #endregion Private methods

  } // class DirectoryImageViewer

} // namespace Empiria.Web.UI.LRS
