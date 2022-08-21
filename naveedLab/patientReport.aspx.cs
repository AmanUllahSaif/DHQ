using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using naveedLab.Reports;
using naveedLabDAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace naveedLab
{
    public partial class patientReport : System.Web.UI.Page
    {
        #region Global Declarations
        naveedLabDLL nlDLL = new naveedLabDLL();
        #endregion

        #region otherMethods
        static DataTable ConvertToDatatable_Patient(List<sp_CalculatePatientReport_Result> list)
        {
            DataTable dt = new DataTable();

            dt.Columns.Add("StandardValue");
            dt.Columns.Add("ValueResult");
            dt.Columns.Add("Name");
            dt.Columns.Add("TestName");
            foreach (var item in list)
            {
                var row = dt.NewRow();

                row["StandardValue"] = item.StandardValue;
                row["ValueResult"] = item.ValueResult;
                row["Name"] = item.Name;
                row["TestName"] = item.TestName;

                dt.Rows.Add(row);
            }

            return dt;
        }
        static DataTable ConvertToDataTable_PatientInfo(List<sp_CalculatePatientBill_Result> list)
        {
            DataTable dt = new DataTable();

            dt.Columns.Add("PatientName");
            dt.Columns.Add("Age");
            dt.Columns.Add("DoctorName");
            dt.Columns.Add("Date");
            dt.Columns.Add("Gender");
            dt.Columns.Add("PatientID");
            dt.Columns.Add("OPDNo");
            dt.Columns.Add("DailyNo");
            dt.Columns.Add("YearlyNo");
            dt.Columns.Add("CurrentDate");

            foreach (var item in list)
            {
                var row = dt.NewRow();

                row["PatientName"] = item.PatientName;
                row["Age"] = item.Age;
                row["DoctorName"] = item.DoctorName;
                row["Date"] = item.Date;
                row["Gender"] = item.Gender;
                row["PatientID"] = item.PatientID;
                row["OPDNo"] = item.Phone;
                row["DailyNo"] = item.monthlyNo;
                row["YearlyNo"] = item.monthlyNo;
                row["CurrentDate"] = item.monthlyNo;

                dt.Rows.Add(row);
            }

            return dt;
        }
        public void clearFields()
        {
            txtPatientID.Text = "";
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
            else if (Role != "Admin" && Role != "Lab Assistant" && Role != "Doctor" && Role != "Chief Technician" && Role != "Senior Technician" && Role != "Junior Technician")
            {
                Response.Redirect("~/authorization.aspx");
            }
            else if (!IsPostBack)
            {
                lblError.Text = String.Empty;

                if (Request.QueryString["id"] != null)
                {
                    txtPatientID.Text = Request.QueryString["id"].ToString();
                }
            }
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            lblError.Text = String.Empty;

            if (Page.IsValid)
            {

                String User = String.Empty;
                String branch = String.Empty;
                List<signInUser_Result> lstUsers = (List<signInUser_Result>)Session["LoginSession"];

                try
                {
                    foreach (var item in lstUsers)
                    {
                        User = item.Name;
                        if (item.BranchFID.Equals(1))
                        {
                            branch = "Civil Lines";
                        }
                        else if (item.BranchFID.Equals(2))
                        {
                            branch = "Wapda Town";
                        }
                    }
                }
                catch { }

                int chkBill = nlDLL.chkBill(Convert.ToInt32(txtPatientID.Text));

                if (chkBill > 0)
                {
                    Response.Redirect("~/ClearPayment.aspx?PatientID=" + txtPatientID.Text + "&RemainingBalance=" + chkBill);
                }

                List<sp_CalculatePatientReport_Result> lst = nlDLL.getPatientResult(Convert.ToInt32(txtPatientID.Text));
                DataTable dtResult = ConvertToDatatable_Patient(lst);

                List<sp_CalculatePatientBill_Result> lstInfo = nlDLL.getPatientInfo(Convert.ToInt32(txtPatientID.Text));
                DataTable dtPatientInfo = ConvertToDataTable_PatientInfo(lstInfo);
                String yearlyID = dtPatientInfo.Rows[0]["PatientID"].ToString();
                String date = dtPatientInfo.Rows[0]["Date"].ToString();
                DateTime registerDate = Convert.ToDateTime(date);

                dtPatientInfo.Rows[0]["Date"] = registerDate.ToString("d");
                dtPatientInfo.Rows[0]["YearlyNo"] = yearlyID + "-" + DateTime.Now.Year;
                dtPatientInfo.Rows[0]["CurrentDate"] = DateTime.Now.ToString("d");

                if (dtResult.Rows.Count > 0)
                {
                    using (ReportDocument rpt = new ReportDocument())
                    {
                        try
                        {
                            lblError.Visible = true;

                            rpt.Load(Server.MapPath("~/Reports/") + "patientReport.rpt");

                            dsNaveedLab ds = new dsNaveedLab();

                            rpt.SetDataSource(dtPatientInfo);

                            foreach (var item in lst)
                            {
                                ds.Tables["dtPatientReport"].Rows.Add(item.StandardValue, item.ValueResult, item.Name, item.TestName);
                            }

                            rpt.Subreports["subPatientReport.rpt"].SetDataSource(ds.Tables["dtPatientReport"]);

                            ds.Tables["dtReportFooter"].Rows.Add(User, branch);
                            rpt.Subreports["subPatientReportFooter.rpt"].SetDataSource(ds.Tables["dtReportFooter"]);

                            rpt.Refresh();

                            Response.Buffer = false;

                            Response.ClearContent();
                            Response.ClearHeaders();

                            rpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, true, "PateintReport");
                        }
                        catch (Exception ex)
                        {

                            lblError.Text = ex.Message;
                            try
                            {
                                //nlDLL.load_Flag("Printed", Convert.ToInt32(txtPatientID.Text));
                            }
                            catch { }
                        }
                    }
                }
                else
                {
                    lblError.Text = "No Record Found";
                }
                clearFields();
            }
        }

        #endregion
    }
}