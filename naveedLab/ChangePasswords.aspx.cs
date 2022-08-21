using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using naveedLabDAL;

namespace naveedLab
{
    public partial class ChangePasswords : System.Web.UI.Page
    {
        #region GlobalDeclartions

        naveedLabDLL dll = new naveedLabDLL();

        #endregion
        #region PageMethods
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["LoginSession"] == null)
            {
                Response.Redirect("~/authentication.aspx");
            }
            else if (!IsPostBack)
            {

            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                String email = String.Empty;
                int Result;

                List<signInUser_Result> empResult = (List<signInUser_Result>)Session["LoginSession"];
                foreach (var lst in empResult)
                {
                    email = lst.Email;
                }
                Result = dll.changePassword(email, empPassword.Text);
                if (Result == 1)
                {
                    naveed_Success.Visible = true;
                    naveed_Success_Text.InnerText = "Successfully Changed";
                }
                else
                {
                    naveed_Danger.Visible = true;
                    naveed_Danger_Text.InnerText = "Error ! Try Again";
                }
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "moveTop()", true);
            }
        }

        #endregion
    }
}