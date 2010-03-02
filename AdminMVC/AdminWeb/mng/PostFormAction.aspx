<%@ Page Language="C#" EnableViewState="false" Theme="" %>
<script runat="server">
    //----------------------------------------------------
    // 禁止缓存该页 让AJAX读取该页始终为最新而非过期缓存页
    //----------------------------------------------------
    public void Page_Load()
    {
        Response.Expires = 0;
        Response.ExpiresAbsolute = DateTime.Now.AddSeconds(-1);
        Response.AddHeader("pragma","no-cache");
        Response.AddHeader("cache-control","private");
        Response.CacheControl = "no-cache";
        //-------------------------------------------
        Response.Charset="GB2312";  //数据返回的编码类型 显示中文数据必须
        //-------------------------------------------
        Response.Write(DateTime.Now); //得到当前时间
        //string s = Request.Form.ToString();
        //Response.Write(s);

        for (int i = 0; i < Request.Form.Count; i++)
        {
            Response.Write(string.Format( "<br /> {0} = {1}",Request.Form.Keys[i], WriteStrings(Request.Form.GetValues(i))));
        } 
    }

    private string WriteStrings(string[] ss)
    {
        if (ss == null) return "null";
        string st = "";
        foreach (string s in ss)
            st += s + ", ";
        return st;
    }
</script>
