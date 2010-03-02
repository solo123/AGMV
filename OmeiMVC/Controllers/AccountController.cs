using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;
using System.Web.Security;

using OmeiWebModel;
using OmeiMVC.Models;

namespace OmeiMVC.Controllers
{
    public class AccountController : Controller
    {
        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult Login()
        {
            return View();
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Login(string email, string password)
        {
            OmeiUserBiz biz = new OmeiUserBiz();
            int userId = biz.UserLogin(email, password);
            if (userId > 0)
            {
                Session["UserInfo"] = biz.GetUserInfo(userId);
                return RedirectToAction("Index");
            }
            else if (userId == 0)
            {
                ViewData["LoginMessage"] = "Please input email and password to login.";
            }
            else if (userId == -1)
            {
                ViewData["LoginMessage"] = "New email. Please <a href='Signup.aspx'>Sign Up</a>";
            }
            else
            {
                Session.Clear();
                ViewData["LoginMessage"] = "Password incorrect. Please try again.";
            }
            return View();
        }

        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult SignUp()
        {
            return View();
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult SignUp(string email, string password, 
            string firstname, string lastname,
            string address, string city, string state, string zip,
            string country, string contactphone, string mobile,
            bool joinmaillist
            )
        {
            UserInfo ui = new UserInfo();
            ui.userId = 0;
            ui.email = email;
            ui.pin = password;
            ui.firstName = firstname;
            ui.lastName = lastname;
            ui.address = address;
            ui.city = city;
            ui.state = state;
            ui.zip = zip;
            ui.country = country;
            ui.homePhone = contactphone;
            ui.cellPhone = mobile;
            ui.mailList = joinmaillist? "1" : "";
            ui.addDate = ui.updateDate = DateTime.Now;
            ui.userType = 0;
            ui.middleName = ui.walkyPhone = "";
            

            OmeiUserBiz biz = new OmeiUserBiz();
            biz.AddUser(ui);
            if (biz.ErrorCode != 0)
                ViewData["ErrorMessage"] = biz.ErrorMessage;
            else
                ViewData["ErrorMessage"] = "";
            ViewData["test"] = string.Format("data:{0},{1},{2},{3},{4}",email, password, firstname, lastname, address);
            return View();
        }
   

    }
}
