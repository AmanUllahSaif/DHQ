using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using naveedLabDAL;

namespace naveedLab
{
    public partial class ClearPayment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            closeMessages();
            String Role = String.Empty;
            List<signInUser_Result> lstUsers = (List<signInUser_Result>)Session["LoginSession"];

            try
            {
                foreach (var item in lstUsers)
                {
                    Role = item.Designation;
                }
            }
            catch { }

            if (Session["LoginSession"] == null)
            {
                Response.Redirect("~/authentication.aspx");
            }
            else if (!Page.IsPostBack)
            {
                lblPayment.Text = " ( Rs " + Request.QueryString["RemainingBalance"].ToString() + " )";
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try { 
            naveedLabDLL nlDLL = new naveedLabDLL();
            int res = nlDLL.FinalRemaingBill(Convert.ToInt32(Request.QueryString["PatientID"]),Convert.ToInt32(txtPayment.Text));
            if (res != 1)
            {
                onErrorFunction("Entered Amount is not sufficient. You must pay Rs "+res+"....");
            }
            if (res == 1)
            {
                Response.Redirect("~/patientReport.aspx");
            }
                }
            catch
            {
                onErrorFunction("Enter correct payment....");
            }
        }

        protected void onErrorFunction(string text)
        {
            naveed_Danger.Visible = true;
            naveedDangerText.Visible = true;
            naveedDangerText.Text = null;
            naveedDangerText.Text = text;
        }

        protected void closeMessages()
        {
            naveed_Danger.Visible = false;
        }
    }
}