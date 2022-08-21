<%@ Page Title="Patient Test Registration" Language="C#" MasterPageFile="~/naveedLab.Master" AutoEventWireup="true" CodeBehind="PatientTestRegistration.aspx.cs" Inherits="naveedLab.PatientTestRegistration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headerData" runat="server">
    <script type="text/javascript">
        function showModal() {

            $('#modalTestResult').modal({
                backdrop: 'static',
                keyboard: false
            });
        }
        function hideModal() {
            $('#modalTestResult').modal('hide');
            $('body').removeClass('modal-open');
            $('.modal-backdrop').remove();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyData" runat="server">
    <div class="row">
        <div class="col-lg-12">
            <br />
            <h1 class="page-header">Add Test Result
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
                                <img src="Images/loading.gif" class="img_header_Loader" alt="loader" />
                            </div>
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div runat="server" class="alert alert-success" role="alert" id="naveed_popup" visible="false">
                        <img src="Images/check-mark.png" width="36" height="36" />
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
                    <br />
                    <div class="clearfix"></div>
                    <div class="row" id="gridTerms" runat="server">
                        <div class="col-lg-12">
                            <div class="col-sm-10 col-sm-offset-2">
                                <div class="table table-responsive">
                                    <h3>Pending to Registered</h3>
                                    <asp:GridView ID="dgvPatientTests" runat="server" ShowHeader="true" Visible="false" OnRowCommand="dgvPatientTests_RowCommand" CssClass="table-bordered table-striped col-sm-8 col-sm-offset-0" AutoGenerateColumns="false">
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
                                                <HeaderTemplate><center>Register Result</center></HeaderTemplate>
                                                <EditItemTemplate></EditItemTemplate>
                                                <ItemTemplate>
                                                   <center> <asp:ImageButton ID="btnResisterTest" runat="server" ImageUrl="~/Images/editImage.png" Width="30" Height="30" ImageAlign="Middle" CommandName="registerTestResult" CommandArgument='<%#Container.DataItemIndex %>' /></center>
                                                </ItemTemplate>
                                                <FooterTemplate></FooterTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="clearfix"></div>
                    <div class="row" id="gridTerms_1" runat="server">
                        <div class="col-lg-12">
                            <div class="col-sm-10 col-sm-offset-2">
                                <div class="table table-responsive">
                                    <h3>Already Registered</h3>
                                    <asp:GridView ID="dgvPatientTests_1" runat="server" ShowHeader="true" Visible="false" OnRowCommand="dgvPatientTests_1_RowCommand" CssClass="table-bordered table-striped col-sm-8 col-sm-offset-0" AutoGenerateColumns="false">
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
                                                <HeaderTemplate><center>Register Result</center></HeaderTemplate>
                                                <EditItemTemplate></EditItemTemplate>
                                                <ItemTemplate>
                                                   <center> <asp:ImageButton ID="btnResisterTest_1" runat="server" ImageUrl="~/Images/editImage.png" Width="30" Height="30" ImageAlign="Middle" CommandName="registerTestResult" CommandArgument='<%#Container.DataItemIndex %>' /></center>
                                                </ItemTemplate>
                                                <FooterTemplate></FooterTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Modal -->
                    <div class="modal fade" id="modalTestResult" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="myModalLabel">Test Result</h4>
                                </div>
                                <div class="modal-body row">

                                    <div class="row" id="grdTestResultvalue" runat="server" visible="false">
                                        <div class="col-lg-12">
                                            <div runat="server" class="alert alert-warning" role="alert" id="Div2">
                                                <img src="Images/1194985624696670932tasto_10_architetto_fran_01.svg.med.png" width="36" height="36" />
                                                <span runat="server" id="Span2">&nbsp; Don't Forget to Save Changes</span>
                                            </div>
                                            <div class="col-sm-10 col-sm-offset-1">
                                                <div class="table table-responsive">
                                                    <asp:HiddenField ID="hlblpatientTestID" runat="server" Value='' />
                                                    <asp:GridView ID="dgvTestResultValue" Style="margin-bottom: 15px" runat="server" ShowHeader="true" CssClass="table-bordered table-striped col-sm-12" AutoGenerateColumns="false">
                                                        <HeaderStyle ForeColor="Black" Font-Size="Small" BackColor="#428BCA" />
                                                        <RowStyle Font-Size="small" />
                                                        <Columns>
                                                            <asp:TemplateField ItemStyle-Width="40%">
                                                                <HeaderTemplate>&nbsp;Parameter&nbsp;</HeaderTemplate>
                                                                <EditItemTemplate></EditItemTemplate>
                                                                <ItemTemplate>
                                                                    <asp:HiddenField ID="hlblTestID" runat="server" Value='<%#Eval("TestId")%>' />
                                                                    <asp:HiddenField ID="hlblResultID" runat="server" Value='<%#Eval("Id")%>' />
                                                                    <asp:Label ID="lblTerm" runat="server" Text='<%#Eval("Name") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <FooterTemplate></FooterTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="30%">
                                                                <HeaderTemplate>&nbsp;Standard Value&nbsp;</HeaderTemplate>
                                                                <EditItemTemplate></EditItemTemplate>
                                                                <ItemTemplate>
                                                                    <asp:Label ID="txtStandardValue" runat="server" Text='<%#Eval("StandardValue") %>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="30%">
                                                                <HeaderTemplate>&nbsp;Resulted Value&nbsp;</HeaderTemplate>
                                                                <EditItemTemplate></EditItemTemplate>
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtResultedValue" CssClass="form-control" runat="server" Text='<%#Eval("ValueResult") %>'></asp:TextBox>
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
                                    <center><asp:Button ID="btnSaveParameterValues" CssClass="btn btn btn-primary" Text="Save Changes" runat="server" OnClick="btnSaveParameterValues_Click"/></center>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="clearfix col-sm-10 col-sm-offset-1" style="border-bottom: 1.5px double #ccc; margin-top:30px; margin-bottom: 30px;">
                        <p class="pull-right" style="font-size: 16px; color: #666; font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif">&copy;<%: DateTime.Now.Year%>-All Rights Reserved at <b>Zamp Technologies</b></p>
                    </div>

                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSaveParameterValues" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
