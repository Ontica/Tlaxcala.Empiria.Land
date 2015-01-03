/* Empiria® Land 2015 ****************************************************************************************
*																																																						 *
*	 Solution  : Empiria® Land                                    System   : Land Extranet Application         *
*	 Namespace : Empiria.Web.UI.Ajax                              Assembly : Empiria.Land.Extranet.dll         *
*	 Type      : LandRegistrationSystemData                       Pattern  : Ajax Services Web Page            *
*	 Date      : 04/Jan/2015                                      Version  : 2.0  License: LICENSE.TXT file    *
*																																																						 *
*  Summary   : Gets Empiria control contents through Ajax invocation.                                        *
*																																																						 *
**************************************************** Copyright © La Vía Óntica SC + Ontica LLC. 2009-2015. **/
using System;
using System.Collections.Generic;

using Empiria.Land.Registration;
using Empiria.Presentation.Web;
using Empiria.Presentation.Web.Content;

namespace Empiria.Web.UI.Ajax {

  public partial class LandRegistrationSystemData : AjaxWebPage {

    protected override string ImplementsCommandRequest(string commandName) {
      switch (commandName) {

        //case "getDirectoryImageURLCmd":
        //  return GetDirectoryImageUrlCommandHandler();

        //case "getRecordingBooksStringArrayCmd":
        //  return GetRecordingBooksStringArrayCommandHandler();

        default:
          throw new WebPresentationException(WebPresentationException.Msg.UnrecognizedCommandName,
                                             commandName);
      }
    }

    #region Private command handlers

    //private string GetDirectoryImageUrlCommandHandler() {
    //  bool attachment = bool.Parse(GetCommandParameter("attachment", false, "false"));

    //  if (attachment) {
    //    return GetAttachmentImageDirectory();
    //  }

    //  string position = GetCommandParameter("position", true);
    //  int currentPosition = int.Parse(GetCommandParameter("currentPosition", true));

    //  int recordingId = int.Parse(GetCommandParameter("recordingId", false, "0"));
    //  RecordBookDirectory directory = null;

    //  if (recordingId == 0) {
    //    int directoryId = int.Parse(GetCommandParameter("directoryId", true));
    //    directory = RecordBookDirectory.Parse(directoryId);
    //  } else {
    //    Recording recording = Recording.Parse(recordingId);
    //    if (currentPosition == -1) {
    //      currentPosition = recording.StartImageIndex - 1;
    //    }
    //    directory = recording.RecordingBook.ImagingFilesFolder;
    //  }

    //  if (!EmpiriaString.IsInteger(position)) {
    //    switch (position) {
    //      case "first":
    //        return directory.GetImageURL(0);
    //      case "previous":
    //        return directory.GetImageURL(Math.Max(currentPosition - 1, 0));
    //      case "next":
    //        return directory.GetImageURL(Math.Min(currentPosition + 1, directory.FilesCount - 1));
    //      case "last":
    //        return directory.GetImageURL(directory.FilesCount - 1);
    //      case "refresh":
    //        return directory.GetImageURL(currentPosition);
    //      default:
    //        return directory.GetImageURL(currentPosition);
    //    }
    //  } else {
    //    return directory.GetImageURL(int.Parse(position));
    //  }
    //}

    //private string GetRecordingBooksStringArrayCommandHandler() {
    //  int recorderOfficeId = int.Parse(GetCommandParameter("recorderOfficeId", true));
    //  int recordingTypeCategoryId = int.Parse(GetCommandParameter("recordingActTypeCategoryId", false, "0"));
    //  bool digitalized = bool.Parse(GetCommandParameter("digitalized", false, "false"));

    //  if (recorderOfficeId == 0) {
    //    return HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "( Primero seleccionar un Distrito )");
    //  }
    //  if (recordingTypeCategoryId == 0) {
    //    return HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "( Primero seleccionar una Sección )");
    //  }

    //  RecorderOffice recorderOffice = RecorderOffice.Parse(recorderOfficeId);
    //  FixedList<RecordingBook> recordingBookList = null;

    //  RecordingSection recordingSection = RecordingSection.Parse(recordingTypeCategoryId);
    //  recordingBookList = recorderOffice.GetRecordingBooks(recordingSection);
    //  List<RecordingBook> theList = null;
    //  if (digitalized) {
    //    theList = recordingBookList.FindAll((x) => !x.ImagingFilesFolder.IsEmptyInstance);
    //  } else {
    //    theList = recordingBookList.FindAll((x) => !x.IsEmptyInstance);
    //  }
    //  if (theList.Count != 0) {
    //    return HtmlSelectContent.GetComboAjaxHtml(theList, 0, "Id", "FullName", "( Seleccionar el libro registral )");
    //  } else {
    //    return HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "( No hay libros digitalizados en esta Sección )");
    //  }
    //}

    #endregion Private command handlers

    #region Private methods

    //private string GetAttachmentImageDirectory() {
    //  string position = GetCommandParameter("position", true);
    //  string folderName = GetCommandParameter("name", false, String.Empty);

    //  int currentPosition = int.Parse(GetCommandParameter("currentPosition", true));

    //  int recordingId = int.Parse(GetCommandParameter("recordingId", false, "0"));

    //  Recording recording = Recording.Parse(recordingId);
    //  if (currentPosition == -1) {
    //    currentPosition = 0;
    //  }
    //  RecordingAttachmentFolder folder = recording.GetAttachementFolder(folderName);

    //  if (!EmpiriaString.IsInteger(position)) {
    //    switch (position) {
    //      case "first":
    //        return folder.GetImageURL(0);
    //      case "previous":
    //        return folder.GetImageURL(Math.Max(currentPosition - 1, 0));
    //      case "next":
    //        return folder.GetImageURL(Math.Min(currentPosition + 1, folder.FilesCount - 1));
    //      case "last":
    //        return folder.GetImageURL(folder.FilesCount - 1);
    //      case "refresh":
    //        return folder.GetImageURL(currentPosition);
    //      default:
    //        return folder.GetImageURL(currentPosition);
    //    }
    //  } else {
    //    return folder.GetImageURL(int.Parse(position));
    //  }
    //}

    #endregion Private methods

  } // class WorkplaceData

} // namespace Empiria.Web.UI.Ajax
