/* Empiria Land **********************************************************************************************
*                                                                                                            *
*  Module   : Land Intranet                                Component : Transaction UI                        *
*  Assembly : Empiria.Land.WebApp.dll                      Pattern   : Web Editor                            *
*  Type     : DigitalizationEditor                         License   : Please read LICENSE.txt file          *
*                                                                                                            *
*  Summary  : Transaction documents digitalization editor.                                                   *
*                                                                                                            *
************************* Copyright(c) La Vía Óntica SC, Ontica LLC and contributors. All rights reserved. **/
using System;
using System.Web;

using Empiria.Security;
using Empiria.Presentation.Web;

using Empiria.Land.Documentation;
using Empiria.Land.Registration.Transactions;

namespace Empiria.Land.WebApp {

  /// <summary>Transaction documents digitalization editor.</summary>
  public partial class DigitalizationEditor : WebPage {

    #region Fields

    protected LRSTransaction transaction = null;
    protected TransactionDocumentSet documentSet = null;

    protected string OnLoadScript = String.Empty;

    #endregion Fields

    #region Constructors and parsers

    protected void Page_Load(object sender, EventArgs e) {
      Initialize();
      if (!IsPostBack) {
        LoadEditor();
      } else {
        ExecuteCommand();
      }
    }

    #endregion Constructors and parsers

    #region Public methods


    protected bool CanEditDocuments() {
      return EmpiriaPrincipal.Current.IsInRole("LRSTransaction.Digitalizer");
    }


    protected string GetDocuments() {
      string template = "<tr class={{CLASS}}>" +
                          "<td style='white-space:nowrap'><a href=\"javascript:doOperation('viewFile', '../{{FILE-URL}}')\">" +
                                "<img src='../themes/default/buttons/pdf.png'>{{DOCUMENT-TYPE}}</a></td>" +
                          "<td style='white-space:nowrap'>{{DIGITALIZED-BY}}</td>" +
                          "<td style='white-space:nowrap'>{{DATE}}</td>" +
                          "<td style='width:40%'>{{OPTIONS}}</td>" +
                        "</tr>";
      string result = String.Empty;

      string temp = String.Empty;

      if (documentSet.HasMainDocument) {
        temp = template.Replace("{{CLASS}}", "detailsItem");
        temp = temp.Replace("{{DOCUMENT-TYPE}}", "Documento principal");
        temp = temp.Replace("{{FILE-URL}}", documentSet.MainDocument.UrlRelativePath);
        temp = temp.Replace("{{DIGITALIZED-BY}}", documentSet.MainDocument.DigitalizedBy.Alias);
        temp = temp.Replace("{{DATE}}", documentSet.MainDocument.DigitalizationDate.ToString("dd/MMM/yyyy HH:mm"));
        temp = temp.Replace("{{OPTIONS}}", GetDeleteLink(documentSet.MainDocument));
        result = temp;
      }

      if (documentSet.HasAuxiliaryDocument) {
        temp = template.Replace("{{CLASS}}", "detailsOddItem");
        temp = temp.Replace("{{DOCUMENT-TYPE}}", "Anexos");
        temp = temp.Replace("{{FILE-URL}}", documentSet.AuxiliaryDocument.UrlRelativePath);
        temp = temp.Replace("{{DIGITALIZED-BY}}", documentSet.AuxiliaryDocument.DigitalizedBy.Alias);
        temp = temp.Replace("{{DATE}}", documentSet.AuxiliaryDocument.DigitalizationDate.ToString("dd/MMM/yyyy HH:mm"));
        temp = temp.Replace("{{OPTIONS}}", GetDeleteLink(documentSet.AuxiliaryDocument));
        result += temp;
      }

      if (result.Length == 0) {
        result = "<tr><td colspan='4'>Aún no se han digitalizado los documentos de este trámite.</td></tr>";
      }

      return result;
    }


    #endregion Public methods

    #region Private methods


    private string GetDeleteLink(TransactionDocument document) {
      if (!CanEditDocuments()) {
        return "&nbsp;";
      }

      const string template =
        "<a href='javascript:doOperation(\"deleteFile\", {{ID}});' title='Elimina este documento digitalizado'>" +
                "<img src='../themes/default/buttons/trash.gif'></a>";

      return template.Replace("{{ID}}", document.Id.ToString());
    }


    private void DeleteFile() {
      int id = int.Parse(GetCommandParameter("documentId"));

      if (documentSet.MainDocument.Id == id) {
        documentSet.MainDocument.Delete();
      } else if (documentSet.AuxiliaryDocument.Id == id) {
        documentSet.AuxiliaryDocument.Delete();
      }
    }


    private void Refresh() {
      Response.Redirect("digitalization.editor.aspx?transactionId=" + transaction.Id.ToString(), true);
    }


    private void UploadFiles() {
      Assertion.AssertObject(this.transaction, "Transaction is null.");
      Assertion.Assert(!this.transaction.IsEmptyInstance, "Transaction can't be the empty instance.");

      UploadMainFile();
      UploadAuxiliaryFile();
    }


    private void UploadMainFile() {
      HttpPostedFile uploadedFile = Request.Files["mainDocument"];

      if (!ValidFile(uploadedFile, "Documento principal")) {
        return;
      }

      DocumentUploader.SetMainDocument(this.transaction, uploadedFile);

      uploadedFile.InputStream.Dispose();
    }


    private void UploadAuxiliaryFile() {
      HttpPostedFile uploadedFile = Request.Files["auxiliaryDocument"];

      if (!ValidFile(uploadedFile, "Archivo de anexos")) {
        return;
      }

      DocumentUploader.SetAuxiliaryDocument(this.transaction, uploadedFile);

      uploadedFile.InputStream.Dispose();
    }


    private bool ValidFile(HttpPostedFile uploadedFile, string documentType) {
      if (uploadedFile == null) {
        return false;
      }

      if (String.IsNullOrWhiteSpace(uploadedFile.FileName)) {
        return false;
      }

      if (uploadedFile.ContentLength == 0) {
        SetMessageBox($"El {documentType} está vacío.");
        return false;
      }

      if (uploadedFile.ContentType != "application/pdf") {
        SetMessageBox($"El {documentType} no está en formato PDF.");
        return false;
      }

      return true;
    }


    private void ExecuteCommand() {
      switch (base.CommandName) {
        case "updloadFiles":
          UploadFiles();
          Refresh();
          return;

        case "deleteFile":
          DeleteFile();
          Refresh();
          return;

        case "refresh":
          Refresh();
          return;

        default:
          throw new NotImplementedException(base.CommandName);
      }
    }


    private void Initialize() {
      int transactionId = int.Parse(Request.QueryString["transactionId"]);

      if (transactionId != 0) {
        transaction = LRSTransaction.Parse(transactionId);
      } else {
        transaction = LRSTransaction.Empty;
      }
      documentSet = TransactionDocumentSet.ParseFor(this.transaction);
    }


    private void LoadEditor() {

    }

    private void SetMessageBox(string msg) {
      OnLoadScript += "alert('" + msg + "');";
    }


    private void SetRefreshPageScript() {
      OnLoadScript += "sendPageCommand('redirectMe');";
    }

    #endregion Private methods

  } // class DigitalizationEditor

} // namespace Empiria.Land.WebApp
