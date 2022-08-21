using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using naveedLabDAL;
using System.IO;
using System.Data.SqlClient;

namespace naveedLab
{
    public partial class TestCharges : System.Web.UI.Page
    {

        NaveedLabFinalDBEntities dbContext = new NaveedLabFinalDBEntities();

        protected void Page_Load(object sender, EventArgs e)
        {
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
            else if (Role != "Admin" && Role != "Doctor")
            {
                Response.Redirect("~/authorization.aspx");
            }
            else if (!IsPostBack)
            {

                List<tblChapter> branch = (from branches in dbContext.tblChapters select branches).ToList();
                DataTable br = ConvertToDatatable(branch);


                ddlBranch.DataSource = br;
                ddlBranch.DataTextField = "ChapterName";
                ddlBranch.DataValueField = "ChapterID";
                ddlBranch.DataBind();

                btnSave.Visible = false;

            }
        }

        static DataTable ConvertToDatatable(List<tblChapter> branch)
        {
            DataTable dt = new DataTable();

            dt.Columns.Add("ChapterID");
            dt.Columns.Add("ChapterName");
            foreach (var item in branch)
            {
                var row = dt.NewRow();

                row["ChapterID"] = item.ChapterID;
                row["ChapterName"] = item.ChapterName;

                dt.Rows.Add(row);
            }

            return dt;
        }

        protected void dgv_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            DataTable dt = (DataTable)ViewState["State"];

            String a = ((TextBox)dgv.Rows[e.RowIndex].FindControl("txtEditFees")).Text;

            if (a == "")
            {
                dt.Rows[e.RowIndex]["Charges"] = 0;
            }
            else
            {
                dt.Rows[e.RowIndex]["Charges"] = ((TextBox)dgv.Rows[e.RowIndex].FindControl("txtEditFees")).Text;
            }
            dt.Rows[e.RowIndex]["ISUPDATE"] = "1";

            dgv.EditIndex = -1;

            dgv.DataSource = dt;
            dgv.DataBind();
            ViewState["State"] = dt;
        }

        protected void dgv_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {

            DataTable dt = (DataTable)ViewState["State"];
            dgv.EditIndex = -1;

            dgv.DataSource = dt;
            dgv.DataBind();
            ViewState["State"] = dt;

        }

        protected void dgv_RowEditing(object sender, GridViewEditEventArgs e)
        {
            DataTable dt = (DataTable)ViewState["State"];
            dgv.EditIndex = e.NewEditIndex;
            dgv.DataSource = dt;
            dgv.DataBind();
            ViewState["State"] = dt;


        }

        protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
        {

            String chapter = ddlBranch.SelectedItem.Text;
            List<SelectTestPrice_Result> lst = dbContext.SelectTestPrice().Where(x => x.ChapterName == chapter).ToList();
            DataTable dt = ConvertTestPriceTolList(lst);

            if (dt.Rows.Count != 0)
            {
                gridError.Visible = false;
                gridSuccess.Visible = false;
                dgv.DataSource = dt;
                dgv.DataBind();
                ViewState["State"] = dt;

                btnSave.Visible = true;


            }
            else
            {
                gridError.Visible = true;
                gridSuccess.Visible = false;
                gridError_Text.InnerText = "No Record Found";
                DataTable Empty=new DataTable();
                Empty.Columns.Add("TestName");
                Empty.Columns.Add("TestCharges");


                dgv.DataSource = Empty;
                dgv.DataBind();
                btnSave.Visible = false;


            }
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "moveTop()", true);


        }

        static DataTable ConvertTestPriceTolList(List<SelectTestPrice_Result> TestPrice)
        {
            DataTable dt = new DataTable();

            dt.Columns.Add("ChapterID");
            dt.Columns.Add("ChapterName");
            dt.Columns.Add("ISUPDATE");
            dt.Columns.Add("TestName");
            dt.Columns.Add("Charges");

            foreach (var item in TestPrice)
            {
                var row = dt.NewRow();

                row["ChapterID"] = item.ChapterID;
                row["ChapterName"] = item.ChapterName;
                row["ISUPDATE"] = item.ISUPDATE;
                row["TestName"] = item.TestName;
                row["Charges"] = item.Charges;

                dt.Rows.Add(row);
            }

            return dt;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            DataTable dt = (DataTable)ViewState["State"];

            dt.TableName = "MYTABLE";

            StringWriter sw = new StringWriter();
            dt.WriteXml(sw);

            String xml = sw.ToString();


            SqlConnection conn = new SqlConnection("Data Source=.;  DataBase=NaveedLabFinalDB;  Integrated Security=true;");

            SqlCommand comm = new SqlCommand("[UpdateTestCharges]", conn);

            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.Add(new SqlParameter("@P1", xml));


            
            conn.Open();
            comm.ExecuteNonQuery();
            conn.Close();

            gridError.Visible = false;
            gridSuccess.Visible = true;
            gridSuccess_Text.InnerText="Record has been Successfully Updated";

        }

        protected void dgv_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

        }




    }
}