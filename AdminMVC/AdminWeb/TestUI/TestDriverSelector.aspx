<%@ Page Language="C#" AutoEventWireup="true" Inherits="TestUI_TestDriverSelector" Codebehind="TestDriverSelector.aspx.cs" %>

<%@ Register Src="../Controls/DataSelector.ascx" TagName="DataSelector" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        ScheduleID:<asp:TextBox ID="txtScheduleID" runat="server"></asp:TextBox>
        <br />
        SelectedValue:<asp:TextBox ID="txtVal" runat="server"></asp:TextBox><br />
        <asp:Button ID="btnGo" runat="server" Text="Go" OnClick="btnGo_Click" /><br />
        <br />
        <uc1:DataSelector ID="lstDriver" runat="server" DataSourceID="DriverDataset" DataTextField="username" DataValueField="userId" DefaultValue="0" NoSelectPrompt="--Drivers list--" />
        <asp:ObjectDataSource ID="DriverDataset" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetAvalibleDriver" TypeName="com.Omei.BLL.Admin.EmployeeBiz" UpdateMethod="UpdateEmployeeDetail">
            <UpdateParameters>
                <asp:Parameter Name="userLoginInfo" Type="Object" />
                <asp:Parameter Name="original_employeeID" Type="Int32" />
                <asp:Parameter Name="original_userId" Type="Int32" />
                <asp:Parameter Name="employDate" Type="DateTime" />
                <asp:Parameter Name="ssn" Type="String" />
                <asp:Parameter Name="birthday" Type="DateTime" />
                <asp:Parameter Name="roles" Type="String" />
                <asp:Parameter Name="position" Type="String" />
                <asp:Parameter Name="companyId" Type="Int32" />
                <asp:Parameter Name="status" Type="Int32" />
                <asp:Parameter Name="firstName" Type="String" />
                <asp:Parameter Name="lastName" Type="String" />
                <asp:Parameter Name="address" Type="String" />
                <asp:Parameter Name="city" Type="String" />
                <asp:Parameter Name="state" Type="String" />
                <asp:Parameter Name="zip" Type="String" />
                <asp:Parameter Name="country" Type="String" />
                <asp:Parameter Name="homephone" Type="String" />
                <asp:Parameter Name="cellphone" Type="String" />
                <asp:Parameter Name="walkyphone" Type="String" />
                <asp:Parameter Name="email" Type="String" />
            </UpdateParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="txtScheduleID" Name="scheduleID" PropertyName="Text"
                    Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
    
    </div>
    </form>
</body>
</html>
