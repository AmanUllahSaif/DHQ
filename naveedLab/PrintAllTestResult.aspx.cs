using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using naveedLabDAL;

namespace naveedLab
{
    public partial class PrintAllTestResult : System.Web.UI.Page
    {
        naveedLabDLL nlDLL = new naveedLabDLL();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Request.QueryString["PatientID"] != null && Request.QueryString["Duplicate"] != null)
                {
                    List<spSelectTestsRegisteredByPatient_Result> lstTests = new List<spSelectTestsRegisteredByPatient_Result>();
                    int patientID = 0;
                    try
                    {
                        patientID = Convert.ToInt32(Request.QueryString["PatientID"]);
                        hlblpatientID.Value = Request.QueryString["PatientID"];
                    }
                    catch
                    {
                    }

                    lstTests = nlDLL.getPatientTestsByID(patientID);

                    List<selectPatientByID_Result> lstPatient = new List<selectPatientByID_Result>();
                    lstPatient = nlDLL.getPatientByID(Convert.ToInt32(hlblpatientID.Value));

                    foreach (var patient in lstPatient)
                    {
                        lblName.Text = patient.PatientName;
                        lblGender.Text = patient.Gender;
                        lblAge.Text = patient.Age.ToString();
                        lblDate.Text = System.DateTime.Now.ToString();
                    }

                    if ( lstTests.Count != 0)
                    {
                        grdMain.DataSource = lstTests;
                        grdMain.DataBind();
                    }
                }
            }
        }                        

        protected void grdMain_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)// Bind nested grid view with parent grid view
            {
                GridView childgrd = (GridView)e.Row.FindControl("dgvTestResultValue"); // find nested grid view from paretn grid veiw
                int TestID = Convert.ToInt32(((HiddenField)e.Row.FindControl("hlblTestID")).Value);

                childgrd.DataSource = nlDLL.getPatientTestsByTestID(TestID);
                childgrd.DataBind();
            }
        }
    }
}