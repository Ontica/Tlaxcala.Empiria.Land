/* Empiria Land **********************************************************************************************
*																																																						 *
*  Solution  : Empiria Land                                     System   : Land Intranet Application         *
*  Namespace : Empiria.Land.WebApp                              Assembly : Empiria.Land.Intranet.dll         *
*  Type      : DirectoryImageViewer                             Pattern  : Explorer Web Page                 *
*  Version   : 2.1                                              License  : Please read license.txt file      *
*                                                                                                            *
*  Summary   : Gets user credentials and redirects users to the workplace start page.                        *
*                                                                                                            *
********************************** Copyright(c) 2009-2016. La Vía Óntica SC, Ontica LLC and contributors.  **/
using System;

using Empiria.Presentation.Web;
using Empiria.Land.Documentation;

namespace Empiria.Land.WebApp {

  public partial class ImageSetViewer : WebPage {

    #region Fields

    protected DocumentImageSet documentImageSet = null;

    protected string pageTitle = "Title";
    protected int currentImagePosition = 0;
    protected int currentImageWidth = 0;

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
        // default:
        // throw new NotImplementedException(base.CommandName);
      }
    }

    #endregion Constructors and parsers

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
          currentImagePosition = Math.Min(currentImagePosition + 1, documentImageSet.FilesCount - 1);
          break;
        case "Last":
          currentImagePosition = documentImageSet.FilesCount - 1;
          break;
        default:
          currentImagePosition = int.Parse(position) - 1;
          break;
      }
    }

    private void SetImageZoom() {
      decimal zoomFactor = decimal.Parse(cboZoomLevel.Value);

      currentImageWidth = Convert.ToInt32(Math.Round(800m * zoomFactor, 0));
    }

    protected string GetCurrentImagePath() {
      return ".." + this.documentImageSet.UrlRelativePath +
                    this.documentImageSet.ImagesNamesArray[currentImagePosition];
    }

    private void Initialize() {
      int id = int.Parse(Request.QueryString["id"]);

      this.documentImageSet = DocumentImageSet.Parse(id);
      pageTitle = this.documentImageSet.Document.UID;
      if (documentImageSet.DocumentImageType == DocumentImageType.Appendix) {
        pageTitle += " (Anexo)";
      }

      if (!IsPostBack) {
        cboZoomLevel.Value = "1.00";
        currentImagePosition = 0;
      }
      SetImageZoom();
    }

    protected string GetCurrentImageWidth() {
      return currentImageWidth.ToString() + "em";
    }

    #endregion Private methods

  } // class ImageSetViewer

} // namespace Empiria.Land.WebApp
