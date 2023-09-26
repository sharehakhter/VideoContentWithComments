<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VideoContentsMainPage.aspx.cs" Inherits="WebAppVideoContent.WebForm2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.0.1/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.3/css/dataTables.bootstrap5.min.css" />

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

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
            /**/ /**/
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

        .custom-btn {
            background-color: #14763e;
            color: #ffffff;
            font-size: 18px;
            padding: 1px 13px;
            border-radius: 6px;
            border: none;
        }

            .custom-btn:hover {
                background-color: #64c88f;
            }

        .label-style {
            font-size: 16px;
            color: black;
            font-weight: bold;
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
       
                <asp:TextBox ID="txtSearchVideo" runat="server" Width="265px" />
        
                <asp:Button Text="Search" ID="btnSearchVideo"  class="custom-btn" OnClick="btnSearchVideo_Click" runat="server" />
        
                <br />
                <br />
            
                <asp:Label Text="Search Videos" cssclass="h3" ID="lblSearchVideos" runat="server" />
      
                <br />
                
                <asp:updatepanel ID="updtPanel" UpdateMode="Conditional" runat="server">
    <contenttemplate>

                <asp:GridView id="videoGrid" CssClass="gridStyle" OnRowCommand="videoGrid_RowCommand" OnRowDataBound="videoGrid_RowDataBound1" EmptyDataText="No Videos with that Name" AutoGenerateColumns="false" runat="server" >
            
                    <Columns>
                
                        <asp:TemplateField HeaderText="Videos">
                    
                            <ItemTemplate>                    
                        
                                <asp:label text="" ID="lblVidId" visible="false" runat="server" />

                                <div class="justify-text">

                                <asp:imagebutton imageurl="~/Images/modaraba.jpg"  cssclass="img-rounded" CommandName="ViewVideo" CommandArgument='<%# Container.DataItemIndex %>' ToolTip="Open Video" ID="imageButton" runat="server" />

                                <br />
                               
                                <br aria-grabbed="true" />
                                
                                <asp:label text="Description:" CssClass="label-style" runat="server" />

                                <br />

                                <asp:label text="" ID="lblVidDescription" CssClass="text-justify" runat="server" />

                                    </div>

                        </ItemTemplate>

                </asp:TemplateField>
               
                         <asp:TemplateField HeaderText="Video Title" >
                    
                            <ItemTemplate>
                                <div class="justify-text">
                        
                                    <asp:label text="" ID="lblVidName" runat="server" />
                            
                        </div>
                    </ItemTemplate>
                
                </asp:TemplateField>

            </Columns>

        </asp:GridView>

        
    </contenttemplate>
</asp:updatepanel>

            </center>
        </div>
    </form>
</body>
</html>
