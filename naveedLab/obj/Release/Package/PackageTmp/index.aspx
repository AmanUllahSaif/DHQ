<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="naveedLab.index" %>

<html>
<head>
    <title>DHQ Teaching Hospital</title>
    <script type="text/javascript">
        $(document).ready(function (e) {
            $("#home_Li").removeClass("active");
        });
    </script>

    <link rel="shortcut icon" href="LogoImages/PunjabGovtFavicon.ico" type="image/x-icon" />

    <script src="Scripts/jquery-1.10.2.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <div style="margin:0 auto; width:500px; margin-top:5% !important;">
            <img src="Images/dhqEquip.jpg" width="500" height="450" style="text-align: center;" />
            <br />
            <br />
            <br />
            <div class="col-md-offset-5 col-md-7">
                <asp:LinkButton runat="server" Text="LogIn" PostBackUrl="~/SignIn.aspx" ID="btnSignIn" CssClass="btn btn-lg btn-success btn_Font" ></asp:LinkButton>
            </div>
        </div>
    </form>
</body>
</html>
