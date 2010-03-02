using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class Controls_UploadPicCtl : System.Web.UI.UserControl
{
    private string m_onAfterUpload = null;

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    public override void DataBind()
    {
        base.DataBind();

        txtUploadMessage.Text = "";

        if (this.ThumbSaveToPath == null)
            pnThumbSize.Visible = false;
        else
        {
            pnThumbSize.Visible = true;
            imgThumbnail.ImageUrl = ThumbSaveToPath + "/" + ThumbSaveToName + SaveToExtension;
        }
        imgPhoto.ImageUrl = PhotoSaveToPath + "/" + PhotoSaveToName + SaveToExtension;
    }

    #region  Ù–‘
    public string SaveToExtension
    {
        set { ViewState["SaveToExtension"] = value; }
        get
        {
            if (ViewState["SaveToExtension"] == null)
                return null;
            else
                return (string)ViewState["SaveToExtension"];
        }
    }
    public string PhotoSaveToPath
    {
        set { ViewState["PhotoPath"] = value; }
        get
        {
            if (ViewState["PhotoPath"] == null)
                return null;
            else
                return (string)ViewState["PhotoPath"];
        }
    }
    public string PhotoSaveToName
    {
        set {  lbPhotoSaveToName.Text = value; }
        get {  return lbPhotoSaveToName.Text;  }
    }
    public int PhotoWidth
    {
        set
        {
            lbPhotoWidth.Text = value.ToString();
            imgPhoto.Width = value;
        }
        get
        {
            if (PhotoSaveToPath == null)
                return 0;
            else
                return int.Parse(lbPhotoWidth.Text);
        }
    }
    public int PhotoHeight
    {
        set
        {
            lbPhotoHeight.Text = value.ToString();
            imgPhoto.Height = value;
        }
        get
        {
            if (PhotoSaveToPath == null)
                return 0;
            else
                return int.Parse(lbPhotoHeight.Text);
        }
    }
    public string ThumbSaveToPath
    {
        set { ViewState["ThumbPath"] = value; }
        get
        {
            if (ViewState["ThumbPath"] == null)
                return null;
            else
                return (string)ViewState["ThumbPath"];
        }
    }
    public string ThumbSaveToName
    {
        set { ViewState["ThumbSaveToName"] = value; }
        get
        {
            if (ViewState["ThumbSaveToName"] == null)
                return null;
            else
                return (string)ViewState["ThumbSaveToName"];
        }
    }
    public int ThumbWidth
    {
        set
        {
            lbThumbWidth.Text = value.ToString();
            imgThumbnail.Width = value;
        }
        get
        {
            if (ThumbSaveToPath == null)
                return 0;
            else
                return int.Parse(lbThumbWidth.Text);
        }
    }
    public int ThumbHeight
    {
        set
        {
            lbThumbHeight.Text = value.ToString();
            imgThumbnail.Height = value;
        }
        get
        {
            if (ThumbSaveToPath == null)
                return 0;
            else
                return int.Parse(lbThumbHeight.Text);
        }
    }
    // eg: "|.gif|.png|.jepg|.jpg|"
    public string AllowPictureType
    {
        set
        {
            ViewState["PictureType"] = value;
        }
        get
        {
            if (ViewState["PictureType"] == null)
                return null;
            else
                return (string)ViewState["PictureType"];
        }
    }
    public string OnAfterUpload
    {
        set { m_onAfterUpload = value; }
    }
    #endregion

    protected void btnUpload_Click(object sender, EventArgs e)
    {
        UploadPic();
    }

    #region UploadPic
    private bool UploadPic()
    {
        txtUploadMessage.Text = "";

        if (this.PhotoSaveToPath == null || this.PhotoSaveToName==null)
        {
            txtUploadMessage.Text = "Please set photo save to path and filename first.";
            txtUploadMessage.ForeColor = System.Drawing.Color.Red;
            return false;
        }

        bool hasThumb = (this.ThumbSaveToPath!=null);
        if (hasThumb)
        {
            if (this.ThumbSaveToName==null)
            {
                txtUploadMessage.Text = "Please set thumb save to filename first.";
                txtUploadMessage.ForeColor = System.Drawing.Color.Red;
                return false;
            }
        }

        if (this.AllowPictureType == null)
        {
            txtUploadMessage.Text = "Please set allowed picture types.";
            txtUploadMessage.ForeColor = System.Drawing.Color.Red;
            return false;
        }

        if (!picUpload.HasFile)
        {
            txtUploadMessage.Text = "Please select a picture to upload.";
            txtUploadMessage.ForeColor = System.Drawing.Color.Red;
            return false;
        }

        string srcPicFileName = picUpload.FileName;
        string srcPicExtension = null, destPicExtension = this.SaveToExtension;

        srcPicExtension = System.IO.Path.GetExtension(srcPicFileName).ToLower();
        if (this.AllowPictureType.IndexOf(srcPicExtension) < 0)
        {
            txtUploadMessage.Text = "Not allow picture type.";
            txtUploadMessage.ForeColor = System.Drawing.Color.Red;
            return false;
        }

        if (destPicExtension == null) destPicExtension = srcPicExtension;
        string destPicFileName = Server.MapPath( this.PhotoSaveToPath ) + "/" + this.PhotoSaveToName + destPicExtension ;
        string destThuFileName = Server.MapPath( this.ThumbSaveToPath ) + "/" + this.ThumbSaveToName + destPicExtension;

        // do upload
        try
        {
            System.Drawing.Image orgPhoto = null;
            if (this.PhotoWidth == 0 && this.PhotoHeight == 0)
            {
                // upload as oraginal size
                picUpload.PostedFile.SaveAs(destPicFileName);
            }
            else
            {
                // upload and change size
                orgPhoto = System.Drawing.Image.FromStream(picUpload.FileContent);
                System.Drawing.Image photo = ImageEdit.FixedSize(orgPhoto, this.PhotoWidth, this.PhotoHeight);
                photo.Save( destPicFileName );
            }

            if (hasThumb)
            {
                if (orgPhoto == null)
                    orgPhoto = System.Drawing.Image.FromStream(picUpload.FileContent);

                System.Drawing.Image thumbnail = ImageEdit.FixedSize(orgPhoto, this.ThumbWidth, this.ThumbHeight);
                thumbnail.Save( destThuFileName );
            }

            if (m_onAfterUpload != null && m_onAfterUpload != "")
            {
                Delegate d = Delegate.CreateDelegate(typeof(EventHandler), Page, m_onAfterUpload);
                ((EventHandler)d)(this, null);
            }

        }
        catch (Exception ex)
        {
            txtUploadMessage.Text = "Picture upload fail. Maybe is the filesize too big. Please use cut down the filesize and upload again <hr />" + ex.Message ;
            txtUploadMessage.ForeColor = System.Drawing.Color.Red;
            return false;
        }

        txtUploadMessage.Text = "Upload successfully.";
        txtUploadMessage.ForeColor = System.Drawing.Color.DarkGreen;
        return true;
    }
    #endregion


}
