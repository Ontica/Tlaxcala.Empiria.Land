<%@ Page language="c#" AutoEventWireup="false" Inherits="Empiria.Web.UI.CalendarControl" Codebehind="calendar.aspx.cs" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
		<title>Calendario</title>
		<script type="text/javascript" src="../scripts/empiria.general.js"></script>
		<script type="text/javascript" language="javascript">
    <!--

			function setDate(value) {
				getElement('txtDate').value = value;
        document.forms[0].action = "calendar.aspx?changed=true"; 
				getElement('divCalendar').style.visibility = "hidden";
        document.forms[0].submit();
      }

      function on_calendar_date_selected(value) {        
        window.parent.execScript("on_calendar_date_selected('" + value + "')");
      }
      
      function on_calendar_lost_focus() {        
        window.parent.execScript("on_calendar_lost_focus()");
      }
                 
      function on_calendar_resize() {
        var oBody	=	document.body;        
        var x = oBody.scrollWidth + (oBody.offsetWidth - oBody.clientWidth) + 1;
        var y = oBody.scrollHeight + (oBody.offsetHeight - oBody.clientHeight) + 1;
        
        window.parent.execScript("on_calendar_resize(" + x + ", " + y + ")");
      }
      
      function window_onload() {
        <% if (!isVisible) { %>
      		getElement('divCalendar').style.visibility = "hidden";
      	<% } %>
      	document.forms[0].action = "calendar.aspx";
        <% if (selectedValue.Length != 0) { %>
          on_calendar_date_selected('<%=selectedValue%>');
        <% } %>
        on_calendar_resize();
      }      
    //-->
		</script>
	</head>
	<body style="FONT-SIZE: 8pt; Z-INDEX: 100; COLOR: #191970; FONT-FAMILY: Arial, Helvetica; BACKGROUND-COLOR: #ffffef; TEXT-DECORATION: none" onload="window_onload();" onblur="on_calendar_lost_focus();">
		<form id="frmEditor" method="post" runat="server">
			<div id="divCalendar">
				<asp:Calendar id="objCalendar" style="FONT-SIZE: 8pt; Z-INDEX: 100; LEFT: 0px; COLOR: #330066; FONT-FAMILY: Arial, Helvetica; POSITION: absolute; TOP: 0px; TEXT-DECORATION: none" runat="server" Visible="true" TodayDayStyle-BackColor="#faebd7" SelectedDayStyle-BackColor="#e9967a" SelectedDayStyle-ForeColor="#191970" TitleStyle-Font-Size="8pt" TitleStyle-Wrap="false" TitleStyle-BackColor="#191970" TitleStyle-ForeColor="#ffffff" BorderStyle="Solid" TitleStyle-VerticalAlign="Middle" NextPrevStyle-ForeColor="#ffffff" NextPrevFormat="ShortMonth" BorderColor="Gray" BorderWidth="1px" NextMonthText=" ">
					<TodayDayStyle Font-Italic="True" Font-Bold="True" BackColor="BlanchedAlmond"></TodayDayStyle>
					<SelectorStyle BorderStyle="None"></SelectorStyle>
					<DayStyle ForeColor="MidnightBlue"></DayStyle>
					<NextPrevStyle ForeColor="MidnightBlue"></NextPrevStyle>
					<DayHeaderStyle ForeColor="MidnightBlue"></DayHeaderStyle>
					<SelectedDayStyle ForeColor="White" BackColor="MidnightBlue"></SelectedDayStyle>
					<TitleStyle Font-Size="8pt" Wrap="False" BorderWidth="1px" ForeColor="MidnightBlue" BorderStyle="Solid" VerticalAlign="Middle" BackColor="#b0c4de"></TitleStyle>
					<WeekendDayStyle Font-Italic="True" BackColor="Cornsilk"></WeekendDayStyle>
					<OtherMonthDayStyle ForeColor="Tan"></OtherMonthDayStyle>
				</asp:Calendar>
				<input id="txtDate" style="Z-INDEX: 102; LEFT: 4px; WIDTH: 12px; POSITION: absolute; TOP: 4px; HEIGHT: 22px" type="hidden" name="txtDate" runat="server" />
			</div>
		</form>
	</body>
</html>
