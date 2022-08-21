<%@ Page Title="Employee" Language="C#" MasterPageFile="~/naveedLab.Master" AutoEventWireup="true" CodeBehind="employee.aspx.cs" Inherits="naveedLab.Dashboard.employee" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headerData" runat="server">
    <script type="text/javascript">
        function pageLoad() {
            $('.bs-pagination td table').each(function (index, obj) {
                convertToPagination(obj)
            });
        }
    </script>
    <style type="text/css">
        .gridpager table {
            text-align: center !important;
        }

        .pagination {
            margin-top: 10px !important;
            margin-bottom: 5px !important;
        }
    </style>
    <script type="text/javascript">
        function moveTop() {
            $('html,body').animate({
                scrollTop: $("#topMove").offset().top
            },
        'slow');
        }

        function moveBottom() {
            $('html, body').animate({
                scrollTop: $("#bannerBottom").offset().top
            }, 2000);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyData" runat="server">
    <div class="row">
        <div class="col-lg-12" id="topMove">
            <br />
            <br />
            <h1 class="page-header">Employee
            </h1>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div id="bannersTop">
                        <div runat="server" visible="false" class="alert alert-success successClass" role="alert" id="naveed_Success">
                            <img src="Images/check-mark.png" width="36" height="36" />
                            <span runat="server" id="naveed_Success_Text"></span>
                        </div>
                        <div runat="server" visible="false" class="alert alert-danger" role="alert" id="naveed_Danger">
                            <img src="Images/1194985624696670932tasto_10_architetto_fran_01.svg.med.png" width="36" height="36" />
                            <span runat="server" id="naveed_Danger_Text">&nbsp;</span>
                        </div>
                    </div>
                    <br />
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="empID" CssClass="col-md-2 control-label">User Name</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" Width="32%" ID="empID" AutoComplete="off" Placeholder="Employee UserName" CssClass="form-control" TextMode="SingleLine" />
                            <asp:RequiredFieldValidator runat="server" ValidationGroup="vg" ControlToValidate="empID"
                                CssClass="text-danger" ErrorMessage="The Employee ID is Required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="empName" CssClass="col-md-2 control-label">Employee Name</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" Width="32%" ID="empName" AutoComplete="off" Placeholder="Employee Name" CssClass="form-control" TextMode="SingleLine" />
                            <asp:RequiredFieldValidator runat="server" ValidationGroup="vg" ControlToValidate="empName"
                                CssClass="text-danger" ErrorMessage="The Employee Name is Required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="empPassword" CssClass="col-md-2 control-label">Password</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" Width="32%" ID="empPassword" AutoComplete="off" Placeholder="Employee Password" CssClass="form-control" TextMode="Password" />
                            <asp:RequiredFieldValidator runat="server" ValidationGroup="vg" ControlToValidate="empPassword"
                                CssClass="text-danger" ErrorMessage="The Password is Required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="empConfPassword" CssClass="col-md-2 control-label">Confirm Password</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" Width="32%" ID="empConfPassword" AutoComplete="off" Placeholder="Confirm Password" CssClass="form-control" TextMode="Password" />
                            <asp:RequiredFieldValidator runat="server" ValidationGroup="vg" Display="Dynamic" ControlToValidate="empConfPassword"
                                CssClass="text-danger" ErrorMessage="The Confirm Password is Required." />
                            <asp:CompareValidator ID="CompareValidator1" runat="server" CssClass="text-danger" Display="Dynamic" ErrorMessage="Password Doesn't Matches" ValidationGroup="vg" ControlToValidate="empConfPassword" ControlToCompare="empPassword"></asp:CompareValidator>
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="rbtnMale" CssClass="col-md-2 control-label">Employee Gender</asp:Label>
                        <div class="col-md-10">
                            <asp:RadioButton ID="rbtnMale" GroupName="sex" Checked="true" Text="&nbsp; Male" runat="server" />
                            <asp:RadioButton ID="rbtnFemale" GroupName="sex" Text="&nbsp;Female" runat="server" />
                            <br />
                            <br />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="empAddress" CssClass="col-md-2 control-label">Employee Address</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="empAddress" AutoComplete="off" Placeholder="Employee Address" Width="32%" CssClass="form-control" TextMode="MultiLine" />
                            <asp:RequiredFieldValidator runat="server" ValidationGroup="vg" ControlToValidate="empAddress"
                                CssClass="text-danger" ErrorMessage="The Employee Address is Required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="ddlEmpStatus" CssClass="col-md-2 control-label">Designation</asp:Label>
                        <div class="col-md-10">
                            <asp:DropDownList ID="ddlEmpStatus" runat="server" CssClass="form-control" Width="32%">
                                <asp:ListItem Value="-Select-">- Select -</asp:ListItem>
                                <asp:ListItem Value="Doctor">Doctor</asp:ListItem>
                                <asp:ListItem Value="Chief Technician">Chief Technician</asp:ListItem>
                                <asp:ListItem Value="Senior Technician">Senior Technician</asp:ListItem>
                                <asp:ListItem Value="Junior Technician">Junior Technician</asp:ListItem>
                                <asp:ListItem Value="Lab Assistant">Lab Assistant</asp:ListItem>
                                <asp:ListItem Value="Receptionist">Receptionist</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator runat="server" ValidationGroup="vg" ControlToValidate="ddlEmpStatus"
                                CssClass="text-danger" InitialValue="- Select -" ErrorMessage="The Employee Status is Required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <br />
                        <asp:Label runat="server" AssociatedControlID="ddlBranch" CssClass="col-md-2 control-label">Branch Name</asp:Label>
                        <div class="col-md-10">
                            <asp:DropDownList ID="ddlBranch" runat="server" CssClass="form-control" Width="32%">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator runat="server" ValidationGroup="vg" ControlToValidate="ddlBranch"
                                CssClass="text-danger" InitialValue="- Select -" ErrorMessage="The Branch is Required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="empNo" CssClass="col-md-2 control-label">Employee Phone#</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" Width="32%" ID="empNo" AutoComplete="off" Placeholder="Employee Phone#" CssClass="form-control" TextMode="SingleLine" />
                            <asp:RequiredFieldValidator runat="server" ValidationGroup="vg" ControlToValidate="empNo" Display="Dynamic"
                                CssClass="text-danger" ErrorMessage="The Employee Phone# is Required." />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" CssClass="text-danger" ControlToValidate="empNo" Display="Dynamic" ValidationExpression="\d{4}-\d{7}" ValidationGroup="vg" runat="server" ErrorMessage="XXXX-XXXXXXX"></asp:RegularExpressionValidator>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-offset-2 col-md-10">
                            <br />
                            <asp:Button runat="server" ID="btnAdd" OnClick="btnAdd_Click" ValidationGroup="vg" Text="Add" CssClass="btn btn-success" />
                            <asp:Button runat="server" ID="btnClear" OnClick="btnClear_Click" ValidationGroup="vg" Text="Clear" CssClass="btn btn-danger" />
                        </div>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnAdd" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnClear" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
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
        </div>
    </div>
    <br />
    <br />
    <br />
    <div class="row">
        <div class="col-lg-12">
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <div id="bannerBottom">
                        <div runat="server" visible="false" class="alert alert-success successClass" role="alert" id="gridSuccess">
                            <img src="Images/check-mark.png" width="36" height="36" />
                            <span runat="server" id="gridSuccess_Text"></span>
                        </div>
                        <div runat="server" visible="false" class="alert alert-danger" role="alert" id="gridError">
                            <img src="Images/1194985624696670932tasto_10_architetto_fran_01.svg.med.png" width="36" height="36" />
                            <span runat="server" id="gridError_Text">&nbsp;</span>
                        </div>
                    </div>
                    <div class="col-sm-11 col-sm-offset-1">
                        <div class="table table-responsive">
                            <asp:GridView ID="grdEmployees" runat="server" AllowPaging="true" ShowHeader="true" PageSize="10" OnRowCommand="grdEmployees_RowCommand" OnPageIndexChanging="grdEmployees_PageIndexChanging" CssClass="table-bordered table-striped gridpager" PagerStyle-CssClass="bs-pagination" AutoGenerateColumns="false">
                                <HeaderStyle ForeColor="Black" Font-Size="Small" BackColor="#428BCA" />
                                <RowStyle Font-Size="small" />
                                <Columns>
                                    <asp:TemplateField>
                                        <HeaderTemplate>&nbsp;User Name&nbsp;</HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblEmpID" runat="server" Text='<%#Bind("Email") %>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate></FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>&nbsp;Employee Name&nbsp;</HeaderTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox runat="server" Text='<%#Bind("Name") %>' ID="empName_Edit" AutoComplete="off" Placeholder="Employee Name" CssClass="form-control" TextMode="SingleLine" />
                                            <asp:RequiredFieldValidator runat="server" ValidationGroup="editVG" ControlToValidate="empName_Edit"
                                                CssClass="text-danger" ErrorMessage="*" />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblEmpName" runat="server" Text='<%#Bind("Name") %>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate></FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>&nbsp;Employee Gender&nbsp;</HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblEmpGender" runat="server" Text='<%#Bind("Gender") %>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate></FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>&nbsp;Employee Address&nbsp;</HeaderTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox runat="server" Text='<%#Bind("Address") %>' ID="empAddress_Edit" AutoComplete="off" Placeholder="Employee Address" CssClass="form-control" TextMode="SingleLine" />
                                            <asp:RequiredFieldValidator runat="server" ValidationGroup="editVG" ControlToValidate="empAddress_Edit"
                                                CssClass="text-danger" ErrorMessage="*" />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblEmpAddress" runat="server" Text='<%#Bind("Address") %>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate></FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>&nbsp;Employee Status&nbsp;</HeaderTemplate>
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="ddlEmpStatus_Edit" runat="server" CssClass="form-control">
                                                <asp:ListItem Value="-Select-">- Select -</asp:ListItem>
                                                <asp:ListItem Value="Doctor">Doctor</asp:ListItem>
                                                <asp:ListItem Value="Chief Technician">Chief Technician</asp:ListItem>
                                                <asp:ListItem Value="Senior Technician">Senior Technician</asp:ListItem>
                                                <asp:ListItem Value="Junior Technician">Junior Technician</asp:ListItem>
                                                <asp:ListItem Value="Lab Assistant">Lab Assistant</asp:ListItem>
                                                <asp:ListItem Value="Receptionist">Receptionist</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator runat="server" ValidationGroup="editVG" ControlToValidate="ddlEmpStatus_Edit"
                                                CssClass="text-danger" InitialValue="- Select -" ErrorMessage="*" />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblEmpStatus" runat="server" Text='<%#Bind("Designation") %>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate></FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>&nbsp;Branch&nbsp;</HeaderTemplate>
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="ddlBranch_Edit" runat="server" CssClass="form-control">
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator runat="server" ValidationGroup="editVG" ControlToValidate="ddlBranch_Edit"
                                                CssClass="text-danger" ErrorMessage="*" />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblBranch_Edit" runat="server" Text='<%#Bind("BranchFID") %>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate></FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>&nbsp;Employee Phone#&nbsp;</HeaderTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox runat="server" Text='<%#Bind("Phone") %>' ID="empPhone_Edit" AutoComplete="off" Placeholder="Employee Phone" CssClass="form-control" TextMode="SingleLine" />
                                            <asp:RequiredFieldValidator runat="server" ValidationGroup="editVG" ControlToValidate="empPhone_Edit"
                                                CssClass="text-danger" ErrorMessage="*" />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblEmpPhoneNo" runat="server" Text='<%#Bind("Phone") %>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate></FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>&nbsp;Actions&nbsp;</HeaderTemplate>
                                        <EditItemTemplate>
                                            <asp:ImageButton ID="updateEmployee" runat="server" ImageUrl="~/Images/updateImage.png" Height="30" Width="30" ValidationGroup="editVG" CommandName="updateRow" CommandArgument='<% #Eval("Email")%>' />
                                            <asp:ImageButton ID="cancelEmployee" runat="server" ImageUrl="~/Images/cancelImage.png" Height="30" Width="30" CommandName="cancelRow" CommandArgument='<% #Eval("Email")%>' />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:ImageButton ID="editEmployee" runat="server" ImageUrl="~/Images/editImage.png" Height="30" Width="30" CommandName="editRow" CommandArgument='<% #Eval("Email")%>' />
                                            <asp:ImageButton ID="deleteEmployee" runat="server" ImageUrl="~/Images/deleteImage.png" Height="30" Width="30" CommandName="deleteRow" CommandArgument='<% #Eval("Email")%>' />
                                        </ItemTemplate>
                                        <FooterTemplate></FooterTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <PagerStyle HorizontalAlign="Center"></PagerStyle>
                            </asp:GridView>
                            <br />
                        </div>
                        <br />
                        <br />
                        <div class="clearfix col-sm-10 col-sm-offset-1" style="border-bottom: 1.5px double #ccc; margin-bottom: 30px;">
                            <p class="pull-right" style="font-size: 16px; color: #666; font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif">&copy;<%: DateTime.Now.Year%>-All Rights Reserved at <b>Zamp Technologies</b></p>
                        </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="grdEmployees" EventName="RowCommand" />
                </Triggers>
            </asp:UpdatePanel>
            <asp:UpdateProgress ID="UpdateProgress2" runat="server" AssociatedUpdatePanelID="UpdatePanel2" DisplayAfter="10">
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
        </div>
    </div>
</asp:Content>
