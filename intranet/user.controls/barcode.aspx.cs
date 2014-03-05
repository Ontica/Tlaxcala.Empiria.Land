using System;
using System.Drawing;

namespace Empiria.Web.UI {

  public partial class BarCodeControl : System.Web.UI.Page {

    private void Page_Load(object sender, System.EventArgs e) {
      Response.Clear();
      PrintBarcode();
      Response.End();

    }

    private Image GetBarcode() {
      C1.Win.C1BarCode.C1BarCode bc = new C1.Win.C1BarCode.C1BarCode();
      bc.CodeType = C1.Win.C1BarCode.CodeTypeEnum.Code128;
      bc.Text = Request.QueryString["data"];
      bc.ShowText = false;

      //return bc.Image;
      return bc.GetImage(System.Drawing.Imaging.ImageFormat.Gif);
    }

    private void PrintBarcode() {
      Image barcodeImage = this.GetBarcode();
      if (!String.IsNullOrEmpty(Request.QueryString["mode"]) && Request.QueryString["mode"] == "vertical") {
        barcodeImage.RotateFlip(RotateFlipType.Rotate90FlipNone);
      }
      //Graphics graphics = System.Drawing.Graphics.FromImage(barcodeImage);
      //graphics.Flush();
      Response.ContentType = "image/gif";
      barcodeImage.Save(Response.OutputStream, System.Drawing.Imaging.ImageFormat.Gif);
      //graphics.Dispose();
      //barcodeImage.Dispose();
    }

  } // class CalendarControl

} // namespace Empiria.Web.UI
