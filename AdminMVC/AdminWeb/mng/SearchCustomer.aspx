<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="SearchCustomer" Title="Untitled Page" Codebehind="SearchCustomer.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class=toolbox>
        <asp:TextBox ID="txtSearch" runat="server" Width="120px"></asp:TextBox>
            
        <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
        <input type=button onclick="location.href='UserInfo.aspx?id=0'" value="New" /> &nbsp;&nbsp;
        通配符: <b>*</b> (匹配多个字符)或 <b>?</b> (匹配一个字符)
    <div style="clear:both"></div></div>
    
    <div id="CustomerListDiv" class="GenericContent">
    <asp:GridView ID="lstUsers" runat="server" AllowPaging="True" AutoGenerateColumns="False"
        DataKeyNames="userId" DataSourceID="UserListDataset" Width="100%" PageSize="100" SkinID="DataList" 
        OnRowDataBound="lstUsers_RowDataBound" OnDataBound="lstUsers_DataBound">
        <Columns>
            <asp:TemplateField HeaderText="ID" InsertVisible="False" SortExpression="userId">
                <ItemStyle HorizontalAlign="Center" Wrap=False />
                <ItemTemplate>
                    <asp:CheckBox ID="chkUsers" runat="server" Text='<%# Bind("userId") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Name" SortExpression="firstName,lastName">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("firstName") %>'></asp:Label>.
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("lastName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Tel" SortExpression="homePhone">
                <ItemTemplate>
                    <span title='Home:<%# Eval("homePhone") %>&#13;Cell:<%# Eval("cellPhone") %>&#13;Walky:<%# Eval("walkyPhone") %>'>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("homePhone") %>'></asp:Label>,
                    <asp:Label ID="Label5" runat="server" Text='<%# Eval("cellPhone") %>'></asp:Label>,
                    <asp:Label ID="Label6" runat="server" Text='<%# Eval("walkyPhone") %>'></asp:Label>
                    </span>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="email" SortExpression="email">
                <ItemTemplate>
                    <span title='Address:<%# Eval("address") %>&#13;City:<%# Eval("city") %>&#13;State:<%# Eval("state") %>(<%# Eval("zip") %>)&#13;Country:<%# Eval("country") %>'>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("email") %>'></asp:Label>
                    </span>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Status" SortExpression="status">
                <ItemTemplate>
                    <asp:Label ID="Label7" runat="server" Text='<%# OmeiStatus.GetOmeiStatusText("UserStatus",Eval("status"),"en") %>' onclick='<%# EditPageUrl(Eval("userId")) %>' ></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    </div>
    
    <div class="toolbox listButtons">
        <ul>
            <li>
                <asp:Button ID="btnDelUsers" runat="server" Text="Del" OnClick="btnDelUsers_Click" />
                <asp:Button ID="btnUndel" runat="Server" Text="Undel" OnClick="btnUndel_Click" />
                <asp:Label ID="lbMsg" runat="server" Text="" ForeColor=darkgreen></asp:Label></li></ul>
    <div style="clear:both"></div></div>
    
    <asp:ObjectDataSource ID="UserListDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="SearchUser" TypeName="com.Omei.BLL.Admin.AdminUserBiz">
        <SelectParameters>
            <asp:Parameter Name="searchText" Type="String" ConvertEmptyStringToNull="false" />
        </SelectParameters>
    </asp:ObjectDataSource>

</asp:Content>



