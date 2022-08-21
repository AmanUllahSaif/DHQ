using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using naveedLabDAL;

namespace naveedLab
{
    public partial class PatientResultedTest : System.Web.UI.Page
    {
        #region
        naveedLabDAL.naveedLabDLL nlDLL = new naveedLabDLL();
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            closeMessages();

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
                this.lblDate.Text = System.DateTime.Now.Day + "-" + System.DateTime.Now.Month + "-" + System.DateTime.Now.Year + "";
                lblEmployeeID.Text = empID;
                lblEmployeeName.Text = empname;
            }
        }

        protected void txtPatientID_TextChanged(object sender, EventArgs e)
        {
            try
            {
                if (txtPatientID.Text != null)
                {
                    List<selectPatientByID_Result> lstPatient = nlDLL.getPatientByID(Convert.ToInt32(txtPatientID.Text));

                    if (lstPatient.Count != 0)
                    {
                        var patientName = (from patient in lstPatient
                                           where patient.PatientID == Convert.ToInt32(txtPatientID.Text)
                                           select new { name = patient.PatientName }).Single();

                        lblPatientName.Text = patientName.name;

                        if (nlDLL.getResultedTest(Convert.ToInt32(txtPatientID.Text)).Count != 0 || nlDLL.getAlreadyPrintedTest(Convert.ToInt32(txtPatientID.Text)).Count != 0)
                        {
                            if (nlDLL.getResultedTest(Convert.ToInt32(txtPatientID.Text)).Count != 0)
                            {

                                dgvPatientTests.DataSource = nlDLL.getResultedTest(Convert.ToInt32(txtPatientID.Text));
                                dgvPatientTests.DataBind();

                                dgvPatientTests.Visible = true;
                            }
                            if (nlDLL.getAlreadyPrintedTest(Convert.ToInt32(txtPatientID.Text)).Count != 0)
                            {
                            dgvAlreadyPrinted.DataSource = nlDLL.getAlreadyPrintedTest(Convert.ToInt32(txtPatientID.Text));
                            dgvAlreadyPrinted.DataBind();
                            dgvAlreadyPrinted.Visible = true;
                            lblAlreadyPrinted.Visible = true;
                                }

                            hdfIsPrinted.Value = nlDLL.isPrinted(Convert.ToInt32(txtPatientID.Text)).ToString();
                            btnPrintAll.Visible = true;
                        }
                        else
                        {
                            onErrorFunction("No Test Result to show for this Patient...");
                            dgvPatientTests.Visible = false;
                            dgvAlreadyPrinted.Visible = false;
                            btnPrintAll.Visible = false;
                            lblAlreadyPrinted.Visible = false;
                        }
                    }
                    else
                    {
                        onErrorFunction("Patient with this ID does not Exist...");
                        dgvPatientTests.Visible = false;
                        dgvAlreadyPrinted.Visible = false;
                        btnPrintAll.Visible = false;
                        lblAlreadyPrinted.Visible = false;
                    }
                }
            }
            catch
            {
                onErrorFunction("Some error on the Page may be some problem with Patient ID...");
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

        protected void dgvPatientTests_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {

                if (e.CommandName == "MarkEdit")
                {
                    int index = Convert.ToInt32(e.CommandArgument);
                    int testID = Convert.ToInt32(((HiddenField)dgvPatientTests.Rows[index].FindControl("hlblID")).Value);

                    nlDLL.updateTestToPending(testID);

                    if (nlDLL.getResultedTest(Convert.ToInt32(txtPatientID.Text)).Count != 0)
                    {
                        dgvPatientTests.DataSource = nlDLL.getResultedTest(Convert.ToInt32(txtPatientID.Text));
                        dgvPatientTests.DataBind();

                        dgvPatientTests.Visible = true;
                        btnPrintAll.Visible = true;
                        btnPrintAll.Visible = false;
                    }
                    else
                    {
                        onErrorFunction("No Test Result to show for this Patient...");
                        dgvPatientTests.Visible = false;
                    }
                }

                else if(e.CommandName == "Redirect")
                {
                    int index = Convert.ToInt32(e.CommandArgument);
                    int testID = Convert.ToInt32(((HiddenField)dgvPatientTests.Rows[index].FindControl("hlblID")).Value);

                    Response.Redirect("~/PrintTestResult.aspx?PatientID="+txtPatientID.Text+"&&TestID=" + testID + "&&Duplicate=no");
                }
            }
            catch
            {
                onErrorFunction("Some problem in the Page...");
            }
        }

        protected void dgvAlreadyPrinted_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            try
            {

                if (e.CommandName == "MarkEdit")
                {
                    int index = Convert.ToInt32(e.CommandArgument);
                    int testID = Convert.ToInt32(((HiddenField)dgvAlreadyPrinted.Rows[index].FindControl("hlblID")).Value);

                    nlDLL.updateTestToPending(testID);

                    if (nlDLL.getAlreadyPrintedTest(Convert.ToInt32(txtPatientID.Text)).Count != 0)
                    {
                        dgvAlreadyPrinted.DataSource = nlDLL.getAlreadyPrintedTest(Convert.ToInt32(txtPatientID.Text));
                        dgvAlreadyPrinted.DataBind();

                        dgvAlreadyPrinted.Visible = true;
                        lblAlreadyPrinted.Visible = true;
                        btnPrintAll.Visible = true;
                    }
                    else
                    {
                        dgvAlreadyPrinted.Visible = false;
                        btnPrintAll.Visible = false;
                        lblAlreadyPrinted.Visible = false;
                    }
                }

                else if (e.CommandName == "Redirect")
                {
                    int index = Convert.ToInt32(e.CommandArgument);
                    int testID = Convert.ToInt32(((HiddenField)dgvAlreadyPrinted.Rows[index].FindControl("hlblID")).Value);

                    Response.Redirect("~/PrintTestResult.aspx?PatientID=" + txtPatientID.Text + "&&TestID=" + testID + "&&Duplicate=yes");
                }
            }
            catch
            {
                onErrorFunction("Some problem in the Page...");
            }
        }

        protected void btnPrintAll_Click(object sender, EventArgs e)
        {
            string isDuplicate = "";
            if (hdfIsPrinted.Value == "1")
            {
                isDuplicate = "yes";
            }
            else
            {
                isDuplicate = "no";
            }
            Response.Redirect("~/PrintAllTestResult.aspx?PatientID=" +txtPatientID.Text+ "&&Duplicate="+isDuplicate);
        }
    }
}