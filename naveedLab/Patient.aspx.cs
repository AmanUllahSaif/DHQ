using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using naveedLabDAL;
using System.Data;
using System.Net;
using System.IO;

namespace naveedLab
{
    public partial class Patient : System.Web.UI.Page
    {
        #region Global Declarations
        naveedLabDLL nlDLL = new naveedLabDLL();
        #endregion

        #region otherMethods
        static DataTable ConvertToDatatable_Doctor(List<getDoctors_Result> list)
        {
            DataTable dt = new DataTable();

            dt.Columns.Add("DoctorId");
            dt.Columns.Add("DoctorName");
            foreach (var item in list)
            {
                var row = dt.NewRow();

                row["DoctorId"] = item.DoctorId;
                row["DoctorName"] = item.DoctorName;

                dt.Rows.Add(row);
            }

            return dt;
        }
        static DataTable ConvertToDatatable_Patient(List<selectPatient_Result> list)
        {

            DataTable dt = new DataTable();

            dt.Columns.Add("PatientID");
            dt.Columns.Add("PatientName");
            dt.Columns.Add("Age");
            dt.Columns.Add("Gender");
            dt.Columns.Add("DoctorID");
            dt.Columns.Add("Date");
            dt.Columns.Add("EmailFID");
            dt.Columns.Add("Phone");

            foreach (var item in list)
            {
                var row = dt.NewRow();

                row["PatientID"] = item.PatientID;
                row["PatientName"] = item.PatientName;
                row["Age"] = item.Age;
                row["Gender"] = item.Gender;
                row["DoctorID"] = item.DoctorID;
                row["Date"] = item.Date;
                row["EmailFID"] = item.EmailFID;
                row["Phone"] = item.Phone;

                dt.Rows.Add(row);
            }

            return dt;

        }
        public void getDoctorList()
        {
            List<getDoctors_Result> dctrList = nlDLL.getDoctors();
            DataTable dt = ConvertToDatatable_Doctor(dctrList);

            ddlDoctorName.DataSource = dt;
            ddlDoctorName.DataTextField = "DoctorName";
            ddlDoctorName.DataValueField = "DoctorId";
            ddlDoctorName.DataBind();

            ddlDoctorName.Items.Insert(0, new ListItem("- Select Doctor -", String.Empty));
            ddlDoctorName.SelectedIndex = 0;
        }
        public void clearFields()
        {
            patientName.Text = String.Empty;
            patientAge.Text = String.Empty;
            patientPhone.Text = String.Empty;
            date.Text = String.Empty;
            ddlDoctorName.SelectedIndex = 0;
            rbtnMale.Checked = true;
            rbtnFemale.Checked = false;
        }
        public String setDailyID()
        {
            String id = String.Empty;
            DateTime DateDaily = Convert.ToDateTime(DateTime.Now.ToString("d"));
            List<sp_GetDailyPatientID_Result> lstDailyId = nlDLL.getDailyID(DateDaily);

            foreach (var item in lstDailyId)
            {
                id = item.monthlyNo;
            }

            if (lstDailyId.Count == 0)
            {
                return 1 + "/" + DateTime.Now.ToString("d");
            }
            else
            {
                String[] arrDailyId = id.Split('/');
                int Val = Convert.ToInt32(arrDailyId[0]) + 1;

                return Val + "/" + DateTime.Now.ToString("yyyy-MM-dd");
            }
        }

        #endregion

        #region PageMEthods
        protected void Page_Load(object sender, EventArgs e)
        {
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
            else if (Role != "Admin" && Role != "Receptionist" && Role != "Doctor" && Role != "Chief Technician" && Role != "Senior Technician")
            {
                Response.Redirect("~/authorization.aspx");
            }
            else if (!IsPostBack)
            {
                date.Text = DateTime.Now.ToString("d");
                getDoctorList();
                setDailyID();
            }
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {


                tblPatient pt = new tblPatient();
                pt.PatientName = patientName.Text;
                pt.Age = Convert.ToInt32(patientAge.Text);
                pt.Gender = "Male";

                if (!rbtnMale.Checked)
                {
                    pt.Gender = "Female";
                }

                pt.DoctorID = Convert.ToInt32(ddlDoctorName.SelectedValue);
                pt.Date = Convert.ToDateTime(date.Text);

                List<signInUser_Result> lstSignIn = (List<signInUser_Result>)Session["LoginSession"];
                foreach (var item in lstSignIn)
                {
                    pt.EmailFID = item.Email;
                }

                pt.Phone = ddlType.SelectedItem.Value+"-"+patientPhone.Text;
                pt.monthlyNo = setDailyID();

                int result = nlDLL.addPatient(pt);

                if (result > 0)
                {
                    clearFields();
                    naveed_Danger.Visible = false;
                    naveed_Success.Visible = true;
                    naveed_Success_Text.InnerHtml = "Patient Successfully Added -!- New Patient ID <b>" + result + "</b>";
                    setDailyID();
                }
                else
                {
                    naveed_Success.Visible = false;
                    naveed_Danger.Visible = true;
                    naveed_Danger_Text.InnerText = "Error ! Please Try Again";
                }

                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "moveTop()", true);
            }
        }
        protected void btnClear_Click(object sender, EventArgs e)
        {
            clearFields();
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                List<selectPatient_Result> lstPatients = nlDLL.selectPatient(Convert.ToInt32(pId.Text));

                if (lstPatients.Count > 0)
                {
                    DataTable dt = ConvertToDatatable_Patient(lstPatients);

                    grdPatient.DataSource = dt;
                    grdPatient.DataBind();

                    ViewState["ptData"] = dt;

                    lblErrorText.InnerText = "";
                    pId.Text = "";
                }
                else
                {
                    DataTable dtEmpty = new DataTable();
                    grdPatient.DataSource = dtEmpty;
                    grdPatient.DataBind();

                    lblErrorText.InnerText = "No Patient with Id " + pId.Text + " Exists";
                }
            }
        }
        protected void grdPatient_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "updateRow")
            {
                int Result;
                int rowIndex = ((GridViewRow)((ImageButton)e.CommandSource).NamingContainer).RowIndex;

                tblPatient pt = new tblPatient();
                pt.PatientID = Convert.ToInt32(e.CommandArgument);
                pt.PatientName = ((TextBox)grdPatient.Rows[rowIndex].FindControl("PtName_Edit")).Text;
                pt.Age = Convert.ToInt32(((TextBox)grdPatient.Rows[rowIndex].FindControl("PtAge_Edit")).Text);
                if (((RadioButton)grdPatient.Rows[rowIndex].FindControl("rbtnMale_Edit")).Checked)
                {
                    pt.Gender = "Male";
                }
                else
                {
                    pt.Gender = "Female";
                }
                pt.Phone = ((TextBox)grdPatient.Rows[rowIndex].FindControl("PtPhone_Edit")).Text;

                Result = nlDLL.updatePatient(pt);

                grdPatient.EditIndex = -1;

                DataTable dt = new DataTable();
                grdPatient.DataSource = dt;
                grdPatient.DataBind();

                if (Result == 1)
                {
                    gridSuccess.Visible = true;
                    gridSuccess_Text.InnerText = "SuccessFully Updated";
                }
                else
                {
                    gridError.Visible = true;
                    gridError.InnerText = "Error ! Not Updated Try Again Please .";
                }

                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "moveBottom()", true);

            }
            else if (e.CommandName == "editRow")
            {
                DataTable dt = (DataTable)ViewState["ptData"];

                int rowIndex = ((GridViewRow)((ImageButton)e.CommandSource).NamingContainer).RowIndex;
                grdPatient.EditIndex = rowIndex;

                grdPatient.DataSource = dt;
                grdPatient.DataBind();



                RadioButton rbtnMale_Edit = (RadioButton)grdPatient.Rows[rowIndex].FindControl("rbtnMale_Edit");
                RadioButton rbtnFemale_Edit = (RadioButton)grdPatient.Rows[rowIndex].FindControl("rbtnFemale_Edit");

                String rbtnValue = dt.Rows[rowIndex]["Gender"].ToString();
                if (rbtnValue == "Male")
                {
                    rbtnMale_Edit.Checked = true;
                    rbtnFemale_Edit.Checked = false;
                }
                else
                {
                    rbtnMale_Edit.Checked = false;
                    rbtnFemale_Edit.Checked = true;
                }
            }
            else if (e.CommandName == "cancelRow")
            {
                grdPatient.EditIndex = -1;

                DataTable dt = (DataTable)ViewState["ptData"];
                grdPatient.DataSource = dt;
                grdPatient.DataBind();
            }
        }
        #endregion
    }
}