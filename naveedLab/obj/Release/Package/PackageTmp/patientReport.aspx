<%@ Page Title="Patient Report" Language="C#" MasterPageFile="~/naveedLab.Master" AutoEventWireup="true" CodeBehind="patientReport.aspx.cs" Inherits="naveedLab.patientReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headerData" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyData" runat="server">
    <div class="row">
        <div class="col-lg-12" id="topMove">
            <br />
            <br />
            <h1 class="page-header">Patient Report
            </h1>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-10">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="form-group">
                        <div class="col-md-10">
                            <asp:TextBox ID="txtPatientID" runat="server" TextMode="Number" CssClass="form-control col-md-offset-4" Width="32%">
                            </asp:TextBox>
                            <asp:RequiredFieldValidator CssClass="text-danger col-md-offset-4" ID="RequiredFieldValidator2" runat="server" ValidationGroup="VGDCTR" ControlToValidate="txtPatientID" ErrorMessage="PatientID is Required"></asp:RequiredFieldValidator>

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
