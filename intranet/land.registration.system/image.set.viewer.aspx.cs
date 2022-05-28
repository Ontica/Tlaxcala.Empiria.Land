﻿/* Empiria Land **********************************************************************************************
*                                                                                                            *
*  Solution  : Empiria Land                                     System   : Land Intranet Application         *
*  Namespace : Empiria.Land.WebApp                              Assembly : Empiria.Land.Intranet.dll         *
*  Type      : DirectoryImageViewer                             Pattern  : Explorer Web Page                 *
*  Version   : 3.0                                              License  : Please read license.txt file      *
*                                                                                                            *
*  Summary   :                                                                                               *
*                                                                                                            *
************************* Copyright(c) La Vía Óntica SC, Ontica LLC and contributors. All rights reserved. **/
using System;

using Empiria.Documents;
using Empiria.Presentation.Web;

using Empiria.Land.Documentation;
using Empiria.Land.Registration;

namespace Empiria.Land.WebApp {

  public partial class ImageSetViewer : WebPage {

    #region Fields

    protected ImageSet imageSet = null;

    protected string pageTitle = "Title";
    protected int currentImagePosition = 0;
    protected decimal defaultImageWidth = 800m;
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

    protected string GetCurrentImagePath() {
      if (this.imageSet.IsEmptyInstance) {
        return String.Empty;
      }

      Assertion.Require(0 <= currentImagePosition &&
                   currentImagePosition < imageSet.ImagesNamesArray.Length,
                  $"CurrentImagePosition ({currentImagePosition}) out of bounds: MAX = {imageSet.ImagesNamesArray.Length}. " +
                  $"Please check folder {this.imageSet.UrlRelativePath}.");

      return ".." + this.imageSet.UrlRelativePath + this.imageSet.ImagesNamesArray[currentImagePosition];
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
          currentImagePosition = Math.Min(currentImagePosition + 1, imageSet.FilesCount - 1);
          break;
        case "Last":
          currentImagePosition = imageSet.FilesCount - 1;
          break;
        default:
          currentImagePosition = int.Parse(position) - 1;
          break;
      }
    }

    private void Initialize() {
      if (!String.IsNullOrWhiteSpace(Request.QueryString["recordingBookId"])) {
        var recordingBook = RecordingBook.Parse(int.Parse(Request.QueryString["recordingBookId"]));
        this.imageSet = ImageSet.Parse(recordingBook.ImageSetId);

      } else if (!String.IsNullOrWhiteSpace(Request.QueryString["recordingDocumentId"])) {
        var document = RecordingDocument.Parse(int.Parse(Request.QueryString["recordingDocumentId"]));
        this.imageSet = ImageSet.Parse(document.Imaging.ImageSetId);

      } else {
        this.imageSet = ImageSet.Parse(int.Parse(Request.QueryString["id"]));

      }

      SetPageTitle();

      if (!IsPostBack) {
        cboZoomLevel.Value = "1.00";
        currentImagePosition = 0;
      }

      SetImageZoom();
    }

    private void SetImageZoom() {
      decimal zoomFactor = decimal.Parse(cboZoomLevel.Value);

      if (imageSet is DocumentImageSet) {
        this.defaultImageWidth = 800m;
      } else if (imageSet is RecordingBookImageSet) {
        this.defaultImageWidth = 1380m;
      }
      currentImageWidth = Convert.ToInt32(Math.Round(defaultImageWidth * zoomFactor, 0));
    }

    private void SetPageTitle() {
      if (imageSet is DocumentImageSet) {
        var documentImageSet = (DocumentImageSet) imageSet;
        pageTitle = documentImageSet.Document.UID;
        if (documentImageSet.DocumentImageType == DocumentImageType.Appendix) {
          pageTitle += " (Anexos)";
        }
      } else if (imageSet is RecordingBookImageSet) {
        var recordingImageSet = (RecordingBookImageSet) imageSet;

        pageTitle = recordingImageSet.RecordingBook.AsText;
      }
    }

    protected string GetCurrentImageWidth() {
      return currentImageWidth.ToString() + "em";
    }

    #endregion Private methods

  } // class ImageSetViewer

} // namespace Empiria.Land.WebApp
