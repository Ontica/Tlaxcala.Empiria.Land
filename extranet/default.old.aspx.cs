/* Empiria® Land 2014 ****************************************************************************************
*																																																						 *
*	 Solution  : Empiria® Land                                    System   : Land Extranet Application         *
*	 Namespace : Empiria.Web.UI                                   Assembly : Empiria.Land.Extranet.dll         *
*	 Type      : LogonPage										                    Pattern  : Logon Web Page                    *
*	 Date      : 28/Mar/2014                                      Version  : 1.5  License: CC BY-NC-SA 4.0     *
*																																																						 *
*  Summary   : Gets user credentials and redirects users to the workplace start page.                        *
*																																																						 *
**************************************************** Copyright © La Vía Óntica SC + Ontica LLC. 1994-2014. **/
using System;
using Empiria.Land.Registration;
using Empiria.Land.Registration.Transactions;
using Empiria.Presentation.Web;
using Empiria.Presentation.Web.Controllers;

namespace Empiria.Web.UI {

  public partial class OLDLogonPage : WebPage {

    #region Fields

    protected string theClientScript = String.Empty;

    protected bool viewResultFlag = false;
    protected bool isFinished = false;

    #endregion Fields

    #region Public properties

    #endregion Public properties

    #region Event handlers

    private void CreateGuestSessionIfUnauthenticated() {
      if (!IsSessionAlive) {
        GuestLogonController guestLogon = new GuestLogonController();
        if (!guestLogon.Logon()) {
          throw new Security.SecurityException(Empiria.Security.SecurityException.Msg.WrongAuthentication);
        }
      }
    }

    protected override void OnPreLoad(EventArgs e) {
      CreateGuestSessionIfUnauthenticated();
      base.OnPreLoad(e);
    }

    protected void Page_Load(object sender, System.EventArgs e) {
      if (!IsPostBack) {
        SetDefaultValues();
      } else {
        DoPageCommand();
      }
    }

    #endregion Event handlers

    #region Private methods

    private void DoPageCommand() {
      switch (cboOption.Value) {
        case "transaction":
          ShowTransaction();
          return;
        case "property":
          ShowProperty();
          return;
        case "recording":
          ShowRecording();
          return;
        case "book":
          ShowBook();
          return;
        default:
          break;
      }
    }

    private void ShowBook() {

    }

    private void ShowRecording() {

    }

    private void ShowProperty() {
      Property p = Property.ParseWithTractKey(txtPropertyKey.Value);
      if (p != null) {
        RecordingAct r = p.LastRecordingAct;
        theClientScript = @"alert('El predio está registrado en: \n" + r.Recording.FullNumber + ".')";
      } else {
        theClientScript = "alert('No tenemos registrado ningún predio con el folio electrónico proporcionado.')";
      }
    }

    private void ShowTransaction() {
      LRSTransaction t = LRSTransaction.ParseWithNumber(txtTransactionKey.Value);
      if (t != null) {
        lblTransactionState.InnerText = LRSTransaction.StatusName(t.Status);
        if (t.Status == TransactionStatus.Delivered) {
          lblTransactionDelivery.InnerText = t.ClosingTime.ToString("dd/MMM/yyyy");
          isFinished = true;
        } else if (t.Status == TransactionStatus.ToDeliver || t.Status == TransactionStatus.ToReturn) {
          lblTransactionDelivery.InnerText = "Listo para entregarse";
          isFinished = true;
        } else if (t.Status == TransactionStatus.OnSign) {
          lblTransactionDelivery.InnerText = "En dos días hábiles";
        } else {
          lblTransactionDelivery.InnerText = "No determinada";
        }
        viewResultFlag = true;
        cmdSend.Value = "Otra consulta";
      } else {
        lblTransactionState.InnerText = "Trámite no encontrado";
        lblTransactionDelivery.InnerText = String.Empty;
        theClientScript = "alert('No tenemos registrado ningún trámite con el número proporcionado.')";
        viewResultFlag = false;
      }
    }

    private void SetDefaultValues() {

    }

    #endregion Private methods

  } // class LogonPage

} // namespace Empiria.Web.UI