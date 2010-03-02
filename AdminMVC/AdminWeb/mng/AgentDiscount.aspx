<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="AgentDiscount" Title="Untitled Page" Codebehind="AgentDiscount.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">



<div class="toolbox listButtons">
    <ul>
        <li>
            <asp:LinkButton ID="btnSave" runat="server" OnClick="btnSave_Click">Save</asp:LinkButton>
        </li>
    </ul>
    <asp:Panel ID="pnResult" Visible="false" runat="server"> 
    <asp:Label ID="lbMsg" runat="server" ></asp:Label>
    <hr />
    <asp:Button ID="btnSaveToDB" runat="server" Text="Save!" OnClick="btnSaveToDB_Click" />
    <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" /></asp:Panel>
    <div style="clear:both"></div>
</div>

<asp:GridView ID="lstCompany" runat="server" AllowPaging="True" AllowSorting="True"
    AutoGenerateColumns="False" DataKeyNames="companyId" DataSourceID="CompanyListDataset"
    SkinID="DataList" Width="100%" 
    PageSize="100" >
    <Columns>
        <asp:TemplateField HeaderText="ID" InsertVisible="False" SortExpression="companyId">
            <ItemTemplate>
                <asp:Label ID="lbAgentID" runat="server" Text='<%# Eval("companyId") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Name" SortExpression="companyName">
            <ItemTemplate>
                <asp:Label ID="lbCompanyName" runat="server" Text='<%# Eval("companyName") %>'></asp:Label><br />
                <asp:Label ID="lbCompanyName_cn" runat="Server" Text='<%# Eval("companyName_cn") %>' />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Contact" SortExpression="contactPerson">
            <ItemTemplate>
                <asp:Label ID="lbContact" runat="server" Text='<%# Eval("contactPerson") %>'></asp:Label><br />
                <asp:Label ID="lbTel" runat="Server" Text='<%# Eval("telephone") %>' />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Max Credit" SortExpression="maxCredit">
            <ItemStyle HorizontalAlign="Right" />
            <ItemTemplate>
                <asp:TextBox ID="txtCredit" runat="server" Text='<%# Eval("maxCredit", "{0:N2}") %>' />
                <asp:HiddenField ID="hdCredit" runat="server" Value='<%# Eval("maxCredit") %>' />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Discount%" SortExpression="discount">
            <ItemStyle HorizontalAlign="Right" />
            <ItemTemplate>
                <asp:TextBox ID="txtDiscount" runat="server" Text='<%# Eval("discount", "{0:N2}") %>' />
                <asp:HiddenField ID="hdDiscount" runat="server" Value='<%# Eval("discount") %>' />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="creditBalance" HeaderText="Balance" SortExpression="creditBalance" >
            <ItemStyle HorizontalAlign="right" />
        </asp:BoundField>
    </Columns>
</asp:GridView>

<asp:ObjectDataSource ID="CompanyListDataset" runat="server" OldValuesParameterFormatString="original_{0}"
    SelectMethod="GetAgentCreditList" TypeName="com.Omei.BLL.Admin.AgentBiz" >
</asp:ObjectDataSource>

</asp:Content>

