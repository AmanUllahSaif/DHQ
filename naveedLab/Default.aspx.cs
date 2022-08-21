using naveedLabDAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.DataVisualization.Charting;
using System.Web.UI.WebControls;

namespace naveedLab
{
    public partial class Default : System.Web.UI.Page
    {
        NaveedLabFinalDBEntities dbContext = new NaveedLabFinalDBEntities();
        SqlConnection conn = new SqlConnection("Data Source=(local); Database=NaveedLabFinalDB; Integrated Security=true");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["LoginSession"] == null)
            {
                Response.Redirect("~/authentication.aspx");
            }
            else
            {

            String year = DateTime.Now.ToString("yyyy");

            //int CurreYearCost = (from x in dbContext.tblPatients where x.Date  select x.TotalDiscountedCost).FirstOrDefault();

            string que3 = " select ISNULL(SUM(TotalDiscountedCost),0) as Total_Cost,tblPatient.PatientName from tblPatient  where  tblPatient.Date Like '%'+ @Year+'%' Group By PatientName ";

            SqlCommand com3 = new SqlCommand(que3, conn);
            com3.Parameters.AddWithValue("@Year", year);
            SqlDataAdapter da3 = new SqlDataAdapter(com3);
            DataTable ds3 = new DataTable();
            da3.Fill(ds3);

            


                int TotalEmployess = (from x in dbContext.tblEmployees select x).Count();
                int TotalPatients = (from x in dbContext.tblPatients select x).Count();
                int TotalDoctors = (from x in dbContext.tblDoctors select x).Count();

                DateTime CurrentDay = DateTime.Now;

                int day = CurrentDay.Day;

                string que = "select  isnull(sum(cast(isnull(TotalDiscountedCost,'0') as INT)),'0') as DaySale from tblPatient where tblPatient.Date=CAST(CURRENT_TIMESTAMP AS DATE)";
                conn.Open();
                SqlCommand cmd = new SqlCommand(que, conn);

                SqlDataAdapter dap = new SqlDataAdapter(cmd);

                DataTable Sale = new DataTable();
                dap.Fill(Sale);
                conn.Close();

                String DaySale = Sale.Rows[0]["DaySale"].ToString();



                ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript:TotalEmployess('" + TotalEmployess + "');TotalPatients('" + TotalPatients + "');TotalDaySale('" + DaySale + "');TotalDoctors('" + TotalDoctors + "')", true);


                



            }
        }
    }
}