<%@ Page Title="Sales Report" Language="C#" MasterPageFile="~/naveedLab.Master" AutoEventWireup="true" CodeBehind="salesReport.aspx.cs" Inherits="naveedLab.salesReport" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>


<asp:Content ID="Content1" ContentPlaceHolderID="headerData" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyData" runat="server">
    <div class="row">
        <div class="col-lg-12" id="topMove">
            <br />
            <br />
            <h1 class="page-header">Yearly/Monthly Report
            </h1>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div runat="server" class="alert alert-success successClass" role="alert" id="naveed_Success">
                <h2 style="text-align: center;">Yearly Counted Report
                </h2>
                <br />
                <h4 runat="server" id="lblYear" style="text-align: center;" class="text-danger"></h4>
                <br />
                <asp:Button runat="server" ID="btnYearly" OnClick="btnYearly_Click" Text="Print Yearly Report" CssClass="col-sm-offset-5 btn btn-danger btn-lg" />
                <br />
                <br />
            </div>
            <br />
            <br />
            <div runat="server" class="alert alert-warning successClass" role="alert" id="Div1">
                <h2 style="text-align: center;">Monthly Counted Report
                </h2>
                <br />
                <div class="form-group" runat="server">
                    <div class="col-md-12">
                        <asp:DropDownList ID="ddlMonth" runat="server" CssClass="form-control col-md-offset-4" Width="32%">
                            <asp:ListItem Value="0">- Select Month -</asp:ListItem>
                            <asp:ListItem Text="January" Value="01"></asp:ListItem>
                            <asp:ListItem Text="Febraury" Value="02"></asp:ListItem>
                            <asp:ListItem Text="March" Value="03"></asp:ListItem>
                            <asp:ListItem Text="April" Value="04"></asp:ListItem>
                            <asp:ListItem Text="May" Value="05"></asp:ListItem>
                            <asp:ListItem Text="June" Value="06"></asp:ListItem>
                            <asp:ListItem Text="July" Value="07"></asp:ListItem>
                            <asp:ListItem Text="August" Value="08"></asp:ListItem>
                            <asp:ListItem Text="September" Value="09"></asp:ListItem>
                            <asp:ListItem Text="October" Value="10"></asp:ListItem>
                            <asp:ListItem Text="November" Value="11"></asp:ListItem>
                            <asp:ListItem Text="December" Value="12"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator CssClass="text-danger col-md-offset-4" InitialValue="0" ID="RFVMonth" runat="server" ValidationGroup="VGDCTR" ControlToValidate="ddlMonth" ErrorMessage="Month Is Required"></asp:RequiredFieldValidator>
                        <br />
                    </div>
                </div>
                <br />
                <div class="form-group" runat="server">
                    <div class="col-md-12">
                        <asp:DropDownList ID="ddlTest" runat="server" CssClass="form-control col-md-offset-4" Width="32%">
                            <asp:ListItem Value="0">- Select Test -</asp:ListItem>
                            <asp:ListItem Text="SGOT (AST)" Value="1"></asp:ListItem>
                            <asp:ListItem Text="SGPT (ALT)" Value="2"></asp:ListItem>
                            <asp:ListItem Text="Anti HCV" Value="3"></asp:ListItem>
                            <asp:ListItem Text="HBsAg" Value="4"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator CssClass="text-danger col-md-offset-4" InitialValue="0" ID="RequiredFieldValidator1" runat="server" ValidationGroup="VGDCTR" ControlToValidate="ddlTest" ErrorMessage="Test Name Is Required"></asp:RequiredFieldValidator>
                        <br />
                    </div>
                </div>
                <br />
                <br />
                <h4 runat="server" id="lblMonth" style="text-align: center;" class="text-danger"></h4>
                <br />
                <asp:Button runat="server" ID="btnMonthly" OnClick="btnMonthly_Click" ValidationGroup="VGDCTR" Text="Print Monthly Report" CssClass="col-sm-offset-5 btn btn-danger btn-lg" />
                <br />
                <br />
            </div>
            <br />
            <br />
            <div runat="server" class="alert alert-success successClass" role="alert" id="Div2">
                <h2 style="text-align: center;">Doctor Counted Report
                </h2>
                <br />
                <h4 runat="server" id="H1" style="text-align: center;" class="text-danger"></h4>
                <br />
                <asp:Button runat="server" ID="btnDoctorCount" OnClick="btnDoctorCount_Click" Text="Print Doctor Counted Report" CssClass="col-sm-offset-5 btn btn-danger btn-lg" />
                <br />
                <br />
            </div>
            <div class="clearfix"></div>
            <br />
            <br />
            <br />
            <div class="clearfix col-sm-10 col-sm-offset-1" style="border-bottom: 1.5px double #ccc; margin-bottom: 30px;">
                <p class="pull-right" style="font-size: 16px; color: #666; font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif">&copy;<%: DateTime.Now.Year%>-All Rights Reserved at <b>Zamp Technologies</b></p>
            </div>

        </div>
    </div>
</asp:Content>
