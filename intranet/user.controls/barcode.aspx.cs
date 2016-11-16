using System;
using System.Drawing;

using C1.Win.C1BarCode;

namespace Empiria.Web.UI {

  public partial class BarCodeControl : System.Web.UI.Page {

    private void Page_Load(object sender, System.EventArgs e) {
      Response.Clear();
      Response.ContentType = "image/gif";
      PrintBarcode();
      Response.End();
    }

    private Image GetBarcode() {
      C1BarCode bc = new C1BarCode();
      bc.CodeType = CodeTypeEnum.Code128;
      bc.Text = Request.QueryString["data"];

      int height = int.Parse(Request.QueryString["height"] ?? "-1");
      if (height > 0) {
        bc.BarHeight = height;
      }

      bool showText = bool.Parse(Request.QueryString["show-text"] ?? "false");
      bc.ShowText = showText;

      //return bc.Image;
      return bc.GetImage(System.Drawing.Imaging.ImageFormat.Gif);
    }

    private void PrintBarcode() {
      Image barcodeImage = this.GetBarcode();

      bool showVertical = bool.Parse(Request.QueryString["vertical"] ?? "false");

      if (showVertical) {
        barcodeImage.RotateFlip(RotateFlipType.Rotate270FlipNone);
      }

      barcodeImage.Save(Response.OutputStream, System.Drawing.Imaging.ImageFormat.Gif);

    }

  } // class CalendarControl

} // namespace Empiria.Web.UI
