using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AdminMVC.Controllers
{
    public class StringResult : ActionResult
    {
        public StringResult(string value)
        {
            _value = value;
        }

        string _value;

        public override void ExecuteResult(ControllerContext context)
        {
            context.HttpContext.Response.ContentType = "text/plain";
            context.HttpContext.Response.Write(_value);
        }
    }
}
