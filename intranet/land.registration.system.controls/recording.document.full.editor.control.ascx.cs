/* Empiria® Land 2015 ****************************************************************************************
*																																																						 *
*  Solution  : Empiria® Land                                    System   : Land Intranet Application         *
*  Namespace : Empiria.Web.UI                                   Assembly : Empiria.Land.Intranet.dll         *
*  Type      : RecordingDocumentFullEditorControl               Pattern  : User Control                      *
*  Date      : 04/Jan/2015                                      Version  : 2.0  License: LICENSE.TXT file    *
*                                                                                                            *
*  Summary   : User control that handles recorder document edition.                                          *
*																																																						 *
**************************************************** Copyright © La Vía Óntica SC + Ontica LLC. 2009-2015. **/
using System;
using System.Web.UI.WebControls;
using Empiria.Contacts;
using Empiria.Geography;
using Empiria.Land.Registration;
using Empiria.Land.Registration.Transactions;
using Empiria.Land.UI;
using Empiria.Ontology;
using Empiria.Presentation.Web.Content;

namespace Empiria.Web.UI.LRS {

  public partial class RecordingDocumentFullEditorControl : LRSDocumentEditorControl {

    protected override RecordingDocument ImplementsFillRecordingDocument(RecordingDocumentType documentType) {
      switch (documentType.Name) {
        case "ObjectType.RecordingDocument.NotaryDeed":
          FillNotaryDocument(documentType);
          break;
        case "ObjectType.RecordingDocument.PropertyTitle":
          FillPropertyTitleDocument(documentType);
          break;
        case "ObjectType.RecordingDocument.JudicialOrder":
          FillJudicialDocument(documentType);
          break;
        case "ObjectType.RecordingDocument.PrivateContract":
          FillPrivateContractDocument(documentType);
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
      oNotaryRecording.Style["display"] = "none";
      oTitleRecording.Style["display"] = "none";
      oJudicialRecording.Style["display"] = "none";
      oPrivateRecording.Style["display"] = "none";
      LoadMainCombos();
      switch (documentType.Name) {
        case "ObjectType.RecordingDocument.NotaryDeed":
          oNotaryRecording.Style["display"] = "inline";
          LoadNotaryDocument();
          return;
        case "ObjectType.RecordingDocument.PropertyTitle":
          oTitleRecording.Style["display"] = "inline";
          LoadPropertyTitleDocument();
          return;
        case "ObjectType.RecordingDocument.JudicialOrder":
          oJudicialRecording.Style["display"] = "inline";
          LoadJudicialDocument();
          return;
        case "ObjectType.RecordingDocument.PrivateContract":
          oPrivateRecording.Style["display"] = "inline";
          LoadPrivateContractDocument();
          return;
        case "ObjectType.RecordingDocument.Empty":
          return;
      }
    }

    private void LoadMainCombos() {
      RecordingBook book = RecordingBook.Empty;
      RecorderOffice office = RecorderOffice.Empty;

      HtmlSelectContent.LoadCombo(this.cboNotaryDocIssuePlace, office.GetNotaryOfficePlaces(),
                                  "Id", "Name", "( Seleccionar )", String.Empty, "No consta");

      HtmlSelectContent.LoadCombo(this.cboPrivateDocIssuePlace, office.GetPrivateDocumentIssuePlaces(),
                                  "Id", "Name", "( Seleccionar )", String.Empty, "No consta");

      HtmlSelectContent.LoadCombo(this.cboJudicialDocIssuePlace, office.GetJudicialDocumentIssuePlaces(),
                                  "Id", "Name", "( Seleccionar )", String.Empty, "No consta");

      FixedList<Person> signers = office.GetPropertyTitleSigners(book.RecordingsControlTimePeriod);
      HtmlSelectContent.LoadCombo(this.cboPropTitleDocIssuedBy, signers, "Id", "FullName",
                                  "( Seleccionar al C. Funcionario Público )", String.Empty, 
                                  "No consta o no se puede determinar");

      HtmlSelectContent.LoadCombo(this.cboPropTitleIssueOffice, office.GetPropertyTitleOffices(),
                                  "Id", "Alias", "( Seleccionar )", String.Empty, "No consta");

      GeneralList listType = GeneralList.Parse("PrivateContract.WitnessPosition.List");
      FixedList<TypeAssociationInfo> witnessRoles = 
                  listType.GetItems<TypeAssociationInfo>((x, y) => x.DisplayName.CompareTo(y.DisplayName));
      HtmlSelectContent.LoadCombo(this.cboPrivateDocMainWitnessPosition, witnessRoles,
                                  "Id", "DisplayName", "( Seleccionar )", "No consta", String.Empty);
    }

    private void LoadJudicialDocument() {
      RecordingDocument document = base.Document;

      cboJudicialDocSubtype.Value = document.Subtype.Id.ToString();
      cboJudicialDocIssuePlace.Value = document.IssuePlace.Id.ToString();

      HtmlSelectContent.LoadCombo(this.cboJudicialDocIssueOffice, JudicialOffice.GetList(document.IssuePlace),
                                  "Id", "Number", "( Seleccionar )", String.Empty, "No consta");
      cboJudicialDocIssueOffice.Value = document.IssueOffice.Id.ToString();

      //if (document.IssueOffice is JudicialOffice) {
      HtmlSelectContent.LoadCombo(this.cboJudicialDocIssuedBy, JudicialOffice.Parse(document.IssueOffice.Id).GetJudges(),
                                  "Id", "FamilyFullName", "( C. Juez )", String.Empty, "No consta");
      //HtmlSelectContent.LoadCombo(this.cboJudicialDocIssuedBy, ((JudicialOffice) document.IssueOffice).GetJudges(),
      //                            "Id", "FamilyFullName", "( C. Juez )", String.Empty, "No consta");
      //} else {
      //  HtmlSelectContent.LoadCombo(this.cboJudicialDocIssuedBy, "( C. Juez )", String.Empty, "No consta");
      //}
      cboJudicialDocIssuedBy.Value = document.IssuedBy.Id.ToString();

      txtJudicialDocBook.Value = document.ExtensionData.BookNo;
      txtJudicialDocNumber.Value = document.Number;
      if (document.IssueDate != ExecutionServer.DateMinValue) {
        txtJudicialDocIssueDate.Value = document.IssueDate.ToString("dd/MMM/yyyy");
      } else {
        txtJudicialDocIssueDate.Value = String.Empty;
      }
    }

    private void LoadNotaryDocument() {
      RecordingDocument document = base.Document;

      cboNotaryDocIssuePlace.Value = document.IssuePlace.Id.ToString();

      HtmlSelectContent.LoadCombo(this.cboNotaryDocIssueOffice, NotaryOffice.GetList(document.IssuePlace), "Id", "Number",
                                  "( ? )", String.Empty, "N/C");

      cboNotaryDocIssueOffice.Value = document.IssueOffice.Id.ToString();

      HtmlSelectContent.LoadCombo(this.cboNotaryDocIssuedBy, NotaryOffice.Parse(document.IssueOffice.Id).GetNotaries(),
                                  "Id", "FamilyFullName", "( Seleccionar al C. Notario Público )", String.Empty,
                                  "No consta o no se puede determinar");

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

    private void LoadPrivateContractDocument() {
      RecordingDocument document = base.Document;

      cboPrivateDocSubtype.Value = document.Subtype.Id.ToString();
      cboPrivateDocIssuePlace.Value = document.IssuePlace.Id.ToString();
      txtPrivateDocNumber.Value = document.Number;

      var roleType = RoleType.Parse(document.ExtensionData.MainWitnessPosition.Id);

      cboPrivateDocMainWitnessPosition.Value = roleType.Id.ToString();

      if (document.ExtensionData.MainWitnessPosition.Id == -1) {
        cboPrivateDocMainWitness.Items.Clear();
        cboPrivateDocMainWitness.Items.Add(new ListItem("No consta o no se puede determinar", "-2"));
      } else {
        FixedList<Person> peopleInRoleList = roleType.GetActors<Person>(document.IssuePlace);
        HtmlSelectContent.LoadCombo(this.cboPrivateDocMainWitness, peopleInRoleList, "Id", "FamilyFullName",
                                    "( Seleccionar al C. Funcionario Público )", String.Empty,
                                    "No consta o no se puede determinar");
      }
      cboPrivateDocMainWitness.Value = document.ExtensionData.MainWitness.Id.ToString();
      if (document.IssueDate != ExecutionServer.DateMinValue) {
        txtPrivateDocIssueDate.Value = document.IssueDate.ToString("dd/MMM/yyyy");
      } else {
        txtPrivateDocIssueDate.Value = String.Empty;
      }
    }

    private void LoadPropertyTitleDocument() {
      RecordingDocument document = base.Document;

      txtPropTitleDocNumber.Value = document.Number;
      cboPropTitleDocIssuedBy.Value = document.IssuedBy.Id.ToString();
      cboPropTitleIssueOffice.Value = document.IssueOffice.Id.ToString();
      txtPropTitleStartSheet.Value = document.ExtensionData.StartSheet;
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

    private void FillJudicialDocument(RecordingDocumentType documentType) {
      RecordingDocument document = base.Document;

      document.Subtype = LRSDocumentType.Parse(int.Parse(cboJudicialDocSubtype.Value));
      document.ChangeDocumentType(documentType);
      document.IssuePlace = GeographicRegion.Parse(int.Parse(Request.Form[cboJudicialDocIssuePlace.Name]));
      document.IssueOffice = Organization.Parse(int.Parse(Request.Form[cboJudicialDocIssueOffice.Name]));
      document.IssuedBy = Contact.Parse(int.Parse(Request.Form[cboJudicialDocIssuedBy.Name]));
      document.ExtensionData.BookNo = txtJudicialDocBook.Value;
      document.Number = txtJudicialDocNumber.Value;
      if (txtJudicialDocIssueDate.Value.Length != 0) {
        document.IssueDate = EmpiriaString.ToDate(txtJudicialDocIssueDate.Value);
      } else {
        document.IssueDate = ExecutionServer.DateMinValue;
      }
    }

    private void FillNotaryDocument(RecordingDocumentType documentType) {
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

    private void FillPrivateContractDocument(RecordingDocumentType documentType) {
      RecordingDocument document = base.Document;

      document.ChangeDocumentType(documentType);

      document.Subtype = LRSDocumentType.Parse(int.Parse(cboPrivateDocSubtype.Value));
      document.IssuePlace = GeographicRegion.Parse(int.Parse(cboPrivateDocIssuePlace.Value));
      document.Number = txtPrivateDocNumber.Value;
      document.ExtensionData.MainWitnessPosition = RoleType.Parse(Request.Form[cboPrivateDocMainWitnessPosition.Name]);
      document.ExtensionData.MainWitness = Contact.Parse(int.Parse(Request.Form[cboPrivateDocMainWitness.Name]));
      if (txtPrivateDocIssueDate.Value.Length != 0) {
        document.IssueDate = EmpiriaString.ToDate(txtPrivateDocIssueDate.Value);
      } else {
        document.IssueDate = ExecutionServer.DateMinValue;
      }
    }

    private void FillPropertyTitleDocument(RecordingDocumentType documentType) {
      RecordingDocument document = base.Document;

      document.ChangeDocumentType(documentType);

      document.Number = txtPropTitleDocNumber.Value;
      document.IssuedBy = Contact.Parse(int.Parse(cboPropTitleDocIssuedBy.Value));
      document.IssueOffice = Organization.Parse(int.Parse(cboPropTitleIssueOffice.Value));
      document.ExtensionData.StartSheet = txtPropTitleStartSheet.Value;
      if (txtPropTitleIssueDate.Value.Length != 0) {
        document.IssueDate = EmpiriaString.ToDate(txtPropTitleIssueDate.Value);
      } else {
        document.IssueDate = ExecutionServer.DateMinValue;
      }
    }

  } // class RecordingDocumentEditorControl

} // namespace Empiria.Web.UI.LRS
