<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="TourPrice" Title="Untitled Page" Codebehind="TourPrice.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<table>
    <tr>
        <td>
    <asp:DropDownList ID="selectTourType" runat="server" AutoPostBack="True">
        <asp:ListItem Value="0">請選擇類型</asp:ListItem>
        <asp:ListItem Value="1">巴士團</asp:ListItem>
        <asp:ListItem Value="2">飛機團</asp:ListItem>
        <asp:ListItem Value="3">遊輪</asp:ListItem>
    </asp:DropDownList>        
        </td>
        <td>
            <asp:CheckBox ID="cbShowOnWeb" runat="server" Text="Show All" Checked="false" AutoPostBack="true" />
        </td>
    </tr>
</table>
    

    <hr />

    <asp:GridView ID="lstTourList" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" DataKeyNames="TourID" DataSourceID="TourListDataset"
        SkinID="DataList" Width="100%" AutoGenerateEditButton="True" PageSize="20">
        <Columns>
            <asp:BoundField DataField="TourID" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                SortExpression="TourID" >
                <ItemStyle Font-Bold="True" HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Name" SortExpression="TourName">
                <ItemTemplate>
                    <asp:Label ID="lbTourName" runat="server" Text='<%# Eval("TourName") %>'></asp:Label><br />
                    <asp:Label ID="lbTourName_cn" runat="server" Text='<%# Eval("TourName_cn") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="時間" SortExpression="TourDay">
                <ItemStyle Wrap="False" HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Literal ID="lbDay" runat="server" Text='<%# Eval("TourDay") %>'></asp:Literal>
                    Days
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Price-Adult" SortExpression="priceAdult">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("priceAdult") %>' Width="60px"></asp:TextBox>
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
                <HeaderStyle HorizontalAlign="Right" />
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("priceAdult") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Price-Child" SortExpression="priceChild">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("priceChild") %>' Width="60px"></asp:TextBox>
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
                <HeaderStyle HorizontalAlign="Right" />
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("priceChild") %>' ></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Type" SortExpression="tourType">
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# OmeiStatus.GetOmeiStatusText("TourType",Eval("tourType"),"en") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Status" SortExpression="status">
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# OmeiStatus.GetOmeiStatusText("TourStatus",Eval("status"),"en") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <asp:ObjectDataSource ID="TourListDataset" runat="server"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetTourList" TypeName="com.Omei.BLL.Admin.AdminTourBiz" UpdateMethod="UpdateTourPrice">
        <SelectParameters>
            <asp:ControlParameter ControlID="selectTourType" DefaultValue="0" Name="tourType"
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cbShowOnWeb" DefaultValue="0" Name="showOnWeb"
                PropertyName="Checked" Type="Boolean" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Original_TourID" Type="Int32" />
            <asp:Parameter Name="priceAdult" Type="Decimal" />
            <asp:Parameter Name="priceChild" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
</asp:Content>

