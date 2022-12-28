/* Empiria ***************************************************************************************************
*																																																						 *
*	 Solution  : Empiria Web																			System   : Javascript Core Library					 *
*	 File      : /pngfix.js																				Pattern  : JavaScript Methods Library				 *
*  Version   : 3.0                                              License  : Please read license.txt file      *
*																																																						 *
*  Summary   : Correctly handle PNG transparency in Windows Internet Explorer 5.5 & 6.0											 *
*																																																						 *
********************************** Copyright(c) 1994-2023. La Vía Óntica SC, Ontica LLC and contributors.  **/

// region Public methods

function setPNGTransparency(img) {
	var arVersion = navigator.appVersion.split("MSIE");
	
	if (arVersion[1] == undefined) {
		return;		// not Internet Explorer
	}

	if (img == undefined) {
		return;		// not Internet Explorer
	}
		
	var version = parseFloat(arVersion[1]);
	if ((version >= 5.5 && version < 7.0 ) && (document.body.filters)) {
		//for(var i = 0; i < document.images.length; i++) {
			//var img = document.getElementById(oImage); //divAppIcon document.images[i];
			var imgName = img.src.toLowerCase();
			if (imgName.substring(imgName.length - 3, imgName.length) == "png") {
				 var imgID = (img.id) ? "id='" + img.id + "' " : "";
				 var imgClass = (img.className) ? "class='" + img.className + "' " : "";
				 var imgTitle = (img.title) ? "title='" + img.title + "' " : "title='" + img.alt + "' ";
				 var imgStyle = "display:block;" + img.style.cssText;
				 if (img.align == "left") {
					imgStyle = "float:left;" + imgStyle;
				 }
				 if (img.align == "right") {
					imgStyle = "float:right;" + imgStyle;
				 }
				 if (img.parentElement.href) {
					imgStyle = "cursor:pointer;" + imgStyle;
				 }
				 var strNewHTML = "<span " + imgID + imgClass + imgTitle + " style=\"" +
													"width:" + (img.width != 0 ? img.width : arguments[1]) + "px; height:" + (img.height != 0 ? img.height : arguments[2]) + "px;" +
													imgStyle + "filter:progid:DXImageTransform.Microsoft.AlphaImageLoader" +
													"(src=\'" + img.src + "\', sizingMethod='scale');\"></span>";
				 img.outerHTML = strNewHTML;
			//	 i = i - 1;
			}
		// }
	}	
}

// endregion Public methods
