using System;
using System.Linq;
using System.Web.UI.WebControls;

using Empiria.DataTypes;
using Empiria.Land.Registration;
using Empiria.Land.Registration.Data;
using Empiria.Presentation.Web.Content;

namespace Empiria.Land.WebApp {

  public partial class RecordingPartyEditorControl : System.Web.UI.UserControl {

    #region Fields

    private RecordingAct recordingAct = null;
    private Party party = null;
    protected bool isLoaded = false;

    #endregion Fields

    #region Public properties

    public bool IsPartyInRecordingAct {
      get { return true; }
    }

    public Party Party {
      get { return party; }
      set { party = value; }
    }

    public RecordingAct RecordingAct {
      get { return recordingAct; }
      set { recordingAct = value; }
    }

    #endregion Public properties

    #region Public methods

    public void LoadEditor() {
      LoadMainCombos();
    }

    private void LoadMainCombos() {
      FixedList<RecordingActParty> parties = PartyData.GetInvolvedDomainParties(this.recordingAct);
      LoadRolesCombo(parties);
      LoadFirstPartyInRoleCombo(parties);
    }

    private void LoadFirstPartyInRoleCombo(FixedList<RecordingActParty> parties) {
      cboFirstPartyInRole.Items.Clear();
      parties.Sort((x, y) => x.Party.FullName.CompareTo(y.Party.FullName));

      cboFirstPartyInRole.Items.Add(new ListItem("( Seleccionar una persona u organización )", String.Empty));
      foreach (RecordingActParty item in parties) {
        if (item.Party.Equals(this.party)) {
          continue;
        }
        ListItem listItem = new ListItem(item.Party.FullName, item.Party.Id.ToString());
        if (!cboFirstPartyInRole.Items.Contains(listItem)) {
          cboFirstPartyInRole.Items.Add(listItem);
        }
      }

      parties = PartyData.GetSecondaryPartiesList(this.recordingAct);

      parties.Sort((x, y) => x.PartyOf.FullName.CompareTo(y.PartyOf.FullName));
      foreach (RecordingActParty item in parties) {
        if (item.PartyOf.Equals(this.party)) {
          continue;
        }
        ListItem listItem = new ListItem(item.PartyOf.FullName, item.PartyOf.Id.ToString());
        if (!cboFirstPartyInRole.Items.Contains(listItem)) {
          cboFirstPartyInRole.Items.Add(listItem);
        }
      }
      if (cboFirstPartyInRole.Items.Count > 2) {
        cboFirstPartyInRole.Items.Add(new ListItem("( Selección múltiple )", "multiselect"));
      }
    }

    protected string GetMultiselectListItems(System.Web.UI.HtmlControls.HtmlSelect control, string controlName) {
      const string row = "<tr><td><input id='{CONTROL.ID}' name='{CONTROL.NAME}' type='checkbox' value='{ITEM.VALUE}' /></td>" +
                         "<td id='{ITEM.NAME.ID}' style='white-space:normal;width:98%'>{ITEM.NAME}</td></tr>";
      string html = String.Empty;
      foreach (ListItem item in control.Items) {
        if (EmpiriaString.IsInteger(item.Value) && (int.Parse(item.Value) > 0)) {
          string temp = row.Replace("{ITEM.VALUE}", item.Value);
          temp = temp.Replace("{ITEM.NAME}", item.Text);
          temp = temp.Replace("{ITEM.NAME.ID}", controlName + "_text_" + item.Value);
          temp = temp.Replace("{CONTROL.ID}", controlName + "_" + item.Value);
          temp = temp.Replace("{CONTROL.NAME}", controlName);
          html += temp;
        }
      }
      return html;
    }

    private void LoadRolesCombo(FixedList<RecordingActParty> parties) {
      this.cboRole.Items.Clear();

      HtmlSelectContent.LoadCombo(this.cboRole, this.recordingAct.RecordingActType.GetRoles(), "Id", "Name", "( Seleccionar rol )");

      if (parties.Count != 0) {
        HtmlSelectContent.LoadCombo<Party>(cboUsufructuaryOf, parties.Select((x) => x.Party), (x) => x.Id.ToString(),
                                           (x) => x.FullName, "( Seleccionar al nudo propietario )");
        if (cboUsufructuaryOf.Items.Count > 2) {
          cboUsufructuaryOf.Items.Add(new ListItem("( Selección múltiple )", "multiselect"));
        }
      }

      this.cboRole.Items.Add(new ListItem("( Secundarios )", String.Empty));
      HtmlSelectContent.AppendToCombo(this.cboRole, SecondaryPartyRole.GetList(), "Id", "Name");
    }

    private Party FillOrganizationParty() {
      if (this.Party == null) {
        this.Party = new OrganizationParty(int.Parse(cboPartyType.Value), txtOrgName.Value);
        //this.Party.UID = txtOrgTaxIDNumber.Value;
      }
      this.Party.Save();

      return this.Party;
    }

    private Party FillHumanParty() {
      if (this.Party == null) {
        this.Party = new HumanParty(txtPersonFullName.Value);
        //this.Party.UID = txtIDNumber.Value;
      }
      this.Party.Save();

      return this.Party;
    }

    private void UpdateRecordingActParty(RecordingActParty rap) {
      rap.Notes = txtNotes.Value;
      rap.Save();
    }

    private void FillHumanPartyOnRecording() {
      FixedList<RecordingActParty> list = PartyData.GetRecordingPartyList(this.RecordingAct.Document, this.Party);
      foreach (RecordingActParty rap in list) {
        if ((rap.Party.Equals(this.Party) && rap.PartyOf.IsEmptyInstance) || rap.PartyOf.Equals(this.Party)) {
          UpdateRecordingActParty(rap);
        }
      }
    }

    private void LoadHumanParty() {
      HumanParty person = (HumanParty) this.Party;

      cboPartyType.Value = person.GetEmpiriaType().Id.ToString();

      txtBornDate.Value = String.Empty;
      txtPersonFullName.Value = person.FullName;
      txtIDNumber.Value = person.UID;
      isLoaded = true;
    }

    private void LoadOrganizationParty() {
      OrganizationParty org = (OrganizationParty) this.Party;

      cboPartyType.Value = org.GetEmpiriaType().Id.ToString();
      txtOrgName.Value = org.FullName;
      txtOrgTaxIDNumber.Value = org.UID;
      isLoaded = true;
    }

    public void SelectParty(int partyId) {
      this.Party = Party.Parse(partyId);
      if (this.Party.GetEmpiriaType().Id == 2435) {
        LoadHumanParty();
      } else {
        LoadOrganizationParty();
      }
      cboParty.Items.Clear();
      cboParty.Items.Add(new ListItem(this.Party.ExtendedName, this.Party.Id.ToString()));

      FixedList<RecordingActParty> parties = PartyData.GetInvolvedDomainParties(this.recordingAct);

      LoadRolesCombo(parties);
      LoadFirstPartyInRoleCombo(parties);
    }

    private void FillPartyData(RecordingActParty rap) {
      if (this.party is HumanParty) {
        rap.Notes = txtNotes.Value;
      }
    }

    public void SaveParty(int partyId) {
      this.Party = Party.Parse(partyId);
      if (this.Party.GetEmpiriaType().Id == 2435) {
        this.Party = FillHumanParty();
        if (IsPartyInRecordingAct) {
          FillHumanPartyOnRecording();
        }
      } else {
        this.Party = FillOrganizationParty();
      }
    }

    public void SaveRecordingParty() {
      string selectedParty = Request.Form[cboParty.Name];
      if (String.IsNullOrWhiteSpace(selectedParty)) {
        //this.party = FillNewParty();
      } else if (selectedParty == "appendParty") {
        if (cboPartyType.Value == "2435") {
          this.party = FillHumanParty();
        } else {
          this.party = FillOrganizationParty();
        }
      } else {
        this.party = Party.Parse(int.Parse(selectedParty));
      }
      SaveRecordingActParty();
    }

    private void SaveRecordingActParty() {
      string selectedRole = Request.Form[cboRole.Name];

      var role = BasePartyRole.Parse(int.Parse(selectedRole));
      if (role is DomainActPartyRole) {
        SaveDomainRoleParty();
      } else {
        SaveSecondaryRoleParty();
      }
    }

    private void SaveDomainRoleParty() {
      var role = (DomainActPartyRole) BasePartyRole.Parse(int.Parse(Request.Form[cboRole.Name]));

      RecordingActParty rap = RecordingActParty.Create(this.RecordingAct, this.party, role);

      if (txtOwnershipPartAmount.Value.Length == 0) {
        txtOwnershipPartAmount.Value = "1.00";
      }
      rap.OwnershipPart = Quantity.Parse(DataTypes.Unit.Parse(cboOwnershipPartUnit.Value),
                                         decimal.Parse(txtOwnershipPartAmount.Value));
      FillPartyData(rap);

      rap.Save();
    }

    private void SaveSecondaryRoleParty() {
      string[] selectedParties = null;
      if (Request.Form[cboFirstPartyInRole.Name] == "multiselect") {
        selectedParties = Request.Form[hdnMultiPartiesInRole.Name].Split('|');
      } else {
        selectedParties = new string[] { Request.Form[cboFirstPartyInRole.Name] };
      }
      foreach (string selectedParty in selectedParties) {
        var role = (SecondaryPartyRole) BasePartyRole.Parse(int.Parse(Request.Form[cboRole.Name]));
        var rap = RecordingActParty.Create(this.RecordingAct,
                                           this.party, role, Party.Parse(int.Parse(selectedParty)));

        FillPartyData(rap);

        rap.Save();
      }
    }

    #endregion Public methods

  } // class RecordingPartyEditorControl

} // namespace Empiria.Land.WebApp
