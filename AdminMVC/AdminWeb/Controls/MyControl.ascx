<%@ Control Language="C#" ClassName="MyControl" %>

<script runat="server">

    void Page_Load(object sender, EventArgs e)
    {
        if (strEvent != null && strEvent != "")
        {
            Delegate d = Delegate.CreateDelegate(typeof(EventHandler), Page, strEvent);
            SelectedIndexChanged = (EventHandler)d;
        }

    }

    private string strEvent;
    private EventHandler SelectedIndexChanged;
    
    public string OnSelectedIndexChanged
    {
        set { strEvent = value; }
    }
    
    public string SelectedValue
    {
        get
        {
            if (DropDownList1.SelectedIndex < 0)
                return "";
            else
                return DropDownList1.SelectedValue;
        }
    }
        
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (SelectedIndexChanged != null)
            SelectedIndexChanged(this, null);
        
        
    }
</script>

<asp:DropDownList ID="DropDownList1" runat="server" 
    OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged"
    AutoPostBack=true>
    <asp:ListItem Value=1 Text="item 01"></asp:ListItem>
    <asp:ListItem Value=2 Text="item 02"></asp:ListItem>
    <asp:ListItem Value=3 Text="item 03"></asp:ListItem>
</asp:DropDownList>