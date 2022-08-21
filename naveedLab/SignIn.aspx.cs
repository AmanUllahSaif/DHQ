using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using naveedLabDAL;

namespace naveedLab
{
    public partial class SignIn : System.Web.UI.Page
    {
        #region GlobalArea
        naveedLabDLL dll = new naveedLabDLL();
        #endregion

        #region pageMethods
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

            }
        }

        protected void btnSignIn_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                List<signInUser_Result> lstSignIn = dll.signInData(txtEmail.Text, txtPassword.Text);

                if (lstSignIn.Count > 0)
                {
                    Session["LoginSession"] = lstSignIn;
                    Response.Redirect("~/Default.aspx");
                }
                else
                {
                    ul_Change_Password.Visible = true;
                    lblError.Text = "Username / Password Doesn't Exists !";
                }
            }
        }

        #endregion
    }
}