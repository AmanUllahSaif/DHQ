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
    public partial class doctor : System.Web.UI.Page
    {
        #region Global Functions
        naveedLabDLL nLDLL = new naveedLabDLL();
        #endregion

        #region otherMethods
        public void clearFields()
        {
            drName.Text = String.Empty;
            drAddress.Text = String.Empty;
            drNo.Text = String.Empty;
            ddlDrType.SelectedIndex = 0;
            drPercentage.Text = String.Empty;
        }

        static DataTable ConvertToDt_Doctor(List<getDoctors_Result> list)
        {
            DataTable dt = new DataTable();

            dt.Columns.Add("DoctorId");
            dt.Columns.Add("DoctorName");
            dt.Columns.Add("Address");
            dt.Columns.Add("DoctorType");
            dt.Columns.Add("Gender");
            dt.Columns.Add("Phone");
            dt.Columns.Add("SharePercentage");
            foreach (var item in list)
            {
                var row = dt.NewRow();

                row["DoctorId"] = item.DoctorId;
                row["DoctorName"] = item.DoctorName;
                row["Address"] = item.Address;
                row["DoctorType"] = item.DoctorType;
                row["Gender"] = item.Gender;
                row["Phone"] = item.Phone;
                row["SharePercentage"] = item.SharePercentage;

                dt.Rows.Add(row);
            }

            return dt;
        }

        public void GetAllDoctors()
        {
            List<getDoctors_Result> drList = nLDLL.getDoctors();

            DataTable dtDoctor = ConvertToDt_Doctor(drList);

            grdDoctor.DataSource = dtDoctor;
            grdDoctor.DataBind();

            ViewState["drData"] = dtDoctor;
            
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
                GetAllDoctors();
            }
        }

        protected void grdDoctor_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "updateRow")
            {
                int Result;
                int rowIndex = ((GridViewRow)((ImageButton)e.CommandSource).NamingContainer).RowIndex;

                tblDoctor dr = new tblDoctor();
                dr.DoctorId = Convert.ToInt32(e.CommandArgument);
                dr.DoctorName = ((TextBox)grdDoctor.Rows[rowIndex].FindControl("drName_Edit")).Text;
                dr.Address = ((TextBox)grdDoctor.Rows[rowIndex].FindControl("drAddress_Edit")).Text;
                dr.DoctorType = ((DropDownList)grdDoctor.Rows[rowIndex].FindControl("ddlDrType_Edit")).SelectedValue.ToString();
                dr.Phone = ((TextBox)grdDoctor.Rows[rowIndex].FindControl("drPhone_Edit")).Text;
                dr.SharePercentage = Convert.ToInt32(((TextBox)grdDoctor.Rows[rowIndex].FindControl("drSharePercentage_Edit")).Text);

                Result = nLDLL.updateDoctor(dr);

                grdDoctor.EditIndex = -1;
                GetAllDoctors();

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
                DataTable dt = (DataTable)ViewState["drData"];

                int rowIndex = ((GridViewRow)((ImageButton)e.CommandSource).NamingContainer).RowIndex;
                grdDoctor.EditIndex = rowIndex;

                GetAllDoctors();

                DropDownList ddlDrType = (DropDownList)grdDoctor.Rows[rowIndex].FindControl("ddlDrType_Edit");

                String DrType = dt.Rows[rowIndex]["DoctorType"].ToString();
                ddlDrType.SelectedValue = DrType;
            }
            else if (e.CommandName == "cancelRow")
            {
                grdDoctor.EditIndex = -1;
                GetAllDoctors();
            }
            else if (e.CommandName == "deleteRow")
            {
                int result;

                result = nLDLL.deleteDoctor(Convert.ToInt32(e.CommandArgument));
                if (result == 1)
                {
                    gridSuccess.Visible = true;
                    gridSuccess_Text.InnerText = "SuccessFully Deleted";

                    GetAllDoctors();
                }
                else
                {
                    gridError.Visible = true;
                    gridError.InnerText = "Error ! Not Deleted Try Again Please .";
                }

                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "moveBottom()", true);
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                tblDoctor dr = new tblDoctor();
                dr.DoctorName = drName.Text;
                dr.DoctorType = ddlDrType.SelectedValue;
                dr.Address = drAddress.Text;
                dr.Phone = drNo.Text;
                dr.SharePercentage = Convert.ToInt32(drPercentage.Text);

                String Gender = "Male";
                if (!rbtnMale.Checked)
                {
                    Gender = "Female";
                }

                dr.Gender = Gender;


                int Result = nLDLL.addDoctor(dr);

                if (Result == 1)
                {
                    clearFields();
                    naveed_Danger.Visible = false;
                    naveed_popup.Visible = true;
                    naveed_popup_text.InnerText = "Doctor Successfully Added";

                    GetAllDoctors();
                }
                else
                {
                    naveed_popup.Visible = false;
                    naveed_Danger.Visible = true;
                    naveed_Danger_Text.InnerText = "Error ! Please Add Again";
                }

                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "moveTop()", true);
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {

        }

        protected void grdDoctor_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdDoctor.PageIndex = e.NewPageIndex;
            GetAllDoctors();
        }

        #endregion
    }
}