<%@ Control Language="C#" AutoEventWireup="true" Inherits="WebParts_TourFeeCtl" Codebehind="TourFeeCtl.ascx.cs" %>

<asp:GridView ID="lstFee" runat="server" AutoGenerateColumns="False" DataSourceID="TourFeeListDataset" SkinID="dataList" Width="100%" OnRowDataBound="lstFee_RowDataBound" ShowFooter="True">
    <Columns>
        <asp:TemplateField HeaderText="Fee" SortExpression="feeType">
            <ItemStyle HorizontalAlign="Center" />
            <ItemTemplate>
                <asp:Label ID="Label1" runat="server" Text='<%# OmeiStatus.GetOmeiStatusText("TourFee", Eval("feeType"), "en") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Description" SortExpression="description">
            <ItemTemplate>
                <asp:Label ID="Label4" runat="server" Text='<%# Bind("description") %>'></asp:Label>
            </ItemTemplate>
            <FooterTemplate>Total:</FooterTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Adult" SortExpression="feeAdult">
            <ItemStyle HorizontalAlign="Right" />
            <FooterStyle HorizontalAlign="Right" />
            <ItemTemplate>
                <asp:Label ID="Label2" runat="server" Text='<%# Bind("feeAdult") %>'></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
                <asp:Label ID="lbAdultTot" runat="server" />
            </FooterTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Child" SortExpression="feeChild">
            <ItemStyle HorizontalAlign="Right" />
            <FooterStyle HorizontalAlign="Right" />
            <ItemTemplate>
                <asp:Label ID="Label3" runat="server" Text='<%# Bind("feeChild") %>'></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
                <asp:Label ID="lbChildTot" runat="server" />
            </FooterTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>


        
    <asp:ObjectDataSource ID="TourFeeListDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetTourFeeList" TypeName="com.Omei.DLL.DS_TourFeeTableAdapters.TourFeeTableAdapter">
        <SelectParameters>
            <asp:Parameter Name="tourID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>