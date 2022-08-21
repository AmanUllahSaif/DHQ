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
    public partial class TestRegistrations : System.Web.UI.Page
    {
        //OLD CODE FOR DISCOUNT STATUS
        //protected void txtPercentageDiscount_TextChanged(object sender, EventArgs e)
        //{
        //    TextBox txtPercentage = ((TextBox)(sender));

        //    try
        //    {
        //        //DataTable dt = (DataTable)Session["SelectedTest"];

        //        //int CountryCode = Convert.ToInt32(((HiddenField)txtPercentage.Parent.FindControl("hlblSelectedTestID")).Value);

        //        TextBox thisTextBox = (TextBox)sender;
        //        GridViewRow currentRow = (GridViewRow)thisTextBox.Parent.Parent;
        //        int rowindex = 0;
        //        rowindex = currentRow.RowIndex;
        //        try
        //        {
        //            int percentageDiscount = Convert.ToInt32(((TextBox)dgvSelectedTests.Rows[rowindex].FindControl("txtPercentageDiscount")).Text);

        //            if (percentageDiscount < 0 || percentageDiscount > 100)
        //            {
        //                onErrorFunction("Enter a number between 0-100....");
        //                bool errorFlag = (bool)ViewState["errorFlag"];

        //                errorFlag = true;
        //                ViewState["errorFlag"] = errorFlag;

        //            }

        //            int totalTestPrice = Convert.ToInt32(((Label)dgvSelectedTests.Rows[rowindex].FindControl("lblCharges")).Text);

        //            int remainingAfterDiscount = 0;

        //            remainingAfterDiscount = totalTestPrice - Convert.ToInt32((totalTestPrice * percentageDiscount) / 100);

        //            DataTable dt = (DataTable)Session["SelectedTest"];

        //            dt.Rows[rowindex]["RemainingTestPrice"] = remainingAfterDiscount;
        //            dt.Rows[rowindex]["PercentageDiscount"] = percentageDiscount;

        //            dt.AcceptChanges();

        //            Session["SelectedTest"] = dt;

        //            dgvSelectedTests.DataSource = dt;
        //            dgvSelectedTests.DataBind();

        //        }
        //        catch
        //        {
        //            onErrorFunction("Enter a number between 0-100....");
        //            return;
        //        }

        //    }
        //    catch
        //    {

        //    }
        //}

        protected void txtPercentageDiscount_TextChanged(object sender, EventArgs e)
        {
            TextBox txtPercentage = ((TextBox)(sender));

            try
            {
                //DataTable dt = (DataTable)Session["SelectedTest"];

                //int CountryCode = Convert.ToInt32(((HiddenField)txtPercentage.Parent.FindControl("hlblSelectedTestID")).Value);

                TextBox thisTextBox = (TextBox)sender;
                GridViewRow currentRow = (GridViewRow)thisTextBox.Parent.Parent;
                int rowindex = 0;
                rowindex = currentRow.RowIndex;
                try
                {
                    int percentageDiscount = Convert.ToInt32(((TextBox)dgvSelectedTests.Rows[rowindex].FindControl("txtPercentageDiscount")).Text);
                    int totalTestPrice = Convert.ToInt32(((Label)dgvSelectedTests.Rows[rowindex].FindControl("lblCharges")).Text);

                    if (percentageDiscount < 0 || percentageDiscount > totalTestPrice)
                    {
                        onErrorFunction("Enter a number between 0-100....");
                        bool errorFlag = (bool)ViewState["errorFlag"];

                        errorFlag = true;
                        ViewState["errorFlag"] = errorFlag;

                    }

                    int remainingAfterDiscount = 0;

                    //remainingAfterDiscount = totalTestPrice - Convert.ToInt32((totalTestPrice * percentageDiscount) / 100);
                    remainingAfterDiscount = totalTestPrice - percentageDiscount;

                    DataTable dt = (DataTable)Session["SelectedTest"];

                    dt.Rows[rowindex]["RemainingTestPrice"] = remainingAfterDiscount;
                    dt.Rows[rowindex]["PercentageDiscount"] = percentageDiscount;

                    dt.AcceptChanges();

                    Session["SelectedTest"] = dt;

                    dgvSelectedTests.DataSource = dt;
                    dgvSelectedTests.DataBind();

                }
                catch
                {
                    onErrorFunction("Enter a number between 0-100....");
                    return;
                }

            }
            catch
            {

            }
        }


        protected void btnCalculateBill_Click(object sender, EventArgs e)
        {
            try
            {
                int drID = nlDLL.GetDoctor_ID(Convert.ToInt32(txtPatientID.Text));

                if (drID == 14)
                {
                    lblTotalBill.Text = "0";
                    lblDiscountedBill.Text = "0";
                    txtPaidRupees.Text = "0";
                    txtPaidRupees.Enabled = false;
                    btnPrint.Enabled = true;
                    divBill.Visible = true;
                    return;
                }
                else if (drID == 13)
                {
                    lblTotalBill.Text = "0";
                    lblDiscountedBill.Text = "0";
                    txtPaidRupees.Text = "0";
                    txtPaidRupees.Enabled = false;
                    btnPrint.Enabled = true;
                    divBill.Visible = true;
                    return;
                }
                else if (drID == 16)
                {
                    lblTotalBill.Text = "0";
                    lblDiscountedBill.Text = "0";
                    txtPaidRupees.Text = "0";
                    txtPaidRupees.Enabled = false;
                    btnPrint.Enabled = true;
                    divBill.Visible = true;
                    return;
                }
                else if (drID == 18)
                {
                    lblTotalBill.Text = "0";
                    lblDiscountedBill.Text = "0";
                    txtPaidRupees.Text = "0";
                    txtPaidRupees.Enabled = false;
                    btnPrint.Enabled = true;
                    divBill.Visible = true;
                    return;
                }

                bool errorFlag = (bool)ViewState["errorFlag"];

                if (errorFlag == true)
                {
                    DataTable dt = (DataTable)Session["SelectedTest"];

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (Convert.ToInt32(dt.Rows[i]["PercentageDiscount"]) < 0 || Convert.ToInt32(dt.Rows[i]["PercentageDiscount"]) > 100)
                        {
                            onErrorFunction("Correct Error in the Percentage Discount....");
                            return;
                        }

                    }

                    int TotalBill = 0;
                    int DiscountedBill = 0;

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        TotalBill += Convert.ToInt32(dt.Rows[i]["Charges"]);

                        DiscountedBill += Convert.ToInt32(dt.Rows[i]["RemainingTestPrice"]);
                    }

                    lblTotalBill.Text = TotalBill.ToString();
                    lblDiscountedBill.Text = DiscountedBill.ToString();

                    divBill.Visible = true;

                }
                else
                {
                    DataTable dt = (DataTable)Session["SelectedTest"];

                    int TotalBill = 0;
                    int DiscountedBill = 0;

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        TotalBill += Convert.ToInt32(dt.Rows[i]["Charges"]);

                        DiscountedBill += Convert.ToInt32(dt.Rows[i]["RemainingTestPrice"]);
                    }

                    lblTotalBill.Text = TotalBill.ToString();
                    lblDiscountedBill.Text = DiscountedBill.ToString();

                    divBill.Visible = true;
                }

                txtPaidRupees.Text = null;
                lblRemaining.Text = null;

            }
            catch
            {
                onErrorFunction("Correct Error in the Percentage Discount....");
            }
        }
        #region globalVariables
        naveedLabDAL.naveedLabDLL nlDLL = new naveedLabDLL();
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {

            closeMessages();

            divBill.Visible = false;
            btnPrint.Enabled = false;

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
            else if (Role != "Admin" && Role != "Receptionist" && Role != "Doctor" && Role != "Chief Technician" && Role != "Senior Technician")
            {
                Response.Redirect("~/authorization.aspx");
            }
            else if (!Page.IsPostBack)
            {
                ViewState["errorFlag"] = false;

                List<selectTestInChapter_Result> Haematology = nlDLL.getTestByID(1).ToList();
                List<selectTestInChapter_Result> Biochemistry = nlDLL.getTestByID(2).ToList();
                List<selectTestInChapter_Result> Serology = nlDLL.getTestByID(3).ToList();
                List<selectTestInChapter_Result> Microbiology = nlDLL.getTestByID(8).ToList();
                List<selectTestInChapter_Result> Culture = nlDLL.getTestByID(5).ToList();
                List<selectTestInChapter_Result> Immunohematology = nlDLL.getTestByID(6).ToList();

                DataTable SelectedTest = new DataTable();

                SelectedTest.Columns.Add("SelectedTestID");
                SelectedTest.Columns.Add("TestName");
                SelectedTest.Columns.Add("Charges");
                SelectedTest.Columns.Add("PercentageDiscount");
                SelectedTest.Columns.Add("RemainingTestPrice");
                SelectedTest.Columns.Add("ChapterFID");

                Session["SelectedTest"] = SelectedTest;

                Session["Haematology"] = Haematology;
                Session["Biochemistry"] = Biochemistry;
                Session["Serology"] = Serology;
                Session["Microbiology"] = Microbiology;
                Session["Culture"] = Culture;
                Session["Immunohematology"] = Immunohematology;

            }
        }
        protected void ddlChapter_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlChapter.SelectedIndex != 0)
            {
                if (Convert.ToInt32(ddlChapter.SelectedItem.Value) == 1)
                {
                    List<selectTestInChapter_Result> Haematology = new List<selectTestInChapter_Result>();
                    Haematology = (List<selectTestInChapter_Result>)Session["Haematology"];

                    dgvSelectTest.DataSource = Haematology;
                    dgvSelectTest.DataBind();
                }
                else if (Convert.ToInt32(ddlChapter.SelectedItem.Value) == 2)
                {
                    List<selectTestInChapter_Result> Biochemistry = new List<selectTestInChapter_Result>();
                    Biochemistry = (List<selectTestInChapter_Result>)Session["Biochemistry"];

                    dgvSelectTest.DataSource = Biochemistry;
                    dgvSelectTest.DataBind();
                }
                else if (Convert.ToInt32(ddlChapter.SelectedItem.Value) == 3)
                {
                    List<selectTestInChapter_Result> Serology = new List<selectTestInChapter_Result>();
                    Serology = (List<selectTestInChapter_Result>)Session["Serology"];

                    dgvSelectTest.DataSource = Serology;
                    dgvSelectTest.DataBind();
                }
                else if (Convert.ToInt32(ddlChapter.SelectedItem.Value) == 8)
                {
                    List<selectTestInChapter_Result> Microbiology = new List<selectTestInChapter_Result>();
                    Microbiology = (List<selectTestInChapter_Result>)Session["Microbiology"];

                    dgvSelectTest.DataSource = Microbiology;
                    dgvSelectTest.DataBind();
                }
                else if (Convert.ToInt32(ddlChapter.SelectedItem.Value) == 5)
                {
                    List<selectTestInChapter_Result> Culture = new List<selectTestInChapter_Result>();
                    Culture = (List<selectTestInChapter_Result>)Session["Culture"];

                    dgvSelectTest.DataSource = Culture;
                    dgvSelectTest.DataBind();
                }
                else if (Convert.ToInt32(ddlChapter.SelectedItem.Value) == 6)
                {
                    List<selectTestInChapter_Result> Immunohematology = new List<selectTestInChapter_Result>();
                    Immunohematology = (List<selectTestInChapter_Result>)Session["Immunohematology"];

                    dgvSelectTest.DataSource = Immunohematology;
                    dgvSelectTest.DataBind();
                }
                else
                {
                    dgvSelectTest.DataSource = null;
                    dgvSelectTest.DataBind();
                }

                if (dgvSelectTest.Rows.Count > 0)
                {
                    ScriptManager.RegisterClientScriptBlock((sender as Control), this.GetType(), "LaunchServerSide", "showModal();", true);
                }
                else
                {
                    onSuccessFunction("No test currently exist Or all Tests in this Chapter has been registered....");
                }
            }
        }
        protected void txtPatientID_TextChanged(object sender, EventArgs e)
        {
            //int chkPatient = nlDLL.chkPatient(Convert.ToInt32(txtPatientID.Text));

            //if (chkPatient == 1)
            //{
            //    onErrorFunction("Tests for this Patient already registered...");
            //    return;
            //}


            List<selectTestInChapter_Result> Haematology = nlDLL.getTestByID(1).ToList();
            List<selectTestInChapter_Result> Biochemistry = nlDLL.getTestByID(2).ToList();
            List<selectTestInChapter_Result> Serology = nlDLL.getTestByID(3).ToList();
            List<selectTestInChapter_Result> Microbiology = nlDLL.getTestByID(8).ToList();
            List<selectTestInChapter_Result> Culture = nlDLL.getTestByID(5).ToList();
            List<selectTestInChapter_Result> Immunohematology = nlDLL.getTestByID(6).ToList();

            DataTable SelectedTest = new DataTable();

            SelectedTest.Columns.Add("SelectedTestID");
            SelectedTest.Columns.Add("TestName");
            SelectedTest.Columns.Add("Charges");
            SelectedTest.Columns.Add("PercentageDiscount");
            SelectedTest.Columns.Add("RemainingTestPrice");
            SelectedTest.Columns.Add("ChapterFID");

            Session["SelectedTest"] = SelectedTest;

            List<selectPatientByID_Result> lstpatient = nlDLL.getPatientByID(Convert.ToInt32(txtPatientID.Text));

            if (lstpatient.Count != 0)
            {
                string patientNme = lstpatient.Select(x => x.PatientName).First().ToString();

                lblPatientName.Text = patientNme;
                ddlChapter.Enabled = true;
                ddlChapter.Items.Clear();
                ddlChapter.Items.Add("- Select -");
                ddlChapter.DataSource = nlDLL.getAllChapters().ToList();
                ddlChapter.DataTextField = "ChapterName";
                ddlChapter.DataValueField = "ChapterID";
                ddlChapter.DataBind();
                naveed_Danger.Visible = false;

                //New By MB
                DataTable dt = new DataTable();

                dt = nlDLL.getPatientTests(Convert.ToInt32(txtPatientID.Text.Trim()));
                dgvSelectedTests.DataSource = dt;
                dgvSelectedTests.DataBind();

                List<selectPreviousBill_Result> lstBill = nlDLL.getPreviousBill(Convert.ToInt32(txtPatientID.Text.Trim()));


                try
                {
                    foreach (var item in lstBill)
                    {
                        lblPreviousPaidAmount.Text = item.TotalDiscountedCost.ToString();
                        lblPreviousPayableAmount.Text = item.RemainingPaidRupees.ToString();
                    }
                }
                catch { }

                Session["SelectedTest"] = dt;
                grdSelectedTests.Visible = true;
                tbl.Visible = true;

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    try
                    {
                        var firstMatch = Haematology.First(s => s.Id == Convert.ToInt32(dt.Rows[i]["SelectedTestID"].ToString()));
                        Haematology.Remove(firstMatch);
                    }
                    catch { }
                    try
                    {
                        var firstMatch = Biochemistry.First(s => s.Id == Convert.ToInt32(dt.Rows[i]["SelectedTestID"].ToString()));
                        Biochemistry.Remove(firstMatch);
                    }
                    catch { }
                    try
                    {
                        var firstMatch = Serology.First(s => s.Id == Convert.ToInt32(dt.Rows[i]["SelectedTestID"].ToString()));
                        Serology.Remove(firstMatch);
                    }
                    catch { }
                    try
                    {
                        var firstMatch = Microbiology.First(s => s.Id == Convert.ToInt32(dt.Rows[i]["SelectedTestID"].ToString()));
                        Microbiology.Remove(firstMatch);
                    }
                    catch { }
                    try
                    {
                        var firstMatch = Culture.First(s => s.Id == Convert.ToInt32(dt.Rows[i]["SelectedTestID"].ToString()));
                        Culture.Remove(firstMatch);
                    }
                    catch { }
                    try
                    {
                        var firstMatch = Immunohematology.First(s => s.Id == Convert.ToInt32(dt.Rows[i]["SelectedTestID"].ToString()));
                        Immunohematology.Remove(firstMatch);
                    }
                    catch { }
                }

            }
            else
            {
                onErrorFunction("User with this ID does not exist");

                lblPatientName.Text = null;
                ddlChapter.Enabled = false;
                ddlChapter.SelectedIndex = 0;
                //New By MB
                grdSelectedTests.Visible = false;
                tbl.Visible = false;
            }

            Session["Haematology"] = Haematology;
            Session["Biochemistry"] = Biochemistry;
            Session["Serology"] = Serology;
            Session["Microbiology"] = Microbiology;
            Session["Culture"] = Culture;
            Session["Immunohematology"] = Immunohematology;

            //Commented By MB
            //grdSelectedTests.Visible = false;
            divBill.Visible = false;
        }
        protected void dgvSelectTest_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            DataTable SelectedTest = (DataTable)Session["SelectedTest"];

            int ID = Convert.ToInt32(((HiddenField)dgvSelectTest.Rows[e.RowIndex].FindControl("hlblTestID")).Value);
            string TestName = ((Label)dgvSelectTest.Rows[e.RowIndex].FindControl("lblTestName")).Text;
            string Charges = ((Label)dgvSelectTest.Rows[e.RowIndex].FindControl("lblCharges")).Text;
            int chapterFID = Convert.ToInt32(((HiddenField)dgvSelectTest.Rows[e.RowIndex].FindControl("hlblChapterFID")).Value);

            string branch = ddlChapter.SelectedItem.Text;

            List<selectTestInChapter_Result> lst = (List<selectTestInChapter_Result>)Session[branch];

            selectTestInChapter_Result obj = lst.Select(x => x).Where(x => x.Id == ID).First();

            lst.Remove(obj);

            Session[branch] = lst;

            SelectedTest.Rows.Add(ID, TestName, Charges, 0, Charges, chapterFID);

            Session["SelectedTest"] = SelectedTest;


            if (ddlChapter.SelectedIndex != 0)
            {
                if (Convert.ToInt32(ddlChapter.SelectedItem.Value) == 1)
                {
                    List<selectTestInChapter_Result> Haematology = new List<selectTestInChapter_Result>();
                    Haematology = (List<selectTestInChapter_Result>)Session["Haematology"];

                    dgvSelectTest.DataSource = Haematology;
                    dgvSelectTest.DataBind();
                }
                else if (Convert.ToInt32(ddlChapter.SelectedItem.Value) == 2)
                {
                    List<selectTestInChapter_Result> Biochemistry = new List<selectTestInChapter_Result>();
                    Biochemistry = (List<selectTestInChapter_Result>)Session["Biochemistry"];

                    dgvSelectTest.DataSource = Biochemistry;
                    dgvSelectTest.DataBind();
                }
                else if (Convert.ToInt32(ddlChapter.SelectedItem.Value) == 3)
                {
                    List<selectTestInChapter_Result> Serology = new List<selectTestInChapter_Result>();
                    Serology = (List<selectTestInChapter_Result>)Session["Serology"];

                    dgvSelectTest.DataSource = Serology;
                    dgvSelectTest.DataBind();
                }
                else if (Convert.ToInt32(ddlChapter.SelectedItem.Value) == 8)
                {
                    List<selectTestInChapter_Result> Microbiology = new List<selectTestInChapter_Result>();
                    Microbiology = (List<selectTestInChapter_Result>)Session["Microbiology"];

                    dgvSelectTest.DataSource = Microbiology;
                    dgvSelectTest.DataBind();
                }
                else if (Convert.ToInt32(ddlChapter.SelectedItem.Value) == 5)
                {
                    List<selectTestInChapter_Result> Culture = new List<selectTestInChapter_Result>();
                    Culture = (List<selectTestInChapter_Result>)Session["Culture"];

                    dgvSelectTest.DataSource = Culture;
                    dgvSelectTest.DataBind();
                }
                else if (Convert.ToInt32(ddlChapter.SelectedItem.Value) == 6)
                {
                    List<selectTestInChapter_Result> Immunohematology = new List<selectTestInChapter_Result>();
                    Immunohematology = (List<selectTestInChapter_Result>)Session["Immunohematology"];

                    dgvSelectTest.DataSource = Immunohematology;
                    dgvSelectTest.DataBind();
                }
                else
                {
                    dgvSelectTest.DataSource = null;
                    dgvSelectTest.DataBind();
                }


                ScriptManager.RegisterClientScriptBlock((sender as Control), this.GetType(), "LaunchServerSide", "showModal();", true);

            }
        }
        protected void btnClose_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterClientScriptBlock((sender as Control), this.GetType(), "LaunchServerSide", "hideModal();", true);

            DataTable dt = (DataTable)Session["SelectedTest"];

            if (dt.Rows.Count > 0)
            {

                dgvSelectedTests.DataSource = dt;
                dgvSelectedTests.DataBind();
                btnCalculateBill.Visible = true;
                grdSelectedTests.Visible = true;
            }

            else
            {
                btnCalculateBill.Visible = false;
                grdSelectedTests.Visible = false;
            }

            Session["SelectedTest"] = dt;
            ddlChapter.SelectedIndex = 0;

        }
        protected void txtPaidRupees_TextChanged(object sender, EventArgs e)
        {
            try
            {
                int paidAmount = Convert.ToInt32(txtPaidRupees.Text);
                if (paidAmount < 0)
                {
                    onErrorFunction("Entered Amount is not sufficient....");
                }
                else
                {
                    lblRemaining.Text = (Convert.ToInt32(lblDiscountedBill.Text) - paidAmount).ToString();
                    divBill.Visible = true;
                    btnPrint.Enabled = true;
                }
            }
            catch
            {
                onErrorFunction("Entered Amount is not Appropriate....");
            }
        }
        protected void dgvSelectedTests_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            if (e.CommandName == "Remove")
            {
                int index = Convert.ToInt32(e.CommandArgument);

                DataTable dt = (DataTable)Session["SelectedTest"];

                int testID = Convert.ToInt32(((HiddenField)dgvSelectedTests.Rows[index].FindControl("hlblSelectedTestID")).Value);
                int charges = Convert.ToInt32(((Label)dgvSelectedTests.Rows[index].FindControl("lblCharges")).Text);
                int chapterFID = Convert.ToInt32(((HiddenField)dgvSelectedTests.Rows[index].FindControl("hlblChapterFID")).Value);
                string testName = ((Label)dgvSelectedTests.Rows[index].FindControl("lblTestName")).Text;



                if (Convert.ToInt32(dt.Rows[index]["ChapterFID"]) == 1)
                {
                    List<selectTestInChapter_Result> Haematology = (List<selectTestInChapter_Result>)Session["Haematology"];
                    selectTestInChapter_Result obj = new selectTestInChapter_Result();
                    obj.Id = testID;
                    obj.ChapterFID = chapterFID;
                    obj.Charges = charges;
                    obj.TestName = testName;
                    Haematology.Add(obj);

                    Session["Haematology"] = Haematology;
                }
                else if (Convert.ToInt32(dt.Rows[index]["ChapterFID"]) == 2)
                {
                    List<selectTestInChapter_Result> Biochemistry = (List<selectTestInChapter_Result>)Session["Biochemistry"];
                    selectTestInChapter_Result obj = new selectTestInChapter_Result();
                    obj.Id = testID;
                    obj.ChapterFID = chapterFID;
                    obj.Charges = charges;
                    obj.TestName = testName;
                    Biochemistry.Add(obj);
                    Session["Biochemistry"] = Biochemistry;
                }
                else if (Convert.ToInt32(dt.Rows[index]["ChapterFID"]) == 3)
                {
                    List<selectTestInChapter_Result> Serology = (List<selectTestInChapter_Result>)Session["Serology"];
                    selectTestInChapter_Result obj = new selectTestInChapter_Result();
                    obj.Id = testID;
                    obj.ChapterFID = chapterFID;
                    obj.Charges = charges;
                    obj.TestName = testName;
                    Serology.Add(obj);
                    Session["Serology"] = Serology;
                }
                else if (Convert.ToInt32(dt.Rows[index]["ChapterFID"]) == 8)
                {
                    List<selectTestInChapter_Result> Microbiology = (List<selectTestInChapter_Result>)Session["Microbiology"];
                    selectTestInChapter_Result obj = new selectTestInChapter_Result();
                    obj.Id = testID;
                    obj.ChapterFID = chapterFID;
                    obj.Charges = charges;
                    obj.TestName = testName;
                    Microbiology.Add(obj);

                    Session["Microbiology"] = Microbiology;
                }
                else if (Convert.ToInt32(dt.Rows[index]["ChapterFID"]) == 5)
                {
                    List<selectTestInChapter_Result> Culture = (List<selectTestInChapter_Result>)Session["Culture"];
                    selectTestInChapter_Result obj = new selectTestInChapter_Result();
                    obj.Id = testID;
                    obj.ChapterFID = chapterFID;
                    obj.Charges = charges;
                    obj.TestName = testName;
                    Culture.Add(obj);

                    Session["Culture"] = Culture;
                }
                else if (Convert.ToInt32(dt.Rows[index]["ChapterFID"]) == 6)
                {
                    List<selectTestInChapter_Result> Immunohematology = (List<selectTestInChapter_Result>)Session["Immunohematology"];
                    selectTestInChapter_Result obj = new selectTestInChapter_Result();
                    obj.Id = testID;
                    obj.ChapterFID = chapterFID;
                    obj.Charges = charges;
                    obj.TestName = testName;
                    Immunohematology.Add(obj);

                    Session["Immunohematology"] = Immunohematology;
                }

                dt.Rows[index].Delete();
                dt.AcceptChanges();

                Session["SelectedTest"] = dt;

                if (dt.Rows.Count != 0)
                {
                    dgvSelectedTests.DataSource = dt;
                    dgvSelectedTests.DataBind();
                }

                else
                {
                    dgvSelectedTests.DataSource = null;
                    dgvSelectedTests.DataBind();
                    btnCalculateBill.Visible = false;
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

        protected void btnPrint_Click(object sender, EventArgs e)
        {
            DataTable dt = (DataTable)Session["SelectedTest"];

            try
            {
                nlDLL.addTestsForPatient(dt, ViewState["empID"].ToString(), Convert.ToInt32(txtPatientID.Text));
                nlDLL.updateMoneyInPatient(Convert.ToDecimal(txtPatientID.Text), Convert.ToDecimal(lblDiscountedBill.Text), Convert.ToDecimal(lblDiscountedBill.Text) - Convert.ToDecimal(txtPaidRupees.Text));
                Response.Redirect("~/TestRegistrationSuccessPage.aspx?patientID=" + txtPatientID.Text);

            }
            catch
            {
                try
                {
                    List<selectPatientNameAndTests_Result> lstRegisteredTest = new List<selectPatientNameAndTests_Result>();
                    lstRegisteredTest = nlDLL.getPatientNameAndTests(Convert.ToInt32(txtPatientID.Text));
                    grdAlreadyRegisteredTest.DataSource = lstRegisteredTest;
                    grdAlreadyRegisteredTest.DataBind();

                    ScriptManager.RegisterClientScriptBlock((sender as Control), this.GetType(), "ShowErrorModal", "showErrorModal();", true);
                }
                catch
                {
                    onErrorFunction("Some Problem in the Page...");
                }
            }
        }
        protected void btnCloseErrorModal_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterClientScriptBlock((sender as Control), this.GetType(), "CloseModal", "hideErrorModal();", true);
        }
    }
}