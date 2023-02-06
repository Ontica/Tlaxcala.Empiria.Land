﻿/* Empiria Land ***********************************************************************************************
*                                                                                                             *
*  Solution  : Empiria Land                                    System   : Land Registration System            *
*  Namespace : Empiria.Land.UI                                 Assembly : Empiria.Land.UI                     *
*  Type      : LRSDocumentEditorControl                        Pattern  : User Control                        *
*  Version   : 3.0                                             License  : Please read license.txt file        *
*                                                                                                             *
*  Summary   : Base class for the document editor control.                                                    *
*                                                                                                             *
************************** Copyright(c) La Vía Óntica SC, Ontica LLC and contributors. All rights reserved. **/
using System;

using Empiria.Presentation.Web;
using Empiria.Land.Registration;

namespace Empiria.Land.UI {

  /// <summary>Base class for the document editor control.</summary>
  public abstract class LRSDocumentEditorControl : WebUserControl {

    #region Public properties

    static private string _virtualPath =
                          ConfigurationData.GetString("UIControls.RecordingDocumentEditorControl");

    static public string ControlVirtualPath {
      get {
        return _virtualPath;
      }
    }

    public RecordingDocument Document {
      get;
      private set;
    }

    #endregion Public properties

    #region Public methods

    public RecordingDocument FillRecordingDocument(RecordingDocumentType documentType) {
      if (this.Document.IsEmptyInstance) {
        this.Document = new RecordingDocument(documentType);
      }
      return ImplementsFillRecordingDocument(documentType);
    }

    protected abstract RecordingDocument ImplementsFillRecordingDocument(RecordingDocumentType documentType);

    protected abstract void ImplementsLoadRecordingDocument();

    public void LoadRecordingDocument(RecordingDocument document) {
      this.Document = document;
      if (!IsPostBack) {
        ImplementsLoadRecordingDocument();
      }
    }

    #endregion Public methods

  } // class LRSDocumentEditorControl

} // namespace Empiria.Land.UI
