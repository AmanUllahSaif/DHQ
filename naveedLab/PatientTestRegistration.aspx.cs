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
    public partial class PatientTestRegistration : System.Web.UI.Page
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

            if (Session["LoginSession"] == null)
            {
                Response.Redirect("~/authentication.aspx");
            }
            else if (Role != "Admin" && Role != "Doctor" && Role != "Chief Technician" && Role != "Senior Technician" && Role != "Junior Technician")
            {
                Response.Redirect("~/authorization.aspx");
            }
            else if (!IsPostBack)
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

                        if (nlDLL.getPatientTestForAddingValue(Convert.ToInt32(txtPatientID.Text)).Count != 0)
                        {
                            dgvPatientTests.DataSource = nlDLL.getPatientTestForAddingValue(Convert.ToInt32(txtPatientID.Text.Trim()));
                            dgvPatientTests.DataBind();

                            dgvPatientTests.Visible = true;

                        }
                        else
                        {
                            onErrorFunction("No New Test Registered for this Patient...");
                            dgvPatientTests.Visible = false;
                        }

                        if (nlDLL.getPatientTestForAddingValueForUpdate(Convert.ToInt32(txtPatientID.Text)).Count != 0)
                        {

                            dgvPatientTests_1.DataSource = nlDLL.getPatientTestForAddingValueForUpdate(Convert.ToInt32(txtPatientID.Text.Trim()));
                            dgvPatientTests_1.DataBind();

                            dgvPatientTests_1.Visible = true;

                        }
                        else
                        {
                            dgvPatientTests_1.Visible = false;
                        }

                    }
                    else
                    {
                        onErrorFunction("Patient with this ID does not Exist...");
                        dgvPatientTests.Visible = false;
                        dgvPatientTests_1.Visible = false;
                    }
                }
            }
            catch
            {
                onErrorFunction("Some error on the Page may be some problem with patient ID...");
            }
        }

        protected void dgvPatientTests_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "registerTestResult")
            {
                int index = Convert.ToInt32(e.CommandArgument);

                int testID = Convert.ToInt32(((HiddenField)dgvPatientTests.Rows[index].FindControl("hlblID")).Value);

                List<selectTestParametersForResult_Result> lstParameters = nlDLL.getTestParametersForAddingValue(testID);

                if (lstParameters.Count != 0)
                {

                    dgvTestResultValue.DataSource = null;
                    dgvTestResultValue.DataSource = lstParameters;
                    dgvTestResultValue.DataBind();
                    grdTestResultvalue.Visible = true;
                    ScriptManager.RegisterClientScriptBlock((sender as Control), this.GetType(), "LaunchServerSide", "showModal();", true);

                    DataTable dtParameters = new DataTable();
                    dtParameters.Columns.Add("ParameterID");
                    dtParameters.Columns.Add("ParameterValue");

                    for (int i = 0; i < lstParameters.Count; i++)
                    {
                        var obj = lstParameters[i];
                        try
                        {
                            dtParameters.Rows.Add(Convert.ToInt32(obj.Id), obj.StandardValue.ToString());
                        }
                        catch (Exception)
                        {

                            dtParameters.Rows.Add(Convert.ToInt32(obj.Id),"");
                        }
                    }

                    hlblpatientTestID.Value = ((HiddenField)dgvPatientTests.Rows[index].FindControl("hlblID")).Value;
                    ViewState["dtParameters"] = dtParameters;
                    Session["lstParameters"] = lstParameters;
                }
                else
                {
                    onErrorFunction("There is no parameter added in this test...");
                }
            }
        }


        protected void dgvPatientTests_1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "registerTestResult")
            {
                int index = Convert.ToInt32(e.CommandArgument);

                int testID = Convert.ToInt32(((HiddenField)dgvPatientTests_1.Rows[index].FindControl("hlblID")).Value);

                List<selectTestParametersForResult_Result> lstParameters = nlDLL.getTestParametersForAddingValue(testID);

                if (lstParameters.Count != 0)
                {

                    dgvTestResultValue.DataSource = null;
                    dgvTestResultValue.DataSource = lstParameters;
                    dgvTestResultValue.DataBind();
                    grdTestResultvalue.Visible = true;
                    ScriptManager.RegisterClientScriptBlock((sender as Control), this.GetType(), "LaunchServerSide", "showModal();", true);

                    DataTable dtParameters = new DataTable();
                    dtParameters.Columns.Add("ParameterID");
                    dtParameters.Columns.Add("ParameterValue");

                    for (int i = 0; i < lstParameters.Count; i++)
                    {
                        var obj = lstParameters[i];
                        try
                        {
                            dtParameters.Rows.Add(Convert.ToInt32(obj.Id), obj.StandardValue.ToString());
                        }
                        catch (Exception)
                        {

                            dtParameters.Rows.Add(Convert.ToInt32(obj.Id), "");
                        }
                    }

                    hlblpatientTestID.Value = ((HiddenField)dgvPatientTests_1.Rows[index].FindControl("hlblID")).Value;
                    ViewState["dtParameters"] = dtParameters;
                    Session["lstParameters"] = lstParameters;
                }
                else
                {
                    onErrorFunction("There is no parameter added in this test...");
                }
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

        protected void btnSaveParameterValues_Click(object sender, EventArgs e)
        {
            try
            {
                GridView grd = (GridView)dgvTestResultValue;

                for (int i = 0; i < grd.Rows.Count; i++)
                {
                    int testID= Convert.ToInt32(((HiddenField)grd.Rows[i].FindControl("hlblTestID")).Value);
                    int resultID = Convert.ToInt32(((HiddenField)grd.Rows[i].FindControl("hlblResultID")).Value);
                    string parameterValue = ((TextBox)grd.Rows[i].FindControl("txtResultedValue")).Text;
                    

                    nlDLL.addTestParameterResult(resultID, parameterValue,testID,Convert.ToInt32(txtPatientID.Text.Trim()));
                }

                if (nlDLL.getPatientTestForAddingValue(Convert.ToInt32(txtPatientID.Text)).Count != 0)
                {
                    dgvPatientTests.DataSource = nlDLL.getPatientTestForAddingValue(Convert.ToInt32(txtPatientID.Text.Trim()));
                    dgvPatientTests.DataBind();

                    dgvPatientTests.Visible = true;
                }
                else
                {
                    onErrorFunction("No New Test Registered for this Patient...");
                    dgvPatientTests.Visible = false;
                }

                if (nlDLL.getPatientTestForAddingValueForUpdate(Convert.ToInt32(txtPatientID.Text)).Count != 0)
                {

                    dgvPatientTests_1.DataSource = nlDLL.getPatientTestForAddingValueForUpdate(Convert.ToInt32(txtPatientID.Text.Trim()));
                    dgvPatientTests_1.DataBind();

                    dgvPatientTests_1.Visible = true;

                }
                else
                {
                    dgvPatientTests_1.Visible = false;
                }

                onSuccessFunction("Test Registered Successfully...");

                ScriptManager.RegisterClientScriptBlock((sender as Control), this.GetType(), "LaunchServerSide", "hideModal();", true);

            }
            catch
            {
                onErrorFunction("Some problem in Registering the Parameter Values...");

                ScriptManager.RegisterClientScriptBlock((sender as Control), this.GetType(), "LaunchServerSide", "hideModal();", true);
            }

        }

        //protected void txtResultedValue_TextChanged(object sender, EventArgs e)
        //{
        //    DataTable dtParameters = new DataTable();
        //    dtParameters = (DataTable)ViewState["dtParameters"];

        //    TextBox txtValue = (TextBox)sender;

        //    GridViewRow currentRow = (GridViewRow)txtValue.Parent.Parent;

        //    int index = currentRow.RowIndex;

        //    List<selectTestParametersForResult_Result> lstParameters = (List<selectTestParametersForResult_Result>)Session["lstParameters"];

        //    dtParameters.Rows[index]["ParameterValue"] = ((TextBox)dgvTestResultValue.Rows[index].FindControl("txtResultedValue")).Text;
        //    dtParameters.Rows[index]["ParameterID"] = Convert.ToInt32(((HiddenField)dgvTestResultValue.Rows[index].FindControl("hlblID")).Value);
        //    dtParameters.AcceptChanges();

        //    dgvTestResultValue.DataSource = lstParameters;
        //    dgvTestResultValue.DataBind();

        //    ScriptManager.RegisterClientScriptBlock((sender as Control), this.GetType(), "LaunchServerSide", "showModal();", true);

        //    ViewState["dtParameters"] = dtParameters;

        //}
    }
}