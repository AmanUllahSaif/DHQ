using naveedLabDAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Text;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using naveedLab.Reports;

namespace naveedLab
{
    public partial class docterReport : System.Web.UI.Page
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
        static DataTable ConvertToDataTable_DoctorShare(List<sp_CalculateDoctor_Result> list)
        {
            DataTable dt = new DataTable();

            dt.Columns.Add("totalCost");
            dt.Columns.Add("SharePercentage");
            dt.Columns.Add("totalPatients");
            foreach (var item in list)
            {
                var row = dt.NewRow();

                row["totalCost"] = item.totalCost;
                row["SharePercentage"] = item.SharePercentage;
                row["totalPatients"] = item.totalPatients;

                dt.Rows.Add(row);
            }

            return dt;
        }
        public void getDoctorList()
        {
            List<getDoctors_Result> dctrList = nlDLL.getDoctors();
            DataTable dt = ConvertToDatatable_Doctor(dctrList);

            ddlDrType.DataSource = dt;
            ddlDrType.DataTextField = "DoctorName";
            ddlDrType.DataValueField = "DoctorId";
            ddlDrType.DataBind();

            ddlDrType.Items.Insert(0, new System.Web.UI.WebControls.ListItem("- Select Doctor -", String.Empty));
            ddlDrType.SelectedIndex = 0;
        }
        public void clearFields()
        {
            ddlDrType.SelectedIndex = 0;
            ddlMonth.SelectedIndex = 0;
            lblError.Text = "";
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
            else if (Role != "Admin")
            {
                Response.Redirect("~/authorization.aspx");
            }
            else if (!IsPostBack)
            {
                getDoctorList();
            }
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                //printDiv.Visible = true;
                //buttonPrint.Visible = true;

                int paidAmount = 0;
                int ID = Convert.ToInt32(ddlDrType.SelectedValue);

                String lastDay = DateTime.DaysInMonth(DateTime.Now.Year, Convert.ToInt32(ddlMonth.SelectedValue)).ToString();

                DateTime strtDate = Convert.ToDateTime(DateTime.Now.Year + "-" + ddlMonth.SelectedValue + "- 1");
                DateTime endDate = Convert.ToDateTime(DateTime.Now.Year + "-" + ddlMonth.SelectedValue + "-" + lastDay);


                List<sp_CalculateDoctor_Result> lst = nlDLL.getDoctorResult(ID, strtDate, endDate);
                DataTable dtResult = ConvertToDataTable_DoctorShare(lst);

                if (dtResult.Rows.Count > 0)
                {
                    paidAmount = Convert.ToInt32(dtResult.Rows[0]["totalCost"]) * Convert.ToInt32(dtResult.Rows[0]["SharePercentage"]) / 100;

                    try
                    {
                        ReportDocument rpt = new ReportDocument();
                        rpt.Load(Server.MapPath("~/Reports/") + "doctorReport.rpt");

                        dsNaveedLab ds = new dsNaveedLab();
                        if (dtResult.Rows.Count > 0)
                        {
                            ds.Tables["dtDoctorReport"].Rows.Add(ddlDrType.SelectedItem.Text, ddlMonth.SelectedItem.Text, DateTime.Now.ToString("dd/MM/yyyy"), dtResult.Rows[0]["totalPatients"].ToString(), dtResult.Rows[0]["totalCost"].ToString(), dtResult.Rows[0]["SharePercentage"].ToString(), paidAmount);
                            rpt.SetDataSource(ds.Tables["dtDoctorReport"]);
                        }

                        rpt.Refresh();

                        Response.Buffer = false;

                        Response.ClearContent();
                        Response.ClearHeaders();

                        rpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, true, "DoctorShareReport");
                    }
                    catch (Exception ex)
                    {

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