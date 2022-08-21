using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using naveedLabDAL;

namespace naveedLab
{
    public partial class PrintTestResult : System.Web.UI.Page
    {
        #region
        naveedLabDAL.naveedLabDLL nlDLL = new naveedLabDLL();
        #endregion
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
            else if (Role != "Doctor")
            {
                Response.Redirect("~/authorization.aspx");
            }
            else if (!Page.IsPostBack)
            {
                try
                {
                    if (Request.QueryString["TestID"] != null && Request.QueryString["PatientID"] != null && Request.QueryString["Duplicate"] != null)
                    {
                        hlblID.Value = Request.QueryString["TestID"].ToString();
                        hlblPatientID.Value = Request.QueryString["PatientID"].ToString();

                        List<selectResultForPrint_Result> lstParameters = nlDLL.getResultForPrint(Convert.ToInt32(hlblID.Value));

                        if (lstParameters.Count != 0)
                        {
                            List<spSelectTestName_Result> lstTestName = nlDLL.getTestName(Convert.ToInt32(hlblID.Value));

                            foreach (var test in lstTestName)
                            {
                                lblTestName.Text = test.TestName;
                            }

                            List<selectPatientByID_Result> lstPatient = new List<selectPatientByID_Result>();
                            lstPatient = nlDLL.getPatientByID(Convert.ToInt32(hlblPatientID.Value));

                            foreach (var patient in lstPatient)
                            {
                                lblName.Text = patient.PatientName;
                                lblGender.Text = patient.Gender;
                                lblAge.Text = patient.Age.ToString();
                                lblDate.Text = System.DateTime.Now.ToString();
                            }

                            dgvTestResultValue.DataSource = null;
                            dgvTestResultValue.DataSource = lstParameters;
                            dgvTestResultValue.DataBind();
                            grdTestResultvalue.Visible = true;
                            btnPrint.Visible = true;
                        }
                        else
                        {
                            onErrorFunction("Test with this ID does not exist...");
                            grdTestResultvalue.Visible = false;
                            btnPrint.Visible = false;
                        }
                    }

                    else
                    {
                        onErrorFunction("Some error on the Page may be some problem with Url...");
                        grdTestResultvalue.Visible = false;
                        btnPrint.Visible = false;
                    }

                }
                catch
                {
                    onErrorFunction("Some error on the Page may be some problem with Url...");
                    grdTestResultvalue.Visible = false;
                    btnPrint.Visible = false;
                }


            }
        }

        protected void btnPrint_Click(object sender, EventArgs e)
        {
            try
            {
                nlDLL.updateTestToPrinted(Convert.ToInt32(hlblID.Value));
                onSuccessFunction("Report has been printed successfully...");
            }
            catch
            {
                onErrorFunction("Some error on the Page may be some problem with Test ID...");
            }
        }

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