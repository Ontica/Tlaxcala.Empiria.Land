/* Empiria Land **********************************************************************************************
*																																																						 *
*  Solution  : Empiria Land                                     System   : Land Intranet Application         *
*  Namespace : Empiria.Land.WebApp                              Assembly : Empiria.Land.Intranet.dll         *
*  Type      : TasksDashboard                                   Pattern  : Explorer Web Page                 *
*  Version   : 2.0                                              License  : Please read license.txt file      *
*                                                                                                            *
*  Summary   : Multiview dashboard used for workflow task management.                                        *
*																																																						 *
********************************** Copyright(c) 2009-2015. La Vía Óntica SC, Ontica LLC and contributors.  **/
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

using Empiria.Land.Registration;
using Empiria.Land.Registration.Data;
using Empiria.Land.UI;
using Empiria.Presentation;
using Empiria.Presentation.Web;

namespace Empiria.Land.WebApp {

  public partial class RecordingBooksSearchDashboard : MultiViewDashboard {

    #region Fields

    private RecorderOffice selectedRecorderOffice = null;
    private RecordingActTypeCategory selectedRecordingBookClass = null;

    #endregion Fields

    #region Protected methods

    protected void Page_Init(object sender, EventArgs e) {
      selectedRecorderOffice = LRSHtmlSelectControls.ParseRecorderOffice(this, cboRecorderOffice.UniqueID);
      selectedRecordingBookClass = LRSHtmlSelectControls.ParseRecordingActTypeCategory(this, cboRecordingClass.UniqueID);
    }

    public sealed override Repeater ItemsRepeater {
      get { return this.itemsRepeater; }
    }

    protected sealed override bool ExecutePageCommand() {
      switch (base.CommandName) {
        case "updateUserInterface":
          LoadPageControls();
          base.LoadRepeater();
          return true;
        default:
          return false;
      }
    }

    protected sealed override void Initialize() {
      base.LoadInboxesInQuickMode = false;
    }

    protected sealed override DataView LoadDataSource() {
      if (base.SelectedTabStrip == 0) {
        return RecordingBooksData.GetVolumeRecordingBooks(selectedRecorderOffice, RecordingBookStatus.Revision,
                                                          GetRecordingBooksFilter(), "BookNo DESC, BookAsText ASC");
      } else if (base.SelectedTabStrip == 1) {
        if (txtSearchExpression.Value.Length != 0) {
          return IndexesData.FindByParty(selectedRecorderOffice, DateTime.MinValue, DateTime.MaxValue, txtSearchExpression.Value);
        } else {
          return new DataView();
        }
      } else {
        if (txtSearchExpression.Value.Length != 0) {
          return IndexesData.FindByProperty(selectedRecorderOffice, DateTime.MinValue, DateTime.MaxValue, txtSearchExpression.Value);
        } else {
          return new DataView();
        }
      }
    }

    private string GetRecordingBooksFilter() {
      string filter = String.Empty;

      if (!selectedRecordingBookClass.IsEmptyInstance) {
        filter += "[RecordingSectionId] = " + selectedRecordingBookClass.Id.ToString();
      }
      if (txtSearchExpression.Value.Length != 0) {
        if (filter.Length != 0) {
          filter += " AND ";
        }
        filter += "[BookNo] LIKE '%" + txtSearchExpression.Value + "%'";
      }
      if (filter.Length != 0) {
        filter += " AND ";
      }
      filter += "[BookStatus] = 'R'";
      return filter;
    }

    protected sealed override void LoadPageControls() {
      LRSHtmlSelectControls.LoadRecorderOfficeCombo(this.cboRecorderOffice, ComboControlUseMode.ObjectSearch, selectedRecorderOffice);
      LRSHtmlSelectControls.LoadRecordingBookClassesCombo(this.cboRecordingClass, "( Todos )", selectedRecordingBookClass);
    }

    protected sealed override void SetRepeaterTemplates() {
      if (base.SelectedTabStrip == 0) {
        itemsRepeater.HeaderTemplate = Page.LoadTemplate("~/templates/land.registration.system.searching/recording.book.directories.header.ascx");
        if (RecordingBook.UseBookLevel) {
          itemsRepeater.ItemTemplate = Page.LoadTemplate("~/templates/land.registration.system.searching/recording.book.directories.bookLevel.items.ascx");
        } else {
          itemsRepeater.ItemTemplate = Page.LoadTemplate("~/templates/land.registration.system.searching/recording.book.directories.nobookLevel.items.ascx");
        }
        base.PageSize = 50;
        base.ItemsPerRow = 3;
      } else if (base.SelectedTabStrip == 1) {
        itemsRepeater.HeaderTemplate = Page.LoadTemplate("~/templates/land.registration.system.searching/party.search.header.ascx");
        itemsRepeater.ItemTemplate = Page.LoadTemplate("~/templates/land.registration.system.searching/party.search.items.ascx");
      } else {
        itemsRepeater.HeaderTemplate = Page.LoadTemplate("~/templates/land.registration.system.searching/property.search.header.ascx");
        itemsRepeater.ItemTemplate = Page.LoadTemplate("~/templates/land.registration.system.searching/property.search.items.ascx");
      }
    }

    #endregion Protected methods

  } // class RecordingBooksSearchDashboard

} // namespace Empiria.Land.WebApp
