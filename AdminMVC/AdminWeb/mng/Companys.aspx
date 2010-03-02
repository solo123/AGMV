<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="Companys" Title="Untitled Page" Codebehind="Companys.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="SearchBlock">
    <asp:DropDownList ID="seleCompanyType" runat="server" DataSourceID="CompanyType" DataTextField="listTitle_cn" DataValueField="listValue" AutoPostBack="True">
    </asp:DropDownList>&nbsp;&nbsp;
    <asp:DropDownList ID="seleStatus" runat="server" AutoPostBack="True">
        <asp:ListItem Value="99">--选择状态--</asp:ListItem>
        <asp:ListItem Value="1">有傚</asp:ListItem>
        <asp:ListItem Value="0">無傚</asp:ListItem>
    </asp:DropDownList>
    &nbsp; 查找:<asp:TextBox ID="txtSearch" runat="server"></asp:TextBox>
    <asp:Button ID="btnGo"   runat="server" Text="Go" OnClick="btnGo_Click" />
</div>    


<asp:ObjectDataSource ID="CompanyType" runat="server" OldValuesParameterFormatString="original_{0}"
    SelectMethod="GetValidList" TypeName="com.Omei.DLL.DS_TypeRefTableAdapters.DListTableAdapter">
    <SelectParameters>
        <asp:Parameter DefaultValue="CompanyType" Name="listClass" Type="String" />
    </SelectParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="CompanyListDataset" runat="server" OldValuesParameterFormatString="original_{0}"
    SelectMethod="GetCompanys" TypeName="com.Omei.BLL.Admin.AdminCompanyBiz">
    <SelectParameters>
        <asp:ControlParameter ControlID="seleStatus" Name="status" PropertyName="SelectedValue"
            Type="Int32" DefaultValue="" />
        <asp:ControlParameter ControlID="seleCompanyType" DefaultValue="99" Name="companyType"
            PropertyName="SelectedValue" Type="Int32" />
        <asp:Parameter Name="companyName" Type="String" DefaultValue="" />
    </SelectParameters>
</asp:ObjectDataSource>

<div>
        <asp:GridView ID="lstCompany" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataKeyNames="companyId" DataSourceID="CompanyListDataset"
            SkinID="DataList" Width="100%" OnRowDataBound="lstCompany_RowDataBound" 
            PageSize="100" >
            <Columns>
                <asp:BoundField DataField="companyId" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                    SortExpression="companyId" />
                <asp:BoundField DataField="shortName" HeaderText="Short Name" SortExpression="shortName" />
                <asp:BoundField DataField="companyName" HeaderText="Name" SortExpression="companyName" />
                <asp:BoundField DataField="telephone" HeaderText="Telephone" SortExpression="telephone" />
                <asp:BoundField DataField="contactPerson" HeaderText="Contact person" SortExpression="contactPerson" />
                <asp:TemplateField HeaderText="Type" SortExpression="companyType">
                    <ItemStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# OmeiStatus.GetOmeiStatusText("companyType", Eval("companyType"),"en") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Status" SortExpression="status">
                    <ItemStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# OmeiStatus.GetOmeiStatusText("companyStatus", Eval("status"), "en") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
</div>    
    
</asp:Content>

