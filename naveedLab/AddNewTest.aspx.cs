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
    public partial class AddNewTest : System.Web.UI.Page
    {
        NaveedLabFinalDBEntities dbcontext = new NaveedLabFinalDBEntities();

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

                List<tblChapter> branch = (from branches in dbcontext.tblChapters select branches).ToList();
                DataTable br = ConvertToDatatable(branch);


                ddlBranch.DataSource = br;
                ddlBranch.DataTextField = "ChapterName";
                ddlBranch.DataValueField = "ChapterID";
                ddlBranch.DataBind();

                lblTestName.Visible = false;
                btnSave.Visible = false;
                txtTestName.Visible = false;

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
        protected void dgvNewTest_RowEditing(object sender, GridViewEditEventArgs e)
        {
            DataTable dt = (DataTable)ViewState["State"];
            dgvNewTest.EditIndex = e.NewEditIndex;
            dgvNewTest.DataSource = dt;
            dgvNewTest.DataBind();
            ViewState["State"] = dt;


            String OldTestName = ((TextBox)dgvNewTest.Rows[e.NewEditIndex].FindControl("txtTestName")).Text;

            ViewState["OldTestName"] = OldTestName;


        }
        protected void dgvNewTest_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            DataTable dt = (DataTable)ViewState["State"];
            dgvNewTest.EditIndex = -1;

            dgvNewTest.DataSource = dt;
            dgvNewTest.DataBind();
            ViewState["State"] = dt;
        }
        protected void dgvNewTest_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int branchId = Convert.ToInt32(ddlBranch.SelectedItem.Value);

            string OldTestName = (string)ViewState["OldTestName"];

            String NewTestName = ((TextBox)dgvNewTest.Rows[e.RowIndex].FindControl("txtTestName")).Text;


            string Name = (from x in dbcontext.tblTests where x.TestName == NewTestName && x.ChapterFID == branchId select x.TestName).FirstOrDefault();

            if (Name == null)
            {

                dbcontext.Database.ExecuteSqlCommand("update tblTest Set tblTest.TestName='" + NewTestName + "' where tblTest.ChapterFID='" + branchId + "' and tblTest.TestName='" + OldTestName + "'");
                dbcontext.SaveChanges();
                dgvNewTest.EditIndex = -1;

                List<tblTest> TestName = (from testname in dbcontext.tblTests where testname.ChapterFID == branchId select testname).ToList();

                DataTable dt = ConvertToDatatable1(TestName);

                if (dt.Rows.Count > 0)
                {
                    btnSave.Visible = true;
                    txtTestName.Visible = true;
                    lblTestName.Visible = true;
                    dgvNewTest.DataSource = null;
                    dgvNewTest.DataBind();
                    gridError.Visible = false;
                    gridSuccess.Visible = false;
                    gridSuccess_Text.InnerText = "Record has been update successfully";
                    gridSuccess.Visible = true;
                    dgvNewTest.DataSource = dt;
                    dgvNewTest.DataBind();

                    ViewState["State"] = dt;

                }
                else
                {
                    btnSave.Visible = true;
                    txtTestName.Visible = true;
                    lblTestName.Visible = true;
                    gridError_Text.InnerText = "No Record Found";

                    dgvNewTest.DataSource = null;
                    dgvNewTest.DataBind();
                    gridError.Visible = true;
                    gridSuccess.Visible = false;
                    dgvNewTest.EditIndex = -1;

                }




            }
            else if (Name != null)
            {
                //Duplicate Value So No insert


                dgvNewTest.EditIndex = -1;
                List<tblTest> TestName = (from testname in dbcontext.tblTests where testname.ChapterFID == branchId select testname).ToList();

                DataTable dt = ConvertToDatatable1(TestName);

                if (dt.Rows.Count > 0)
                {
                    btnSave.Visible = true;
                    txtTestName.Visible = true;
                    lblTestName.Visible = true;
                    dgvNewTest.DataSource = null;
                    dgvNewTest.DataBind();
                    gridError_Text.InnerText = "Test Name Already Exists";
                    gridError.Visible = true;
                    gridSuccess.Visible = false;
                    dgvNewTest.DataSource = dt;
                    dgvNewTest.DataBind();

                    ViewState["State"] = dt;

                }
                else
                {
                    btnSave.Visible = true;
                    txtTestName.Visible = true;
                    lblTestName.Visible = true;
                    gridError_Text.InnerText = "No Record Found";

                    dgvNewTest.DataSource = null;
                    dgvNewTest.DataBind();
                    gridError.Visible = true;
                    gridSuccess.Visible = false;
                    dgvNewTest.EditIndex = -1;

                }


            }





        }
        protected void dgvNewTest_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

            int branchId = Convert.ToInt32(ddlBranch.SelectedItem.Value);
            String TName = ((Label)dgvNewTest.Rows[e.RowIndex].FindControl("lblTestName")).Text;
            dbcontext.Database.ExecuteSqlCommand("delete from tblTest where tblTest.ChapterFID='" + branchId + "' And tblTest.TestName='" + TName + "'");
            dbcontext.SaveChanges();

            List<tblTest> TestName = (from testname in dbcontext.tblTests where testname.ChapterFID == branchId select testname).ToList();

            DataTable dt = ConvertToDatatable1(TestName);

            if (dt.Rows.Count > 0)
            {
                btnSave.Visible = true;
                txtTestName.Visible = true;
                lblTestName.Visible = true;
                dgvNewTest.DataSource = null;
                dgvNewTest.DataBind();
                gridError.Visible = false;
                gridSuccess.Visible = false;
                dgvNewTest.DataSource = dt;
                dgvNewTest.DataBind();
                gridSuccess_Text.InnerText = "Record has been deleted successfully";
                gridSuccess.Visible = true;

                ViewState["State"] = dt;

            }
            else
            {
                btnSave.Visible = true;
                txtTestName.Visible = true;
                lblTestName.Visible = true;
                gridError_Text.InnerText = "No Record Found";

                dgvNewTest.DataSource = null;
                dgvNewTest.DataBind();
                gridError.Visible = true;
                gridSuccess.Visible = false;

            }

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            gridError.Visible = false;
            gridSuccess.Visible = false;
            if (Page.IsValid)
            {

                int branchId = Convert.ToInt32(ddlBranch.SelectedItem.Value);

                string txtName = txtTestName.Text;

                string Name = (from x in dbcontext.tblTests where x.TestName == txtName && x.ChapterFID == branchId select x.TestName).FirstOrDefault();

                if (Name == null)
                {

                    //Insert New Test Name here

                    tblTest tblparameters = new tblTest();

                    tblparameters.ChapterFID = branchId;
                    tblparameters.TestName = txtName;
                    dbcontext.tblTests.Add(tblparameters);
                    //dbcontext.Database.ExecuteSqlCommand("insert into tblTestParameter(TestName) values('" + txtName + "')");
                    //dbcontext.tblTestParameters.SqlQuery("select * from tbltestparameter");
                    txtTestName.Text = "";
                    dbcontext.SaveChanges();

                    //  Refresh From Data Base

                    List<tblTest> TestName = (from testname in dbcontext.tblTests where testname.ChapterFID == branchId select testname).ToList();

                    DataTable dt = ConvertToDatatable1(TestName);

                    if (dt.Rows.Count > 0)
                    {
                        btnSave.Visible = true;
                        txtTestName.Visible = true;
                        lblTestName.Visible = true;
                        dgvNewTest.DataSource = null;
                        dgvNewTest.DataBind();
                        gridSuccess_Text.InnerText = "Record has been Added Successfully";

                        gridError.Visible = false;
                        gridSuccess.Visible = true;
                        dgvNewTest.DataSource = dt;
                        dgvNewTest.DataBind();

                        ViewState["State"] = dt;

                    }
                    else
                    {
                        btnSave.Visible = true;
                        txtTestName.Visible = true;
                        lblTestName.Visible = true;
                        gridError_Text.InnerText = "No Record Found";

                        dgvNewTest.DataSource = null;
                        dgvNewTest.DataBind();
                        gridError.Visible = true;
                        gridSuccess.Visible = false;

                    }




                }
                else if (Name != null)
                {
                    //Duplicate Value So No insert

                    gridError_Text.InnerText = "Test Name Already Exists";
                    gridError.Visible = true;
                    gridSuccess.Visible = false;
                    txtTestName.Text = "";
                }


            }
        }

        protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
        {

            if (ddlBranch.SelectedIndex != 0)
            {
                int branchId = Convert.ToInt32(ddlBranch.SelectedItem.Value);

                List<tblTest> TestName = (from testname in dbcontext.tblTests where testname.ChapterFID == branchId select testname).ToList();

                DataTable dt = ConvertToDatatable1(TestName);

                if (dt.Rows.Count > 0)
                {
                    btnSave.Visible = true;
                    txtTestName.Visible = true;
                    lblTestName.Visible = true;
                    dgvNewTest.DataSource = null;
                    dgvNewTest.DataBind();
                    gridError.Visible = false;
                    gridSuccess.Visible = false;
                    dgvNewTest.DataSource = dt;
                    dgvNewTest.DataBind();

                    ViewState["State"] = dt;

                }
                else
                {
                    btnSave.Visible = true;
                    txtTestName.Visible = true;
                    lblTestName.Visible = true;
                    gridError_Text.InnerText = "No Record Found";

                    dgvNewTest.DataSource = null;
                    dgvNewTest.DataBind();
                    gridError.Visible = true;
                    gridSuccess.Visible = false;

                }

            }
            else
            {
                btnSave.Visible = true;
                txtTestName.Visible = true;
                lblTestName.Visible = true;
                gridError_Text.InnerText = "Select Branch";

                dgvNewTest.DataSource = null;
                dgvNewTest.DataBind();
                gridError.Visible = true;
                gridSuccess.Visible = false;


            }
        }
        static DataTable ConvertToDatatable1(List<tblTest> TestName)
        {
            DataTable dt = new DataTable();

            dt.Columns.Add("Id");
            dt.Columns.Add("TestName");

            foreach (var item in TestName)
            {
                var row = dt.NewRow();


                row["Id"] = item.Id;
                row["TestName"] = item.TestName;


                dt.Rows.Add(row);
            }

            return dt;
        }

    }
}