using System;
using System.Collections.Generic;
using System.Text;

namespace com.Omei.OmeiAdminData
{
    public class D_PhotoDetail
    {
        public int picId, relateId, picOrder;
        public string title, title_cn, description, description_cn;
        public byte photoType, status;

        public D_PhotoDetail()
        {
            picId = relateId = picOrder = 0;
            title = title_cn = description = description_cn = "";
            photoType = status = 0;
        }
    }
}
