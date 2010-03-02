using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OmeiMVC.Models
{
    public static class LoginHelper
    {
        public static string LoginIndicator(this HtmlHelper helper)
        {
            return String.Format("<label for='bb'>aa</label>");
        }
    }
}
