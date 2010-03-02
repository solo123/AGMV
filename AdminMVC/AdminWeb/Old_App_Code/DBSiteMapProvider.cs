using System;
using System.Configuration.Provider;
using System.Collections;
using System.Collections.Specialized;
using System.IO;
using System.Security.Permissions;
using System.Web;

using System.Data;
using com.Omei.BLL.Admin;
using com.Omei.DLL;

/// <summary>
/// save nodes in these arrays:
/// 1. siteMapProvider          - nodeID, siteMapNode
/// 2. childParentRelationship  - nodeID, parentID
/// 3. nodeIDs                  - nodeID, rawUrl
/// and implement these method:
/// FindSiteMapNode, GetChildNodes, GetParentNode etc.
/// </summary>
[AspNetHostingPermission(SecurityAction.Demand, Level = AspNetHostingPermissionLevel.Minimal)]
public class DBSiteMapProvider : SiteMapProvider
{
    private SiteMapProvider parentSiteMapProvider = null;
    private SiteMapNode rootNode = null;

    private ArrayList siteMapNodes = null;
    private ArrayList childParentRelationship = null;
    private ArrayList nodeIDs = null;


    // A default constructor. The Name property is initialized in the
    // Initialize method.
    public DBSiteMapProvider()
    {
    }
    // Implement the CurrentNode property.
    public override SiteMapNode CurrentNode
    {
        get
        {
            string currentUrl = FindCurrentUrl();
            // Find the SiteMapNode that represents the current page.
            SiteMapNode currentNode = FindSiteMapNode(currentUrl);
            return currentNode;
        }
    }

    // Implement the RootNode property.
    public override SiteMapNode RootNode
    {
        get
        {
            return rootNode;
        }
    }
    // Implement the ParentProvider property.
    public override SiteMapProvider ParentProvider
    {
        get
        {
            return parentSiteMapProvider;
        }
        set
        {
            parentSiteMapProvider = value;
        }
    }

    // Implement the RootProvider property.
    public override SiteMapProvider RootProvider
    {
        get
        {
            // If the current instance belongs to a provider hierarchy, it
            // cannot be the RootProvider. Rely on the ParentProvider.
            if (this.ParentProvider != null)
            {
                return ParentProvider.RootProvider;
            }
            // If the current instance does not have a ParentProvider, it is
            // not a child in a hierarchy, and can be the RootProvider.
            else
            {
                return this;
            }
        }
    }
    // Implement the FindSiteMapNode method.
    public override SiteMapNode FindSiteMapNode(string rawUrl)
    {
        if (rawUrl == null || rawUrl==string.Empty) return null;

        // --Jimmy, 2006.12.18--
        // for control TreeView, seems it use it's key as rawUrl, so add this to run over it.
        int nid = ParseInt(rawUrl);
        if (nid > 0)  return GetNodeByID(nid);

        // Does the root node match the URL?
        if (RootNode.Url == rawUrl)
        {
            return RootNode;
        }
        else
        {
            SiteMapNode candidate = null;
            // Retrieve the SiteMapNode that matches the URL.
            lock (this)
            {
                candidate = GetNode( rawUrl);
            }
            return candidate;
        }
    }
    // Implement the GetChildNodes method.
    public override SiteMapNodeCollection GetChildNodes(SiteMapNode node)
    {
        SiteMapNodeCollection children = new SiteMapNodeCollection();
        int nodeID = int.Parse(node.Key);

        // Iterate through the ArrayList and find all nodes that have the specified node as a parent.
        lock (this)
        {
            if (nodeID > 0)
            {
                for (int i = 0; i < childParentRelationship.Count; i++)
                {
                    DictionaryEntry item = (DictionaryEntry)childParentRelationship[i];
                    int pid = (int)item.Value;
                    if (pid == nodeID)
                    {
                        // The SiteMapNode with the Url that corresponds to nodeUrl
                        // is a child of the specified node. Get the SiteMapNode for
                        // the nodeUrl.
                        int cid = (int)item.Key;
                        SiteMapNode child = GetNodeByID(cid);
                        if (child != null)
                        {
                            children.Add(child as SiteMapNode);
                        }
                        else
                        {
                            throw new Exception("ArrayLists not in sync.");
                        }
                    }
                }
            }
        }
        return children;
    }

    protected override SiteMapNode GetRootNodeCore()
    {
        return RootNode;
    }
    // Implement the GetParentNode method.
    public override SiteMapNode GetParentNode(SiteMapNode node)
    {
        // Check the childParentRelationship table and find the parent of the current node.
        // If there is no parent, the current node is the RootNode.
        SiteMapNode parent = null;
        int cid=int.Parse(node.Key);

        lock (this)
        {
            if (cid > 0)
            {
                // Get the Value of the node in childParentRelationship
                for (int i = 0; i < childParentRelationship.Count; i++)
                {
                    DictionaryEntry item = (DictionaryEntry)childParentRelationship[i];
                    if ((int)item.Key == cid)
                    {
                        parent = GetNodeByID((int)item.Value);
                        break;
                    }
                }
            }
        }
        return parent;
    }

    // Implement the ProviderBase.Initialize property.
    // Initialize is used to initialize the state that the Provider holds, but
    // not actually build the site map.
    public override void Initialize(string name, NameValueCollection attributes)
    {

        lock (this)
        {

            base.Initialize(name, attributes);

            siteMapNodes = new ArrayList();
            childParentRelationship = new ArrayList();
            nodeIDs = new ArrayList();

            // Build the site map in memory.
            LoadSiteMapFromStore();
        }
    }

    // Private helper methods
    private SiteMapNode GetNode(string url)
    {
        return GetNodeByID(GetIDByUrl(url));
    }
    private SiteMapNode GetNodeByID(int id)
    {
        if (id == 0) return null;

        for (int i = 0; i < siteMapNodes.Count; i++)
        {
            DictionaryEntry item = (DictionaryEntry)siteMapNodes[i];
            if ((int)item.Key == id)
                return item.Value as SiteMapNode;
        }
        return null;
    }
    private string GetUrlByID(int id)
    {
        if (nodeIDs == null || nodeIDs.Count < 1) return null;

        for (int i = 0; i < nodeIDs.Count; i++)
        {
            DictionaryEntry item = (DictionaryEntry)nodeIDs[i];
            if ((int)item.Key == id)
                return item.Value as string;
        }
        return null;
    }
    private int GetIDByUrl(string rawUrl)
    {
        if (rawUrl == null || rawUrl == string.Empty) return 0;

        for (int i = nodeIDs.Count-1; i >=0; i--)
        {
            DictionaryEntry item = (DictionaryEntry)nodeIDs[i];
            if ( rawUrl.ToUpper().StartsWith( (string)item.Value) )
                return (int)item.Key;
        }
        return 0;
    }

    private int ParseInt(string str)
    {
        if (str == null || str == string.Empty || str.Length>4) return 0;
        for (int i = 0; i < str.Length; i++)
        {
            if (str[i] < '0' || str[i] > '9') return 0;
        }
        return int.Parse(str);
    }

    // Get the URL of the currently displayed page.
    private string FindCurrentUrl()
    {
        try
        {
            // The current HttpContext.
            HttpContext currentContext = HttpContext.Current;
            if (currentContext != null)
            {
                return currentContext.Request.RawUrl;
            }
            else
            {
                throw new Exception("HttpContext.Current is Invalid"); 
            }
        }
        catch (Exception e)
        {
            throw new NotSupportedException("This provider requires a valid context.", e);
        }
    }


    protected virtual void LoadSiteMapFromStore()
    {
        lock (this)
        {
            // If a root node exists, LoadSiteMapFromStore has already
            // been called, and the method can return.
            if (rootNode != null)
            {
                return;
            }
            else
            {
                reLoadSiteMap();
            }
        }
        return;
    }

    public void reLoadSiteMap()
    {
        // Clear the state of the collections and rootNode
        rootNode = null;
        siteMapNodes.Clear();
        childParentRelationship.Clear();
        nodeIDs.Clear();
        SiteMapNode temp = null;
        string navUrl = null;

        AdminMenuBiz mbiz = new AdminMenuBiz();
        DS_Menu.MenuItemDataTable dt = mbiz.GetMenuItems(true);
        DataRow[] rows = dt.Select("status=1", "parentId,menuId");
        foreach (DS_Menu.MenuItemRow row in rows)
        {
            navUrl = HttpRuntime.AppDomainAppVirtualPath + "/" + row.navigateUrl;
            temp = new SiteMapNode(this, row.menuID.ToString(), navUrl, row.title, row.description);

            nodeIDs.Add(new DictionaryEntry(row.menuID, navUrl.ToUpper()));
            siteMapNodes.Add(new DictionaryEntry(row.menuID, temp));

            // Is this a root node yet?
            if (row.parentID == 0)
            {
                rootNode = temp;
            }
            // If not the root node, add the node to the various collections.
            else
            {
                // The parent node has already been added to the collection.
                SiteMapNode parentNode = GetNodeByID(row.parentID);
                if (parentNode != null)
                {
                    childParentRelationship.Add(new DictionaryEntry(row.menuID, row.parentID));
                }
                else
                {
                    throw new Exception("Parent node not found for current node.");
                }
            }
        }
    }
}



