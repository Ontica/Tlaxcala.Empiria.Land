/* Empiria Land **********************************************************************************************
*																																																						 *
*  Solution  : Empiria Land                                     System   : Land Intranet Application         *
*  Namespace : Empiria.Land.WebApp                              Assembly : Empiria.Land.Intranet.dll         *
*  Type      : RecordingDocumentFullEditorControl               Pattern  : User Control                      *
*  Version   : 2.1                                              License  : Please read license.txt file      *
*                                                                                                            *
*  Summary   : User control that handles recorder document edition.                                          *
*																																																						 *
********************************** Copyright(c) 2009-2016. La Vía Óntica SC, Ontica LLC and contributors.  **/
using System;
using System.Web.UI.WebControls;
using Empiria.Contacts;
using Empiria.Geography;
using Empiria.Land.Registration;
using Empiria.Land.Registration.Transactions;
using Empiria.Land.UI;
using Empiria.Ontology;
using Empiria.Presentation.Web.Content;

namespace Empiria.Land.WebApp {

  public partial class RecordingDocumentFullEditorControl : LRSDocumentEditorControl {

    protected override RecordingDocument ImplementsFillRecordingDocument(RecordingDocumentType documentType) {
      switch (documentType.Name) {
        case "ObjectType.RecordingDocument.NotaryPublicDeed":
          FillNotaryPublicDeed(documentType);
          break;
        case "ObjectType.RecordingDocument.NotaryOfficialLetter":
          FillNotaryOfficialLetter(documentType);
          break;
        case "ObjectType.RecordingDocument.JudgeOfficialLetter":
          FillJudgeOfficialLetter(documentType);
          break;
        case "ObjectType.RecordingDocument.PrivateContract":
          FillPrivateDocument(documentType);
          break;
        case "ObjectType.RecordingDocument.EjidalSystemTitle":
          FillEjidalSystemTitle(documentType);
          break;
        case "ObjectType.RecordingDocument.Empty":
          FillEmptyRecordingDocument(documentType);
          break;
      }
      return this.Document;
    }

    protected override void ImplementsLoadRecordingDocument() {
      Assertion.Assert(base.Document != null, "Document can't be null");
      RecordingDocumentType documentType = base.Document.DocumentType;
      oNotaryOfficialLetter.Style["display"] = "none";
      oNotaryPublicDeed.Style["display"] = "none";
      oEjidalSystemTitle.Style["display"] = "none";
      oJudgeOfficialLetter.Style["display"] = "none";
      oPrivateContract.Style["display"] = "none";
      LoadMainCombos();
      switch (documentType.Name) {
        case "ObjectType.RecordingDocument.NotaryPublicDeed":
          oNotaryPublicDeed.Style["display"] = "inline";
          LoadNotaryPublicDeed();
          return;
        case "ObjectType.RecordingDocument.NotaryOfficialLetter":
          oNotaryOfficialLetter.Style["display"] = "inline";
          LoadNotaryOfficialLetter();
          return;
        case "ObjectType.RecordingDocument.JudgeOfficialLetter":
          oJudgeOfficialLetter.Style["display"] = "inline";
          LoadJudgeOfficialLetter();
          return;
        case "ObjectType.RecordingDocument.PrivateContract":
          oPrivateContract.Style["display"] = "inline";
          LoadPrivateDocument();
          return;
        case "ObjectType.RecordingDocument.EjidalSystemTitle":
          oEjidalSystemTitle.Style["display"] = "inline";
          LoadEjidalSystemTitle();
          return;
        case "ObjectType.RecordingDocument.Empty":
          return;
      }
    }

    private void LoadMainCombos() {
      RecordingBook book = RecordingBook.Empty;
      RecorderOffice office = RecorderOffice.Empty;

      HtmlSelectContent.LoadCombo(this.cboNotaryOfficialLetterIssuePlace, office.GetNotaryOfficePlaces(),
                            "Id", "Name", "( Seleccionar )");

      HtmlSelectContent.LoadCombo(this.cboNotaryDocIssuePlace, office.GetNotaryOfficePlaces(),
                                  "Id", "Name", "( Seleccionar )");


      HtmlSelectContent.LoadCombo(this.cboPrivateDocIssuePlace, office.GetPrivateDocumentIssuePlaces(),
                                  "Id", "Name", "( Seleccionar )");

      HtmlSelectContent.LoadCombo(this.cboJudicialDocIssuePlace, office.GetJudicialDocumentIssuePlaces(),
                                  "Id", "Name", "( Seleccionar )");

      FixedList<Person> signers = office.GetPropertyTitleSigners();
      HtmlSelectContent.LoadCombo(this.cboPropTitleDocIssuedBy, signers, "Id", "FullName",
                                  "( Seleccionar al C. Funcionario Público )");

      HtmlSelectContent.LoadCombo(this.cboPropTitleIssueOffice, office.GetPropertyTitleOffices(),
                                  "Id", "Alias", "( Seleccionar )");

      //HtmlSelectContent.LoadCombo(this.cboPrivateDocIssuedBy, JudicialOffice.Parse(document.IssuedBy.Id).GetJudges(),
      //                            "Id", "FullName", "( Seleccionar entidad )");
    }

    private void LoadNotaryOfficialLetter() {
      RecordingDocument document = base.Document;

      cboNotaryOfficialLetterSubtype.Value = document.Subtype.Id.ToString();
      cboNotaryOfficialLetterIssuePlace.Value = document.IssuePlace.Id.ToString();

      HtmlSelectContent.LoadCombo(this.cboNotaryOfficialLetterIssueOffice, NotaryOffice.GetList(document.IssuePlace),
                                  "Id", "Number", "( ? )");

      cboNotaryOfficialLetterIssueOffice.Value = document.IssueOffice.Id.ToString();

      HtmlSelectContent.LoadCombo(this.cboNotaryOfficialLetterIssuedBy, NotaryOffice.Parse(document.IssueOffice.Id).GetNotaries(),
                                  "Id", "FamilyFullName", "( Seleccionar al C. Notario Público )");

      cboNotaryOfficialLetterIssuedBy.Value = document.IssuedBy.Id.ToString();

      txtNotaryOfficialLetterNo.Value = document.Number;
      txtNotaryOfficialLetterIssueDate.Value = document.IssueDate.ToString("dd/MMM/yyyy");
    }

    private void LoadJudgeOfficialLetter() {
      RecordingDocument document = base.Document;

      cboJudicialDocSubtype.Value = document.Subtype.Id.ToString();
      cboJudicialDocIssuePlace.Value = document.IssuePlace.Id.ToString();

      HtmlSelectContent.LoadCombo(this.cboJudicialDocIssueOffice, JudicialOffice.GetList(document.IssuePlace),
                                  "Id", "Number", "( Seleccionar )");
      cboJudicialDocIssueOffice.Value = document.IssueOffice.Id.ToString();

      HtmlSelectContent.LoadCombo(this.cboJudicialDocIssuedBy, JudicialOffice.Parse(document.IssueOffice.Id).GetJudges(),
                                  "Id", "FamilyFullName", "( C. Juez )");


      cboJudicialDocIssuedBy.Value = document.IssuedBy.Id.ToString();

      txtJudicialDocBook.Value = document.ExpedientNo;
      txtJudicialDocNumber.Value = document.Number;
      if (document.IssueDate != ExecutionServer.DateMinValue) {
        txtJudicialDocIssueDate.Value = document.IssueDate.ToString("dd/MMM/yyyy");
      } else {
        txtJudicialDocIssueDate.Value = String.Empty;
      }
    }

    private void LoadNotaryPublicDeed() {
      RecordingDocument document = base.Document;

      cboNotaryDocIssuePlace.Value = document.IssuePlace.Id.ToString();

      HtmlSelectContent.LoadCombo(this.cboNotaryDocIssueOffice, NotaryOffice.GetList(document.IssuePlace), "Id", "Number",
                                  "( ? )");

      cboNotaryDocIssueOffice.Value = document.IssueOffice.Id.ToString();

      HtmlSelectContent.LoadCombo(this.cboNotaryDocIssuedBy, NotaryOffice.Parse(document.IssueOffice.Id).GetNotaries(),
                                  "Id", "FamilyFullName", "( Seleccionar al C. Notario Público )");

      cboNotaryDocIssuedBy.Value = document.IssuedBy.Id.ToString();

      txtNotaryDocBook.Value = document.ExtensionData.BookNo;
      txtNotaryDocNumber.Value = document.Number;
      txtNotaryDocStartSheet.Value = document.ExtensionData.StartSheet;
      txtNotaryDocEndSheet.Value = document.ExtensionData.EndSheet;
      if (document.IssueDate != ExecutionServer.DateMinValue) {
        txtNotaryDocIssueDate.Value = document.IssueDate.ToString("dd/MMM/yyyy");
      } else {
        txtNotaryDocIssueDate.Value = String.Empty;
      }
    }

    private void LoadPrivateDocument() {
      RecordingDocument document = base.Document;

      HtmlSelectContent.LoadCombo(this.cboPrivateDocIssuedBy, document.Subtype.IssuedByEntities,
                                  "Id", "FullName", "( Documento expedido por )");

      cboPrivateDocSubtype.Value = document.Subtype.Id.ToString();
      cboPrivateDocIssuePlace.Value = document.IssuePlace.Id.ToString();
      cboPrivateDocIssuedBy.Value = document.IssuedBy.Id.ToString();
      txtPrivateDocNumber.Value = document.Number;

      if (document.IssueDate != ExecutionServer.DateMinValue) {
        txtPrivateDocIssueDate.Value = document.IssueDate.ToString("dd/MMM/yyyy");
      } else {
        txtPrivateDocIssueDate.Value = String.Empty;
      }
    }

    private void LoadEjidalSystemTitle() {
      RecordingDocument document = base.Document;

      txtPropTitleDocNumber.Value = document.Number;
      cboPropTitleDocIssuedBy.Value = document.IssuedBy.Id.ToString();
      cboPropTitleIssueOffice.Value = document.IssueOffice.Id.ToString();
      txtPropTitleStartSheet.Value = document.ExpedientNo;
      if (document.IssueDate != ExecutionServer.DateMinValue) {
        txtPropTitleIssueDate.Value = document.IssueDate.ToString("dd/MMM/yyyy");
      } else {
        txtPropTitleIssueDate.Value = String.Empty;
      }
    }

    private void FillEmptyRecordingDocument(RecordingDocumentType documentType) {
      RecordingDocument document = base.Document;

      document.ChangeDocumentType(documentType);
    }

    private void FillNotaryOfficialLetter(RecordingDocumentType documentType) {
      RecordingDocument document = base.Document;

      document.ChangeDocumentType(documentType);
      document.Subtype = LRSDocumentType.Parse(int.Parse(cboNotaryOfficialLetterSubtype.Value));
      document.IssuePlace = GeographicRegion.Parse(int.Parse(cboNotaryOfficialLetterIssuePlace.Value));
      document.IssueOffice = NotaryOffice.Parse(int.Parse(Request.Form[cboNotaryOfficialLetterIssueOffice.Name]));
      document.IssuedBy = Contact.Parse(int.Parse(Request.Form[cboNotaryOfficialLetterIssuedBy.Name]));
      document.Number = txtNotaryOfficialLetterNo.Value;
      document.IssueDate = EmpiriaString.ToDate(txtNotaryOfficialLetterIssueDate.Value);
    }

    private void FillJudgeOfficialLetter(RecordingDocumentType documentType) {
      RecordingDocument document = base.Document;

      document.Subtype = LRSDocumentType.Parse(int.Parse(cboJudicialDocSubtype.Value));
      document.ChangeDocumentType(documentType);
      document.IssuePlace = GeographicRegion.Parse(int.Parse(Request.Form[cboJudicialDocIssuePlace.Name]));
      document.IssueOffice = Organization.Parse(int.Parse(Request.Form[cboJudicialDocIssueOffice.Name]));
      document.IssuedBy = Contact.Parse(int.Parse(Request.Form[cboJudicialDocIssuedBy.Name]));
      document.ExpedientNo = txtJudicialDocBook.Value;
      document.Number = txtJudicialDocNumber.Value;
      if (txtJudicialDocIssueDate.Value.Length != 0) {
        document.IssueDate = EmpiriaString.ToDate(txtJudicialDocIssueDate.Value);
      } else {
        document.IssueDate = ExecutionServer.DateMinValue;
      }
    }

    private void FillNotaryPublicDeed(RecordingDocumentType documentType) {
      RecordingDocument document = base.Document;

      document.ChangeDocumentType(documentType);
      document.IssuePlace = GeographicRegion.Parse(int.Parse(cboNotaryDocIssuePlace.Value));
      document.IssueOffice = NotaryOffice.Parse(int.Parse(Request.Form[cboNotaryDocIssueOffice.Name]));
      document.IssuedBy = Contact.Parse(int.Parse(Request.Form[cboNotaryDocIssuedBy.Name]));
      document.ExtensionData.BookNo = txtNotaryDocBook.Value;
      document.Number = txtNotaryDocNumber.Value;
      document.ExtensionData.StartSheet = txtNotaryDocStartSheet.Value;
      document.ExtensionData.EndSheet = txtNotaryDocEndSheet.Value;
      if (txtNotaryDocIssueDate.Value.Length != 0) {
        document.IssueDate = EmpiriaString.ToDate(txtNotaryDocIssueDate.Value);
      } else {
        document.IssueDate = ExecutionServer.DateMinValue;
      }
    }

    private void FillPrivateDocument(RecordingDocumentType documentType) {
      RecordingDocument document = base.Document;

      document.ChangeDocumentType(documentType);

      document.Subtype = LRSDocumentType.Parse(int.Parse(cboPrivateDocSubtype.Value));
      document.IssuePlace = GeographicRegion.Parse(int.Parse(cboPrivateDocIssuePlace.Value));
      document.IssuedBy = Contact.Parse(int.Parse(Request.Form[cboPrivateDocIssuedBy.Name]));
      document.Number = txtPrivateDocNumber.Value;
      if (txtPrivateDocIssueDate.Value.Length != 0) {
        document.IssueDate = EmpiriaString.ToDate(txtPrivateDocIssueDate.Value);
      } else {
        document.IssueDate = ExecutionServer.DateMinValue;
      }
    }

    private void FillEjidalSystemTitle(RecordingDocumentType documentType) {
      RecordingDocument document = base.Document;

      document.ChangeDocumentType(documentType);

      document.Number = txtPropTitleDocNumber.Value;
      document.IssuedBy = Contact.Parse(int.Parse(cboPropTitleDocIssuedBy.Value));
      document.IssueOffice = Organization.Parse(int.Parse(cboPropTitleIssueOffice.Value));
      document.ExpedientNo = txtPropTitleStartSheet.Value;
      if (txtPropTitleIssueDate.Value.Length != 0) {
        document.IssueDate = EmpiriaString.ToDate(txtPropTitleIssueDate.Value);
      } else {
        document.IssueDate = ExecutionServer.DateMinValue;
      }
    }

  } // class RecordingDocumentEditorControl

} // namespace Empiria.Land.WebApp
