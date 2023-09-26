using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Text.RegularExpressions;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Web.UI.HtmlControls;

namespace WebAppVideoContent
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        //To Fill GridViews Across The Code
        DataSet dtSet;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    BindVidGridView();
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

        #region GridView Menu Work

        protected void videoGrid_RowDataBound1(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // <video> element and set its source attribute
                VideoTagSourceSetup(e.Row);
            }
        }

        protected void VideoTagSourceSetup(GridViewRow row)
        {
            //HtmlControl videoSource = (HtmlControl)row.FindControl("videoSource");

            Label lblVidName = (Label)row.FindControl("lblVidName");
            Label lblVidId = (Label)row.FindControl("lblVidId");
            Label lblVidDescription = (Label)row.FindControl("lblVidDescription");

            if (lblVidName != null)
            {
                // Get the videoId from the data source
                DataRowView dataRowView = (DataRowView)row.DataItem;

                string videoName = dataRowView["VideoName"].ToString();
                string videoId = dataRowView["VideoId"].ToString();
                string videoDescription = dataRowView["VideoDescription"].ToString();

                lblVidName.Text = videoName;
                lblVidId.Text = videoId;
                lblVidDescription.Text = videoDescription;
            }
        }

        private DataTable GetVideoDataFromDatabase()
        {
            DataTable dt = new DataTable();
            string query = "SELECT * FROM VideoContent";
            using (SqlConnection connection = new SqlConnection(strConnectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    connection.Open();
                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    adapter.Fill(dt);
                }
            }
            return dt;
        }

        protected void BindVidGridView()
        {
            lblSearchVideos.Visible = true;
            videoGrid.Visible = false;
            DataTable videoDataTable = GetVideoDataFromDatabase();
            videoGrid.DataSource = videoDataTable;
            videoGrid.DataBind();
        }

        #endregion

        #region Searching

        protected void btnSearchVideo_Click(object sender, EventArgs e)
        {
            if (!videoGrid.Visible)
            {
                videoGrid.Visible = true;
            }

            string inputValue = txtSearchVideo.Text;

            if (string.IsNullOrEmpty(inputValue))
            {
                BindVidGridView();
            }

            else
            {
                SearchVideo();
                lblSearchVideos.Visible = false;
            }
        }

        public void SearchVideo()
        {
            CreateConnection();
            OpenConnection();

            sqlCommand.CommandText = "sp_SearchVideoName";
            sqlCommand.CommandType = CommandType.StoredProcedure;
            sqlCommand.Parameters.AddWithValue("@SearchVideo", Convert.ToString(txtSearchVideo.Text.Trim()));
            sqlDataAdapter = new SqlDataAdapter(sqlCommand);
            dtSet = new DataSet();
            sqlDataAdapter.Fill(dtSet);
            videoGrid.DataSource = dtSet;
            videoGrid.DataBind();

            CloseConnection();
            DisposeConnection();
        }

        #endregion

        #region Redirection

        protected void videoGrid_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewVideo")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = videoGrid.Rows[rowIndex];

                Label lblVidId = (Label)row.FindControl("lblVidId");
                string videoId = lblVidId.Text;

                // Store the videoId in a session variable
                Session["SelectedVideoId"] = videoId;

                // Use JavaScript to open the NextPage.aspx in a new tab
                string redirectUrl = ResolveUrl("~/VideoContents.aspx");
                string script = "window.open('" + redirectUrl + "', '_blank');";
                ScriptManager.RegisterStartupScript(this, GetType(), "OpenNewTab", script, true);

                updtPanel.Update();

            }
        }

        #endregion
    }
}