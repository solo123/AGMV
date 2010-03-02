using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace com.Omei.OmeiModel
{
    public class OmeiServiceBase
    {
        protected static DAO m_dao = new DAO();

        private static List<string> _errors = new List<string>();
        public string LastError
        {
            get
            {
                if (_errors.Count > 0)
                {
                    int idx = _errors.Count - 1;
                    string err = _errors[idx];
                    _errors.RemoveAt(idx);
                    return err;
                }
                else
                    return null;
            }
            set
            {
                _errors.Add(value);
            }
        }
        public bool HasError
        {
            get { return _errors.Count > 0; }
        }
    }
}
