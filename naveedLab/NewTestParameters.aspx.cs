using naveedLabDAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace naveedLab
{
    public partial class NewTestParameters : System.Web.UI.Page
    {

        NaveedLabFinalDBEntities dbContext = new NaveedLabFinalDBEntities();
        SqlConnection conn = new SqlConnection("Data Source=(local); Database=NaveedLabFinalDB; Integrated Security=true");

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
            else if (Role != "Admin" && Role != "Doctor" && Role != "Chief Technician" && Role != "Senior Technician")
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

        protected void EmptyGridFix(GridView grdView)
        {
            // normally executes after a grid load method
            if (grdView.Rows.Count == 0 &&
                grdView.DataSource != null)
            {
                DataTable dt = null;

                // need to clone sources otherwise
                // it will be indirectly adding to 
                // the original source

                if (grdView.DataSource is DataSet)
                {
                    dt = ((DataSet)grdView.DataSource).Tables[0].Clone();
                }
                else if (grdView.DataSource is DataTable)
                {
                    dt = ((DataTable)grdView.DataSource).Clone();
                }

                if (dt == null)
                {
                    return;
                }

                dt.Rows.Add(dt.NewRow()); // add empty row
                grdView.DataSource = dt;
                grdView.DataBind();

                // hide row
                grdView.Rows[0].Visible = false;
                grdView.Rows[0].Controls.Clear();
            }

            // normally executes at all postbacks
            if (grdView.Rows.Count == 1 &&
                grdView.DataSource == null)
            {
                bool bIsGridEmpty = true;

                // check first row that all cells empty
                for (int i = 0; i < grdView.Rows[0].Cells.Count; i++)
                {
                    if (grdView.Rows[0].Cells[i].Text != string.Empty)
                    {
                        bIsGridEmpty = false;
                    }
                }
                // hide row
                if (bIsGridEmpty)
                {
                    grdView.Rows[0].Visible = false;
                    grdView.Rows[0].Controls.Clear();
                }
            }
        }

   
        protected void dgvNewTest_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            gridError.Visible = false;
            gridSuccess.Visible = false;
            DataTable dt = (DataTable)ViewState["State"];

            DataTable deleteDt = (DataTable)ViewState["deleteDt"];
            deleteDt.Rows.Add(dt.Rows[e.RowIndex]["Id"].ToString(), dt.Rows[e.RowIndex]["Name"].ToString());

            dt.Rows[e.RowIndex].Delete();
            dt.AcceptChanges();

            dgvNewTest.DataSource = dt;
            dgvNewTest.DataBind();

            ViewState["State"] = dt;
            ViewState["deleteDt"] = deleteDt;
            gridSuccess.Visible = false;
            gridSuccess_Text.InnerText = "Record has been Deleted Successfully";
        }

        protected void dgvNewTest_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gridError.Visible = false;
            gridSuccess.Visible = false;

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
            gridError.Visible = false;
            gridSuccess.Visible = false;
            DataTable dt = (DataTable)ViewState["State"];
            dgvNewTest.EditIndex = -1;

            dgvNewTest.DataSource = dt;
            dgvNewTest.DataBind();
            ViewState["State"] = dt;
        }
        protected void dgvNewTest_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

            String id = ddlTestName.SelectedItem.Value;
            String name = ((TextBox)dgvNewTest.Rows[e.RowIndex].FindControl("txtTestName")).Text;
            if (!string.IsNullOrWhiteSpace(name) && name.Length > 0)
            {

                String query = "select Name from tblTestParameters where Name='" + name + "' and TestId='" + id + "' group by Name,TestId ";

                conn.Open();
                SqlCommand cmd = new SqlCommand(query, conn);
                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                DataTable DuplicateTestName = new DataTable();

                dap.Fill(DuplicateTestName);
                if (DuplicateTestName.Rows.Count <= 0)
                {
                    gridError.Visible = false;
                    gridSuccess.Visible = false;

                    string OldTestName = (string)ViewState["OldTestName"];

                    DataTable dt = (DataTable)ViewState["State"];
                    dt.Rows[e.RowIndex]["Name"] = ((TextBox)dgvNewTest.Rows[e.RowIndex].FindControl("txtTestName")).Text;
                    dt.Rows[e.RowIndex]["OldTestName"] = OldTestName;
                    dt.Rows[e.RowIndex]["ISUPDATE"] = "1";


                    dgvNewTest.EditIndex = -1;

                    dgvNewTest.DataSource = dt;
                    dgvNewTest.DataBind();
                    ViewState["State"] = dt;
                    gridSuccess.Visible = false;
                    gridSuccess_Text.InnerText = "Test Name has been Updated";
                }
                else if (DuplicateTestName.Rows.Count > 0)
                {
                    gridError.Visible = true;
                    gridSuccess.Visible = false;
                    gridError_Text.InnerText = "Test Name Already Exists";
                }

            }
            else
            {

                gridError.Visible = false;
                gridSuccess.Visible = false;
                gridError.Visible = true;
                gridError_Text.InnerText = "Test Name cannot be Empty";

            }








           
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {

            DataTable dt = (DataTable)ViewState["State"];

            String id = ddlTestName.SelectedItem.Value;


            String name = ((TextBox)dgvNewTest.FooterRow.FindControl("txtFooterTestName")).Text;

            if (!string.IsNullOrWhiteSpace(name) && name.Length > 0)
            {

                String query = "select Name from tblTestParameters where Name='" + name + "' and TestId='" + id + "' group by Name,TestId ";

                conn.Open();
                SqlCommand cmd = new SqlCommand(query, conn);
                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                DataTable DuplicateTestName = new DataTable();

                dap.Fill(DuplicateTestName);
                if (DuplicateTestName.Rows.Count <= 0)
                {
                    gridError.Visible = false;
                    gridSuccess.Visible = false;

                    int rows = dt.Rows.Count;
                    dt.Rows.Add(id, name, "0", "1");
                    dgvNewTest.DataSource = dt;
                    dgvNewTest.DataBind();
                    EmptyGridFix(dgvNewTest);
                    ViewState["State"] = dt;
                }
                else if (DuplicateTestName.Rows.Count > 0)
                {
                    gridError.Visible = true;
                    gridSuccess.Visible = false;
                    gridError_Text.InnerText = "Test Name Already Exists";
                }

            }
            else
            {

                gridError.Visible = false;
                gridSuccess.Visible = false;
                gridError.Visible = true;
                gridError_Text.InnerText = "Test Name cannot be Empty";

            }

        }
       

        protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlBranch.SelectedIndex != 0)
            {
                dgvNewTest.DataSource = null;
                dgvNewTest.DataBind();
                int branchId = Convert.ToInt32(ddlBranch.SelectedItem.Value);

                List<tblTest> TestName = (from testname in dbContext.tblTests where testname.ChapterFID == branchId select testname).ToList();

                DataTable dt = ConvertToDatatable1(TestName);

                if (dt.Rows.Count > 0)
                {
                    ddlTestName.Items.Clear();
                    ddlTestName.DataSource = null;
                    gridError.Visible = false;
                    gridSuccess.Visible = false;
                    ddlTestName.Enabled = true;
                    ddlTestName.Items.Add("Select One");
                    ddlTestName.DataSource = dt;
                    ddlTestName.DataTextField = "TestName";
                    ddlTestName.DataValueField = "Id";
                    ddlTestName.DataBind();



                }
                else
                {
                    gridError.Visible = true;
                    gridSuccess.Visible = false;
                    gridError_Text.InnerText = "No Record Found";
                    dgvNewTest.DataSource = null;
                    dgvNewTest.DataBind();
                    ddlTestName.Enabled = false;
                    ddlTestName.Items.Clear();
                    ddlTestName.DataSource = null;
                    ddlTestName.DataBind();


                }
            }
            else
            {

                gridError.Visible = true;
                gridSuccess.Visible = false;
                gridError_Text.InnerText = "Choose Branch";
                dgvNewTest.DataSource = null;
                dgvNewTest.DataBind();
                ddlTestName.Enabled = false;
                ddlTestName.Items.Clear();
                ddlTestName.DataSource = null;
                ddlTestName.DataBind();

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

        protected void ddlTestName_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlTestName.SelectedIndex != 0)
            {

                Int16 TestID = Convert.ToInt16(ddlTestName.SelectedItem.Value);
                var Parameter = (from param in dbContext.tblTestParameters
                                 where param.TestId == TestID
                                 group param by new { param.Name } into g
                                 select new
                                                              {
                                                                  Name = g.Key.Name,



                                                              });
                List<tblTestParameter> lstparam = new List<tblTestParameter>();

                foreach (var item in Parameter)
                {
                    tblTestParameter tbl = new tblTestParameter();
                    tbl.Name = item.Name;

                    lstparam.Add(tbl);

                }
                DataTable dt = ConvertToDatatable2(lstparam, TestID);


                gridError.Visible = false;
                gridSuccess.Visible = false;
                dgvNewTest.DataSource = dt;
                dgvNewTest.DataBind();
                EmptyGridFix(dgvNewTest);


                DataTable deleteDt = new DataTable();
                deleteDt.Columns.Add("ID");
                deleteDt.Columns.Add("Name");


                ViewState["deleteDt"] = deleteDt;

                ViewState["State"] = dt;
                btnSave.Visible = true;



            }
            else
            {
                dgvNewTest.DataSource = null;
                dgvNewTest.DataBind();
                gridError.Visible = true;
                gridSuccess.Visible = false;
                gridError_Text.InnerText = "Choose Test";
                btnSave.Visible = false;


            }
        }

        static DataTable ConvertToDatatable2(List<tblTestParameter> Parameters, Int16 TestID)
        {



            DataTable dt = new DataTable();
            dt.Columns.Add("Id");

            dt.Columns.Add("Name");

            dt.Columns.Add("ISUPDATE");

            dt.Columns.Add("ISNEW");
            dt.Columns.Add("OldTestName");




            foreach (var item in Parameters)
            {
                var row = dt.NewRow();
                row["Id"] = TestID;
                row["Name"] = item.Name;
                row["ISUPDATE"] = 0;
                row["ISNEW"] = 0;
                row["OldTestName"] = 0;



                dt.Rows.Add(row);
            }

            return dt;
        }

        //protected void dgvNewTest_PageIndexChanging(object sender, GridViewPageEventArgs e)
        //{

        //}

        protected void btnSave_Click(object sender, EventArgs e)
        {

            DataTable dt = (DataTable)ViewState["State"];
            DataTable dtDelete = (DataTable)ViewState["deleteDt"];

            dt.TableName = "MYTABLE";
            dtDelete.TableName = "MYTABLE";

            StringWriter sw = new StringWriter();
            dt.WriteXml(sw);

            String xml = sw.ToString();

            StringWriter swDelete = new StringWriter();
            dtDelete.WriteXml(swDelete);

            String xmlDelete = swDelete.ToString();

            SqlConnection conn = new SqlConnection("Data Source=(local); Database=NaveedLabFinalDB; Integrated Security=true");
            SqlCommand comm = new SqlCommand("[SpAddParameters]", conn);

            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.Add(new SqlParameter("@P1", xml));
            comm.Parameters.Add(new SqlParameter("@P2", xmlDelete));

            conn.Open();
            comm.ExecuteNonQuery();
            conn.Close();
            //gridError.Visible = false;
            //gridSuccess.Visible = true;
            //gridSuccess_Text.InnerText = "Record has been Updated";

ScriptManager.RegisterStartupScript(Page, Page.GetType(), "showError", "$('#myModal').modal();", true);

            //int rownumber = dt.Rows.Count-1;
            //dt.Rows[rownumber]["ISNEW"] = 0;

        }

        protected void btnModelResponseRedirect_Click(object sender, EventArgs e)
        {
            Response.Redirect("NewTestParameters.aspx");
        }




    }
}