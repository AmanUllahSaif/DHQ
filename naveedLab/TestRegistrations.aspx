<%@ Page Title="Test Registrations" Language="C#" MasterPageFile="~/naveedLab.Master" AutoEventWireup="true" CodeBehind="TestRegistrations.aspx.cs" Inherits="naveedLab.TestRegistrations" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headerData" runat="server">
    <script type="text/javascript">
        function showModal() {

            $('#modalSelectTest').modal({
                backdrop: 'static',
                keyboard: false
            });
        }
        function hideModal() {
            $('#modalSelectTest').modal('hide');
        }

        function showErrorModal() {

            $('#modalError').modal({
                backdrop: 'static',
                keyboard: false
            });
        }
        function hideErrorModal() {
            $('#modalError').modal('hide');
            $('body').removeClass('modal-open');
            $('.modal-backdrop').remove();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyData" runat="server">
    <div class="row">
        <div class="col-lg-12">
            <br />
            <h1 class="page-header">Test Registrations
            </h1>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="Panel1" DisplayAfter="10">
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
            <asp:UpdatePanel ID="Panel1" runat="server">
                <ContentTemplate>
                    <div runat="server" class="alert alert-danger" role="alert" id="naveed_Danger" visible="false">
                        <img src="Images/1194985624696670932tasto_10_architetto_fran_01.svg.med.png" width="36" height="36" />
                        <asp:Label runat="server" ID="naveedDangerText" Text="">&nbsp;</asp:Label>
                    </div>
                    <div runat="server" class="alert alert-success" role="alert" id="naveed_popup" visible="false">
                        <img src="Images/check-mark.png" width="36" height="36" />
                        <asp:Label runat="server" ID="naveedPopupText" Text=""></asp:Label>
                    </div>
                    <br />

                    <div class="form-group">
                        <asp:Label ID="lblPatientID" AssociatedControlID="txtPatientID" runat="server" CssClass="col-md-2 control-label">Patient ID</asp:Label>
                        <div class="col-md-3">
                            <asp:TextBox ID="txtPatientID" CssClass="form-control" AutoPostBack="true" OnTextChanged="txtPatientID_TextChanged" runat="server" placeholder="Enter Patient ID...">
                            </asp:TextBox>
                        </div>
                    </div>
                    <br />
                    <br />
                    <div class="form-group">
                        <asp:Label ID="Label1" AssociatedControlID="lblPatientName" runat="server" CssClass="col-md-2 control-label">Patient Name</asp:Label>
                        <div class="col-md-10">
                            <asp:Label ID="lblPatientName" runat="server" CssClass="col-md-4 control-label" Text=""></asp:Label>
                        </div>
                    </div>
                    <br />
                    <br />
                    <div class="form-group">
                        <asp:Label ID="Label2" AssociatedControlID="ddlChapter" runat="server" CssClass="col-md-2 control-label">Chapter Name</asp:Label>
                        <div class="col-md-10">
                            <asp:DropDownList ID="ddlChapter" AutoPostBack="true" AppendDataBoundItems="true" OnSelectedIndexChanged="ddlChapter_SelectedIndexChanged" Enabled="false" runat="server" CssClass="form-control" Width="32%">
                                <asp:ListItem Value="-Select-">- Select -</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <br />
                    <table runat="server" id="tbl" visible="false" border="1" style="margin-left:70%">
                        <tr>
                            <th>
                                Previous Paid Amount
                                </th>
                            <td>
                                <asp:Label ID="lblPreviousPaidAmount" runat="server" CssClass="col-md-4 control-label" Text=""></asp:Label>
                                </td>
                            </tr>
                        <tr>
                            <th>
                                Previous Payable Amount
                                </th>
                            <td>
                                <asp:Label ID="lblPreviousPayableAmount" runat="server" CssClass="col-md-4 control-label" Text=""></asp:Label>
                                </td>
                            </tr>
                        </table>
                    <br />
                    <div class="col-sm-10 col-sm-offset-1" runat="server" id="grdSelectedTests" visible="false">
                        <div class="table table-responsive">
                            <asp:GridView ID="dgvSelectedTests" runat="server" ShowHeader="true" OnRowCommand="dgvSelectedTests_RowCommand" CssClass="table-bordered table-striped" AutoGenerateColumns="false" Width="734px">
                                <HeaderStyle ForeColor="Black" Font-Size="Small" BackColor="#428BCA" />
                                <RowStyle Font-Size="small" />
                                <Columns>
                                    <asp:TemplateField ItemStyle-Width="30%">
                                        <HeaderTemplate>&nbsp;Test Name&nbsp;</HeaderTemplate>
                                        <EditItemTemplate></EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:HiddenField ID="hlblSelectedTestID" runat="server" Value='<%#Eval("SelectedTestID") %>' />
                                            <asp:HiddenField ID="hlblChapterFID" runat="server" Value='<%#Eval("ChapterFID") %>' />
                                            <asp:Label ID="lblTestName" runat="server" Text='<%#Eval("TestName") %>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate></FooterTemplate>
                                        <ItemStyle Width="30%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Width="20%">
                                        <HeaderTemplate>&nbsp;Charges&nbsp;</HeaderTemplate>
                                        <EditItemTemplate></EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblCharges" CssClass="form-control" runat="server" Text='<%#Eval("Charges")%>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate></FooterTemplate>
                                        <ItemStyle Width="20%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Width="20%">
                                        <HeaderTemplate>&nbsp;PKR Discount&nbsp;</HeaderTemplate>
                                        <EditItemTemplate></EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtPercentageDiscount" AutoPostBack="true" OnTextChanged="txtPercentageDiscount_TextChanged" CssClass="form-control" CausesValidation="true" runat="server" Text='<%#Eval("PercentageDiscount")%>'></asp:TextBox>
                                        </ItemTemplate>
                                        <FooterTemplate></FooterTemplate>
                                        <ItemStyle Width="20%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Width="20%">
                                        <HeaderTemplate>&nbsp;Remaining Price&nbsp;</HeaderTemplate>
                                        <EditItemTemplate></EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblRemainingTestPrice" CssClass="form-control" runat="server" Text='<%#Eval("RemainingTestPrice")%>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate></FooterTemplate>
                                        <ItemStyle Width="20%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Width="10%">
                                        <HeaderTemplate>&nbsp;Remove&nbsp;</HeaderTemplate>
                                        <EditItemTemplate></EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:ImageButton ID="btnDeleteTest" runat="server" ImageUrl="~/Images/deleteImage.png" Width="30" Height="30" ImageAlign="Middle" CommandArgument='<%#Container.DataItemIndex %>' CommandName="Remove" />
                                        </ItemTemplate>
                                        <FooterTemplate></FooterTemplate>
                                        <ItemStyle Width="10%" />
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <br />
                            <br />
                        </div>

                        <div class="clearfix"></div>
                        <asp:Button ID="btnCalculateBill" CssClass="btn btn-primary" runat="server" Text="Calculate Bill" OnClick="btnCalculateBill_Click" />
                    </div>

                    <div class="col-sm-offset-6" runat="server" id="divBill">
                        <div class="form-group">
                            <asp:Label ID="lblBill" AssociatedControlID="lblTotalBill" runat="server" CssClass="col-md-4 control-label">Total Bill</asp:Label>
                            <div class="col-md-10">
                                <asp:Label ID="lblTotalBill" runat="server" CssClass="col-md-4 control-label" Text=""></asp:Label>
                            </div>
                        </div>
                        <br />
                        <br />
                        <div class="form-group">
                            <asp:Label ID="lbl" runat="server" AssociatedControlID="lblDiscountedBill" CssClass="col-md-4 control-label">Discounted Bill</asp:Label>
                            <div class="col-md-10">
                                <asp:Label ID="lblDiscountedBill" runat="server" CssClass="col-md-4 control-label" Text=""></asp:Label>
                            </div>
                        </div>
                        <br />
                        <br />
                        <div class="form-group">
                            <asp:Label ID="Label4" runat="server" AssociatedControlID="txtPaidRupees" CssClass="col-md-4 control-label">Paid Rupees</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox ID="txtPaidRupees" CssClass="form-control col-sm-4" AutoPostBack="true" OnTextChanged="txtPaidRupees_TextChanged" runat="server" placeholder="Paid Rupees...">
                                </asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtPaidRupees" Display="Dynamic" runat="server" ForeColor="Red" ErrorMessage="Enter Received Amount..."></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <br />
                        <br />
                        <div class="form-group">
                            <asp:Label ID="Label5" runat="server" AssociatedControlID="lblRemaining" CssClass="col-md-4 control-label">Remaining</asp:Label>
                            <div class="col-md-10">
                                <asp:Label ID="lblRemaining" runat="server" CssClass="col-md-4 control-label" Text=""></asp:Label>
                            </div>
                        </div>
                        <br />
                        <br />
                        <asp:Button runat="server" ID="btnPrint" ValidationGroup="vg" OnClick="btnPrint_Click" Text="Save" CssClass="col-sm-offset-4 btn btn-primary btn-md" />
                    </div>

                    </div>
                    </div>

            <div class="modal fade col-sm-12" id="modalError" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="myLabel">Conflict, Already Registered Test For This User...</h4>
                        </div>
                        <div class="modal-body  row">
                            <div class="col-lg-12">
                                <asp:UpdateProgress ID="UpdateProgress2" runat="server" AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="10">
                                    <ProgressTemplate>
                                        <div id="overlay1">
                                            <div id="modalprogress1">
                                                <div id="theprogress1">
                                                    <img src="Images/loading.gif" class="img_header_Loader" alt="loader" />
                                                </div>
                                            </div>
                                        </div>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                        <div class="col-sm-10 col-sm-offset-1">
                                            <div class="table table-responsive">
                                                <asp:GridView ID="grdAlreadyRegisteredTest" Style="margin-bottom: 20px;" runat="server" ShowHeader="true" CssClass="table-bordered table-striped col-sm-12" AutoGenerateColumns="false">
                                                    <HeaderStyle ForeColor="Black" Font-Size="Small" BackColor="#428BCA" />
                                                    <RowStyle Font-Size="small" />
                                                    <Columns>
                                                        <asp:TemplateField>
                                                            <HeaderTemplate>Serial Number</HeaderTemplate>
                                                            <EditItemTemplate></EditItemTemplate>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblSerialNumber" runat="server" Text='<%#Container.DataItemIndex+1%>'></asp:Label>
                                                            </ItemTemplate>
                                                            <FooterTemplate></FooterTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField>
                                                            <HeaderTemplate>&nbsp;TestName&nbsp;</HeaderTemplate>
                                                            <EditItemTemplate></EditItemTemplate>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblTestName" CssClass="form-control" runat="server" Text='<%#Eval("TestName")%>'></asp:Label>
                                                            </ItemTemplate>
                                                            <FooterTemplate></FooterTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField>
                                                            <HeaderTemplate>&nbsp;Save/Update&nbsp;</HeaderTemplate>
                                                            <EditItemTemplate></EditItemTemplate>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblCharges" CssClass="form-control" runat="server" Text='<%#Eval("Charges")%>'></asp:Label>
                                                            </ItemTemplate>
                                                            <FooterTemplate></FooterTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                                <br />
                                                <br />
                                                <center>
                                                    <asp:Button runat="server" ID="btnCloseErrorModal" OnClick="btnCloseErrorModal_Click" Text="Close" CssClass="col-sm-4 col-sm-offset-4 btn btn-primary"/></center>
                                            </div>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="btnCloseErrorModal" EventName="Click" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


                </ContentTemplate>

                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnCalculateBill" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnPrint" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
            <div class="modal fade col-sm-12" id="modalSelectTest" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="myModalLabel">Select Test</h4>
                        </div>
                        <div class="modal-body  row">
                            <div class="col-lg-12">
                                <asp:UpdateProgress ID="UpdateProgress3" runat="server" AssociatedUpdatePanelID="modalUpdate" DisplayAfter="10">
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
                                <asp:UpdatePanel ID="modalUpdate" runat="server">
                                    <ContentTemplate>
                                        <div class="col-sm-10 col-sm-offset-1">
                                            <div class="table table-responsive">
                                                <asp:GridView ID="dgvSelectTest" Style="margin-bottom: 20px;" runat="server" ShowHeader="true" OnRowDeleting="dgvSelectTest_RowDeleting" CssClass="table-bordered table-striped col-sm-12" AutoGenerateColumns="false">
                                                    <HeaderStyle ForeColor="Black" Font-Size="Small" BackColor="#428BCA" />
                                                    <RowStyle Font-Size="small" />
                                                    <Columns>
                                                        <asp:TemplateField>
                                                            <HeaderTemplate>&nbsp;Test Name&nbsp;</HeaderTemplate>
                                                            <EditItemTemplate></EditItemTemplate>
                                                            <ItemTemplate>
                                                                <asp:HiddenField ID="hlblTestID" runat="server" Value='<%#Eval("Id") %>' />
                                                                <asp:HiddenField ID="hlblChapterFID" runat="server" Value='<%#Eval("ChapterFID") %>' />
                                                                <asp:Label ID="lblTestName" runat="server" Text='<%#Eval("TestName") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <FooterTemplate></FooterTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField>
                                                            <HeaderTemplate>&nbsp;Charges&nbsp;</HeaderTemplate>
                                                            <EditItemTemplate></EditItemTemplate>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblCharges" CssClass="form-control" runat="server" Text='<%#Eval("Charges")%>'></asp:Label>
                                                            </ItemTemplate>
                                                            <FooterTemplate></FooterTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField>
                                                            <HeaderTemplate>&nbsp;Register&nbsp;</HeaderTemplate>
                                                            <EditItemTemplate></EditItemTemplate>
                                                            <ItemTemplate>
                                                                <asp:ImageButton ID="btnAddTest" runat="server" ImageUrl="~/Images/check-mark.png" Width="30" Height="30" ImageAlign="Middle" CommandName="Delete" />
                                                            </ItemTemplate>
                                                            <FooterTemplate></FooterTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                                <br />
                                                <br />
                                                <center><asp:Button runat="server" ID="btnClose" OnClick="btnClose_Click" ValidationGroup="vg" Text="Close" CssClass="col-sm-4 col-sm-offset-4 btn btn-primary"/></center>
                                            </div>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:PostBackTrigger ControlID="btnClose" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
    <div class="row">
        <div class="clearfix col-sm-10 col-sm-offset-1" style="border-bottom: 1.5px double #ccc; margin-bottom: 30px;">
            <p class="pull-right" style="font-size: 16px; color: #666; font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif">&copy;<%: DateTime.Now.Year%>-All Rights Reserved at <b>Zamp Technologies</b></p>
        </div>
    </div>
</asp:Content>
