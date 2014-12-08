/* Empiria® Land 2014 ****************************************************************************************
*																																																						 *
*	 Solution  : Empiria® Land                                    System   : Land Intranet Application         *
*	 Namespace : Empiria.Web.UI                                   Assembly : Empiria.Land.Intranet.dll         *
*	 Type      : ObjectSearcher                                   Pattern  : Explorer Web Page                 *
*	 Date      : 28/Mar/2014                                      Version  : 1.5  License: CC BY-NC-SA 4.0     *
*																																																						 *
*  Summary   : Gets user credentials and redirects users to the workplace start page.                        *
*																																																						 *
**************************************************** Copyright © La Vía Óntica SC + Ontica LLC. 1994-2014. **/
using System;
using System.Web.UI.WebControls;

using Empiria.DataTypes;
using Empiria.Geography;
using Empiria.Land.Registration;
using Empiria.Land.UI;
using Empiria.Presentation;
using Empiria.Presentation.Web;
using Empiria.Presentation.Web.Content;

namespace Empiria.Web.UI.LRS {

  public partial class PropertyEditor : WebPage {

    #region Fields

    private Property property = null;
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
        case "appendSettlement":
          AppendSettlement();
          Response.Redirect("property.editor.aspx?propertyId=" + property.Id.ToString() + "&recordingActId=" + recordingAct.Id.ToString(), true);
          return;
        case "appendStreetRoad":
          AppendStreetRoad();
          Response.Redirect("property.editor.aspx?propertyId=" + property.Id.ToString() + "&recordingActId=" + recordingAct.Id.ToString(), true);
          return;
        case "appendPostalCode":
          AppendPostalCode();
          Response.Redirect("property.editor.aspx?propertyId=" + property.Id.ToString() + "&recordingActId=" + recordingAct.Id.ToString(), true);
          return;
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

    private void AppendSettlement() {
      //GeographicRegionItem municipality = GeographicRegionItem.Parse(int.Parse(Request.Form[cboMunicipality.ClientID]));
      //GeographicItemType settlementType = GeographicItemType.Parse(int.Parse(cboSettlementType.Value));

      //GeographicRegionItem settlement = (GeographicRegionItem) settlementType.CreateInstance();
      //settlement.Name = txtSearchText.Value;
      //settlement.Save();

      //municipality.AddMember("Municipality_Settlements", settlement);

      //FillPropertyData();
      //property.Location.Settlement = settlement;
      //property.Save();
    }

    private void AppendStreetRoad() {
      //var settlement = Settlement.Parse(int.Parse(Request.Form[cboSettlement.ClientID]));
      //GeographicItemType streetRoadType = GeographicItemType.Parse(int.Parse(cboStreetRoadType.Value));

      //GeographicPathItem street = (GeographicPathItem) streetRoadType.CreateInstance();
      //street.Name = txtSearchText.Value;
      //street.Save();

      //settlement.AddMember("Settlement_Paths", street);

      //GeographicRegionItem municipality = GeographicRegionItem.Parse(int.Parse(Request.Form[cboMunicipality.ClientID]));
      //municipality.AddMember("Municipality_Paths", street);

      //FillPropertyData();
      //property.Location.Street = street;
      //property.Save();
    }

    private void AppendPostalCode() {
      //GeographicItemType postalCodeType = GeographicItemType.Parse(309);

      //GeographicRegionItem postalCode = (GeographicRegionItem) postalCodeType.CreateInstance();
      //postalCode.Name = txtSearchText.Value;
      //postalCode.Save();

      //if (Request.Form[cboSettlement.ClientID].Length != 0 && int.Parse(Request.Form[cboSettlement.ClientID]) > 0) {
      //  GeographicRegionItem settlement = GeographicRegionItem.Parse(int.Parse(Request.Form[cboSettlement.ClientID]));
      //  settlement.AddMember("Settlement_PostalCodes", postalCode);
      //}
      //GeographicRegionItem municipality = GeographicRegionItem.Parse(int.Parse(Request.Form[cboMunicipality.ClientID]));
      //municipality.AddMember("Municipality_PostalCodes", postalCode);

      //FillPropertyData();
      //property.Location.PostalCode = postalCode;
      //property.Save();
    }

    private void Initialize() {
      recordingAct = RecordingAct.Parse(int.Parse(Request.QueryString["recordingActId"]));
      property = Property.Parse(int.Parse(Request.QueryString["propertyId"]));
      //propertyEvent = recordingAct.GetPropertyEvent(property);
    }

    private void LoadControls() {
      LRSHtmlSelectControls.LoadPropertyTypesCombo(this.cboPropertyType, ComboControlUseMode.ObjectCreation, property.PropertyKind);

      RecorderOffice selectedRecorderOffice = recordingAct.Recording.RecordingBook.RecorderOffice;

      LRSHtmlSelectControls.LoadRecorderOfficeCombo(this.cboCadastralOffice, ComboControlUseMode.ObjectCreation, selectedRecorderOffice);
      LRSHtmlSelectControls.LoadRecorderOfficeMunicipalitiesCombo(this.cboMunicipality, ComboControlUseMode.ObjectCreation,
                                                                  selectedRecorderOffice, property.Location.Municipality);

      LoadSettlementsCombo();
      LoadRoadsCombo();
      LoadPostalCodesCombo();
      LoadPropertyControls();
    }

    private void LoadPostalCodesCombo() {
      //cboPostalCode.Items.Clear();
      //FixedList<GeographicRegionItem> list = new FixedList<GeographicRegionItem>();
      //GeographicItemType postalCodeType = property.Location.PostalCode.GeographicItemType;
      //if (property.Location.Settlement.Id > 0) {
      //  list = property.Location.Settlement.GetRegions("Settlement_PostalCodes", postalCodeType);
      //} else if (property.Location.Municipality.Id > 0) {
      //  list = property.Location.Municipality.GetRegions("Municipality_PostalCodes");
      //} else if (property.Location.Municipality.Equals(GeographicRegionItem.Unknown)) {
      //  // no-op
      //} else {
      //  cboPostalCode.Items.Add(new ListItem("Municipio?", String.Empty));
      //  return;
      //}
      //HtmlSelectContent.LoadCombo(cboPostalCode, list, "Id", "Name",
      //                            list.Count != 0 ? "( ? )" : "( No def )", String.Empty, GeographicRegionItem.Unknown.Name);
    }

    private void LoadRoadsCombo() {
      //cboStreetRoad.Items.Clear();
      //FixedList<GeographicPathItem> list = new FixedList<GeographicPathItem>();
      //GeographicItemType roadType = property.Location.Street.GeographicItemType;
      //if (property.Location.Settlement.Id >= 0) {
      //  list = property.Location.Settlement.GetPaths("Settlement_Paths", roadType);
      //} else if (property.Location.Municipality.Id > 0) {
      //  list = property.Location.Municipality.GetPaths("Municipality_Paths");
      //} else if (property.Location.Municipality.Equals(GeographicRegionItem.Unknown)) {
      //  // no-op
      //} else {
      //  cboStreetRoad.Items.Add(new ListItem("( Primero seleccionar un municipio )", String.Empty));
      //  return;
      //}
      //string headerItem = String.Empty;
      //if (list.Count != 0) {
      //  headerItem = "( Seleccionar" + (roadType.FemaleGenre ? " una " : " un ") + roadType.DisplayName.ToLowerInvariant() + " )";
      //} else {
      //  headerItem = "( No hay " + roadType.DisplayPluralName.ToLowerInvariant() + (roadType.FemaleGenre ? " definidas )" : " definidos )");
      //}

      //HtmlSelectContent.LoadCombo(cboStreetRoad, list, "Id", "Name", headerItem, String.Empty, GeographicRegionItem.Unknown.Name);
    }

    private void LoadSettlementsCombo() {
      //cboSettlement.Items.Clear();
      //FixedList<GeographicRegionItem> list = new FixedList<GeographicRegionItem>();
      //GeographicItemType settlementType = property.Location.Settlement.GeographicItemType;
      //if (property.Location.Settlement.Id >= 0) {
      //  list = property.Location.Municipality.GetRegions("Municipality_Settlements", settlementType);
      //} else if (property.Location.Municipality.Id > 0) {
      //  list = property.Location.Municipality.GetRegions("Municipality_Settlements");
      //} else if (property.Location.Municipality.Equals(GeographicRegionItem.Unknown)) {
      //  // no-op
      //} else {
      //  cboSettlement.Items.Add(new ListItem("( Primero seleccionar un municipio )", String.Empty));
      //  return;
      //}
      //string headerItem = String.Empty;
      //if (list.Count != 0) {
      //  headerItem = "( Seleccionar" + (settlementType.FemaleGenre ? " una " : " un ") + settlementType.DisplayName.ToLowerInvariant() + " )";
      //} else {
      //  headerItem = "( No hay " + settlementType.DisplayPluralName.ToLowerInvariant() + (settlementType.FemaleGenre ? " definidas )" : " definidos )");
      //}
      //HtmlSelectContent.LoadCombo(cboSettlement, list, "Id", "Name", headerItem, String.Empty, GeographicRegionItem.Unknown.Name);
    }

    private void LoadPropertyControls() {
      txtCadastralNumber.Value = property.CadastralData.CadastralCode;
      txtTractNumber.Value = property.UniqueCode;
      txtStatus.Value = property.StatusName;
      cboPropertyType.Value = property.PropertyKind.Value;
      txtPropertyCommonName.Value = property.Name;
      txtAntecendent.Value = property.AntecedentNotes;
      txtObservations.Value = property.RecordingNotes;
      //cboCadastralOffice.Value = property.CadastralData.CadastralOffice.Id.ToString();
      cboMunicipality.Value = property.Location.Municipality.Id.ToString();
      cboSettlementType.Value = property.Location.Settlement.Id.ToString();
      cboSettlement.Value = property.Location.Settlement.Id.ToString();
      cboStreetRoadType.Value = property.Location.Street.GetEmpiriaType().Id.ToString();
      cboStreetRoad.Value = property.Location.Street.Id.ToString();
      cboPostalCode.Value = property.Location.PostalCode;
      txtUbication.Value = property.Location.UbicationReference;
      txtExternalNumber.Value = property.Location.ExternalNo;
      txtInternalNumber.Value = property.Location.InternalNo;
      txtFractionTag.Value = property.PartitionNo;

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
      //property.AntecedentNotes = txtAntecendent.Value;
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

} // namespace Empiria.Web.UI.LRS
