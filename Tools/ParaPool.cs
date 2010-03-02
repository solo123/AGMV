using System;
using System.Collections.Generic;
using System.Text;

namespace com.Jimmy.Tools
{
    public class ParaPool
    {
        private Dictionary<string, string> para;
        public string[] paras;

        public ParaPool()
        {
            para = new Dictionary<string, string>();
            paras = null;
        }

        public void SetPara(string key, string val)
        {
            if (para.ContainsKey(key))
                para[key] = val;
            else
                para.Add(key, val);
        }

        public void SetKey(string key)
        {
            paras = null;
            if (!para.ContainsKey(key)) return;
            string s = para[key];
            if (s == null) return;

            paras = s.Split(',');
        }
        public string GetVal(int index)
        {
            if (paras == null) return null;

            if (index >= 0 && index < paras.Length)
                return paras[index];
            else
                return null;
        }
    }
}
