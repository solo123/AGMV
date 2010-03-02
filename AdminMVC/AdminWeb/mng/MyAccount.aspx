<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="MyAccount" Title="Untitled Page" Codebehind="MyAccount.aspx.cs" %>
<%@ Register Src="../Controls/DateInputCtl.ascx" TagName="DateInputCtl" TagPrefix="uc4" %>
<%@ Register Src="../Controls/TypeMultiSelector.ascx" TagName="TypeMultiSelector" TagPrefix="uc3" %>
<%@ Register Src="../Controls/DataSelector.ascx" TagName="DataSelector" TagPrefix="uc2" %>
<%@ Register Src="../Controls/CountrySelector.ascx" TagName="CountrySelector" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="toolbox listButtons">
        <ul>
            <li>
                <asp:LinkButton ID="btnSave" OnClick="btnSave_Click" runat="server" Enabled='<%# PageLogic.CheckActionAuth("auth_EmployeeEdit") %>'>保存</asp:LinkButton></li><li><asp:Label ID="txtToolMessage" runat="server" ForeColor="Red"></asp:Label></li><li><asp:HyperLink ID="lnkChgPwd" Text="修改密码" runat=server Enabled='<%# PageLogic.CheckActionAuth("ASP.ChangeSignIn_aspx") %>' /></li></ul>
    <div style="clear:both"></div></div>
            
    <asp:FormView ID="fvEmployee" runat="server" DefaultMode="Edit" Width="100%" DataSourceID="EmployeeDataset" DataKeyNames="employeeID,userId">
        <EditItemTemplate>
            <table style="width: 100%">
                <tr>
                    <td>
                        登錄名:</td>
                    <td>
                        <asp:Label ID="txtLoginName" runat="server" Text='<%# Eval("loginName") %>'></asp:Label>&nbsp;&nbsp;
                    </td>
                    <td>Display name:</td>
                    <td>
                        <asp:TextBox ID="txtNickname" runat="server" Text='<%# Bind("nickname") %>'></asp:TextBox></td>
                    
                </tr>
                <tr>
                    <td>
                        First Name:</td><td><asp:TextBox ID="txtFirstName" runat="server" Width="100px" Text='<%# Bind("firstName") %>'></asp:TextBox></td>
                    <td>
                        Last Name:</td><td><asp:TextBox ID="txtLastName" runat="server" Width="100px" Text='<%# Bind("lastName") %>'></asp:TextBox></td>
                </tr>
                <tr>
                    <td>
                        SSN:</td>
                    <td>
                        <asp:TextBox ID="txtSSN" runat="server" Text='<%# Bind("ssn") %>'></asp:TextBox></td>
                    <td>
                        公司名稱:</td>
                    <td>    
                        <uc2:DataSelector ID="lstCompany" runat="server" DefaultValue="0" DataSourceID="CompanyDataset"
                            DataTextField="companyName_cn" DataValueField="companyId" SelectedValue='<%# Bind("companyId") %>' />
                        
                    </td>
                </tr>
                <tr>
                    <td>
                        生日:</td>
                     <td><uc4:DateInputCtl ID="DateInputCtl1" runat="server" DateValue='<%# Bind("birthday") %>' />
                    </td>
                    <td>
                        加入公司日期:</td><td><uc4:DateInputCtl ID="DateInputCtl2" runat="server" DateValue='<%# Bind("employDate") %>' />
                    </td>
                </tr>
                <tr>
                    <td>
                        Email:</td>
                    <td colspan=3>
                        <asp:TextBox ID="txtEmail" runat="server" Width="240px" Text='<%# Bind("email") %>'></asp:TextBox></td>
                </tr>
                <tr>
                    <td colspan="4">
                        <table cellspacing="2">
                            <tr>
                                <td colspan="3">
                                    地阯:<asp:TextBox ID="txtAddress" runat="server" Width="457px" Text='<%# Bind("address") %>'></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td style="white-space: nowrap;">
                                    City:<asp:TextBox ID="txtCity" runat="server" Width="103px" Text='<%# Bind("city") %>'></asp:TextBox></td>
                                <td style="white-space: nowrap;">
                                    State:<asp:TextBox ID="txtState" runat="server" Width="81px" Text='<%# Bind("state") %>'></asp:TextBox></td>
                                <td style="white-space: nowrap;">
                                    ZIP:<asp:TextBox ID="txtZIP" runat="server" Width="102px" Text='<%# Bind("zip") %>'></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td colspan=3>Country:<uc1:CountrySelector ID="lstCountry" runat="server" Lang="cn" CountryCode='<%# Bind("country") %>' /></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <table width="100%">
                            <tr>
                                <td nowrap="noWrap">
                                    聯繫電話:<asp:TextBox ID="txtHomePhone" runat="server" Width="140px" Text='<%# Bind("homephone") %>'></asp:TextBox></td>
                                <td nowrap="noWrap">
                                    移動電話:<asp:TextBox ID="txtCellPhone" runat="server" Width="140px" Text='<%# Bind("cellphone") %>'></asp:TextBox></td>
                                <td nowrap="noWrap">
                                    Walky:<asp:TextBox ID="txtWalky" runat="server" Width="140px" Text='<%# Bind("walkyphone") %>'></asp:TextBox></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <hr />
                        用戶角色:<asp:Label ID="Label1" runat="server" Text='<%# ShowRoles(Eval("employeeID")) %>'></asp:Label>
                        <br />
                        用戶職位:<asp:Label ID="Label2" runat="server" Text='<%# ShowPositions(Eval("employeeID")) %>'></asp:Label>
                    </td>
                </tr>
            </table>        
        </EditItemTemplate>
    </asp:FormView>
    
    <asp:ObjectDataSource ID="EmployeeDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetEmployeeDetail" TypeName="com.Omei.BLL.Admin.EmployeeBiz" UpdateMethod="UpdateMyAccount">
        <UpdateParameters>
            <asp:Parameter Name="userLoginInfo" Type="Object" />
            <asp:Parameter Name="original_employeeID" Type="Int32" />
            <asp:Parameter Name="original_userId" Type="Int32" />
            <asp:Parameter Name="employDate" Type="DateTime" />
            <asp:Parameter Name="ssn" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="birthday" Type="DateTime" />
            <asp:Parameter Name="companyId" Type="Int32" />
            <asp:Parameter Name="firstName" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="lastName" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="nickname" Type="String" ConvertEmptyStringToNull=false />
            <asp:Parameter Name="address" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="city" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="state" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="zip" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="country" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="homephone" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="cellphone" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="walkyphone" Type="String" ConvertEmptyStringToNull=False />
            <asp:Parameter Name="email" Type="String" ConvertEmptyStringToNull=False />
        </UpdateParameters>

        <SelectParameters>
            <asp:Parameter Name="employeeID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    
    <asp:ObjectDataSource ID="CompanyDataset" runat="server" SelectMethod="GetCompanyNameList"
        TypeName="com.Omei.DLL.DS_CompanysTableAdapters.CompanyNameListTableAdapter"
        OldValuesParameterFormatString="original_{0}">
        <SelectParameters>
            <asp:Parameter DefaultValue="2" Name="companyType" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>

</asp:Content>

