using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace naveedLabDAL
{
    public class naveedLabDLL
    {
        NaveedLabFinalDBEntities dbContext = new NaveedLabFinalDBEntities();

        #region AddMethods

        public int addEmployees(tblEmployee empRecord)
        {
            try
            {
                dbContext.setEmployees(empRecord.Email, empRecord.Name, empRecord.Password, empRecord.Gender, empRecord.Address, empRecord.Designation, empRecord.Phone, Convert.ToInt32(empRecord.BranchFID));
                return 1;
            }
            catch
            {
                return 0;
            }
        }

        public int addDoctor(tblDoctor drRecord)
        {
            try
            {
                dbContext.setDoctor(drRecord.DoctorName, drRecord.Gender, drRecord.DoctorType, drRecord.Address, drRecord.Phone, Convert.ToInt32(drRecord.SharePercentage));
                return 1;
            }
            catch
            {
                return 0;
            }
        }

        public int addPatient(tblPatient patient)
        {
            try
            {
                System.Data.Entity.Core.Objects.ObjectParameter returnValue = new System.Data.Entity.Core.Objects.ObjectParameter("returnId", SqlDbType.Int);
                dbContext.DHQ_AddPatient(patient.PatientName, patient.Age, patient.Gender, patient.DoctorID, patient.Date, patient.EmailFID, patient.Phone, patient.monthlyNo,returnValue);

                int result = (int)returnValue.Value;

                return result;
            }
            catch
            {
                return -1;
            }
        }

        public void addTestsForPatient(DataTable dt, string employeeEmail, int PatientID)
        {
            List<selectPatientByID_Result> lstpatient = dbContext.selectPatientByID(PatientID).ToList();

            int age = 0;
            string gender = "";

            foreach (var patient in lstpatient)
            {
                age = Convert.ToInt32(patient.Age);
                gender = patient.Gender.ToString();
            }

            if (age <= 1)
            {
                age = 1;
            }
            else if (age >= 2 && age <= 12)
            {
                age = 2;
            }
            else if (age >= 13 && age <= 50 && gender == "Male")
            {
                age = 3;
            }
            else if (age > 50 && gender == "Male")
            {
                age = 4;
            }
            else if (age >= 13 && age <= 50 && gender == "Female")
            {
                age = 5;
            }
            else if (age > 50 && gender == "Female")
            {
                age = 6;
            }


            for (int i = 0; i < dt.Rows.Count; i++)
            {
                dbContext.spRegisterTest(PatientID, Convert.ToInt32(dt.Rows[i]["SelectedTestID"]), employeeEmail, Convert.ToInt32(dt.Rows[i]["Charges"]) - Convert.ToInt32(dt.Rows[i]["RemainingTestPrice"]), age, i);

            }
        }

        public void addTestParameterResult(int resultID, string parameterValue, int testID, int patientID)
        {
            dbContext.insertTestParameterResult(resultID, patientID, parameterValue, testID);
        }

        #endregion

        #region DeleteMethods

        public int deleteEmployee(string email)
        {
            try
            {
                dbContext.deleteEmployees(email);
                return 1;
            }
            catch
            {
                return 0;
            }
        }

        public int deleteDoctor(int drId)
        {
            try
            {
                dbContext.deleteDoctor(drId);
                return 1;
            }
            catch
            {
                return 0;
            }
        }

        public int deleteParameterFromSpecificAgeFactor(int ID)
        {
            return dbContext.deleteParameterFromSpecificAgeFactor(ID);
        }


        #endregion

        #region UpdateMethods

        public int updatedEmployees(tblEmployee emp)
        {
            try
            {
                dbContext.updateEmployees(emp.Email, emp.Name, emp.Address, emp.Designation, emp.BranchFID, emp.Phone);
                return 1;
            }
            catch
            {
                return 0;
            }
        }

        public int changePassword(string email, string Password)
        {
            try
            {
                dbContext.changePassword(email, Password);
                return 1;
            }
            catch
            {
                return 0;
            }
        }
        public int updateDoctor(tblDoctor dr)
        {
            try
            {
                dbContext.updateDoctor(dr.DoctorId, dr.DoctorName, dr.DoctorType, dr.Address, dr.Phone, dr.SharePercentage);
                return 1;
            }
            catch
            {
                return 0;
            }
        }

        public int addParameterFromSpecificAgeFactor(int ID, string value)
        {
            return dbContext.addParameterInSpecificAgeFactor(ID, value);
        }

        public int updateTestToPending(int ID)
        {
            return dbContext.setTestToPendingForUpdate(ID);
        }

        public int updateTestToPrinted(int ID)
        {
            return dbContext.setTestToPrinted(ID);
        }
        public int updatePatient(tblPatient ptData)
        {
            try
            {
                dbContext.updatePatient(ptData.PatientID, ptData.PatientName, ptData.Age, ptData.Gender, ptData.Phone);
                return 1;
            }
            catch
            {
                return 0;
            }
        }

        #endregion

        #region SelectMethods
        public int GetDoctor_ID(int patientID)
        {
            System.Data.Entity.Core.Objects.ObjectParameter output = new System.Data.Entity.Core.Objects.ObjectParameter("outPut", SqlDbType.Int);
            dbContext.getDoctorID(patientID, output);
            return (int)output.Value;
        }
        public List<sp_GetDailyPatientID_Result> getDailyID(DateTime date)
        {
            return dbContext.sp_GetDailyPatientID(date).ToList();
        }

        public List<sp_SelectTestYearlyCount_Result> getYearlyCount(String year)
        {
            return dbContext.sp_SelectTestYearlyCount(year).ToList();
        }

        public List<sp_SelectTestMonthlyCount_Result> getMonthlyCount(String testName, DateTime startDate, DateTime endDate)
        {
            return dbContext.sp_SelectTestMonthlyCount(testName,startDate,endDate).ToList();
        }

        public List<sp_CountDoctor_Result> getDoctorCount(String year)
        {
            return dbContext.sp_CountDoctor(year).ToList();
        }

        public List<getAllBranches_Result> getAllBranches()
        {
            return dbContext.getAllBranches().ToList();
        }

        public List<getEmployees_Result> getEmployee()
        {
            return dbContext.getEmployees().ToList();
        }

        public List<signInUser_Result> signInData(string email, string Password)
        {
            return dbContext.signInUser(email, Password).ToList();
        }

        public List<getDoctors_Result> getDoctors()
        {
            return dbContext.getDoctors().ToList();
        }

        public List<selectChapter_Result> getAllChapters()
        {
            return dbContext.selectChapter().ToList();
        }

        public List<selectAgeFactor_Result> getAllAgeFactors()
        {
            return dbContext.selectAgeFactor().ToList();
        }

        public List<selectTestInChapter_Result> getTestByID(int chapterID)
        {
            return dbContext.selectTestInChapter(chapterID).ToList();
        }

        public List<selectTestParametersInAgeRange_Result> getTestParametersByAge(int ageFactor, int testID)
        {
            return dbContext.selectTestParametersInAgeRange(ageFactor, testID).ToList();
        }

        public int isPrinted(int patientID)
        {
            System.Data.Entity.Core.Objects.ObjectParameter output = new System.Data.Entity.Core.Objects.ObjectParameter("output", SqlDbType.Int);
            dbContext.spIsPrinted(patientID, output);
            return (int)output.Value;
        }

        public List<spSelectTestName_Result> getTestName(int testID)
        {
            return dbContext.spSelectTestName(testID).ToList();

        }

        public List<selectPatientNameAndTests_Result> getPatientNameAndTests(int patientID)
        {
            return dbContext.selectPatientNameAndTests(patientID).ToList();
        }

        //OLD METHOD
        //public List<selectPatientTestsForAddingResult_Result> getPatientTestForAddingValue(int patientID)
        //{
        //    return dbContext.selectPatientTestsForAddingResult(patientID).ToList();
        //}

        public List<selectTestParametersForResult_Result> getTestParametersForAddingValue(int testID)
        {
            return dbContext.selectTestParametersForResult(testID).ToList();
        }

        public List<selectPatientByID_Result> getPatientByID(int ID)
        {
            return dbContext.selectPatientByID(ID).ToList();
        }
        public List<spSelectTestsRegisteredByPatient_Result> getPatientTestsByID(int ID)
        {
            List<spSelectTestsRegisteredByPatient_Result> lstOfTest = new List<spSelectTestsRegisteredByPatient_Result>();
            return dbContext.spSelectTestsRegisteredByPatient(ID).ToList();  
        }

        public List<sp_Load_Flag_Result> load_Flag(string status, int pId)
        {
            return dbContext.sp_Load_Flag(status, pId).ToList();
        }

        public DataTable getPatientTestsByTestID(int ID)
        {
            List<spSelectTestsRegisteredByPatient_Result> lstOfTest = new List<spSelectTestsRegisteredByPatient_Result>();
            lstOfTest = dbContext.spSelectTestsRegisteredByPatient(ID).ToList();

            DataTable dt = ConvertToDatatable(dbContext.selectResultForPrint(ID).ToList());
            
            return dt;
        }

        public List<selectResultedTest_Result> getResultedTest(int ID)
        {
            return dbContext.selectResultedTest(ID).ToList();
        }

        public List<selectResultForPrint_Result> getResultForPrint(int ID)
        {
            return dbContext.selectResultForPrint(ID).ToList();
        }

        public List<selectAlreadyPrintedTest_Result> getAlreadyPrintedTest(int ID)
        {
            return dbContext.selectAlreadyPrintedTest(ID).ToList();
        }

        public List<sp_CalculateDoctor_Result> getDoctorResult(int ID, DateTime startDate, DateTime endDate)
        {
            return dbContext.sp_CalculateDoctor(ID, startDate, endDate).ToList();
        }

        public List<sp_CalculateSales_Result> getSalesResult(DateTime startDate, DateTime endDate, String calType)
        {
            return dbContext.sp_CalculateSales(startDate, endDate, calType).ToList();
        }

        public List<sp_CalculatePatientReport_Result> getPatientResult(int id)
        {
            return dbContext.sp_CalculatePatientReport(id).ToList();
        }

        public List<sp_CalculatePatientBill_Result> getPatientInfo(int id)
        {
            return dbContext.sp_CalculatePatientBill(id).ToList();
        }

        public List<sp_CalculateBill_Result> getPatientFinalBill(int id)
        {
            return dbContext.sp_CalculateBill(id).ToList();
        }

        public int chkPatient(int patientID)
        {

            System.Data.Entity.Core.Objects.ObjectParameter output = new System.Data.Entity.Core.Objects.ObjectParameter("patinentCheck", SqlDbType.Int);
            dbContext.spChkPatientTest(patientID, output);
            return (int)output.Value;
        }

        public int chkBill(int patientID)
        {
            System.Data.Entity.Core.Objects.ObjectParameter output = new System.Data.Entity.Core.Objects.ObjectParameter("remaingAmount", SqlDbType.Int);
            dbContext.sp_ChkBil(patientID, output);
            return (int)output.Value;
        }

        static DataTable ConvertToDatatable(List<selectResultForPrint_Result> list)
        {
            DataTable dt = new DataTable();
            
            dt.Columns.Add("PatientTestId");
            dt.Columns.Add("StandardValue");
            dt.Columns.Add("ValueResult");
            dt.Columns.Add("Name");
            foreach (var item in list)
            {
                var row = dt.NewRow();

                row["PatientTestId"] = item.PatientTestId;
                row["StandardValue"] = item.StandardValue;
                row["ValueResult"] = item.ValueResult;
                row["Name"] = item.Name;

                dt.Rows.Add(row);
            }

            return dt;
        }

        public void updateMoneyInPatient(decimal patientID, decimal PaidAmount,decimal RemainingAmount)
        {
            dbContext.spUpdatePatientDiscountedCost(patientID, PaidAmount,RemainingAmount);
        }

        public int FinalRemaingBill(int patientID,int amount)
        {
            System.Data.Entity.Core.Objects.ObjectParameter output = new System.Data.Entity.Core.Objects.ObjectParameter("output", SqlDbType.Int);
            dbContext.spAcceptRemainingPayment(patientID, amount, output);
            return (int)output.Value;
        }

        #endregion

        #region supportingMethods

        #endregion

        #region SearchMethods
        public List<selectPatient_Result> selectPatient(int pId)
        {
            return dbContext.selectPatient(pId).ToList();
        }
        #endregion

        //Updated Method

        public DataTable getPatientTests(int ID)
        {
            return ConvertToDatatable_1(dbContext.selectPatientTests(ID).ToList());
        }

        static DataTable ConvertToDatatable_1(List<selectPatientTests_Result> list)
        {
            DataTable dt = new DataTable();

            dt.Columns.Add("SelectedTestID");
            dt.Columns.Add("TestName");
            dt.Columns.Add("Charges");
            dt.Columns.Add("PercentageDiscount");
            dt.Columns.Add("RemainingTestPrice");
            dt.Columns.Add("ChapterFID");
            foreach (var item in list)
            {
                var row = dt.NewRow();

                row["SelectedTestID"] = item.SelectedTestID;
                row["ChapterFID"] = item.ChapterFID;
                row["TestName"] = item.TestName;
                row["Charges"] = item.Charges;
                row["PercentageDiscount"] = item.PercentageDiscount;
                row["RemainingTestPrice"] = item.RemainingTestPrice;

                dt.Rows.Add(row);
            }

            return dt;
        }

        //Updated Method

        public List<selectPatientTestsForAddingResult_Result> getPatientTestForAddingValue(int patientID)
        {
            return dbContext.selectPatientTestsForAddingResult(patientID).ToList();
        }

        //New Method

        public List<selectPatientTestsForAddingResultForUpdate_Result> getPatientTestForAddingValueForUpdate(int patientID)
        {
            return dbContext.selectPatientTestsForAddingResultForUpdate(patientID).ToList();
        }

        //New Method

        public List<selectPreviousBill_Result> getPreviousBill(int patientID)
        {
            return dbContext.selectPreviousBill(patientID).ToList();
        }



    }
}