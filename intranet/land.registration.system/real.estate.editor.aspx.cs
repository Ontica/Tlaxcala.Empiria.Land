/* Empiria Land **********************************************************************************************
*                                                                                                            *
*  Solution  : Empiria Land                                     System   : Land Intranet Application         *
*  Namespace : Empiria.Land.WebApp                              Assembly : Empiria.Land.Intranet.dll         *
*  Type      : RealEstateEditor                                 Pattern  : Explorer Web Page                 *
*  Version   : 3.0                                              License  : Please read license.txt file      *
*                                                                                                            *
*  Summary   : Display and update real estate data from the user interface.                                  *
*                                                                                                            *
************************* Copyright(c) La Vía Óntica SC, Ontica LLC and contributors. All rights reserved. **/
using System;

using Empiria.DataTypes;
using Empiria.Geography;
using Empiria.Presentation;
using Empiria.Presentation.Web;
using Empiria.Presentation.Web.Content;

using Empiria.Land.Registration;
using Empiria.Land.UI;

namespace Empiria.Land.WebApp {

  /// <summary>Display and update real estate data from the user interface.</summary>
  public partial class RealEstateEditor : WebPage {

    #region Fields

    protected RealEstate property = null;
    private RecordingAct recordingAct = null;

    #endregion Fields

    #region Protected methods

    protected void Page_Load(object sender, EventArgs e) {
      Initialize();
      if (IsPostBack) {
        DoCommand();
      } else {
        LoadControls();
      }
    }

    protected bool IsInEditionMode() {
      return recordingAct.Document.Security.IsReadyForEdition();
    }

    protected bool AllowsPartitionEdition() {
      return property.IsPartition && this.RecordingActAllowsEdition() &&
             property.IsInTheRankOfTheFirstDomainAct(recordingAct);
    }

    protected bool RecordingActAllowsEdition() {
      return property.Kind.Length == 0 ||
             recordingAct.ResourceUpdated ||
             recordingAct.RecordingActType.RecordingRule.EditRealEstate ||
             property.IsInTheRankOfTheFirstDomainAct(recordingAct);
    }

    #endregion Protected methods

    #region Private methods

    private void DoCommand() {
      switch (base.CommandName) {
        case "saveRealEstate":
          SaveProperty();
          Response.Redirect("real.estate.editor.aspx?propertyId=" +
                            property.Id.ToString() + "&recordingActId=" + recordingAct.Id.ToString(), true);
          return;
        case "cancelEdition":
          Response.Redirect("real.estate.editor.aspx?propertyId=" +
                            property.Id.ToString() + "&recordingActId=" + recordingAct.Id.ToString(), true);
          return;
        default:
          throw new NotImplementedException(base.CommandName);
      }
    }

    private void SaveProperty() {
      FillPropertyData();
      property.Save();
      recordingAct.OnResourceUpdated(property);
    }

    private void Initialize() {
      recordingAct = RecordingAct.Parse(int.Parse(Request.QueryString["recordingActId"]));
      property = RealEstate.Parse(int.Parse(Request.QueryString["propertyId"]));
    }

    private void LoadControls() {
      var realEstateTypes = RealEstateType.GetList();

      HtmlSelectContent.LoadCombo(this.cboRealEstateKind, realEstateTypes, "Name", "Name",
                                  "( Tipo de predio )");

      LRSHtmlSelectControls.LoadRecorderOfficeCombo(this.cboRecordingOffice, ComboControlUseMode.ObjectCreation, property.RecorderOffice);
      LRSHtmlSelectControls.LoadRecorderOfficeMunicipalitiesCombo(this.cboMunicipality, ComboControlUseMode.ObjectCreation,
                                                                  property.RecorderOffice, property.Municipality);

      LoadPropertyControls();
    }


    private void LoadPropertyControls() {
      txtCadastralKey.Value = property.CadastralKey;
      txtPropertyUID.Value = property.UID;
      txtCommonName.Value = property.Name;
      cboRealEstateKind.Value = property.Kind;
      txtNotes.Value = property.Notes;
      txtLocationReference.Value = property.Description;

      if (property.LotSize.Amount != 0m) {
        txtLotSize.Value = property.LotSize.Amount.ToString("0.#######");
      } else {
        txtLotSize.Value = String.Empty;
      }
      cboLotSizeUnit.Value = property.LotSize.Unit.Id.ToString();
      txtMetesAndBounds.Value = property.MetesAndBounds;

      if (property.IsPartition) {
        txtPartitionNo.Value = property.PartitionNo;
        txtPartitionOf.Value = property.IsPartitionOf.UID;
      }
    }


    private void FillPropertyData() {
      var data = new RealEstateExtData();

      data.CadastralKey = txtCadastralKey.Value;

      property.Name = txtCommonName.Value;
      property.Description = txtLocationReference.Value;
      property.RecorderOffice = RecorderOffice.Parse(int.Parse(cboRecordingOffice.Value));
      property.Municipality = Municipality.Parse(int.Parse(cboMunicipality.Value));
      property.Kind = cboRealEstateKind.Value;
      data.Notes = txtNotes.Value;
      data.MetesAndBounds = txtMetesAndBounds.Value;

      if (cboLotSizeUnit.Value.Length != 0 && txtLotSize.Value.Length != 0) {
        property.LotSize = Quantity.Parse(Unit.Parse(int.Parse(cboLotSizeUnit.Value)),
                                      decimal.Parse(txtLotSize.Value));
      } else {
        property.LotSize = Quantity.Zero;
      }

      property.SetExtData(data);

      if (txtPartitionNo.Value != property.PartitionNo &&
          this.AllowsPartitionEdition()) {
        property.SetPartitionNo(EmpiriaString.TrimAll(txtPartitionNo.Value));
      }
    }

    #endregion Private methods

  } // class RealEstateEditor

} // namespace Empiria.Land.WebApp
