using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using naveedLabDAL;

namespace naveedLab.Dashboard
{
    public partial class employee : System.Web.UI.Page
    {
        #region GlobalFunctioning
        naveedLabDLL naveedLabDLL = new naveedLabDLL();
        #endregion

        #region functions

        static DataTable ConvertToDatatable(List<getEmployees_Result> list)
        {
            DataTable dt = new DataTable();

            dt.Columns.Add("Email");
            dt.Columns.Add("Name");
            dt.Columns.Add("Password");
            dt.Columns.Add("Gender");
            dt.Columns.Add("Address");
            dt.Columns.Add("Designation");
            dt.Columns.Add("BranchFID");
            foreach (var item in list)
            {
                var row = dt.NewRow();

                row["Email"] = item.Email;
                row["Name"] = item.Name;
                row["Password"] = item.Password;
                row["Gender"] = item.Gender;
                row["Address"] = item.Address;
                row["Designation"] = item.Designation;
                row["BranchFID"] = item.BranchFID;

                dt.Rows.Add(row);
            }

            return dt;
        }

        static DataTable ConvertToDatatable_Branch(List<getAllBranches_Result> list)
        {
            DataTable dt = new DataTable();

            dt.Columns.Add("ID");
            dt.Columns.Add("BranchName");
            dt.Columns.Add("Address");
            foreach (var item in list)
            {
                var row = dt.NewRow();

                row["ID"] = item.ID;
                row["BranchName"] = item.BranchName;
                row["Address"] = item.Address;

                dt.Rows.Add(row);
            }

            return dt;
        }

        public void clearFields()
        {
            empID.Text = String.Empty;
            empName.Text = String.Empty;
            empNo.Text = String.Empty;
            empAddress.Text = String.Empty;
            rbtnMale.Checked = true;
            rbtnFemale.Checked = false;
            ddlEmpStatus.SelectedIndex = 0;
            ddlBranch.SelectedIndex = 0;
        }

        public void getAllBranches()
        {
            List<getAllBranches_Result> LiBranches = naveedLabDLL.getAllBranches();

            ddlBranch.DataSource = LiBranches;
            ddlBranch.DataTextField = "BranchName";
            ddlBranch.DataValueField = "ID";
            ddlBranch.DataBind();

            ddlBranch.Items.Insert(0, new ListItem("- Select Branch -", String.Empty));
            ddlBranch.SelectedIndex = 0;

            DataTable dtBranches = ConvertToDatatable_Branch(LiBranches);

            ViewState["grdBranchData"] = dtBranches;
        }

        public void loadEmployees()
        {
            List<getEmployees_Result> LstEmployees = naveedLabDLL.getEmployee();

            grdEmployees.DataSource = LstEmployees;
            grdEmployees.DataBind();

            DataTable dtEmp = ConvertToDatatable(LstEmployees);

            ViewState["grdEmployeesData"] = dtEmp;
        }

        #endregion

        #region Methods
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
                getAllBranches();
                if (Role == "Admin")
                {
                    loadEmployees();
                }
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                tblEmployee empRecord = new tblEmployee();
                empRecord.Email = empID.Text;
                empRecord.Name = empName.Text;
                empRecord.Address = empAddress.Text;
                empRecord.Password = empPassword.Text;
                empRecord.Phone = empNo.Text;
                empRecord.Email = empID.Text;
                empRecord.Designation = ddlEmpStatus.SelectedValue;
                if (rbtnMale.Checked)
                {
                    empRecord.Gender = "Male";
                    rbtnFemale.Checked = false;
                }
                else
                {
                    empRecord.Gender = "Female";
                    rbtnMale.Checked = false;
                }
                empRecord.BranchFID = Convert.ToInt32(ddlBranch.SelectedItem.Value);

                int result = 0;
                result = naveedLabDLL.addEmployees(empRecord);

                if (result == 1)
                {
                    clearFields();
                    naveed_Danger.Visible = false;
                    naveed_Success.Visible = true;
                    naveed_Success_Text.InnerText = "Employee Successfully Added";

                    loadEmployees();
                }
                else
                {
                    naveed_Success.Visible = false;
                    naveed_Danger.Visible = true;
                    naveed_Danger_Text.InnerText = "Username Already Exists";
                }

                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "moveTop()", true);
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            clearFields();
        }

        protected void grdEmployees_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdEmployees.PageIndex = e.NewPageIndex;
            loadEmployees();
        }

        protected void grdEmployees_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "updateRow")
            {
                int Result;
                int rowIndex = ((GridViewRow)((ImageButton)e.CommandSource).NamingContainer).RowIndex;

                tblEmployee emp = new tblEmployee();
                emp.Email = e.CommandArgument.ToString();
                emp.Name = ((TextBox)grdEmployees.Rows[rowIndex].FindControl("empName_Edit")).Text;
                emp.Address = ((TextBox)grdEmployees.Rows[rowIndex].FindControl("empAddress_Edit")).Text;
                emp.Designation = ((DropDownList)grdEmployees.Rows[rowIndex].FindControl("ddlEmpStatus_Edit")).SelectedValue.ToString();
                emp.BranchFID = Convert.ToInt32(((DropDownList)grdEmployees.Rows[rowIndex].FindControl("ddlBranch_Edit")).SelectedValue);
                emp.Phone = ((TextBox)grdEmployees.Rows[rowIndex].FindControl("empPhone_Edit")).Text;

                Result = naveedLabDLL.updatedEmployees(emp);

                grdEmployees.EditIndex = -1;
                loadEmployees();

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
                DataTable dt = (DataTable)ViewState["grdEmployeesData"];
                DataTable dtBranch = (DataTable)ViewState["grdBranchData"];

                int rowIndex = ((GridViewRow)((ImageButton)e.CommandSource).NamingContainer).RowIndex;
                grdEmployees.EditIndex = rowIndex;

                loadEmployees();



                String Designation = dt.Rows[rowIndex]["Designation"].ToString();
                DropDownList ddlDesignation = (DropDownList)grdEmployees.Rows[rowIndex].FindControl("ddlEmpStatus_Edit");
                ddlDesignation.SelectedValue = Designation;

                DropDownList ddlBranch = (DropDownList)grdEmployees.Rows[rowIndex].FindControl("ddlBranch_Edit");
                ddlBranch.DataSource = dtBranch;
                ddlBranch.DataTextField = "BranchName";
                ddlBranch.DataValueField = "ID";
                ddlBranch.DataBind();
                ddlBranch.Items.Insert(0, new ListItem("- Select Branch -", String.Empty));
                ddlBranch.SelectedIndex = 0;

                String Branch = dt.Rows[rowIndex]["BranchFID"].ToString();
                ddlBranch.SelectedValue = Branch;
            }
            else if (e.CommandName == "cancelRow")
            {
                grdEmployees.EditIndex = -1;
                loadEmployees();
            }
            else if (e.CommandName == "deleteRow")
            {
                int result;

                result = naveedLabDLL.deleteEmployee(e.CommandArgument.ToString());
                if (result == 1)
                {
                    gridSuccess.Visible = true;
                    gridSuccess_Text.InnerText = "SuccessFully Deleted";

                    loadEmployees();
                }
                else
                {
                    gridError.Visible = true;
                    gridError.InnerText = "Error ! Not Deleted Try Again Please .";
                }

                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "moveBottom()", true);
            }
        }
        #endregion
    }
}