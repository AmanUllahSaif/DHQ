<%@ Page Title="" Language="C#" MasterPageFile="~/naveedLab.Master" AutoEventWireup="true" CodeBehind="PrintTestResult.aspx.cs" Inherits="naveedLab.PrintTestResult" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headerData" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyData" runat="server">
    <div class="row">
        <div class="col-lg-12">
            <br />
            <h1 class="page-header">Print Test Result
            </h1>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="10">
                <ProgressTemplate>
                    <div id="overlay">
                        <div id="modalprogress">
                            <div id="theprogress">
                                <img src="../Images/loading.gif" class="img_header_Loader" alt="loader" />
                            </div>
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div runat="server" class="alert alert-success" role="alert" id="naveed_popup" visible="false">
                        <img src="../Images/check-mark.png" width="36" height="36" />
                        <asp:Label runat="server" ID="naveedPopupText" Text=""></asp:Label>
                    </div>
                    <div runat="server" class="alert alert-danger" role="alert" id="naveed_Danger" visible="false">
                        <img src="Images/1194985624696670932tasto_10_architetto_fran_01.svg.med.png" width="36" height="36" />
                        <asp:Label runat="server" ID="naveedDangerText" Text="">&nbsp;</asp:Label>
                    </div>
                    <br />

                    <div class="col-sm-12" style="margin-bottom:20px;">
                        <asp:Label ID="lblTestName" style="font-size:x-large; font-weight:bold;" class="col-sm-offset-4" runat="server"></asp:Label>
                        
                        <table border="0" style="width: 100%; margin-top:10px">
                            <tr style="">
                                <th style="width:10%; text-align:right">Name :</th>
                                <td style="width:30%; text-align:left">
                                    <asp:Label ID="lblName" runat="server" Text=""></asp:Label></td>
                                <th style="width:20%;  text-align:right">Gender :</th>
                                <td style="width:30%; text-align:left">
                                    <asp:Label ID="lblGender" runat="server" Text=""></asp:Label></td>
                            </tr>

                            <tr>
                                <th style="width:20%; text-align:right">Age :</th>
                                <td style="width:30%; text-align:left">
                                    <asp:Label ID="lblAge" runat="server" Text=""></asp:Label></td>
                                <th style="width:20%;  text-align:right">Date :</th>
                                <td style="width:30%; text-align:left">
                                    <asp:Label ID="lblDate" runat="server" Text=""></asp:Label></td>
                            </tr>
                        </table>
                        </table>
                    </div>
                    <br />
                    <asp:HiddenField ID="hlblID" runat="server" Value="" />
                    <asp:HiddenField ID="hlblPatientID" runat="server" Value="" />
                    <div class="modal-body row">

                        <div class="row" id="grdTestResultvalue" runat="server" visible="false">
                            <div class="col-lg-12">
                                <div class="col-sm-10 col-sm-offset-1">
                                    <div class="table table-responsive">
                                        <asp:HiddenField ID="hlblpatientTestID" runat="server" Value='' />
                                        <asp:GridView ID="dgvTestResultValue" Style="margin-bottom: 15px" runat="server" ShowHeader="true" CssClass="table-bordered table-striped col-sm-10 col-sm-offset-1" AutoGenerateColumns="false">
                                            <HeaderStyle ForeColor="Black" Font-Size="Small" BackColor="#428BCA" />
                                            <RowStyle Font-Size="small" />
                                            <Columns>
                                                <asp:TemplateField ItemStyle-Width="40%">
                                                    <HeaderTemplate>&nbsp;Parameter&nbsp;</HeaderTemplate>
                                                    <EditItemTemplate></EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:HiddenField ID="hlblTestID" runat="server" Value='<%#Eval("PatientTestID")%>' />
                                                        <asp:Label ID="lblTerm" runat="server" Text='<%#Eval("Name") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <FooterTemplate></FooterTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField ItemStyle-Width="30%">
                                                    <HeaderTemplate>&nbsp;Reference Value&nbsp;</HeaderTemplate>
                                                    <EditItemTemplate></EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="txtStandardValue" runat="server" Text='<%#Eval("StandardValue") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField ItemStyle-Width="30%">
                                                    <HeaderTemplate>&nbsp;Resulted Value&nbsp;</HeaderTemplate>
                                                    <EditItemTemplate></EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="txtResultedValue" CssClass="form-control" runat="server" Text='<%#Eval("ValueResult") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <FooterTemplate></FooterTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                        <br />
                                        <br />
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <asp:Button ID="btnPrint" OnClick="btnPrint_Click" CssClass="btn btn-info col-sm-offset-5" runat="server" Text="Print Report" />

                    <div class="clearfix col-sm-10 col-sm-offset-1" style="border-bottom: 1.5px double #ccc; margin-top: 30px; margin-bottom: 30px;">
                        <p class="pull-right" style="font-size: 16px; color: #666; font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif">©2015-All Rights Reserved at <b>Naveed Lab</b></p>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
