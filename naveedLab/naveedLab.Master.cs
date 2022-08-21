using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using naveedLabDAL;

namespace naveedLab
{
    public partial class naveedLab : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["LoginSession"] != null)
            {
                foreach (var lst in Session["LoginSession"] as List<signInUser_Result>)
                {
                    lblLoginStatus.Text = lst.Name;
                }
            }
        }

        protected void logOut_Click(object sender, EventArgs e)
        {
            Session["LoginSession"] = null;
            Response.Redirect("~/SignIn.aspx");
        }
    }
}