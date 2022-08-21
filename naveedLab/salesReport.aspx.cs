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
    public partial class salesReport : System.Web.UI.Page
    {
        #region Global Declarations

        naveedLabDLL nlDLL = new naveedLabDLL();

        #endregion

        #region otherMethods
        static DataTable ConvertToDataTable_CountDataYearly(List<sp_SelectTestYearlyCount_Result> list)
        {
            DataTable dt = new DataTable();

            dt.Columns.Add("TestName");
            dt.Columns.Add("TestCount");
            dt.Columns.Add("TName");
            dt.Columns.Add("ReportType");
            foreach (var item in list)
            {
                var row = dt.NewRow();

                row["TestName"] = item.Name;
                row["TestCount"] = item.TestCount;
                row["TName"] = item.TestName;
                row["ReportType"] = "Yearly";

                dt.Rows.Add(row);
            }

            return dt;
        }

        static DataTable ConvertToDataTable_CountDoctor(List<sp_CountDoctor_Result> list)
        {
            DataTable dt = new DataTable();

            dt.Columns.Add("TestName");
            dt.Columns.Add("TestCount");
            dt.Columns.Add("TName");
            dt.Columns.Add("ReportType");
            foreach (var item in list)
            {
                var row = dt.NewRow();

                row["TestName"] = item.TestName;
                row["TestCount"] = item.TestCount;
                row["TName"] = "";
                row["ReportType"] = "Doctor";

                dt.Rows.Add(row);
            }

            return dt;
        }

        static DataTable ConvertToDataTable_CountDataMonthly(List<sp_SelectTestMonthlyCount_Result> list)
        {
            DataTable dt = new DataTable();

            dt.Columns.Add("TestName");
            dt.Columns.Add("TestCount");
            dt.Columns.Add("TName");
            dt.Columns.Add("ReportType");
            foreach (var item in list)
            {
                var row = dt.NewRow();

                row["TestName"] = item.Name;
                row["TestCount"] = item.TestCount;
                row["TName"] = item.TestName;
                row["ReportType"] = "Monthly";

                dt.Rows.Add(row);
            }

            return dt;
        }
        public void clearFields()
        {

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
            else if (Role != "Admin" && Role != "Doctor")
            {
                Response.Redirect("~/authorization.aspx");
            }
            else if (!IsPostBack)
            {

            }
        }

        protected void btnYearly_Click(object sender, EventArgs e)
        {
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

                List<sp_SelectTestYearlyCount_Result> lstInfo = nlDLL.getYearlyCount(DateTime.Now.Year.ToString());
                DataTable dtResult = ConvertToDataTable_CountDataYearly(lstInfo);

                if (dtResult.Rows.Count > 0)
                {
                    using (ReportDocument rpt = new ReportDocument())
                    {
                        try
                        {
                            rpt.Load(Server.MapPath("~/Reports/") + "monthlyYearlyReport.rpt");

                            dsNaveedLab ds = new dsNaveedLab();

                            rpt.SetDataSource(dtResult);

                            ds.Tables["dtReportFooter"].Rows.Add(User, branch);
                            rpt.Subreports["subPatientReportFooter.rpt"].SetDataSource(ds.Tables["dtReportFooter"]);

                            rpt.Refresh();

                            Response.Buffer = false;

                            Response.ClearContent();
                            Response.ClearHeaders();

                            rpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, true, "YearlyReport");
                        }
                        catch (Exception ex)
                        {

                        }
                    }
                }
                else
                {
                    lblYear.InnerText = "No Record Found";
                }
                clearFields();
            }
        }

        protected void btnMonthly_Click(object sender, EventArgs e)
        {
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

                DateTime strtDate = Convert.ToDateTime(DateTime.Now.Year + "-" + ddlMonth.SelectedValue + "- 1");
                String lastDay = DateTime.DaysInMonth(DateTime.Now.Year, Convert.ToInt32(ddlMonth.SelectedValue)).ToString();
                DateTime endDate = Convert.ToDateTime(DateTime.Now.Year + "-" + ddlMonth.SelectedValue + "-" + lastDay);

                List<sp_SelectTestMonthlyCount_Result> lstInfo = nlDLL.getMonthlyCount(ddlTest.SelectedItem.Text, strtDate, endDate);
                DataTable dtResult = ConvertToDataTable_CountDataMonthly(lstInfo);

                if (dtResult.Rows.Count > 0)
                {
                    using (ReportDocument rpt = new ReportDocument())
                    {
                        try
                        {
                            rpt.Load(Server.MapPath("~/Reports/") + "monthlyYearlyReport.rpt");

                            dsNaveedLab ds = new dsNaveedLab();

                            rpt.SetDataSource(dtResult);

                            ds.Tables["dtReportFooter"].Rows.Add(User, branch);
                            rpt.Subreports["subPatientReportFooter.rpt"].SetDataSource(ds.Tables["dtReportFooter"]);

                            rpt.Refresh();

                            Response.Buffer = false;

                            Response.ClearContent();
                            Response.ClearHeaders();

                            rpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, true, "MonthlyReport");
                        }
                        catch (Exception ex)
                        {

                        }
                    }
                }
                else
                {
                    lblMonth.InnerText = "No Record Found";
                }
                clearFields();
            }
        }


        protected void btnDoctorCount_Click(object sender, EventArgs e)
        {
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

                List<sp_CountDoctor_Result> lstInfo = nlDLL.getDoctorCount(DateTime.Now.Year.ToString());
                DataTable dtResult = ConvertToDataTable_CountDoctor(lstInfo);

                if (dtResult.Rows.Count > 0)
                {
                    using (ReportDocument rpt = new ReportDocument())
                    {
                        try
                        {
                            rpt.Load(Server.MapPath("~/Reports/") + "monthlyYearlyReport.rpt");

                            dsNaveedLab ds = new dsNaveedLab();

                            rpt.SetDataSource(dtResult);

                            ds.Tables["dtReportFooter"].Rows.Add(User, branch);
                            rpt.Subreports["subPatientReportFooter.rpt"].SetDataSource(ds.Tables["dtReportFooter"]);

                            rpt.Refresh();

                            Response.Buffer = false;

                            Response.ClearContent();
                            Response.ClearHeaders();

                            rpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, true, "DoctorReport");
                        }
                        catch (Exception ex)
                        {

                        }
                    }
                }
                else
                {
                    lblYear.InnerText = "No Record Found";
                }
                clearFields();
            }

        }
        #endregion


    }
}