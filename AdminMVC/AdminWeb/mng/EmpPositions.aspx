<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="EmpPositions" Title="Untitled Page" Codebehind="EmpPositions.aspx.cs" %>
<%@ Register Src="../WebParts/TypeRefCtl.ascx" TagName="TypeRefCtl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<h1>Positions</h1>
    <uc1:TypeRefCtl ID="TypeRefCtl1" runat="server" ListClass="Position" />
    
</asp:Content>

