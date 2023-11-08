using CrystalDecisions.CrystalReports.Engine;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebAppVideoContent
{
    public partial class Reporting : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                try
                {
                    BindDDL();
                }
                catch (Exception ex)
                {

                }
            }
        }
        #region SQL Functions

        //Connection String
        private string strConnectionString = ConfigurationManager.ConnectionStrings["ConnStringDb1"].ConnectionString;
        private SqlCommand sqlCommand;
        private SqlDataAdapter sqlDataAdapter;

        public void CreateConnection()
        {
            SqlConnection sqlConnection = new SqlConnection(strConnectionString);
            sqlCommand = new SqlCommand();
            sqlCommand.Connection = sqlConnection;
        }

        public void OpenConnection()
        {
            sqlCommand.Connection.Open();
        }

        public void CloseConnection()
        {
            sqlCommand.Connection.Close();
        }

        public void DisposeConnection()
        {
            sqlCommand.Connection.Dispose();
        }

        #endregion

        public void BindDDL()
        {
            CreateConnection();
            OpenConnection();

            sqlCommand.CommandText = "sp_DdlVideo";
            sqlCommand.CommandType = CommandType.StoredProcedure;
            sqlDataAdapter = new SqlDataAdapter(sqlCommand);

            DataTable dt = new DataTable();
            sqlDataAdapter.Fill(dt);
            ddlVideo.DataSource = dt;
            ddlVideo.DataTextField = "VideoName";
            ddlVideo.DataValueField = "VideoId";
            ddlVideo.DataBind();
            ddlVideo.Items.Insert(0, new ListItem("--Select--", "0"));

            CloseConnection();
            DisposeConnection();
        }

        DataSet dtSet;

        public void GenerateReport()
        {
            CreateConnection();
            OpenConnection();

            string ddlinput = Convert.ToString(ddlVideo.SelectedItem.Text);

            sqlCommand.CommandText = "sp_VideoReport";
            sqlCommand.CommandType = CommandType.StoredProcedure;
            sqlCommand.Parameters.AddWithValue("@UserN", Convert.ToString(txtUserN.Text.Trim()));
            sqlCommand.Parameters.AddWithValue("@VideoName", ddlinput);
            sqlDataAdapter = new SqlDataAdapter(sqlCommand);
            dtSet = new DataSet();
            sqlDataAdapter.Fill(dtSet, "Table1");

            ReportDocument rept = new ReportDocument();
            rept.Load(Server.MapPath("~/VideoRpt.rpt"));
            rept.SetDataSource(dtSet.Tables["Table1"]);
            rept.SetParameterValue("@UserN", txtUserN.Text);
            rept.SetParameterValue("@VideoName", ddlinput);
            CrystalReportViewer1.ReportSource = rept;
            CrystalReportViewer1.DataBind();
            Clear();

            CloseConnection();
            DisposeConnection();
        }

        protected void btnGenerateRpt_Click(object sender, EventArgs e)
        {
            GenerateReport();
        }

        public void Clear()
        {
            txtUserN.Text = "";
            ddlVideo.ClearSelection();
        }
    }
}