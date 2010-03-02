<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<OmeiWebModel.v_tourDestination>>" %>


    <%  int cd = 0;
        foreach (var item in Model) {
            if (item.visitDate != cd)
            {
                cd = item.visitDate;
                Response.Write("<div>Day "+ cd.ToString() +"</div>");
            }
            %>
    
        <div>
            <div>
            </div>
            <div>
                <%= Html.Encode(item.description) %>
            </div>
        </div>
    
    <% } %>




