<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminPopup.master" AutoEventWireup="true" Inherits="SearchCustomer_pop" Title="Untitled Page" Codebehind="SearchCustomer_pop.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="toolbox">
        <asp:TextBox ID="txtSearch" runat="server" Width="220px" AutoPostBack="True" OnTextChanged="txtSearch_TextChanged"></asp:TextBox>
        <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
        <input type="button" onclick="location.href='UserInfo_pop.aspx?id=0'" value="New" />
        (可使用通配符:* ?)
   <div style="clear:both"></div> </div>
    <div id="CustomerListDiv" class="GenericContent">
        <asp:GridView ID="lstUsers" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataKeyNames="userId" DataSourceID="UserListDataset" Width="100%" PageSize="10"
            SkinID="DataList" OnRowDataBound="lstUsers_RowDataBound">
            <PagerSettings Position="Top" />
            <Columns>
                <asp:TemplateField HeaderText="ID" InsertVisible="False" SortExpression="userId">
                    <ItemStyle HorizontalAlign="Center" Wrap="False" />
                    <ItemTemplate>
                        <asp:Label ID="chkUsers" runat="server" Text='<%# Bind("userId") %>' />
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
            </Columns>
        </asp:GridView>
    </div>
    <asp:ObjectDataSource ID="UserListDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="SearchUser" TypeName="com.Omei.DLL.DS_UserInfoTableAdapters.UserListTableAdapter">
        <SelectParameters>
            <asp:Parameter Name="searchStr" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
