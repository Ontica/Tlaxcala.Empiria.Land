/* Empiria® Land 2014 ****************************************************************************************
*																																																						 *
*	 Solution  : Empiria® Land                                    System   : Land Intranet Application         *
*	 Namespace : Empiria.Web.UI.Ajax                              Assembly : Empiria.Land.Intranet.dll         *
*	 Type      : GeographicData                                   Pattern  : Ajax Services Web Page            *
*	 Date      : 28/Mar/2014                                      Version  : 1.5  License: CC BY-NC-SA 4.0     *
*																																																						 *
*  Summary   : Validates and gets geographic data through Ajax invocation.                                   *
*																																																						 *
**************************************************** Copyright © La Vía Óntica SC + Ontica LLC. 1994-2014. **/
using System;

using Empiria.Geography;
using Empiria.Presentation.Web;
using Empiria.Presentation.Web.Content;

namespace Empiria.Web.UI.Ajax {

  public partial class GeographicData : AjaxWebPage {

    protected override string ImplementsCommandRequest(string commandName) {
      switch (commandName) {
        case "getSettlementIdCmd":
          return GetSettlementIdCommandHandler();
        case "getSettlementsStringArrayCmd":
          return GetSettlementsStringArrayCommandHandler();
        case "getStreetRoadsStringArrayCmd":
          return GetStreetRoadsStringArrayCommandHandler();
        case "getPostalCodesStringArrayCmd":
          return GetPostalCodesStringArrayCommandHandler();
        case "getRegionsStringArrayCmd":
          return GetRegionsStringArrayCommandHandler();
        case "searchSettlementsCmd":
          return SearchSettlementsCommandHandler();
        default:
          throw new WebPresentationException(WebPresentationException.Msg.UnrecognizedCommandName,
                                             commandName);
      }
    }

    #region Private command handlers

    private string GetPostalCodesStringArrayCommandHandler() {
      int municipalityId = int.Parse(GetCommandParameter("municipalityId", false, "0"));
      int settlementId = int.Parse(GetCommandParameter("settlementId", false, "-1"));

      string items = String.Empty;
      if (municipalityId == 0) {
        return HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "Municipio?");
      }
      if (settlementId <= 0) {
        return HtmlSelectContent.GetComboAjaxHtmlItem("-2", GeographicRegionItem.Unknown.Name);
      }
      GeographicRegionItem municipality = GeographicRegionItem.Parse(municipalityId);
      GeographicRegionItem settlement = GeographicRegionItem.Parse(settlementId);

      FixedList<GeographicRegionItem> list = null;
      if (settlement.IsEmptyInstance) {
        list = municipality.GetRegions("Municipality_PostalCodes");
      } else {
        list = settlement.GetRegions("Settlement_PostalCodes");
      }
      if (list.Count != 0) {
        return HtmlSelectContent.GetComboAjaxHtml(list, 0, "Id", "Name", "( ? )", String.Empty, GeographicRegionItem.Unknown.Name);
      } else {
        return HtmlSelectContent.GetComboAjaxHtml("( No def ) ", String.Empty, GeographicRegionItem.Unknown.Name);
      }
    }

    private string GetSettlementsStringArrayCommandHandler() {
      int municipalityId = int.Parse(GetCommandParameter("municipalityId", false, "0"));
      int settlementTypeId = int.Parse(GetCommandParameter("settlementTypeId", false, "310"));

      if (municipalityId == 0) {
        return HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "( Primero seleccionar un municipio )");
      }
      if (municipalityId < 0) {
        return HtmlSelectContent.GetComboAjaxHtmlItem("-2", GeographicPathItem.Unknown.Name);
      }
      GeographicRegionItem municipality = GeographicRegionItem.Parse(municipalityId);
      GeographicItemType settlementType = GeographicItemType.Parse(settlementTypeId);

      FixedList<GeographicRegionItem> list = new FixedList<GeographicRegionItem>();
      list = municipality.GetRegions("Municipality_Settlements", settlementType);

      if (list.Count != 0) {
        string header = "( Seleccionar" + (settlementType.FemaleGenre ? " una " : " un ") + settlementType.DisplayName.ToLowerInvariant() + " )";

        Func<GeographicRegionItem, string> textFunction = (x) => x.Name + " (" + x.ObjectTypeInfo.DisplayName + ")";
        return HtmlSelectContent.GetComboAjaxHtml(list, "Id", textFunction, header, String.Empty, GeographicRegionItem.Unknown.Name);
      } else {
        string header = "( No hay " + settlementType.DisplayPluralName.ToLowerInvariant() + (settlementType.FemaleGenre ? " definidas )" : " definidos )");
        return HtmlSelectContent.GetComboAjaxHtml(header, String.Empty, GeographicRegionItem.Unknown.Name);
      }
    }

    private string GetStreetRoadsStringArrayCommandHandler() {
      int municipalityId = int.Parse(GetCommandParameter("municipalityId", false, "0"));
      int settlementId = int.Parse(GetCommandParameter("settlementId", false, "-1"));
      int streetRoadTypeId = int.Parse(GetCommandParameter("pathTypeId", false, "305"));


      if (municipalityId == 0) {
        return HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "( Primero seleccionar un municipio )");
      }
      if (settlementId <= 0) {
        return HtmlSelectContent.GetComboAjaxHtmlItem("-2", GeographicPathItem.Unknown.Name);
      }

      GeographicRegionItem municipality = GeographicRegionItem.Parse(municipalityId);
      GeographicRegionItem settlement = GeographicRegionItem.Parse(settlementId);
      GeographicItemType pathType = GeographicItemType.Parse(streetRoadTypeId);

      FixedList<GeographicPathItem> list = null;
      if (settlement.IsEmptyInstance) {
        list = municipality.GetPaths("Municipality_Paths", pathType);
      } else {
        list = settlement.GetPaths("Settlement_Paths", pathType);
      }
      if (list.Count != 0) {
        string header = "( Seleccionar" + (pathType.FemaleGenre ? " una " : " un ") + pathType.DisplayName.ToLowerInvariant() + " )";

        Func<GeographicPathItem, string> textFunction = (x) => x.Name + " (" + x.ObjectTypeInfo.DisplayName + ")";

        return HtmlSelectContent.GetComboAjaxHtml(list, "Id", textFunction, header, String.Empty, GeographicPathItem.Unknown.Name);
      } else {
        string header = "( No hay " + pathType.DisplayPluralName.ToLowerInvariant() + (pathType.FemaleGenre ? " definidas )" : " definidos )");

        return HtmlSelectContent.GetComboAjaxHtml(header, String.Empty, GeographicPathItem.Unknown.Name);
      }
    }

    private string GetRegionsStringArrayCommandHandler() {
      string header = GetCommandParameter("header", false, "( Seleccionar )");
      string keywords = GetCommandParameter("keywords", false, String.Empty);

      if (keywords.Length == 0) {
        return HtmlSelectContent.GetComboAjaxHtml(header, String.Empty, GeographicRegionItem.Unknown.Name);
      }
      string filter = SearchExpression.ParseAndLike("GeoItemKeywords", keywords);

      if (filter.Length != 0) {
        filter += " AND ";
      }
      filter += "GeoItemTypeId IN (307, 308, 315, 316, 317, 318, 322)";

      FixedList<GeographicRegionItem> list = GeographicRegionItem.GetList(filter);

      return HtmlSelectContent.GetComboAjaxHtml(list, 0, "Id", "CompoundName", header, String.Empty, GeographicRegionItem.Unknown.Name);
    }

    private string GetSettlementIdCommandHandler() {
      int settlementTypeId = int.Parse(GetCommandParameter("settlementTypeId", true));
      int municipalityId = int.Parse(GetCommandParameter("municipalityId", true));
      string name = GetCommandParameter("name", true);

      GeographicItemType settlementType = GeographicItemType.Parse(settlementTypeId);
      GeographicRegionItem municipality = GeographicRegionItem.Parse(municipalityId);

      GeographicRegionItem result = GeographicItemValidator.SearchSettlement(settlementType, municipality, name);

      if (result.Id != GeographicRegionItem.Empty.Id) {
        return result.Id.ToString();
      }

      return String.Empty;
    }

    private string SearchSettlementsCommandHandler() {
      int municipalityId = int.Parse(GetCommandParameter("municipalityId", true));
      string name = GetCommandParameter("name", true);

      GeographicRegionItem municipality = GeographicRegionItem.Parse(municipalityId);
      FixedList<GeographicRegionItem> list = GeographicItemValidator.SearchSettlements(municipality, name, 0.75m);

      string temp = String.Empty;
      foreach (GeographicRegionItem region in list) {
        string item = region.Id.ToString() + " " + region.Name + " " + region.ObjectTypeInfo.DisplayName;
        item += " (DL " + EmpiriaString.DamerauLevenshteinProximityFactor(region.Name, name).ToString("P2") + " - ME ";
        item += EmpiriaString.MongeElkanProximityFactor(EmpiriaString.DistanceAlgorithm.DamerauLevenshtein, region.Name, name).ToString("P2") + " - J ";
        item += EmpiriaString.JaroProximityFactor(region.Name, name).ToString("P2") + " - JW ";
        item += EmpiriaString.JaroWinklerProximityFactor(region.Name, name).ToString("P2") + ") ";

        temp += item + "|";
      }
      return temp.Trim('|');
    }

    #endregion Private command handlers

  } // class GeographicData

} // namespace Empiria.Web.UI.Ajax
