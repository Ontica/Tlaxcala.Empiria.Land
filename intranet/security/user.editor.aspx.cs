﻿/* Empiria Land **********************************************************************************************
*                                                                                                            *
*  Solution  : Empiria Land                                     System   : Land Intranet Application         *
*  Namespace : Empiria.Web.UI.Security                          Assembly : Empiria.Land.Intranet.dll         *
*  Type      : ChangePassword                                   Pattern  : MasterPage View                   *
*  Version   : 3.0                                              License  : Please read license.txt file      *
*                                                                                                            *
*  Summary   : Allows change the current user password.                                                      *
*                                                                                                            *
********************************** Copyright(c) 1994-2017. La Vía Óntica SC, Ontica LLC and contributors.  **/
using System;

using Empiria.Presentation.Web;

using Empiria.Security;

using Empiria.OnePoint.Security.UserManagement.UseCases;

namespace Empiria.Web.UI.Security {

  public partial class UserEditor : WebPage {

    #region Fields

    protected EmpiriaUser user = null;
    protected string grdEntitiesContents = String.Empty;
    protected bool canEditEntitiesGroup = false;
    protected string onDeleteButtonAttrs = String.Empty;
    protected string onChangesButtonAttrs = String.Empty;
    protected string btnAcceptChangesText = String.Empty;
    protected string btnApplyChangesText = String.Empty;
    protected string hdnEntitiesGroupsToInclude = String.Empty;

    #endregion Fields

    protected void Page_Load(object sender, EventArgs e) {
      Initialize();
      if (!IsPostBack) {
        LoadObject();
      } else {
        ExecuteCommand();
      }
    }

    private void Initialize() {
      int userId = int.Parse(Request.QueryString["id"]);
      Assertion.Require(userId != 0, "userId should be greater than zero.");

      user = EmpiriaUser.Parse(userId);
      base.Title = "Editor de Usuarios";
      SetEditorButtons();
    }

    private void ExecuteCommand() {
      string commandName = Request.Form["hdnEmpiriaPageCommandName"];
      string commandArgs = Request.Form["hdnEmpiriaPageCommandArguments"];

      switch (commandName) {
        case "acceptChangesCmd":
          if (ValidateObject()) {
            ChangePassword();
            base.RefreshParent = true;
            base.CloseWindow = true;
          }
          break;
        case "applyChangesCmd":
          if (ValidateObject()) {
            ChangePassword();
            Response.Redirect(Request.Url.PathAndQuery.Replace("id=0", "id=" + user.Id), true);
          }
          break;
        case "cancelEditionCmd":
          base.CloseWindow = true;
          break;
        case "printObjectCmd":
          break;
        case "deleteObjectCmd":
          DeleteObject();
          base.RefreshParent = true;
          base.CloseWindow = true;
          break;
        default:
          break;
      }
    }

    private void LoadObject() {
      txtDisplayName.Value = user.UserName;
      txtObservations.Value = String.Empty;
      txtUserName.Value = user.UserName;
      chkIsActive.Checked = user.IsActive;
      if (user.Id < 0) {      // System user
        txtDisplayName.Disabled = true;
        txtObservations.Disabled = true;
        txtEmail.Disabled = true;
        txtUserName.Disabled = true;
        txtNewPassword.Disabled = true;
        txtNewPassword2.Disabled = true;
        chkIsActive.Disabled = true;
      } else {
        SetFocus(this.txtUserName);
      }
      canEditEntitiesGroup = false; //GetCanEditEntitiesGroupFlag(PagaTodo.Rules.EntityGroup.GetTypeInfo().Id);
      grdEntitiesContents = String.Empty; //GetEntitiesGridContents();
      SetDeleteScript();
    }

    private void SetDeleteScript() {
      string script = String.Empty;

      script = "var sMsg = '';\n";
      script += "sMsg = 'Esta operación eliminará en forma definitiva la cuenta de usuario \\n';\n";
      script += "sMsg += '" + user.UserName + ".\\n\\n';\n";
      script += "sMsg += '¿Procedo con la eliminación de la cuenta de usuario?';\n";
      script += "return confirm(sMsg);\n";

      base.Master.SetDeleteScript(script);
    }

    private bool ValidateObject() {
      txtDisplayName.Value = EmpiriaString.TrimAll(txtDisplayName.Value);
      txtObservations.Value = EmpiriaString.TrimAll(txtObservations.Value);
      txtUserName.Value = EmpiriaString.TrimAll(txtUserName.Value);
      txtNewPassword.Value = EmpiriaString.TrimAll(txtNewPassword.Value);
      txtNewPassword2.Value = EmpiriaString.TrimAll(txtNewPassword2.Value);
      if (txtDisplayName.Value.Length < 6) {
        base.Master.SetOKScriptMsg("El nombre del usuario no puede ser menor de seis caracteres.");
        SetFocus(this.txtDisplayName);
        return false;
      }
      if (txtUserName.Value.Length < 6) {
        base.Master.SetOKScriptMsg("El identificador de usuario no puede ser menor de seis caracteres.");
        SetFocus(this.txtUserName);
        return false;
      }
      if (AlreadyExistsUserName(txtDisplayName.Value)) {
        base.Master.SetOKScriptMsg("Ya existe otro usuario con el mismo nombre de usuario.");
        SetFocus(this.txtDisplayName);
        return false;
      }
      if (AlreadyExistsUserId(txtUserName.Value)) {
        base.Master.SetOKScriptMsg("Ya existe otro usuario con el mismo identificador de usuario.");
        SetFocus(this.txtUserName);
        return false;
      }
      if (1 <= txtNewPassword.Value.Length && txtNewPassword.Value.Length < 8) {
        base.Master.SetOKScriptMsg("La nueva contraseña no puede ser menor de ocho caracteres.");
        SetFocus(this.txtNewPassword);
        return false;
      }
      if (txtNewPassword.Value != txtNewPassword2.Value) {
        base.Master.SetOKScriptMsg("La nueva contraseña y su confirmación no coinciden.");
        SetFocus(this.txtNewPassword);
        return false;
      }
      if (txtUserName.Value != user.UserName && txtNewPassword.Value.Length == 0) {
        base.Master.SetOKScriptMsg("Al cambiar el identificador del usuario, también debe modificarse la contraseña de acceso.");
        SetFocus(this.txtNewPassword);
        return false;
      }
      return true;
    }

    private string GetGridColumn(string columnData, string attributes) {
      string xhtml = "<td {COLUMN.ATTRIBUTES}>{COLUMN.DATA}</td>";

      xhtml = xhtml.Replace("{COLUMN.ATTRIBUTES}", attributes);

      return xhtml.Replace("{COLUMN.DATA}", columnData);
    }

    private void ChangePassword() {
      if (!ValidateObject()) {
        return;
      }
      Assertion.Require(EmpiriaMath.IsMemberOf(base.User.Id, new int[] { 2, 19, 155, 3878 }),
                       "Only system managers can change passwords.");

      var apiKey = "48ebbebb-3409-4c91-a8b9-59fc269cfdec-717ae95719b3bcd064f193af448aaf7e20f8c780a4bcbb0ca4f0edd937ecde5e";
      string userName = txtUserName.Value;
      string password = txtNewPassword.Value;
      string email = txtEmail.Value;

      using (var usecases = UserCredentialsUseCases.UseCaseInteractor()) {
        usecases.CreateUserPassword(apiKey, userName, email, password);
      }
    }

    private void DeleteObject() {

    }

    private void SetEditorButtons() {
      btnAcceptChangesText = "Aceptar";
      btnApplyChangesText = "Aplicar";
    }

    private bool AlreadyExistsUserName(string userName) {
      return false;
    }

    private bool AlreadyExistsUserId(string userId) {
      return false;
    }

    private string GetEntitiesGroupsValues() {
      string controlValue = Request.Form["grdMembersIds"];
      string[] controlValues = Request.Form.GetValues("grdMembersIds");
      string valuesString = String.Empty;

      if (controlValues == null || controlValues.Length == 0) {
        return String.Empty;
      }
      for (int i = 0; i < controlValues.Length; i++) {
        if (String.IsNullOrEmpty(controlValue) || controlValue == "off") {
          // no-op
        } else {
          if (valuesString.Length == 0) {
            valuesString = controlValues[i];
          } else {
            valuesString += "|" + controlValues[i];
          }
        } // if
      } // for
      return valuesString;
    }

  } // class UserEditor

} // namespace Empiria.Web.UI.Storage
