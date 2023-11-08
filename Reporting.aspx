<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Reporting.aspx.cs" Inherits="WebAppVideoContent.Reporting" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.3500.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">

    <title></title>

    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.0.1/css/bootstrap.min.css" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="crystalreportviewers13/js/crviewer/crv.js"></script>
    <style type="text/css">
        body {
            font-family: Arial;
            margin: 0;
        }

        .error-message {
            color: red;
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

        .custom-btn {
            background-color: #14763e; /* Bootstrap's btn-info background color */
            color: #ffffff;
            font-size: 18px;
            padding: 2px 18px;
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

        .topnav {
            background-color: #333;
            overflow: hidden;
        }

            /* Style the links inside the navigation bar */
            .topnav a {
                float: left;
                color: #f2f2f2;
                text-align: center;
                padding: 14px 16px;
                text-decoration: none;
                font-size: 17px;
            }

                /* Change the color of links on hover */
                .topnav a:hover {
                    background-color: #ddd;
                    color: black;
                }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

            <div class="topnav">
                <a href="VideoContentsMainPage.aspx">Home</a>
                <a class="active" href="Reporting.aspx">Comment Reports</a>
            </div>
            <div class="header">
                <h1>VIDEO WORK</h1>
            </div>
            <br />
            <center>
             <asp:Label Text="Fill Report Form" cssclass="h4" ID="lblReportForm" runat="server" />
<br />
                <br />            
            <asp:Label Text="Enter User Name" runat="server" />
            <asp:TextBox ID="txtUserN" runat="server" />
            <asp:Label Text="Select Video Name" runat="server" />
            <asp:DropDownList ID="ddlVideo" runat="server" Height="18px" Width="94px">
            </asp:DropDownList>                
                <br />
                <asp:requiredfieldvalidator CssClass="error-message" errormessage="Please Enter User Name" ValidationGroup="UserValidate" controltovalidate="txtUserN" runat="server"/>
                <br />
                <asp:button ID="btnGenerateRpt" text="Generate Report" ValidationGroup="UserValidate" onclick="btnGenerateRpt_Click" class="custom-btn" runat="server" />

    <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true" EnableParameterPrompt="False" EnableTheming="False" EnableToolTips="False" 
            HasCrystalLogo="False" HasDrilldownTabs="False" HasDrillUpButton="False" 
            HasToggleGroupTreeButton="False" HasToggleParameterPanelButton="False" 
            ShowAllPageIds="True" HasSearchButton="False" ToolPanelView="None" Height="50px" Width="350px" />

                </center>
        </div>
    </form>
</body>
</html>
