<%@ Page Language="C#" AutoEventWireup="true" Inherits="ClientCallback" Codebehind="ClientCallback.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 
  1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
  <script type="text/javascript">
    function LookUpStock()
    {
        var lb = document.forms[0].ListBox1;
        var product = lb.options[lb.selectedIndex].text 
        CallServer(product, "");
    }
    
    function ReceiveServerData(rValue)
    {
        Results.innerText = rValue;
    }
  </script>
</head>
<body>
  <form id="form1" runat="server">
    <div>
      <asp:ListBox ID="ListBox1" Runat="server"></asp:ListBox>
      <br />
      <br />
      <button onclick="LookUpStock()">Look Up Stock</button>
      <br />
      <br />
      Items in stock: <span ID="Results"></span>
      <br />
    </div>
  </form>
</body>
