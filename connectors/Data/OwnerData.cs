/* Empiria Land **********************************************************************************************
*                                                                                                            *
*  Solution  : Empiria Land                                System   : Land System Connectors                 *
*  Namespace : Empiria.Land.Connectors                     Assembly : Empiria.Land.Connectors.dll            *
*  Type      : OwnerData                                   Pattern  : Data Transfer Object                   *
*  Version   : 3.0                                         License  : Please read license.txt file           *
*                                                                                                            *
*  Summary   : Contains cadastral data about a registered real estate owner.                                 *
*                                                                                                            *
************************* Copyright(c) La Vía Óntica SC, Ontica LLC and contributors. All rights reserved. **/
using System;

namespace Empiria.Land.Integration.TlaxcalaGov {

  /// <summary>Contains cadastral data about a registered real estate owner.</summary>
  public class OwnerData {


    public string ApellidoMaterno;


    public string ApellidoPaterno;


    public string Calle;


    public string ClaveMunicipio;


    public string Correo;


    public string Nombre;


    public string Rfc;


  }  // class OwnerData

}  // namespace Empiria.Land.Integration.TlaxcalaGov
