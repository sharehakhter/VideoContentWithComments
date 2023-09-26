<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" CodeBehind="VideoContents.aspx.cs" Inherits="WebAppVideoContent.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title></title>

    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.0.1/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.3/css/dataTables.bootstrap5.min.css" />

    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/emojionearea@3/dist/emojionearea.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/emojionearea@3/dist/emojionearea.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#txtComments").emojioneArea();
            pickerPosition: "top"
        });
    </script>
    <script type="text/javascript">
        document.getElementById("emojiButton").addEventListener("click", function () {
            var actElem = document.getElementById("txtComments");
            var actText = actElem.value;

            actElem.value =
              actText.slice(0, actElem.selectionStart) +
              this.getText() +
              actText.slice(actElem.selectionEnd);
        });
    </script>

    <script type="text/javascript" charset="utf-8" src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script type="text/javascript" charset="utf-8" src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="https://cdn.datatables.net/1.11.3/js/dataTables.bootstrap5.min.js"></script>

    <script type="text/javascript">

        $(document).ready(function () {

            $('#example').DataTable();

        });

    </script>


    <style type="text/css">
        body {
            font-family: Arial;
            margin: 0;
        }

        .auto-style1 {
            height: 30px;
        }

        .error-message {
            color: red;
        }

        .gridStyle {
            font-family: Arial, Helvetica, sans-serif;
            border-collapse: collapse;
            width: 50%;
            margin: 0 auto;
        }

            .gridStyle td, .gridStyle th {
                border: 1px solid #ddd;
                padding: 8px;
            }

            .gridStyle tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            .gridStyle th {
                padding-top: 12px;
                padding-bottom: 12px;
                text-align: left;
                background-color: #14763e;
                color: white;
            }

        .header {
            padding: 40px;
            text-align: center;
            background: #14763e;
            color: white;
            font-size: 30px;
        }

        div {
            border-radius: 5px;
            background-color: #f2f2f2;
            padding: 20px;
        }

        .commentgridStyle {
            font-family: Arial, Helvetica, sans-serif;
            border-collapse: collapse;
            width: 50%;
        }

            .commentgridStyle td, .commentgridStyle th {
                border: 1px solid #ddd;
                padding: 8px;
            }

            .commentgridStyle tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            .commentgridStyle th {
                padding-top: 12px;
                padding-bottom: 12px;
                text-align: left;
                background-color: #14763e;
                color: white;
            }

        .replygridStyle {
            font-family: Arial, Helvetica, sans-serif;
            border-collapse: collapse;
            width: 50%;
        }

            .replygridStyle td, .replygridStyle th {
                border: 1px solid #ddd;
                padding: 5px;
                border-radius: 10px; /* Adjust the radius value as needed */
            }

            .replygridStyle tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            .replygridStyle th {
                padding-top: 12px;
                padding-bottom: 12px;
                text-align: left;
                background-color: #14763e;
                color: white;
                border-radius: 10px;
            }

        .custom-btn {
            background-color: #14763e; /* Bootstrap's btn-info background color */
            color: #ffffff;
            font-size: 18px;
            padding: 10px 20px;
            border-radius: 6px;
            border: none;
        }

            .custom-btn:hover {
                background-color: #64c88f;
            }

        .custom-btn-sm {
            background-color: #14763e; /* Bootstrap's btn-info background color */
            color: #ffffff;
            width: 80px;
            font-size: 10px;
            padding: 10px 10px;
            border-radius: 6px;
            border: none;
        }

            .custom-btn-sm:hover {
                background-color: #64c88f;
            }

        .label-style {
            font-size: 16px;
            color: black;
            font-weight: bold;
        }

        .justify-text {
            text-align: justify;
        }

        /* Increase the modal's width */
        .modal-dialog {
            max-width: 1500px; /* Set your desired width */
        }

        /* Increase the modal's height */
        .modal-content {
            height: 500px; /* Set your desired height */
        }
        /* Adjust modal content */
        .modal-body {
            max-height: 500px; /* Set your desired content height */
            overflow-y: auto; /*Add vertical scroll if content exceeds height */
        }
    </style>

</head>

<body>

    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <div class="header">

                <h1>VIDEO WORK</h1>

            </div>

            <br />

            <center>
                
                <asp:GridView id="videoGrid" CssClass="gridStyle" OnRowDataBound="videoGrid_RowDataBound1" EmptyDataText="No Videos with that Name" AutoGenerateColumns="false" runat="server" >           
                    <Columns>          
                        <asp:TemplateField HeaderText="Video">            
                            <ItemTemplate>
                                <div class="justify-text">
                    
                                <video width="640" height="360" controls id="videoElement">
                        
                                    <source runat="server" id="videoSource" type="video/mp4"></source>
                                
                                </video>

                                <br />

                                <br />

                                <asp:label text="Video Title: " cssclass="label-style" runat="server" />
                                   
                                <asp:label text="" ID="lblVidName" cssclass="h7" runat="server" />

                                <br />

                                <br />
                                
                                <asp:label text="Description:" cssclass="label-style" runat="server" />
                                
                                <br />
                                
                                <asp:label text="" ID="lblVidDescription" runat="server" />

                                    </div>

                                <br />

                                <asp:label text="" ID="lblVidId" visible="false" runat="server" />

                                <br />
                        
                            <div class="container">
  
                                <button type="button" class="custom-btn" data-toggle="modal" data-target="#CommentModal">Comment</button>

  <!-- Modal -->
  <div class="modal fade" id="CommentModal" role="dialog">
    
      <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
      
            <div class="modal-header">
          
                      <h4 class="modal-title">Write Your Comment</h4>
        
            </div>
        
          <div class="modal-body">

<div class="form-group">

    <p class="modal-paragraph">Enter Your Name</p>

            <asp:textbox ID="txtUser" PlaceHolder="Your Name" runat="server" Width="356px" CssClass="form-control" />                      
                  <asp:requiredfieldvalidator errormessage="*Enter Your Name" ID="reqUser" CssClass="error-message" controltovalidate="txtUser" ValidationGroup="CommentForm" runat="server"/>
                        
                        <br />
                        <br />
    
    <p class="modal-paragraph">Enter Your Comment</p>
        
     <textarea id="txtComments" runat="server" placeholder="Add a Comment" ClientIDMode="Static" cssclass="form-control" rows="10" width="250px" Height="100px" style="resize:none"></textarea>  
    <button id="emojiButton">Insert Emojis</button>
 
<%--    <asp:textbox ID="txtComments" PlaceHolder="Add a Comment" runat="server" TextMode="MultiLine"  CssClass="form-control"  Rows="15" Width="350px" Height="100px" style="resize:none" />--%>
<%--                      <asp:requiredfieldvalidator errormessage="*Enter Commment" ID="reqComment" ControlToValidate="txtComments" InitialValue="" CssClass="error-message" ValidationGroup="CommentForm" runat="server"/>--%>
                        
                        <br />
                        <br />
                    
    <asp:button text="Post" class="custom-btn" ID="btnCommentPost" ValidationGroup="CommentForm" OnClick="btnCommentPost_Click" runat="server" Width="123px" />

</div>
        <div class="modal-footer">

          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        
        </div>

      </div>

    </div>

  </div>

</div>
                        </ItemTemplate>

                </asp:TemplateField>

            </Columns>

        </asp:GridView>

            </center>

            <div class="justify-text">

                <asp:Label Text="Comments" CssClass="h4" ID="lblheadingComment" Visible="false" runat="server"></asp:Label>

            </div>

            <asp:UpdatePanel runat="server" ID="updtPanel" UpdateMode="Conditional">
                <ContentTemplate>

                    <asp:Repeater ID="rptrComments" OnItemCommand="rptrComments_ItemCommand" runat="server">
                        <HeaderTemplate>
                            <table id="example" class="table table-striped" style="width: 50%">
                                <thead>
                                    <tr>
                                        <th>Comments</th>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <asp:Label Text='<%# Eval("CommentId") %>' ID="lblCommentId" Visible="false" runat="server" />
                                    <asp:Label Text='<%# Eval("UserN") %>' ID="lblUser" CssClass="text-muted" runat="server" />
                                    <br />
                                    <asp:Label Text='<%# Eval("Comment") %>' ID="lblComments" HtmlEncode="false" runat="server"></asp:Label>

                                    <%-- COMMENT REPLIES --%>

                                    <br />
                                    <br />

                                    <asp:Repeater ID="rptrReply" runat="server">
                                        <HeaderTemplate>
                                            <table id="example" class="table table-stripped" style="width: 25%">
                                                <thead>
                                                    <tr>
                                                        <th>Replies</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr>
                                                <td>
                                                    <asp:Label Text='<%# Eval("UserN") %>' ID="lblUserR" CssClass="text-muted" runat="server" />
                                                    <br />
                                                    <asp:Label Text='<%# Eval("ReplyComment") %>' ID="lblReply" runat="server" />
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </tbody>
                                    </table>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </td>
                                <td>
                                    <asp:Button ID="btnReply" CommandName="ReplyForm" Text="Reply" class="custom-btn-sm" runat="server" />
                                    <asp:Panel ID="PnlReplyForm" Visible="false" runat="server">

                                        <asp:TextBox ID="txtReplyComment" PlaceHolder="Reply to this Comment" TextMode="MultiLine" CssClass="form-control" Rows="15" Width="350px" Height="100px" Style="resize: none" runat="server" />
                                        <asp:RequiredFieldValidator ErrorMessage="Please Enter Comment" ValidationGroup="ReplyForm" ControlToValidate="txtReplyComment" runat="server" />

                                        <asp:TextBox ID="txtUserComment" PlaceHolder="*Enter User" CssClass="form-control" runat="server" />
                                        <asp:RequiredFieldValidator ErrorMessage="Please Enter UserName" ValidationGroup="ReplyForm" ControlToValidate="txtUserComment" runat="server" />
                                        <br />
                                        <asp:Button ID="btnReplyPost" Text="Post" ValidationGroup="ReplyForm" runat="server" CommandArgument='<%# Eval("CommentId") %>' CommandName="ReplyPost" class="custom-btn-sm" />
                                        <asp:Button ID="btnCancel" Text="Cancel" runat="server" CommandName="Cancel" class="custom-btn-sm" />
                                    </asp:Panel>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </tbody>
                    </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </form>
</body>
</html>
