

function showAlert(message, title) {
	var win = $("#alertWindow").data("kendoWindow");
	win.title(title);
	$("#alertWindowMessage").html(message.replace(/\n/g, "<br \>"));
	//win.message(message);
	win.center();
	win.open();
}

(function ($) {
	$.fn.showBubble = function (message) {

		var viewPort = $("#bubbleWindow");
		viewPort.offset({ top: 0, left: 0 });
		viewPort.html(message.replace(/\n/g, "<br \>"));

		var position = $(this).offset();
		position.left = position.left + ($(this).width() / 2) - 40;
		position.top = position.top - viewPort.height() - $(this).height() - 30;
		viewPort.css({ "left": position.left + "px", "top": position.top + "px" });
		//viewPort.offset(position);

		viewPort.html(message.replace(/\n/g, "<br \>"));

		viewPort.css('zIndex', 100);
		viewPort.fadeIn(400);

		viewPort.click(function () {
			viewPort.fadeOut(1200);
		});

		$(this).focus(function () {
			viewPort.fadeOut(1200);
		});

		$(window).resize(function (e) {
			if (isOldInternetExplorer()) {
				return;
			}
			viewPort.fadeOut(1200);
		});

		return $(this);
	}; // showBubble
})(jQuery);

(function ($) {

	$.fn.upperCase = function () {
		$(this).val($(this).val().toUpperCase());
		return $(this);
	}

	$.fn.maskEdit = function (maskRule) {

		$(this).keypress(
				function (e) {
					if (!isAlphaNumericCodeFilter(e.which)) {
						e.preventDefault();
						return;
					}
					//e.stopPropagation();
					//$(this).val($(this).val().toUpperCase());
				}	// function
		); // keypress
		return $(this);

		// #region Private members
		function convertToUppercase(keyCode) {
			if (97 <= keyCode && keyCode <= 122) {
				return keyCode - 32;
			} else if (keyCode == 225) {
				return 193;
			} else if (keyCode == 233) {
				return 201;
			} else if (keyCode == 237) {
				return 205;
			} else if (keyCode == 241) {
				return 209;
			} else if (keyCode == 243) {
				return 211;
			} else if (keyCode == 250) {
				return 218;
			} else if (keyCode == 252) {
				return 220;
			} else {
				return keyCode;
			}
		}

		function isAlphaNumericCodeFilter(keyCode) {
			return (isLetterKeyCode(keyCode) || isNumericKeyCode(keyCode) || keyCode == 45);
		}

		function isLetterKeyCode(keyCode) {
			return ((65 <= keyCode && keyCode <= 90) || (97 <= keyCode && keyCode <= 122) ||
							 (keyCode == 193) || (keyCode == 201) || (keyCode == 205) || (keyCode == 209) ||
							 (keyCode == 211) || (keyCode == 218) || (keyCode == 220) ||
							 (keyCode == 225) || (keyCode == 233) || (keyCode == 237) || (keyCode == 241) ||
							 (keyCode == 243) || (keyCode == 250) || (keyCode == 252));
		}

		function isNumericKeyCode(keyCode) {
			return (48 <= keyCode && keyCode <= 57);
		}

		// #endregion Private members

	}; // maskEdit


})(jQuery);


function isOldInternetExplorer() {
	return (document.all && !document.getElementsByClassName);
}
