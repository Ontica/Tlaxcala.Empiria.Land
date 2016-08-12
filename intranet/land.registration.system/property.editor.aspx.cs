/* Empiria Land **********************************************************************************************
*																																																						 *
*  Solution  : Empiria Land                                     System   : Land Intranet Application         *
*  Namespace : Empiria.Land.WebApp                              Assembly : Empiria.Land.Intranet.dll         *
*  Type      : PropertyEditor                                   Pattern  : Explorer Web Page                 *
*  Version   : 2.1                                              License  : Please read license.txt file      *
*																																																						 *
*  Summary   : Gets user credentials and redirects users to the workplace start page.                        *
*                                                                                                            *
********************************** Copyright(c) 2009-2016. La Vía Óntica SC, Ontica LLC and contributors.  **/
using System;

using Empiria.DataTypes;
using Empiria.Land.Registration;
using Empiria.Land.UI;
using Empiria.Presentation;
using Empiria.Presentation.Web;

namespace Empiria.Land.WebApp {

  public partial class PropertyEditor : WebPage {

    #region Fields

    private RealEstate property = null;
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

    #endregion Protected methods

    #region Private methods

    private void DoCommand() {
      switch (base.CommandName) {
        case "savePropertyAsComplete":
          SaveProperty(RecordableObjectStatus.Registered);
          Response.Redirect("property.editor.aspx?propertyId=" + property.Id.ToString() + "&recordingActId=" + recordingAct.Id.ToString(), true);
          return;
        case "savePropertyAsPending":
          SaveProperty(RecordableObjectStatus.Pending);
          Response.Redirect("property.editor.aspx?propertyId=" + property.Id.ToString() + "&recordingActId=" + recordingAct.Id.ToString(), true);
          return;
        case "savePropertyAsNoLegible":
          SaveProperty(RecordableObjectStatus.NoLegible);
          Response.Redirect("property.editor.aspx?propertyId=" + property.Id.ToString() + "&recordingActId=" + recordingAct.Id.ToString(), true);
          return;
        default:
          throw new NotImplementedException(base.CommandName);
      }
    }

    private void SaveProperty(RecordableObjectStatus status) {
      FillPropertyData();
      FillPropertyEventData();
      property.Status = status;
      property.Save();

      //propertyEvent.Status = (TractIndexItemStatus) (char) status;
      //propertyEvent.Save();
    }

    private void Initialize() {
      recordingAct = RecordingAct.Parse(int.Parse(Request.QueryString["recordingActId"]));
      property = RealEstate.Parse(int.Parse(Request.QueryString["propertyId"]));
      //propertyEvent = recordingAct.GetPropertyEvent(property);
    }

    private void LoadControls() {
      //LRSHtmlSelectControls.LoadPropertyTypesCombo(this.cboPropertyType, ComboControlUseMode.ObjectCreation, property.PropertyKind);

      RecorderOffice selectedRecorderOffice = recordingAct.PhysicalRecording.RecordingBook.RecorderOffice;

      LRSHtmlSelectControls.LoadRecorderOfficeCombo(this.cboCadastralOffice, ComboControlUseMode.ObjectCreation, selectedRecorderOffice);
      LRSHtmlSelectControls.LoadRecorderOfficeMunicipalitiesCombo(this.cboMunicipality, ComboControlUseMode.ObjectCreation,
                                                                  selectedRecorderOffice, property.Location.Municipality);

      LoadPropertyControls();
    }


    private void LoadPropertyControls() {
      txtCadastralNumber.Value = property.CadastralData.CadastralCode;
      txtTractNumber.Value = property.UID;
      txtStatus.Value = property.StatusName;
      cboPropertyType.Value = property.PropertyKind;
      txtPropertyCommonName.Value = property.Name;
      txtObservations.Value = property.Notes;
      txtUbication.Value = property.Location.UbicationReference;

      CadastralInfo cadastralData = property.CadastralData;

      if (!cadastralData.TotalArea.Unit.IsEmptyInstance && !cadastralData.TotalArea.Unit.Equals(DataTypes.Unit.Unknown)) {
        txtTotalArea.Value = cadastralData.TotalArea.Amount.ToString("0.#######");
      } else {
        txtTotalArea.Value = String.Empty;
      }
      cboTotalAreaUnit.Value = cadastralData.TotalArea.Unit.Id.ToString();
      if (!cadastralData.FloorArea.Unit.IsEmptyInstance && !cadastralData.FloorArea.Unit.Equals(DataTypes.Unit.Unknown)) {
        txtFloorArea.Value = cadastralData.FloorArea.Amount.ToString("0.#######");
      } else {
        txtFloorArea.Value = String.Empty;
      }
      cboFloorAreaUnit.Value = cadastralData.FloorArea.Unit.Id.ToString();
      txtCommonArea.Value = cadastralData.CommonArea.Amount.ToString("N2");
      if (!cadastralData.CommonArea.Unit.IsEmptyInstance && !cadastralData.CommonArea.Unit.Equals(DataTypes.Unit.Unknown)) {
        txtCommonArea.Value = cadastralData.CommonArea.Amount.ToString("0.####");
      } else {
        txtCommonArea.Value = String.Empty;
      }
      cboCommonAreaUnit.Value = cadastralData.CommonArea.Unit.Id.ToString();
      txtMetesAndBounds.Value = cadastralData.MetesAndBounds;
    }

    private void FillPropertyData() {
      //property.CadastralData.CadastralCode = txtCadastralNumber.Value;
      //if (cboPropertyType.Value.Length != 0) {
      //  property.PropertyKind = PropertyKind.Parse(int.Parse(cboPropertyType.Value));
      //} else {
      //  property.PropertyKind = PropertyKind.Empty;
      //}
      //property.Name = txtPropertyCommonName.Value;
      //property.RecordingNotes = txtObservations.Value;

      //Address locationData = property.Location;

      //if (Request.Form[cboMunicipality.ClientID].Length != 0) {
      //  locationData.Municipality = GeographicRegionItem.Parse(int.Parse(Request.Form[cboMunicipality.ClientID]));
      //  //property.CadastralData.CadastralOffice = RecorderOffice.Parse(int.Parse(cboCadastralOffice.Value));
      //} else {
      //  locationData.Municipality = GeographicRegionItem.Empty;
      //}
      //if (Request.Form[cboSettlement.ClientID].Length != 0) {
      //  locationData.Settlement = GeographicRegionItem.Parse(int.Parse(Request.Form[cboSettlement.ClientID]));
      //} else {
      //  locationData.Settlement = GeographicRegionItem.Empty;
      //}
      //if (Request.Form[cboStreetRoad.ClientID].Length != 0) {
      //  locationData.Street = GeographicPathItem.Parse(int.Parse(Request.Form[cboStreetRoad.ClientID]));
      //} else {
      //  locationData.Street = GeographicPathItem.Empty;
      //}
      //if (Request.Form[cboPostalCode.ClientID].Length != 0) {
      //  locationData.PostalCode = GeographicRegionItem.Parse(int.Parse(Request.Form[cboPostalCode.ClientID]));
      //} else {
      //  locationData.PostalCode = GeographicRegionItem.Empty;
      //}
      //locationData.UbicationReference = txtUbication.Value;
      //locationData.ExternalNo = txtExternalNumber.Value;
      //locationData.InternalNo = txtInternalNumber.Value;
      ////property.PartitionNo = txtFractionTag.Value;
    }

    private void FillPropertyEventData() {
      CadastralInfo cadastralData = property.CadastralData;

      if (cboTotalAreaUnit.Value.Length != 0 && txtTotalArea.Value.Length != 0) {
        cadastralData.TotalArea = Quantity.Parse(DataTypes.Unit.Parse(int.Parse(cboTotalAreaUnit.Value)),
                                                 decimal.Parse(txtTotalArea.Value));
      } else {
        cadastralData.TotalArea = Quantity.Parse(DataTypes.Unit.Empty, 0m);
      }
      if (cboFloorAreaUnit.Value.Length != 0 && txtFloorArea.Value.Length != 0) {
        cadastralData.FloorArea = Quantity.Parse(DataTypes.Unit.Parse(int.Parse(cboFloorAreaUnit.Value)),
                                                 decimal.Parse(txtFloorArea.Value));
      } else {
        cadastralData.FloorArea = Quantity.Parse(DataTypes.Unit.Empty, 0m);
      }
      if (cboCommonAreaUnit.Value.Length != 0 && txtCommonArea.Value.Length != 0) {
        cadastralData.CommonArea = Quantity.Parse(DataTypes.Unit.Parse(int.Parse(cboCommonAreaUnit.Value)),
                                                  decimal.Parse(txtCommonArea.Value));
      } else {
        cadastralData.CommonArea = Quantity.Parse(DataTypes.Unit.Empty, 0m);
      }
      cadastralData.MetesAndBounds = txtMetesAndBounds.Value;
    }

    #endregion Private methods

  } // class PropertyEditor

} // namespace Empiria.Land.WebApp
