using System.IO;
using System.Web;
using System.Web.Mvc;

namespace AdminMVC.Controllers
{
    [HandleError]
    public class HomeController : Controller
    {

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult UploadFile()
        {
            if (Request.Files.Count > 0)
            {
                HttpPostedFileBase f = Request.Files[0];

                string path;
                if (Request.Form["Path"] == null) path = "public";
                else
                {
                    path = Request.Form["Path"].ToString();
                    if (string.IsNullOrEmpty(path)) path = "public";
                }

                //檢查是否有選擇檔案 
                if (f != null)
                {
                    //檢查檔案大小要限制也可以在這裡做 
                    if (f.ContentLength > 0)
                    {
                        path = Server.MapPath("~/Files/"+ path +"/");
                        string savedName = Path.Combine(path, f.FileName);
                        if (!Directory.Exists(path))
                            Directory.CreateDirectory(path);
                        f.SaveAs(savedName);
                        //return new StringResult(savedName);
                        return new StringResult("1");
                    }
                }
            }
            return new StringResult("0");
        }

        public ActionResult down()
        {
            //我要下載的檔案位置 
            string filepath = Server.MapPath("~/123.zip");
            //取得檔案名稱 
            string filename = System.IO.Path.GetFileName(filepath);
            //讀成串流 
            Stream iStream = new FileStream(filepath, FileMode.Open, FileAccess.Read, FileShare.Read);
            //回傳出檔案  如果你不知道檔案的MimeType, application/unknown
            return File(iStream, "application/zip", filename);
        } 
    }
}
