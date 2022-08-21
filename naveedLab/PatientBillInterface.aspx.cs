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
    public partial class PatientBillInterface : System.Web.UI.Page
    {
        naveedLabDLL nlDLL = new naveedLabDLL();
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
            else if (!Page.IsPostBack)
            {
                try
                {
                    //Convert.ToInt32(Request.QueryString["patientID"]);
                    //hdfID.Value = Request.QueryString["patientID"].ToString();
                    txtReturnDate.Text = DateTime.Now.AddDays(1).ToString("dddd, MMMM d, yyyy");
                }
                catch
                {
                    hdfID.Value = 0.ToString();
                }
            }
        }

        public DataTable ConvertToDatatable_Bill(List<sp_CalculateBill_Result> list)
        {
            DataTable dt = new DataTable();

            dt.Columns.Add("TestName");
            dt.Columns.Add("PatientName");
            dt.Columns.Add("Age");
            dt.Columns.Add("DoctorName");
            dt.Columns.Add("Gender");
            dt.Columns.Add("Date");
            dt.Columns.Add("Charges");
            dt.Columns.Add("SpecialDiscount");
            dt.Columns.Add("TotalCost");
            dt.Columns.Add("PatientID");
            dt.Columns.Add("AmountPaid");
            dt.Columns.Add("RemaingAmount");
            dt.Columns.Add("dailyId");
            dt.Columns.Add("mr#");
            dt.Columns.Add("outDate");
            foreach (var item in list)
            {
                var row = dt.NewRow();

                row["TestName"] = item.TestName;
                row["PatientName"] = item.PatientName;
                row["Age"] = item.Age;
                row["DoctorName"] = item.DoctorName;
                row["Gender"] = item.Gender;
                row["Date"] = item.Date;
                row["Charges"] = item.Charges;
                row["SpecialDiscount"] = item.SpecialDiscount;
                row["TotalCost"] = item.TotalCost;
                row["PatientID"] = item.PatientID;
                row["AmountPaid"] = item.AmountPaid;
                row["RemaingAmount"] = item.RemaingAmount;
                row["dailyId"] = item.dailyId;
                row["mr#"] = item.mr_;
                row["outDate"] = txtReturnDate.Text;


                dt.Rows.Add(row);
            }

            return dt;
        }
        protected void btnPrint_Click(object sender, EventArgs e)
        {
            if (hdfID.Value != "0")
            {
                List<sp_CalculateBill_Result> lst = nlDLL.getPatientFinalBill(Convert.ToInt32(txtPatientId.Text));
                DataTable dtResult = ConvertToDatatable_Bill(lst);
                DateTime date = Convert.ToDateTime(dtResult.Rows[0]["Date"].ToString());
                dtResult.Rows[0]["Date"] = date.ToString("d");

                if (dtResult.Rows.Count > 0)
                {
                    using (ReportDocument rpt = new ReportDocument())
                    {
                        try
                        {
                            rpt.Load(Server.MapPath("~/Reports/") + "patientBill.rpt");

                            dsNaveedLab ds = new dsNaveedLab();

                            rpt.SetDataSource(dtResult);
                            rpt.Refresh();

                            Response.Buffer = false;

                            Response.ClearContent();
                            Response.ClearHeaders();

                            rpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, true, "PatientBill");
                        }
                        catch (Exception ex)
                        {

                        }
                    }
                }
                else
                {
                    lblError.Text = "No Bill Exists For ID :"+txtPatientId.Text;
                }
            }
        }
    }
}