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
    public partial class FlagListPage : System.Web.UI.Page
    {
        #region Global Functions
        naveedLabDLL nLDLL = new naveedLabDLL();
        #endregion

        #region otherMethods

        static DataTable ConvertToDt_Doctor(List<sp_Load_Flag_Result> list)
        {
            DataTable dt = new DataTable();

            dt.Columns.Add("PatientID");
            dt.Columns.Add("PatientName");
            dt.Columns.Add("Date");
            dt.Columns.Add("Phone");
            dt.Columns.Add("Age");
            dt.Columns.Add("Gender");
            foreach (var item in list)
            {
                var row = dt.NewRow();

                row["PatientID"] = item.PatientID;
                row["PatientName"] = item.PatientName;
                row["Date"] = item.Date;
                row["Phone"] = item.Phone;
                row["Age"] = item.Age;
                row["Gender"] = item.Gender;

                dt.Rows.Add(row);
            }

            return dt;
        }

        public void GetAllDoctors(string status, int pID)
        {
            List<sp_Load_Flag_Result> PatientList = nLDLL.load_Flag(status, pID);

            DataTable dtPatientList = ConvertToDt_Doctor(PatientList);

            if (status.Equals("Pending"))
            {
                grdFeeding.DataSource = dtPatientList;
                grdFeeding.DataBind();
            }
            else if (status.Equals("Done")) 
            {
                grdPrinting.DataSource = dtPatientList;
                grdPrinting.DataBind();
            }

            ViewState["drData"] = dtPatientList;
        }

        #endregion

        #region Page MEthods

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
                GetAllDoctors("Pending",0);
                GetAllDoctors("Done",0);
            }
        }

        protected void grdFeeding_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "RedirectRow")
            {
                //int rowIndex = ((GridViewRow)((ImageButton)e.CommandSource).NamingContainer).RowIndex;
                Response.Redirect("~/PatientTestRegistration.aspx?id=" + e.CommandArgument.ToString());
            }
        }

        protected void grdFeeding_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdFeeding.PageIndex = e.NewPageIndex;
            GetAllDoctors("Pending",0);
        }

        #endregion

        protected void grdPrinting_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "RedirectRow")
            {
                //int rowIndex = ((GridViewRow)((ImageButton)e.CommandSource).NamingContainer).RowIndex;
                Response.Redirect("~/patientReport.aspx?id="+e.CommandArgument.ToString());
            }
        }

        protected void grdPrinting_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdPrinting.PageIndex = e.NewPageIndex;
            GetAllDoctors("Done",0);
        }

    }
}