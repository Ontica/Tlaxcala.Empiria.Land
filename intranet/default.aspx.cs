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
using Empiria.Json;

namespace Empiria.Web.UI {

  public partial class LogonPage : System.Web.UI.Page {

    #region Fields

    protected string clientScriptCode = String.Empty;

    #endregion Fields

    #region Public properties

    public FormsLogonController Controller {
      get;
    } = new FormsLogonController();

    #endregion Public properties

    #region Protected methods

    protected bool AllowPasswordAutofill() {
      return Request.Url.ToString().StartsWith("http://empiria.land/intranet/");
    }


    protected void Page_Load(object sender, System.EventArgs e) {
      if (!IsPostBack) {
        SetDefaultValues();
      } else {
        if (String.IsNullOrEmpty(txtUserId.Value)) {
          clientScriptCode = "alert('Para efectuar esta operación requiero el identificador de usuario.');";
          return;
        }
        if (String.IsNullOrEmpty(txtPassword.Value)) {
          clientScriptCode = "alert('Para efectuar esta operación requiero la contraseña de acceso al sistema.');";
          return;
        }
        if (!TryLogon(txtUserId.Value, txtPassword.Value)) {
          SetDefaultValues();
          txtPassword.Value = String.Empty;
        }
      }
    }

    #endregion Protected methods

    #region Private methods

    private JsonObject GetContextData() {
      var json = new JsonObject();

      json.Add("UserAddress", Request.UserHostAddress);

      return json;
    }


    private bool TryLogon(string userName, string password) {
      string clientAppKey = ConfigurationData.Get<string>("ApplicationKey");

      userName = userName.Trim();
      password = password.Trim();

      string entropy = String.Empty; // Session.SessionID;

      try {
        password = FormerCryptographer.Encrypt(EncryptionMode.EntropyHashCode, password, userName);
        password = FormerCryptographer.Decrypt(password, userName);

        // password = Cryptographer.GetMD5HashCode(Cryptographer.GetMD5HashCode(password) + entropy);

        JsonObject contextData = GetContextData();
        return this.Controller.Logon(clientAppKey, userName, password, entropy, contextData);

      } catch (System.Threading.ThreadAbortException) {
        return true;

      } catch (Exception e) {
        EmpiriaLog.Error(e);
        throw;

      }
    }


    private void SetDefaultValues() {
      string lastUserName = this.Controller.GetLastAuthenticatedUserName();

      if (!IsPostBack) {
        txtUserId.Value = lastUserName;
      }
      txtAccessCode.Value = "ABCDEFG";
    }


    #endregion Private methods

  } // class LogonPage

} // namespace Empiria.Web.UI
