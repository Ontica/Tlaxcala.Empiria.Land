/* Empiria Land **********************************************************************************************
*                                                                                                            *
*  Solution  : Empiria Land                                System   : Land System Connectors                 *
*  Namespace : Empiria.Land.Connectors                     Assembly : Empiria.Land.Connectors.dll            *
*  Type      : CadastralData                               Pattern  : Data Transfer Object                   *
*  Version   : 3.0                                         License  : Please read license.txt file           *
*                                                                                                            *
*  Summary   : Contains cadastral data about a registered real estate.                                       *
*                                                                                                            *
********************************* Copyright (c) 2009-2017. La Vía Óntica SC, Ontica LLC and contributors.  **/
using System;

namespace Empiria.Land.Integration.TlaxcalaGov {

  /// <summary>Contains cadastral data about a registered real estate.</summary>
  public class CadastralData {

    #region Constructors and parsers


    public CadastralData() {

    }


    static public CadastralData Empty { get; } = new CadastralData() {
      IsEmptyInstance = true
    };


    public bool IsEmptyInstance {
      get;
      private set;
    } = false;


    #endregion Constructors and parsers

    #region Properties


    public string ClaveCatastral;


    public string ClaveCatastralHistorica;


    public string ClaveLocalidad;


    public string ClaveManzana;


    public string ClaveMunicipio;


    public string ClavePredial;


    public string ClavePredialHistorica;


    public string ClaveRegion;


    public string ClaveSector;


    public string ClaveZona;


    public OwnerData[] Propietario;

    #endregion Properties

  }  // class CadastralData

} // namespace EEmpiria.Land.Integration.TlaxcalaGov
