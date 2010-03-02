<%@ Page Language="C#" %>
<%@ Register Src="../Controls/UploadPicCtl.ascx" TagName="UploadPicCtl" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
    void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack && Request.QueryString["id"]!=null)
        {
            string picId = Request.QueryString["id"];
            uploadPicCtl.PhotoSaveToName = "TourPic_" + picId;
            uploadPicCtl.DataBind();
        }
    }

    protected void OnAfterUpload(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.OriginalString);
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <META HTTP-EQUIV="expires" CONTENT="Wed, 03 Nov 1999 12:21:14 GMT"> 
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
    <meta http-equiv="Cache-Control" Content="no-cache"> 
     <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
        &nbsp;
    <a href="" onclick="history.go();return false;">Please click here to refresh after upload</a>
    <div>
        <uc1:UploadPicCtl ID="uploadPicCtl" runat="server" 
                 SaveToExtension=".jpg"
                 AllowPictureType=".jpg"
                 PhotoSaveToPath="~/OmeiWeb/images/upload/TourPics"
                 PhotoWidth=45 PhotoHeight=34
                 OnAfterUpload="OnAfterUpload"
        />
    </div>
    </form>
</body>
</html>
