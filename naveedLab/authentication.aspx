<%@ Page Title="Authentication" Language="C#" AutoEventWireup="true" CodeBehind="authentication.aspx.cs" Inherits="naveedLab.authentication" %>

<html>
<head>
    <title>Authentication</title>
    <link href="Content/bootstrap.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <h2 id="h3_Status" runat="server" style="text-align: center; margin-top: 14%; margin-bottom: 5%;">You cannot Access this Content ! Please LogIn </h2>
        <div class="col-md-offset-5 col-md-7">
            <asp:Button runat="server" Text="Log in" ID="btnSignIn" CssClass="btn btn-lg btn-primary btn_Font" PostBackUrl="~/SignIn.aspx" />
        </div>

        <br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />

        <div class="clearfix col-sm-10 col-sm-offset-1" style="border-bottom: 1.5px double #ccc; margin-bottom: 30px;">
            <p class="pull-right" style="font-size: 16px; color: #666; font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif">&copy;<%: DateTime.Now.Year%>-All Rights Reserved at <b>Zamp Technologies</b></p>
        </div>
    </form>
</body>
</html>
