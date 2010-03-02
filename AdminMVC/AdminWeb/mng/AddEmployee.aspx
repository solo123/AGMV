<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="AddEmployee" Title="Untitled Page" Codebehind="AddEmployee.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <span class="head01">新增員工</span>
    <hr />
    <table cellpadding=2 cellspacing=2 class=detail_view width="100%" >
        <tr>
            <td align="right" class="prompt" width="150">
                登錄名:</td>
            <td width="100%">
                <asp:TextBox ID="txtLoginName" runat="server" Width="150px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtLoginName"
                    Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
        </tr>
        <tr>
            <td align="right" class="prompt">
                登錄密碼:</td>
            <td>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Width="150px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtPassword"
                    Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
        </tr>
        <tr>
            <td align="right" class="prompt" nowrap="noWrap">
                重復登錄密碼:</td>
            <td nowrap="noWrap">
                <asp:TextBox ID="txtPassword1" runat="server" TextMode="Password" Width="150px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtPassword1"
                    Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtPassword"
                    ControlToValidate="txtPassword1" Display="Dynamic" ErrorMessage="兩次輸入密碼不一緻" SetFocusOnError="True"></asp:CompareValidator></td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:Button ID="btnAdd" runat="server" Text="新增" OnClick="btnAdd_Click" />
                <asp:Label ID="lbMsg" runat="server" ForeColor="Red"></asp:Label></td>
        </tr>
    </table>

</asp:Content>
