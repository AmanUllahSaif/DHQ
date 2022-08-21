<%@ Page Title="Sign In" Language="C#" AutoEventWireup="true" CodeBehind="SignIn.aspx.cs" Inherits="naveedLab.SignIn" %>

<html>
<head>
    <title>Sign In</title>
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
        <div class="col-sm-4 col-md-4 col-md-offset-4" style="margin-top: 10%">
            <div class="panel panel-success">
                <div class="panel-heading">
                    <h3 class="panel-title" style="font-size: 30px !important;"><span class="glyphicon glyphicon-cog" aria-hidden="true"></span>&nbsp;Sign In</h3>
                </div>
                <div class="panel-body">
                    <ul id="ul_Change_Password" runat="server" visible="false">
                        <li style="color:#B94A48;">
                            <asp:Label ID="lblError" runat="server" CssClass="text-danger"></asp:Label>
                        </li>
                    </ul>
                    <div class="col-md-12 col-sm-12">
                        <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control textBox_Class" Placeholder="Enter Your Email" TextMode="SingleLine" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" CssClass="text-danger" ErrorMessage="The Email field is required." Display="Dynamic" ValidationGroup="vg" />
                    </div>
                    <br />
                    <div class="col-md-12 col-sm-12">
                        <asp:TextBox runat="server" ID="txtPassword" TextMode="Password" Placeholder="Enter Your Password" CssClass="form-control textBox_Class" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPassword" CssClass="text-danger" Display="Dynamic" ErrorMessage="The password field is required." ValidationGroup="vg" />
                    </div>
                    <br />
                    <br />
                    <div class="col-md-offset-4 col-md-8">
                        <asp:Button runat="server" Text="Log in" ID="btnSignIn" OnClick="btnSignIn_Click" CssClass="btn btn-lg btn-success btn_Font" ValidationGroup="vg" />
                    </div>

                </div>
            </div>
            <br />
            <br />
            <br />
            <br />
            <br />
        </div>
        <div class="clearfix col-sm-10 col-sm-offset-1" style="border-bottom: 1.5px double #ccc; margin-bottom: 30px;">
            <p class="pull-right" style="font-size: 16px; color: #666; font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif">&copy;<%: DateTime.Now.Year%>-All Rights Reserved at <b>Zamp Technologies</b></p>
        </div>
    </form>
</body>
</html>
