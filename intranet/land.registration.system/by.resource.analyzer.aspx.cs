/* Empiria Land **********************************************************************************************
*																																																						 *
*  Solution  : Empiria Land                                     System   : Land Intranet Application         *
*  Namespace : Empiria.Land.WebApp                              Assembly : Empiria.Land.Intranet.dll         *
*  Type      : ByResourceAnalyzer                               Pattern  : Explorer Web Page                 *
*  Version   : 2.1                                              License  : Please read license.txt file      *
*																																																						 *
*  Summary   :                                                                                               *
*                                                                                                            *
********************************** Copyright(c) 2009-2016. La Vía Óntica SC, Ontica LLC and contributors.  **/
using System;

using Empiria.Land.Registration;
using Empiria.Presentation.Web;

namespace Empiria.Land.WebApp {

  public partial class ByResourceAnalyzer : WebPage {

    #region Fields

    protected Resource resource = null;
    protected RecordingAct recordingAct = null;

    protected int currentImagePosition = 0;
    protected int currentImageWidth = 1336;
    protected int currentImageHeight = 994;

    #endregion Fields

    #region Constructors and parsers

    protected void Page_Init(object sender, EventArgs e) {
      LoadDocumentEditorControl();
    }

    private void LoadDocumentEditorControl() {

    }

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
        case "refresh":
          RefreshPage();
          return;
        default:
          throw new NotImplementedException(base.CommandName);
      }
    }

    #endregion Constructors and parsers

    #region Private methods

    protected bool DisplayImages() {
      return true;
      //return !recordingBook.ImagingFilesFolder.IsEmptyInstance;
    }

    protected string GetCurrentImagePath() {
      return "../3214/234/234/2345/empty.aspx";

      //return recordingBook.ImagingFilesFolder.GetImageURL(currentImagePosition);
    }

    private void MoveToImage(string position) {
      switch (position) {
        case "First":
          currentImagePosition = 0;
          break;
        case "Previous":
          currentImagePosition = Math.Max(currentImagePosition - 1, 0);
          break;
        case "Next":
          throw new NotImplementedException();

          //currentImagePosition = Math.Min(currentImagePosition + 1, recordingBook.ImagingFilesFolder.FilesCount - 1);
          //break;
        case "Last":
          throw new NotImplementedException();
          //currentImagePosition = recordingBook.ImagingFilesFolder.FilesCount - 1;
          //break;
        default:
          currentImagePosition = int.Parse(position) - 1;
          break;
      }
    }

    private void RefreshPage() {
      Response.Redirect("by.resource.analyzer.aspx?resourceId=" + resource.Id.ToString() +
                        "&recordingActId=" + recordingAct.Id.ToString() + "&image=" + hdnCurrentImagePosition.Value, true);
    }

    private void SetImageZoom() {
      decimal zoomFactor = decimal.Parse(cboZoomLevel.Value);

      currentImageWidth = Convert.ToInt32(Math.Round(1336m * zoomFactor, 0));
      currentImageHeight = Convert.ToInt32(Math.Round(994m * zoomFactor, 0));
    }

    private void Initialize() {
      resource = Resource.Parse(int.Parse(Request.QueryString["resourceId"]));
      recordingAct = RecordingAct.Parse(int.Parse(Request.QueryString["recordingActId"]));
    }

    protected string GetCurrentImageHeight() {
      return currentImageHeight.ToString() + "em";
    }

    protected string GetCurrentImageWidth() {
      return currentImageWidth.ToString() + "em";
    }

    #endregion Private methods

  } // class ByResourceAnalyzer

} // namespace Empiria.Land.WebApp
