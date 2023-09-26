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
    public partial class WebForm1 : System.Web.UI.Page
    {
        //To Fill GridViews Across The Code
        DataSet dtSet;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    string videoId = Session["SelectedVideoId"] as string;
                    if (!string.IsNullOrEmpty(videoId))
                    {
                        int videoIdInt = Convert.ToInt32(Session["SelectedVideoId"]);

                        //Bind Grid with VideoId
                        BindVidGridView(videoIdInt);

                        //Bind Repeaters
                        rptrComments.ItemDataBound += new RepeaterItemEventHandler(rptrComments_ItemDataBound);
                        ViewCommentsRptr();

                    }

                    string confirmationMessage = Session["ConfirmationMessage"] as string;
                    if (!string.IsNullOrEmpty(confirmationMessage))
                    {
                        Response.Write("<<script>alert('Your Comment was Posted. Thanks!')</script>");

                        Session.Remove("ConfirmationMessage");
                    }
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

        #region Video Work

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
            HtmlControl videoSource = (HtmlControl)row.FindControl("videoSource");
            Label lblVidName = (Label)row.FindControl("lblVidName");
            Label lblVidId = (Label)row.FindControl("lblVidId");
            Label lblVidDescription = (Label)row.FindControl("lblVidDescription");

            if (videoSource != null)
            {
                // Get the video path from the data source
                DataRowView dataRowView = (DataRowView)row.DataItem;

                string videoPath = dataRowView["VideoPath"].ToString();
                string videoName = dataRowView["VideoName"].ToString();
                string videoId = dataRowView["VideoId"].ToString();
                string deptName = dataRowView["DeptName"].ToString();
                string videoDescription = dataRowView["VideoDescription"].ToString();

                // Set the whole path as a string (for Debugging purposes)
                string finalPath = videoPath + deptName + "/" + videoName;

                // Set the video source
                videoSource.Attributes["src"] = finalPath;
                lblVidName.Text = videoName;
                lblVidId.Text = videoId;
                lblVidDescription.Text = videoDescription;
            }
        }

        private DataTable GetVideoDataFromDatabase(int videoId)
        {
            DataTable dt = new DataTable();
            string query = "SELECT * FROM VideoContent where VideoId = " + videoId + "";
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

        protected void BindVidGridView(int videoId)
        {
            DataTable videoDataTable = GetVideoDataFromDatabase(videoId);
            videoGrid.DataSource = videoDataTable;
            videoGrid.DataBind();
        }

        #endregion

        #region Comment Post

        protected void btnCommentPost_Click(object sender, EventArgs e)
        {
            Button btnPostComment = (Button)sender;
            GridViewRow row = (GridViewRow)btnPostComment.NamingContainer;

            //Find conrols
            HtmlTextArea txtComments = (HtmlTextArea)row.FindControl("txtComments");
            //TextBox txtComments = (TextBox)row.FindControl("txtComments");
            TextBox txtUser = (TextBox)row.FindControl("txtUser");
            Label lblVidId = (Label)row.FindControl("lblVidId");

            // Get the input text from the textarea
            string inputText = txtComments.Value;

            // Use a regular expression to remove HTML tags
            string cleanText = Regex.Replace(inputText, "<.*?>", String.Empty);

            CreateConnection();
            OpenConnection();

            sqlCommand.CommandText = "sp_Comments";
            sqlCommand.CommandType = CommandType.StoredProcedure;

            sqlCommand.Parameters.AddWithValue("@Comment", inputText);
            sqlCommand.Parameters.AddWithValue("@userN", Convert.ToString(txtUser.Text.Trim()));
            sqlCommand.Parameters.AddWithValue("@VideoId", Convert.ToInt32(lblVidId.Text));

            int m = sqlCommand.ExecuteNonQuery();
            if (m != 0)
            {
                txtUser.Text = txtComments.Value = "";
            }

            else
            {
                Response.Write("<<script>alert('Comment not Posted, try again')</script>");
            }

            CloseConnection();
            DisposeConnection();

            Session["ConfirmationMessage"] = "submitted";                       
            Response.Redirect("VideoContents.aspx");

        }
        #endregion

        public void ViewCommentsRptr()
        {
            foreach (GridViewRow row in videoGrid.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    Label lblVidId = (Label)row.FindControl("lblVidId");
                    if (lblVidId != null)
                    {
                        int videoId = Convert.ToInt32(lblVidId.Text);

                        CreateConnection();
                        OpenConnection();

                        sqlCommand.CommandText = "sp_ViewComments";
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.Parameters.AddWithValue("@VideoId", videoId);
                        sqlDataAdapter = new SqlDataAdapter(sqlCommand);
                        dtSet = new DataSet();
                        sqlDataAdapter.Fill(dtSet);
                        rptrComments.DataSource = dtSet;
                        rptrComments.DataBind();

                        CloseConnection();
                        DisposeConnection();
                    }
                }
            }
        }

        protected void rptrComments_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rptrReply = (Repeater)e.Item.FindControl("rptrReply");
                Label lblCommentId = (Label)e.Item.FindControl("lblCommentId");

                if (rptrReply != null && lblCommentId != null)
                {
                    int CommentId = Convert.ToInt32(lblCommentId.Text);

                    CreateConnection();
                    OpenConnection();

                    sqlCommand.CommandText = "sp_ViewReply";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@CommentId", CommentId);
                    sqlDataAdapter = new SqlDataAdapter(sqlCommand);
                    dtSet = new DataSet();
                    sqlDataAdapter.Fill(dtSet);

                    if (dtSet != null && dtSet.Tables.Count > 0 && dtSet.Tables[0].Rows.Count > 0)
                    {
                        rptrReply.DataSource = dtSet;
                        rptrReply.DataBind();
                    }
                    else
                    {
                        rptrReply.Visible = false;
                    }

                    CloseConnection();
                    DisposeConnection();

                    updtPanel.Update();
                }
            }
        }

        protected void rptrComments_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "ReplyForm")
            {
                ((Panel)e.Item.FindControl("PnlReplyForm")).Visible = true;
                ((Button)e.Item.FindControl("btnReply")).Visible = false;
            }

            if (e.CommandName == "Cancel")
            {
                ((TextBox)e.Item.FindControl("txtReplyComment")).Text = ((TextBox)e.Item.FindControl("txtUserComment")).Text = "";
                ((Panel)e.Item.FindControl("PnlReplyForm")).Visible = false;
                ((Button)e.Item.FindControl("btnReply")).Visible = true;

                updtPanel.Update();

            }

            else if (e.CommandName == "ReplyPost")
            {
               
                int CommentId = Convert.ToInt32(e.CommandArgument);

                if (CommentId != 0)
                {
                    CreateConnection();
                    OpenConnection();

                    sqlCommand.CommandText = "sp_Reply";
                    sqlCommand.CommandType = CommandType.StoredProcedure;

                    string ReplyComment = ((TextBox)e.Item.FindControl("txtReplyComment")).Text;
                    string userN = ((TextBox)e.Item.FindControl("txtUserComment")).Text;

                    sqlCommand.Parameters.AddWithValue("@ReplyComment", ReplyComment);
                    sqlCommand.Parameters.AddWithValue("@userN", userN);
                    sqlCommand.Parameters.AddWithValue("@CommentId", CommentId);
                    sqlDataAdapter = new SqlDataAdapter(sqlCommand);

                    int m = sqlCommand.ExecuteNonQuery();
                    if (m != 0)
                    {
                        //Clear Controls hide panel
                        ((TextBox)e.Item.FindControl("txtReplyComment")).Text = ((TextBox)e.Item.FindControl("txtUserComment")).Text = "";
                        ((Panel)e.Item.FindControl("PnlReplyForm")).Visible = false;
                        ((Button)e.Item.FindControl("btnReply")).Visible = true;
                    }

                    else
                    {
                        Response.Write("<<script>alert('Comment not Posted, try again')</script>");
                    }

                    CloseConnection();
                    DisposeConnection();

                    Session["ConfirmationMessage"] = "confirmation";

                    Response.Redirect("VideoContents.aspx");

                }
            }
        }
    }
}