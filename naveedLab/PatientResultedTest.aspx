<%@ Page Title="Test Results" Language="C#" MasterPageFile="~/naveedLab.Master" AutoEventWireup="true" CodeBehind="PatientResultedTest.aspx.cs" Inherits="naveedLab.PatientResultedTest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headerData" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyData" runat="server">
    <div class="row">
        <div class="col-lg-12">
            <br />
            <h1 class="page-header">View Test Result
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
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="lblEmployeeID" CssClass="col-md-2 control-label">Employee ID</asp:Label>
                        <div class="col-md-10">
                            <asp:Label ID="lblEmployeeID" runat="server" Text=""></asp:Label>
                        </div>
                    </div>
                    <br />
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="lblEmployeeName" CssClass="col-md-2 control-label">Employee Name</asp:Label>
                        <div class="col-md-10">
                            <asp:Label ID="lblEmployeeName" runat="server" Text=""></asp:Label>
                        </div>
                    </div>
                    <br />
                    <div class="clearfix"></div>

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtPatientID" CssClass="col-md-2 control-label">Patient ID</asp:Label>
                        <div class="col-md-4">
                            <asp:TextBox ID="txtPatientID" runat="server" AutoPostBack="true" OnTextChanged="txtPatientID_TextChanged" CssClass="form-control" Text="" placeholder="Enter Patient ID"></asp:TextBox>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <br />
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="lblPatientName" CssClass="col-md-2 control-label">Patient Name</asp:Label>
                        <div class="col-md-10">
                            <asp:Label ID="lblPatientName" runat="server" Text=""></asp:Label>
                        </div>
                    </div>
                    <br />
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="lblDate" CssClass="col-md-2 control-label">Date</asp:Label>
                        <div class="col-md-10">
                            <asp:Label ID="lblDate" runat="server" Text=""></asp:Label>
                        </div>
                    </div>
                    <br />
                    <br />
                    <asp:Button ID="btnPrintAll" CssClass="btn btn-danger btn-md col-sm-offset-9" Visible="false" runat="server" Text="Print All Tests" OnClick="btnPrintAll_Click" />
                    <asp:HiddenField ID="hdfIsPrinted" runat="server" Value="0"/>
                    <br />
                    <div class="clearfix"></div>
                    <div class="row" id="gridTerms" runat="server">
                        <div class="col-lg-12">
                            <div class="col-sm-10 col-sm-offset-2">
                                <div class="table table-responsive">
                                    <asp:GridView ID="dgvPatientTests" runat="server" ShowHeader="true" Visible="false" OnRowCommand="dgvPatientTests_RowCommand" CssClass="table-bordered table-striped" AutoGenerateColumns="false" Width="734px">
                                        <HeaderStyle ForeColor="Black" Font-Size="Small" BackColor="#428BCA" />
                                        <RowStyle Font-Size="small" />
                                        <Columns>
                                            <asp:TemplateField ItemStyle-Width="70%">
                                                <HeaderTemplate>&nbsp;Test Name&nbsp;</HeaderTemplate>
                                                <EditItemTemplate></EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:HiddenField ID="hlblID" runat="server" Value='<%#Eval("Id")%>' />
                                                    <asp:HiddenField ID="hlblTestID" runat="server" Value='<%#Eval("TestId")%>' />
                                                    <asp:Label ID="lblTestName" runat="server" Text='<%#Eval("TestName") %>'></asp:Label>
                                                </ItemTemplate>
                                                <FooterTemplate></FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-Width="30%">
                                                <HeaderTemplate>
                                                    <center>User Action</center>
                                                </HeaderTemplate>
                                                <EditItemTemplate></EditItemTemplate>
                                                <ItemTemplate>
                                                    <center><asp:ImageButton ID="btnRedirect" runat="server"  Width="30" Height="30" ImageUrl="~/Images/editImage.png" ToolTip="Edit Test" ImageAlign="Middle" CommandName="MarkEdit" CommandArgument='<%#Container.DataItemIndex %>' />
                                                    <asp:ImageButton ID="btnPrintTest" runat="server" style="margin-left:5px" ImageUrl="~/Images/Print.png" ToolTip="Print Test" Width="30" Height="30" ImageAlign="Middle" CommandName="Redirect" CommandArgument='<%#Container.DataItemIndex %>' /></center>
                                                </ItemTemplate>
                                                <FooterTemplate></FooterTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>

                                    <h3 runat="server" id="lblAlreadyPrinted" visible="false">Already Printed</h3>

                                    <asp:GridView ID="dgvAlreadyPrinted" runat="server" ShowHeader="true" Visible="false" OnRowCommand="dgvAlreadyPrinted_RowCommand" CssClass="table-bordered table-striped" AutoGenerateColumns="false" Width="734px">
                                        <HeaderStyle ForeColor="Black" Font-Size="Small" BackColor="#428BCA" />
                                        <RowStyle Font-Size="small" />
                                        <Columns>
                                            <asp:TemplateField ItemStyle-Width="70%">
                                                <HeaderTemplate>&nbsp;Test Name&nbsp;</HeaderTemplate>
                                                <EditItemTemplate></EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:HiddenField ID="hlblID" runat="server" Value='<%#Eval("Id")%>' />
                                                    <asp:HiddenField ID="hlblTestID" runat="server" Value='<%#Eval("TestId")%>' />
                                                    <asp:Label ID="lblTestName" runat="server" Text='<%#Eval("TestName") %>'></asp:Label>
                                                </ItemTemplate>
                                                <FooterTemplate></FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-Width="30%">
                                                <HeaderTemplate>
                                                    <center>User Action</center>
                                                </HeaderTemplate>
                                                <EditItemTemplate></EditItemTemplate>
                                                <ItemTemplate>
                                                     <center><asp:ImageButton ID="btnRedirect" runat="server"  Width="30" Height="30" ImageUrl="~/Images/editImage.png" ToolTip="Edit Test" ImageAlign="Middle" CommandName="MarkEdit" CommandArgument='<%#Container.DataItemIndex %>' />
                                                    <asp:ImageButton ID="btnPrintTest" runat="server" style="margin-left:5px" ImageUrl="~/Images/Print.png" ToolTip="Print Test" Width="30" Height="30" ImageAlign="Middle" CommandName="Redirect" CommandArgument='<%#Container.DataItemIndex %>' /></center>
                                                </ItemTemplate>
                                                <FooterTemplate></FooterTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="clearfix col-sm-10 col-sm-offset-1" style="border-bottom: 1.5px double #ccc; margin-top: 30px; margin-bottom: 30px;">
                        <p class="pull-right" style="font-size: 16px; color: #666; font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif">©2015-All Rights Reserved at <b>Naveed Lab</b></p>
                    </div>

                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
