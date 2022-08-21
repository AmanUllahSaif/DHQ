<%@ Page Title="Doctor Report" Language="C#" MasterPageFile="~/naveedLab.Master" AutoEventWireup="true" CodeBehind="docterReport.aspx.cs" Inherits="naveedLab.docterReport" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headerData" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyData" runat="server">
    <div class="row">
        <div class="col-lg-12" id="topMove">
            <br />
            <br />
            <h1 class="page-header">Doctor Report
            </h1>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-10">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="form-group">
                        <div class="col-md-10">
                            <asp:DropDownList ID="ddlMonth" runat="server" CssClass="form-control col-md-offset-4" Width="32%">
                                <asp:ListItem Value="0">- Select Month -</asp:ListItem>
                                <asp:ListItem Text="January" Value="1"></asp:ListItem>
                                <asp:ListItem Text="Febraury" Value="2"></asp:ListItem>
                                <asp:ListItem Text="March" Value="3"></asp:ListItem>
                                <asp:ListItem Text="April" Value="4"></asp:ListItem>
                                <asp:ListItem Text="May" Value="5"></asp:ListItem>
                                <asp:ListItem Text="June" Value="6"></asp:ListItem>
                                <asp:ListItem Text="July" Value="7"></asp:ListItem>
                                <asp:ListItem Text="August" Value="8"></asp:ListItem>
                                <asp:ListItem Text="September" Value="9"></asp:ListItem>
                                <asp:ListItem Text="October" Value="10"></asp:ListItem>
                                <asp:ListItem Text="November" Value="11"></asp:ListItem>
                                <asp:ListItem Text="December" Value="12"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator CssClass="text-danger col-md-offset-4" ID="RequiredFieldValidator1" runat="server" ValidationGroup="VGDCTR" ControlToValidate="ddlMonth" ErrorMessage="Month Is Required" InitialValue="0"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <br />
                    <div class="form-group">
                        <div class="col-md-10">
                            <asp:DropDownList ID="ddlDrType" runat="server" CssClass="form-control col-md-offset-4" Width="32%">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator CssClass="text-danger col-md-offset-4" ID="RequiredFieldValidator2" runat="server" ValidationGroup="VGDCTR" ControlToValidate="ddlDrType" ErrorMessage="Doctor Is Required"></asp:RequiredFieldValidator>

                            <br />
                            <asp:Label runat="server" CssClass="text-danger col-md-offset-4" id="lblError" ></asp:Label>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <asp:UpdateProgress ID="UpdateProgress2" runat="server" AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="10">
                <ProgressTemplate>
                    <div id="overlay">
                        <div id="modalprogress">
                            <div id="theprogress">
                                <img src="Images/loading.gif" class="img_header_Loader" alt="loader" />
                            </div>
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <br />
                    <div class="form-group">
                        <div class="col-md-offset-4 col-md-10">
                            <br />
                            <asp:Button runat="server" ID="btnSearch" OnClick="btnSearch_Click" ValidationGroup="VGDCTR" Text="Print" CssClass="btn btn-danger" />
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <div class="clearfix col-sm-10 col-sm-offset-1" style="border-bottom: 1.5px double #ccc; margin-bottom: 30px;">
                        <p class="pull-right" style="font-size: 16px; color: #666; font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif">&copy;<%: DateTime.Now.Year%>-All Rights Reserved at <b>Zamp Technologies</b></p>
                    </div>
        </div>
    </div>

</asp:Content>
