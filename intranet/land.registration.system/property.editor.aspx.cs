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
    private PropertyEvent propertyEvent = null;

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
          SaveProperty(PropertyStatus.Registered);
          Response.Redirect("property.editor.aspx?propertyId=" + property.Id.ToString() + "&recordingActId=" + recordingAct.Id.ToString(), true);
          return;
        case "savePropertyAsPending":
          SaveProperty(PropertyStatus.Pending);
          Response.Redirect("property.editor.aspx?propertyId=" + property.Id.ToString() + "&recordingActId=" + recordingAct.Id.ToString(), true);
          return;
        case "savePropertyAsNoLegible":
          SaveProperty(PropertyStatus.NoLegible);
          Response.Redirect("property.editor.aspx?propertyId=" + property.Id.ToString() + "&recordingActId=" + recordingAct.Id.ToString(), true);
          return;
        default:
          throw new NotImplementedException(base.CommandName);
      }
    }

    private void SaveProperty(PropertyStatus status) {
      FillPropertyData();
      property.Status = status;
      property.Save();
      FillPropertyEventData();
      propertyEvent.Status = (PropertyEventStatus) (char) status;
      propertyEvent.Save();
    }

    private void AppendSettlement() {
      GeographicRegionItem municipality = GeographicRegionItem.Parse(int.Parse(Request.Form[cboMunicipality.ClientID]));
      GeographicItemType settlementType = GeographicItemType.Parse(int.Parse(cboSettlementType.Value));

      GeographicRegionItem settlement = (GeographicRegionItem) settlementType.CreateInstance();
      settlement.Name = txtSearchText.Value;
      settlement.Save();

      municipality.AddMember("Municipality_Settlements", settlement);

      FillPropertyData();
      property.Settlement = settlement;
      property.Save();
    }

    private void AppendStreetRoad() {
      GeographicRegionItem settlement = GeographicRegionItem.Parse(int.Parse(Request.Form[cboSettlement.ClientID]));
      GeographicItemType streetRoadType = GeographicItemType.Parse(int.Parse(cboStreetRoadType.Value));

      GeographicPathItem street = (GeographicPathItem) streetRoadType.CreateInstance();
      street.Name = txtSearchText.Value;
      street.Save();

      settlement.AddMember("Settlement_Paths", street);

      GeographicRegionItem municipality = GeographicRegionItem.Parse(int.Parse(Request.Form[cboMunicipality.ClientID]));
      municipality.AddMember("Municipality_Paths", street);

      FillPropertyData();
      property.Street = street;
      property.Save();
    }

    private void AppendPostalCode() {
      GeographicItemType postalCodeType = GeographicItemType.Parse(309);

      GeographicRegionItem postalCode = (GeographicRegionItem) postalCodeType.CreateInstance();
      postalCode.Name = txtSearchText.Value;
      postalCode.Save();

      if (Request.Form[cboSettlement.ClientID].Length != 0 && int.Parse(Request.Form[cboSettlement.ClientID]) > 0) {
        GeographicRegionItem settlement = GeographicRegionItem.Parse(int.Parse(Request.Form[cboSettlement.ClientID]));
        settlement.AddMember("Settlement_PostalCodes", postalCode);
      }
      GeographicRegionItem municipality = GeographicRegionItem.Parse(int.Parse(Request.Form[cboMunicipality.ClientID]));
      municipality.AddMember("Municipality_PostalCodes", postalCode);

      FillPropertyData();
      property.PostalCode = postalCode;
      property.Save();
    }

    private void Initialize() {
      recordingAct = RecordingAct.Parse(int.Parse(Request.QueryString["recordingActId"]));
      property = Property.Parse(int.Parse(Request.QueryString["propertyId"]));
      propertyEvent = recordingAct.GetPropertyEvent(property);
    }

    private void LoadControls() {
      LRSHtmlSelectControls.LoadPropertyTypesCombo(this.cboPropertyType, ComboControlUseMode.ObjectCreation, property.PropertyType);

      RecorderOffice selectedRecorderOffice = null;
      if (!property.CadastralOffice.IsEmptyInstance) {
        selectedRecorderOffice = property.CadastralOffice;
      } else {
        selectedRecorderOffice = recordingAct.Recording.RecordingBook.RecorderOffice;
      }

      LRSHtmlSelectControls.LoadRecorderOfficeCombo(this.cboCadastralOffice, ComboControlUseMode.ObjectCreation, selectedRecorderOffice);
      LRSHtmlSelectControls.LoadRecorderOfficeMunicipalitiesCombo(this.cboMunicipality, ComboControlUseMode.ObjectCreation,
                                                                  selectedRecorderOffice, property.Municipality);

      LoadSettlementsCombo();
      LoadRoadsCombo();
      LoadPostalCodesCombo();
      LoadPropertyControls();
    }

    private void LoadPostalCodesCombo() {
      cboPostalCode.Items.Clear();
      ObjectList<GeographicRegionItem> list = new ObjectList<GeographicRegionItem>();
      GeographicItemType postalCodeType = property.PostalCode.GeographicItemType;
      if (property.Settlement.Id > 0) {
        list = property.Settlement.GetRegions("Settlement_PostalCodes", postalCodeType);
      } else if (property.Municipality.Id > 0) {
        list = property.Municipality.GetRegions("Municipality_PostalCodes");
      } else if (property.Municipality.Equals(GeographicRegionItem.Unknown)) {
        // no-op
      } else {
        cboPostalCode.Items.Add(new ListItem("Municipio?", String.Empty));
        return;
      }
      HtmlSelectContent.LoadCombo(cboPostalCode, list, "Id", "Name",
                                  list.Count != 0 ? "( ? )" : "( No def )", String.Empty, GeographicRegionItem.Unknown.Name);
    }

    private void LoadRoadsCombo() {
      cboStreetRoad.Items.Clear();
      ObjectList<GeographicPathItem> list = new ObjectList<GeographicPathItem>();
      GeographicItemType roadType = property.Street.GeographicItemType;
      if (property.Settlement.Id >= 0) {
        list = property.Settlement.GetPaths("Settlement_Paths", roadType);
      } else if (property.Municipality.Id > 0) {
        list = property.Municipality.GetPaths("Municipality_Paths");
      } else if (property.Municipality.Equals(GeographicRegionItem.Unknown)) {
        // no-op
      } else {
        cboStreetRoad.Items.Add(new ListItem("( Primero seleccionar un municipio )", String.Empty));
        return;
      }
      string headerItem = String.Empty;
      if (list.Count != 0) {
        headerItem = "( Seleccionar" + (roadType.FemaleGenre ? " una " : " un ") + roadType.DisplayName.ToLowerInvariant() + " )";
      } else {
        headerItem = "( No hay " + roadType.DisplayPluralName.ToLowerInvariant() + (roadType.FemaleGenre ? " definidas )" : " definidos )");
      }

      HtmlSelectContent.LoadCombo(cboStreetRoad, list, "Id", "Name", headerItem, String.Empty, GeographicRegionItem.Unknown.Name);
    }

    private void LoadSettlementsCombo() {
      cboSettlement.Items.Clear();
      ObjectList<GeographicRegionItem> list = new ObjectList<GeographicRegionItem>();
      GeographicItemType settlementType = property.Settlement.GeographicItemType;
      if (property.Settlement.Id >= 0) {
        list = property.Municipality.GetRegions("Municipality_Settlements", settlementType);
      } else if (property.Municipality.Id > 0) {
        list = property.Municipality.GetRegions("Municipality_Settlements");
      } else if (property.Municipality.Equals(GeographicRegionItem.Unknown)) {
        // no-op
      } else {
        cboSettlement.Items.Add(new ListItem("( Primero seleccionar un municipio )", String.Empty));
        return;
      }
      string headerItem = String.Empty;
      if (list.Count != 0) {
        headerItem = "( Seleccionar" + (settlementType.FemaleGenre ? " una " : " un ") + settlementType.DisplayName.ToLowerInvariant() + " )";
      } else {
        headerItem = "( No hay " + settlementType.DisplayPluralName.ToLowerInvariant() + (settlementType.FemaleGenre ? " definidas )" : " definidos )");
      }
      HtmlSelectContent.LoadCombo(cboSettlement, list, "Id", "Name", headerItem, String.Empty, GeographicRegionItem.Unknown.Name);
    }

    private void LoadPropertyControls() {
      txtCadastralNumber.Value = property.CadastralCode;
      txtTractNumber.Value = property.UniqueCode;
      txtStatus.Value = property.StatusName;
      cboPropertyType.Value = property.PropertyType.Id.ToString();
      txtPropertyCommonName.Value = property.CommonName;
      txtAntecendent.Value = property.Antecedent;
      txtObservations.Value = property.RecordingNotes;
      cboCadastralOffice.Value = property.CadastralOffice.Id.ToString();
      cboMunicipality.Value = property.Municipality.Id.ToString();
      cboSettlementType.Value = property.Settlement.ObjectTypeInfo.Id.ToString();
      cboSettlement.Value = property.Settlement.Id.ToString();
      cboStreetRoadType.Value = property.Street.ObjectTypeInfo.Id.ToString();
      cboStreetRoad.Value = property.Street.Id.ToString();
      cboPostalCode.Value = property.PostalCode.Id.ToString();
      txtUbication.Value = property.UbicationReference;
      txtExternalNumber.Value = property.ExternalNo;
      txtInternalNumber.Value = property.InternalNo;
      txtFractionTag.Value = property.FractionTag;

      if (!propertyEvent.TotalArea.Unit.IsEmptyInstance && !propertyEvent.TotalArea.Unit.Equals(DataTypes.Unit.Unknown)) {
        txtTotalArea.Value = propertyEvent.TotalArea.Amount.ToString("0.#######");
      } else {
        txtTotalArea.Value = String.Empty;
      }
      cboTotalAreaUnit.Value = propertyEvent.TotalArea.Unit.Id.ToString();
      if (!propertyEvent.FloorArea.Unit.IsEmptyInstance && !propertyEvent.FloorArea.Unit.Equals(DataTypes.Unit.Unknown)) {
        txtFloorArea.Value = propertyEvent.FloorArea.Amount.ToString("0.#######");
      } else {
        txtFloorArea.Value = String.Empty;
      }
      cboFloorAreaUnit.Value = propertyEvent.FloorArea.Unit.Id.ToString();
      txtCommonArea.Value = propertyEvent.CommonArea.Amount.ToString("N2");
      if (!propertyEvent.CommonArea.Unit.IsEmptyInstance && !propertyEvent.CommonArea.Unit.Equals(DataTypes.Unit.Unknown)) {
        txtCommonArea.Value = propertyEvent.CommonArea.Amount.ToString("0.####");
      } else {
        txtCommonArea.Value = String.Empty;
      }
      cboCommonAreaUnit.Value = propertyEvent.CommonArea.Unit.Id.ToString();
      txtMetesAndBounds.Value = propertyEvent.MetesAndBounds;
    }

    private void FillPropertyData() {
      property.CadastralCode = txtCadastralNumber.Value;
      if (cboPropertyType.Value.Length != 0) {
        property.PropertyType = PropertyType.Parse(int.Parse(cboPropertyType.Value));
      } else {
        property.PropertyType = PropertyType.Empty;
      }
      property.CommonName = txtPropertyCommonName.Value;
      property.Antecedent = txtAntecendent.Value;
      property.RecordingNotes = txtObservations.Value;

      if (Request.Form[cboMunicipality.ClientID].Length != 0) {
        property.Municipality = GeographicRegionItem.Parse(int.Parse(Request.Form[cboMunicipality.ClientID]));
        property.CadastralOffice = RecorderOffice.Parse(int.Parse(cboCadastralOffice.Value));
      } else {
        property.Municipality = GeographicRegionItem.Empty;
      }
      if (Request.Form[cboSettlement.ClientID].Length != 0) {
        property.Settlement = GeographicRegionItem.Parse(int.Parse(Request.Form[cboSettlement.ClientID]));
      } else {
        property.Settlement = GeographicRegionItem.Empty;
      }
      if (Request.Form[cboStreetRoad.ClientID].Length != 0) {
        property.Street = GeographicPathItem.Parse(int.Parse(Request.Form[cboStreetRoad.ClientID]));
      } else {
        property.Street = GeographicPathItem.Empty;
      }
      if (Request.Form[cboPostalCode.ClientID].Length != 0) {
        property.PostalCode = GeographicRegionItem.Parse(int.Parse(Request.Form[cboPostalCode.ClientID]));
      } else {
        property.PostalCode = GeographicRegionItem.Empty;
      }
      property.UbicationReference = txtUbication.Value;
      property.ExternalNo = txtExternalNumber.Value;
      property.InternalNo = txtInternalNumber.Value;
      property.FractionTag = txtFractionTag.Value;     
    }

    private void FillPropertyEventData() {
      if (cboTotalAreaUnit.Value.Length != 0 && txtTotalArea.Value.Length != 0) {
        propertyEvent.TotalArea = Quantity.Parse(DataTypes.Unit.Parse(int.Parse(cboTotalAreaUnit.Value)), decimal.Parse(txtTotalArea.Value));
      } else {
        propertyEvent.TotalArea = Quantity.Parse(DataTypes.Unit.Empty, 0m);
      }
      if (cboFloorAreaUnit.Value.Length != 0 && txtFloorArea.Value.Length != 0) {
        propertyEvent.FloorArea = Quantity.Parse(DataTypes.Unit.Parse(int.Parse(cboFloorAreaUnit.Value)), decimal.Parse(txtFloorArea.Value));
      } else {
        propertyEvent.FloorArea = Quantity.Parse(DataTypes.Unit.Empty, 0m);
      }
      if (cboCommonAreaUnit.Value.Length != 0 && txtCommonArea.Value.Length != 0) {
        propertyEvent.CommonArea = Quantity.Parse(DataTypes.Unit.Parse(int.Parse(cboCommonAreaUnit.Value)), decimal.Parse(txtCommonArea.Value));
      } else {
        propertyEvent.CommonArea = Quantity.Parse(DataTypes.Unit.Empty, 0m);
      }
      propertyEvent.MetesAndBounds = txtMetesAndBounds.Value;
    }

    #endregion Private methods

  } // class PropertyEditor

} // namespace Empiria.Web.UI.LRS