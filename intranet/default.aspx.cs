/* Empiria Land **********************************************************************************************
*                                                                                                            *
*  Solution  : Empiria Land                                     System   : Land Intranet Application         *
*  Namespace : Empiria.Web.UI                                   Assembly : Empiria.Land.Intranet.dll         *
*  Type      : LogonPage                                        Pattern  : Logon Web Page                    *
*  Version   : 3.0                                              License  : Please read license.txt file      *
*                                                                                                            *
*  Summary   : Gets user credentials and redirects users to the workplace start page.                        *
*                                                                                                            *
********************************** Copyright(c) 2009-2017. La Vía Óntica SC, Ontica LLC and contributors.  **/
using System;

using Empiria.Presentation.Web.Controllers;
using Empiria.Security;

namespace Empiria.Web.UI {

  public partial class LogonPage : System.Web.UI.Page {

    #region Fields

    private FormsLogonController controller = new FormsLogonController();
    protected string clientScriptCode = String.Empty;

    #endregion Fields

    #region Public properties

    public FormsLogonController Controller {
      get { return controller; }
    }

    #endregion Public properties

    #region Event handlers

    protected void Page_Load(object sender, System.EventArgs e) {
      if (!IsPostBack) {
        SetDefaultValues();
      } else {
        if (String.IsNullOrEmpty(txtUserId.Value)) {
          clientScriptCode = "showAlert('Para efectuar esta operación requiero el identificador de usuario.');";
          return;
        }
        if (String.IsNullOrEmpty(txtPassword.Value)) {
          clientScriptCode = "showAlert('Para efectuar esta operación requiero la contraseña de acceso al sistema.');";

          return;
        }

        if (!TryLogon(txtUserId.Value, txtPassword.Value)) {
          SetDefaultValues();
          txtPassword.Value = String.Empty;
        }
      }
    }

    #endregion Event handlers

    #region Private methods

    private bool TryLogon(string userName, string password) {
      const string clientAppKey = "vQNLXJeCoRPOtINfussrnSabsNs5jaOCRpdEYg5aXIOehqiBIARTgPUwtbrA940Q";

      userName = userName.Trim();
      password = password.Trim();

      string entropy = String.Empty; // Session.SessionID;

      password = Cryptographer.Encrypt(EncryptionMode.EntropyHashCode, password, userName);
      password = Cryptographer.Decrypt(password, userName);

      //password = Cryptographer.GetMD5HashCode(Cryptographer.GetMD5HashCode(password) + entropy);

      return this.Controller.Logon(clientAppKey, userName, password, entropy, 1);
    }

    private void SetDefaultValues() {
      string lastUserName = this.Controller.GetLastAuthenticatedUserName();

      if (!IsPostBack) {
        txtUserId.Value = lastUserName;
      }
      txtAccessCode.Value = "ABCDEFG";
    }

    protected string GetDevelopmentCode() {
      if (Request.Url.ToString().StartsWith("http://jmcota/empiria.land/tlaxcala/intranet/")) {
        return "getElement('txtPassword').value = 's3cur1ty'";
      } else {
        return String.Empty;
      }
    }

    #endregion Private methods

  } // class LogonPage

} // namespace Empiria.Web.UI
