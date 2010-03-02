<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="AirportEdit" Title="Untitled Page" Codebehind="AirportEdit.aspx.cs" %>

<%@ Register Assembly="Infragistics2.WebUI.WebCombo.v7.3, Version=7.3.20073.38, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebCombo" TagPrefix="igcmbo" %>
<%@ Register Assembly="Infragistics2.WebUI.UltraWebGrid.v7.3, Version=7.3.20073.38, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<%@ Register Assembly="Infragistics2.WebUI.UltraWebGrid.v7.3, Version=7.3.20073.38, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>    
<%@ Register Src="../Controls/CountrySelector.ascx" TagName="CountrySelector" TagPrefix="uc1" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


<div class="toolbox listButtons">
    <ul>
        <li>Airport:<asp:TextBox ID="txtAirport" runat="server" /></li><li><asp:Button ID="btnSearch" runat="server" Text="Search" /></li><li><asp:Button ID="btnSave" runat="server" Text="Save" /></li></ul>
<div style="clear:both"></div>
</div>
    <asp:ObjectDataSource ID="AirportDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="SearchAirport" TypeName="com.Omei.BLL.Admin.AirportBiz">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtAirport" Name="airport" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>

    <igtbl:UltraWebGrid ID="lstAirport" runat="server" DataSourceID="AirportDataset"
        Height="400px" Width="100%" OnUpdateRowBatch="lstAirport_UpdateRowBatch" >
        <Bands>
            <igtbl:UltraGridBand>
                <AddNewRow View="NotSet" Visible="NotSet">
                </AddNewRow>
                <FilterOptions AllString="" EmptyString="" NonEmptyString="">
                    <FilterDropDownStyle BackColor="White" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                        CustomRules="overflow:auto;" Font-Names="Verdana,Arial,Helvetica,sans-serif"
                        Font-Size="11px" Width="200px">
                        <Padding Left="2px" />
                    </FilterDropDownStyle>
                    <FilterHighlightRowStyle BackColor="#151C55" ForeColor="White">
                    </FilterHighlightRowStyle>
                </FilterOptions>
                <Columns>
                    <igtbl:UltraGridColumn BaseColumnName="airportCode"
                        Key="airportCode" AllowUpdate="Yes">
                        <Header Caption="Code">
                        </Header>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="name"
                        Key="name">
                        <Header Caption="Airport name">
                            <RowLayoutColumnInfo OriginX="1" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="1" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="name_cn" Key="name_cn">
                        <Header Caption="机场名">
                            <RowLayoutColumnInfo OriginX="2" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="2" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="country"
                        Key="country" AllowUpdate="Yes" EditorControlID="WebCombo1" Type="Custom">
                        <Header Caption="Country">
                            <RowLayoutColumnInfo OriginX="3" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="3" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="airportID" Hidden="True" Key="airportID">
                        <Header>
                            <RowLayoutColumnInfo OriginX="4" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="4" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                </Columns>
            </igtbl:UltraGridBand>
        </Bands>
        <DisplayLayout AllowAddNewDefault="Yes" AllowColSizingDefault="Free" AllowColumnMovingDefault="OnServer" AllowSortingDefault="Yes" AllowUpdateDefault="Yes" BorderCollapseDefault="Separate"
            HeaderClickActionDefault="SortMulti" Name="lstAirport" RowHeightDefault="20px" SelectTypeRowDefault="Extended" Version="4.00" ViewType="OutlookGroupBy" AutoGenerateColumns="False" CellClickActionDefault="RowSelect" AllowDeleteDefault="Yes" StationaryMargins="Header" TableLayout="Fixed">
            <GroupByBox Hidden="True">
                <BoxStyle BackColor="ActiveBorder" BorderColor="Window">
                </BoxStyle>
            </GroupByBox>
            <GroupByRowStyleDefault BackColor="Control" BorderColor="Window">
            </GroupByRowStyleDefault>
            <FooterStyleDefault BackColor="LightGray" BorderStyle="Solid" BorderWidth="1px">
                <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
            </FooterStyleDefault>
            <RowStyleDefault BackColor="Window" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px">
                <BorderDetails ColorLeft="Window" ColorTop="Window" />
                <Padding Left="3px" />
            </RowStyleDefault>
            <FilterOptionsDefault>
                <FilterDropDownStyle BackColor="White" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                    CustomRules="overflow:auto;" Font-Names="Verdana,Arial,Helvetica,sans-serif"
                    Font-Size="11px" Width="200px">
                    <Padding Left="2px" />
                </FilterDropDownStyle>
                <FilterHighlightRowStyle BackColor="#151C55" ForeColor="White">
                </FilterHighlightRowStyle>
            </FilterOptionsDefault>
            <HeaderStyleDefault BackColor="LightGray" BorderStyle="Solid" HorizontalAlign="Left">
                <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
            </HeaderStyleDefault>
            <EditCellStyleDefault BorderStyle="None" BorderWidth="0px" BackColor="#FFC0C0">
            </EditCellStyleDefault>
            <FrameStyle BackColor="Window" BorderColor="InactiveCaption" BorderStyle="Solid"
                BorderWidth="1px" Font-Names="Microsoft Sans Serif" Font-Size="8.25pt" Height="400px"
                Width="100%">
            </FrameStyle>
            <Pager PageSize="100">
                <PagerStyle BackColor="LightGray" BorderStyle="Solid" BorderWidth="1px">
                    <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
                </PagerStyle>
            </Pager>
            <AddNewBox Hidden="False">
                <BoxStyle BackColor="Window" BorderColor="InactiveCaption" BorderStyle="Solid" BorderWidth="1px">
                    <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
                </BoxStyle>
            </AddNewBox>
            <SelectedRowStyleDefault BackColor="LightYellow">
            </SelectedRowStyleDefault>
            <AddNewRowDefault>
                <RowStyle BackColor="#FFC0C0" />
            </AddNewRowDefault>
            <FixedCellStyleDefault BackColor="#C0FFC0">
            </FixedCellStyleDefault>
            <ActivationObject BorderColor="" BorderWidth="">
            </ActivationObject>
        </DisplayLayout>
    </igtbl:UltraWebGrid>
    
    <igcmbo:WebCombo ID="WebCombo1" runat="server" DataSourceID="CountryDataset" DataTextField="code" DataValueField="code" Version="4.00">
        <ExpandEffects ShadowColor="LightGray" />
        <DropDownLayout BorderCollapse="Separate" RowHeightDefault="20px" Version="4.00" DropdownHeight="250px" AllowColSizing="Free" AutoGenerateColumns="False" ColWidthDefault="" DropdownWidth="" StationaryMargins="Header" TableLayout="Fixed">
            <HeaderStyle BackColor="LightGray" BorderStyle="Solid">
                <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
            </HeaderStyle>
            <FrameStyle BackColor="Silver" BorderStyle="Ridge" BorderWidth="2px" Cursor="Default"
                Font-Names="Verdana" Font-Size="10pt" Height="250px">
            </FrameStyle>
            <RowStyle BackColor="White" BorderColor="Gray" BorderStyle="Solid" BorderWidth="1px" Font-Size="8pt">
                <BorderDetails WidthLeft="0px" WidthTop="0px" />
            </RowStyle>
            <SelectedRowStyle BackColor="DarkBlue" ForeColor="White" />
        </DropDownLayout>
        <Columns>
            <igtbl:UltraGridColumn BaseColumnName="code" HeaderText="Code" Key="code" Width="40px">
                <header caption="Code"></header>
            </igtbl:UltraGridColumn>
            <igtbl:UltraGridColumn BaseColumnName="countryName" HeaderText="Country" Key="countryName"
                Width="120px">
                <header caption="Country">
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</header>
                <footer>
<RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
</footer>
            </igtbl:UltraGridColumn>
            <igtbl:UltraGridColumn BaseColumnName="countryName_cn" HeaderText="国家名称" Key="countryName_cn"
                Width="120px">
                <header caption="国家名称">
<RowLayoutColumnInfo OriginX="2"></RowLayoutColumnInfo>
</header>
                <footer>
<RowLayoutColumnInfo OriginX="2"></RowLayoutColumnInfo>
</footer>
            </igtbl:UltraGridColumn>
        </Columns>
    </igcmbo:WebCombo>
    <asp:ObjectDataSource ID="CountryDataset" runat="server" OldValuesParameterFormatString="original_{0}" 
    SelectMethod="GetData" TypeName="com.Omei.DLL.DS_CountryTableAdapters.CountryTableAdapter">
    </asp:ObjectDataSource>
    

</asp:Content>

