<%@ Page Language="C#" AutoEventWireup="true" Inherits="TestUI_TestHotelSelector" Codebehind="TestHotelSelector.aspx.cs" %>

<%@ Register Src="../WebParts/ScheduleHotelCtl.ascx" TagName="ScheduleHotelCtl" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        schedule:<asp:TextBox ID="txtScheduleId" runat="server" Width="56px"></asp:TextBox>
        nights:<asp:TextBox ID="txtNights" runat="server" Width="53px"></asp:TextBox>
        <asp:Button ID="btnGo" runat="server" Text="Go" OnClick="btnGo_Click" /><br />
        <uc1:ScheduleHotelCtl ID="ScheduleHotelCtl1" runat="server" />
    
    </div>
    </form>
</body>
</html>
