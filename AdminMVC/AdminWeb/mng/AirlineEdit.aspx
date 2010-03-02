<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="AirlineEdit" Title="Untitled Page" Codebehind="AirlineEdit.aspx.cs" %>

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
        <li>Airline:<asp:TextBox ID="txtAirline" runat="server"></asp:TextBox></li><li><asp:Button ID="btnSearch" runat="server" Text="Search" /></li><li><asp:Button ID="btnSave" runat="server" Text="Save" /></li></ul>
<div style="clear:both"></div>
</div>

    <asp:ObjectDataSource ID="AirlineDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="SearchAirline" TypeName="com.Omei.BLL.Admin.AirlineBiz">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtAirline" Name="airline" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    
    <igtbl:UltraWebGrid ID="lstAirline" runat="server" DataSourceID="AirlineDataset"
        Height="400px" Width="100%" OnUpdateRowBatch="lstAirline_UpdateRowBatch" >
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
                    <igtbl:UltraGridColumn BaseColumnName="airlineCode"
                        Key="airlineCode" AllowUpdate="Yes">
                        <Header Caption="Code">
                        </Header>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="name"
                        Key="name">
                        <Header Caption="Airline name">
                            <RowLayoutColumnInfo OriginX="1" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="1" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="name_cn" Key="name_cn">
                        <Header Caption="航线名称">
                            <RowLayoutColumnInfo OriginX="2" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="2" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="airlineID" DataType="System.Int32" Hidden="True"
                        Key="airlineID">
                        <Header>
                            <RowLayoutColumnInfo OriginX="3" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="3" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                </Columns>
            </igtbl:UltraGridBand>
        </Bands>
        <DisplayLayout AllowAddNewDefault="Yes" AllowColSizingDefault="Free" AllowColumnMovingDefault="OnServer" AllowSortingDefault="Yes" AllowUpdateDefault="Yes" BorderCollapseDefault="Separate"
            HeaderClickActionDefault="SortMulti" Name="lstAirline" RowHeightDefault="20px" SelectTypeRowDefault="Extended" Version="4.00" ViewType="OutlookGroupBy" AutoGenerateColumns="False" CellClickActionDefault="RowSelect" StationaryMargins="Header" TableLayout="Fixed">
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
            <ClientSideEvents BeforeRowDeletedHandler="lstAirline_BeforeRowDeletedHandler" />
            <ActivationObject BorderColor="" BorderWidth="">
            </ActivationObject>
        </DisplayLayout>
    </igtbl:UltraWebGrid>
    
</asp:Content>

