using System;
using System.Collections.Generic;
using System.Web.Mvc;

using Empiria;
using Empiria.Land.Registration;
using Empiria.Land.Registration.Transactions;
using Empiria.Presentation.Web.Content;
using Empiria.Presentation.Web.Controllers;
using Empiria.Security;

namespace EmpiriaWeb.Government.LandRegistration.Controllers {

  [OutputCache(NoStore = true, Duration = 0, VaryByParam = "*")]
  public class HomeController : Controller {

    public bool IsSessionAlive {
      get { return (ExecutionServer.CurrentPrincipal != null); }
    }

    private void CreateGuestSessionIfUnauthenticated() {
      if (!IsSessionAlive) {
        GuestLogonController guestLogon = new GuestLogonController();
        if (!guestLogon.Logon()) {
          throw new SecurityException(SecurityException.Msg.WrongAuthentication);
        }
      }
    }

    #region Public methods

    //
    // GET: /Home/
    public ActionResult Index() {
      CreateGuestSessionIfUnauthenticated();
      return View();
    }

    // GET: /Home/GetLRSTransaction
    public JsonResult GetLRSTransaction(string transactionNumber) {
      CreateGuestSessionIfUnauthenticated();
      var o = LRSTransaction.ParseWithNumber(transactionNumber);
      if (o == null) {
        return null;
      }
      var result = new {
        Id = o.Id.ToString(),
        Key = o.Key,
        RequestedBy = o.RequestedBy,
        Type = o.TransactionType.Name,
        DocumentType = o.DocumentType.Name,
        RecorderOffice = o.RecorderOffice.Alias,
        PresentationTime = o.PresentationTime.ToString("dd/MMM/yyyy HH:mm:ss"),
        ClosingTime = o.ClosingTime.ToString("dd/MMM/yyyy HH:mm"),
        ReceiptTotal = o.ReceiptTotal.ToString("C2"),
        StatusName = LRSTransaction.StatusName(o.Status),
        DeliveryEstimatedDate = GetDeliveryEstimatedDate(o)
      };

      return base.Json(result, JsonRequestBehavior.AllowGet);
    } // GetLRSTransaction


    // GET: /Home/GetRecordingBooks
    public string GetRecordingBooks(int recorderOfficeId, int recordingSectionId) {
      CreateGuestSessionIfUnauthenticated();
      if (recorderOfficeId == 0) {
        return HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "Primero seleccionar un Distrito");
      }
      if (recordingSectionId == 0) {
        return HtmlSelectContent.GetComboAjaxHtmlItem(String.Empty, "( Seleccionar una sección de actos jurídicos )");
      }

      RecorderOffice recorderOffice = RecorderOffice.Parse(recorderOfficeId);
      ObjectList<RecordingBook> recordingBookList = null;

      RecordingSection section = RecordingSection.Parse(recordingSectionId);
      recordingBookList = recorderOffice.GetRecordingBooks(section);
      List<RecordingBook> imagingList = recordingBookList.FindAll((x) => !x.ImagingFilesFolder.IsEmptyInstance);
      if (imagingList.Count != 0) {
        return HtmlSelectContent.GetComboAjaxHtml(imagingList, 0, "Id", "FullName", "( Seleccionar el libro registral donde se encuentra )");
      } else {
        return HtmlSelectContent.GetComboAjaxHtml("No existen libros registrales para el Distrito", String.Empty, String.Empty);
      }
    }

    #endregion Public methods

    #region Private methods

    private string GetDeliveryEstimatedDate(LRSTransaction transaction) {
      if (transaction == null) {
        return "Trámite desconocido o no encontrado";
      }
      if (transaction.Status == TransactionStatus.Delivered) {
        return transaction.ClosingTime.ToString("dd/MMM/yyyy");
      }
      if (transaction.Status == TransactionStatus.ToDeliver || transaction.Status == TransactionStatus.ToReturn) {
        return "Listo para entregarse";
      }
      return "No determinada";
    }  // GetDeliveryEstimatedDate

    #endregion Private methods

  }  // class HomeController

}  // namespace EmpiriaWeb.Government.LandRegistration.Controllers