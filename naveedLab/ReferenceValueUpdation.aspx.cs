using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using naveedLabDAL;

namespace naveedLab
{
    public partial class ReferenceValueUpdation : System.Web.UI.Page
    {
        #region globalVariables
        naveedLabDAL.naveedLabDLL nlDLL = new naveedLabDLL();
        #endregion endGlobalVariables


        #region Methods
        protected void Page_Load(object sender, EventArgs e)
        {
            closeMessages();

            var script =
    "Sys.WebForms.PageRequestManager.getInstance()._scrollPosition = null; " +
    "window.scrollTo(0, 0);";

            ScriptManager.RegisterStartupScript(this, GetType(), "key", script, true);

            String Role = String.Empty;
            string empID = string.Empty;
            string empname = string.Empty;
            List<signInUser_Result> lstUsers = (List<signInUser_Result>)Session["LoginSession"];

            try
            {
                foreach (var item in lstUsers)
                {
                    Role = item.Designation;
                    empID = item.Email;
                    empname = item.Name;
                }
            }
            catch { }

            ViewState["empID"] = empID;

            if (Session["LoginSession"] == null)
            {
                Response.Redirect("~/authentication.aspx");
            }
            else if (Role != "Admin" && Role != "Doctor" && Role != "Chief Technician" && Role != "Senior Technician")
            {
                Response.Redirect("~/authorization.aspx");
            }
            else if (!Page.IsPostBack)
            {
                naveed_Danger.Visible = false;
                gridTerms.Visible = false;

                try
                {
                    ddlChapter.DataSource = nlDLL.getAllChapters();
                    ddlChapter.DataTextField = "ChapterName";
                    ddlChapter.DataValueField = "ChapterID";
                    ddlChapter.DataBind();
                }
                catch
                {
                    onErrorFunction("No Record Exist in this Test...");
                }
            }
        }

        protected void ddlTest_SelectedIndexChanged(object sender, EventArgs e)
        {

            if (ddlTest.SelectedIndex != 0)
            {

                var lstParameters = nlDLL.getTestParametersByAge(Convert.ToInt32(ddlAgeFactor.SelectedItem.Value), Convert.ToInt32(ddlTest.SelectedItem.Value));

                if (lstParameters != null && lstParameters.Count != 0)
                {
                    dgvReferenceValue.DataSource = lstParameters;
                    dgvReferenceValue.DataBind();
                    gridTerms.Visible = true;
                }
                else
                {
                    onErrorFunction("No Record Exist in this Test...");
                    gridTerms.Visible = false;
                }

            }
            else
            {
                gridTerms.Visible = false;
            }
        }

        protected void ddlChapter_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlChapter.SelectedIndex != 0)
            {
                ddlAgeFactor.Enabled = true;
                ddlAgeFactor.SelectedIndex = 0;

                try
                {
                    ddlAgeFactor.DataSource = nlDLL.getAllAgeFactors();
                    ddlAgeFactor.Items.Clear();
                    ddlAgeFactor.Items.Add("- Select Age -");
                    ddlAgeFactor.DataTextField = "AgeRange";
                    ddlAgeFactor.DataValueField = "ID";
                    ddlAgeFactor.DataBind();
                }
                catch
                {
                    onErrorFunction("Some Problem in Connection...");
                }
            }
            else
            {
                ddlAgeFactor.SelectedIndex = 0;
                ddlAgeFactor.Enabled = false;
            }

            ddlTest.SelectedIndex = 0;
            ddlTest.Enabled = false;
            gridTerms.Visible = false;
        }

        protected void ddlAgeFactor_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlAgeFactor.SelectedIndex != 0)
            {
                ddlTest.Enabled = true;

                try
                {
                    ddlTest.DataSource = nlDLL.getTestByID(Convert.ToInt32(ddlChapter.SelectedItem.Value));

                    ddlTest.Items.Clear();
                    ddlTest.Items.Add("- Select Test -");
                    ddlTest.DataTextField = "TestName";
                    ddlTest.DataValueField = "Id";
                    ddlTest.DataBind();
                }
                catch
                {
                    onErrorFunction("Some Problem in Connection...");
                }
            }
            else
            {
                ddlTest.SelectedIndex = 0;
                ddlTest.Enabled = false;
            }

            gridTerms.Visible = false;
        }

        protected void dgvReferenceValue_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            //if (e.CommandName == "Del")
            //{
            //    try
            //    {
            //        int ID = Convert.ToInt32(((HiddenField)(dgvReferenceValue.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("hlblID"))).Value);

            //        nlDLL.deleteParameterFromSpecificAgeFactor(ID);

            //        var lstParameters = nlDLL.getTestParametersByAge(Convert.ToInt32(ddlAgeFactor.SelectedItem.Value), Convert.ToInt32(ddlTest.SelectedItem.Value));

            //        onSuccessFunction("Value Deleted Successfully...");

            //        if (lstParameters != null && lstParameters.Count != 0)
            //        {
            //            dgvReferenceValue.DataSource = lstParameters;
            //            dgvReferenceValue.DataBind();
            //            gridTerms.Visible = true;
            //        }
            //        else
            //        {
            //            onErrorFunction("No Record Exist in this Test...");
            //            return;
            //        }
            //    }
            //    catch
            //    {
            //        onErrorFunction("Some Problem in Deletion...");
            //    }
            //}
            //else 
            if (e.CommandName == "Add")
            {
                try
                {
                    int ID = Convert.ToInt32(((HiddenField)(dgvReferenceValue.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("hlblID"))).Value);
                    string value = ((TextBox)(dgvReferenceValue.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("txtValue"))).Text;

                    nlDLL.addParameterFromSpecificAgeFactor(ID, value);

                    dgvReferenceValue.DataSource = nlDLL.getTestParametersByAge(Convert.ToInt32(ddlAgeFactor.SelectedItem.Value), Convert.ToInt32(ddlTest.SelectedItem.Value));
                    dgvReferenceValue.DataBind();

                    onSuccessFunction("Value Added Successfully...");
                }
                catch
                {
                    onErrorFunction("Some Problem in Adding Value...");
                }
            }
        }

        #endregion

        #region Functions

        protected void onSuccessFunction(string text)
        {
            naveed_popup.Visible = true;
            naveedPopupText.Visible = true;
            naveedPopupText.Text = null;
            naveedPopupText.Text = text;
            naveed_Danger.Visible = false;
        }
        protected void onErrorFunction(string text)
        {
            naveed_Danger.Visible = true;
            naveedDangerText.Visible = true;
            naveedDangerText.Text = null;
            naveedDangerText.Text = text;
            naveed_popup.Visible = false;
        }

        protected void closeMessages()
        {
            naveed_popup.Visible = false;
            naveed_Danger.Visible = false;
        }

        #endregion
    }

}

