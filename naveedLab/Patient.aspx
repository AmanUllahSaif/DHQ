<%@ Page Title="Patient" Language="C#" MasterPageFile="~/naveedLab.Master" AutoEventWireup="true" CodeBehind="Patient.aspx.cs" Inherits="naveedLab.Patient" %>

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
            <h1 class="page-header">Patient
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
                        <asp:Label runat="server" AssociatedControlID="patientName" CssClass="col-md-2 control-label">Patient Name</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="patientName" Width="32%" AutoComplete="off" Placeholder="Enter Patient Name" CssClass="form-control" TextMode="SingleLine" />
                            <asp:RequiredFieldValidator runat="server" ValidationGroup="vg" ControlToValidate="patientName"
                                CssClass="text-danger" ErrorMessage="The Patient Name is Required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="patientAge" CssClass="col-md-2 control-label">Patient Age</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="patientAge" Width="32%" AutoComplete="off" Placeholder="Enter Patient Age" CssClass="form-control bottomSpacetxtBox" TextMode="SingleLine" />
                            <asp:RequiredFieldValidator runat="server" ValidationGroup="vg" ControlToValidate="patientAge" Display="Dynamic"
                                CssClass="text-danger" ErrorMessage="The Patient Age is Required." />
                            <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="Invalid Age. Please enter the age between 1 to 150." ValidationGroup="vg" ControlToValidate="patientAge"
                                CssClass="text-danger" Display="Dynamic" MaximumValue="150" MinimumValue="1" Type="Integer"></asp:RangeValidator>
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="patientAge" CssClass="col-md-2 control-label">Patient Gender</asp:Label>
                        <div class="col-md-10">
                            <asp:RadioButton ID="rbtnMale" GroupName="Sex" Text="&nbsp; Male" runat="server" Checked="true" />
                            <asp:RadioButton ID="rbtnFemale" GroupName="Sex" Text="&nbsp;Female" runat="server" />

                            <br />
                            <br />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="patientPhone" CssClass="col-md-2 control-label">MR# (OPD/WRD)</asp:Label>
                        <div class="col-md-10">
                            <table border="0">
                                <tr>
                                    <td>
                                        <div style="margin-top: -20px !important;">
                                            <asp:DropDownList ID="ddlType" runat="server" CssClass="form-control" AutoPostBack="True">
                                                <asp:ListItem Text="OPD" Value="OPD" Selected="True"></asp:ListItem>
                                                <asp:ListItem Text="WARD" Value="WARD"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" Width="95%" ID="patientPhone" AutoComplete="off" Placeholder="Enter OPD#/WRD#" CssClass="form-control bottomSpacetxtBox" TextMode="SingleLine" />
                                    </td>
                                </tr>
                            </table>

                            <asp:RequiredFieldValidator runat="server" ValidationGroup="vg" ControlToValidate="patientPhone" Display="Dynamic"
                                CssClass="text-danger" ErrorMessage="The MR# is Required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="ddlDoctorName" CssClass="col-md-2 control-label">Doctor Name</asp:Label>
                        <div class="col-md-10">
                            <asp:DropDownList ID="ddlDoctorName" runat="server" CssClass="form-control" Width="32%" AutoPostBack="True">
                                <asp:ListItem>- Select -</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator runat="server" ValidationGroup="vg" ControlToValidate="ddlDoctorName"
                                CssClass="text-danger" ErrorMessage="The Docotr Name is Required." />
                        </div>
                    </div>
                    <%--<div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtDailyNo" CssClass="col-md-2 control-label">Daily #</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" Width="32%" ID="txtDailyNo" ReadOnly="true" AutoComplete="off" Placeholder="Enter Daily #" CssClass="form-control" TextMode="SingleLine" />
                            <asp:RequiredFieldValidator runat="server" ValidationGroup="vg" ControlToValidate="txtDailyNo"
                                CssClass="text-danger" ErrorMessage="The Daily# is Required." />
                        </div>
                    </div>--%>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="date" CssClass="col-md-2 control-label">Date</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" Width="32%" ID="date" AutoComplete="off" Placeholder="Enter Date (MM/DD/YYYY)" CssClass="form-control" TextMode="SingleLine" />
                            <asp:RequiredFieldValidator runat="server" ValidationGroup="vg" ControlToValidate="date"
                                CssClass="text-danger" ErrorMessage="The Date is Required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-offset-2 col-md-10">
                            <br />
                            <asp:Button runat="server" ID="btnAdd" ValidationGroup="vg" Text="Add" OnClick="btnAdd_Click" CssClass="btn btn-success" />
                            <asp:Button runat="server" ID="btnClear" Text="Clear" OnClick="btnClear_Click" CssClass="btn btn-danger" />
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
            <br />
            <br />
            <br />
            <div class="row">
                <div class="col-lg-12">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <br />
                            <br />
                            <br />
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
                            <br />
                            <div class="col-sm-8 col-sm-offset-3">
                                <table border="0">
                                    <tr>
                                        <th colspan="2">
                                            <h2 style="text-align: center;">Search Patient </h2>
                                        </th>
                                    </tr>
                                    <tr>
                                        <td style="padding-top: 10px;">
                                            <div class="form-group">
                                                <div class="col-md-12">
                                                    <asp:TextBox runat="server" ID="pId" AutoComplete="off" Placeholder="Enter Patient ID" CssClass="form-control" TextMode="Number" />
                                                    <asp:RequiredFieldValidator runat="server" ValidationGroup="VGSEARCH" ControlToValidate="pId"
                                                        CssClass="text-danger" ErrorMessage="The Patient ID is Required." />
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div style="margin-top: -22px !important;">
                                                <asp:Button runat="server" ID="btnSearch" ValidationGroup="VGSEARCH" Text="Search" OnClick="btnSearch_Click" CssClass="btn btn-success negPadding" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <h3 class="text-danger" runat="server" id="lblErrorText" style="text-align: center;"></h3>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <br />
                            <div class="col-sm-10 col-sm-offset-2">
                                <div class="table table-responsive">
                                    <asp:GridView ID="grdPatient" runat="server" AllowPaging="true" OnRowCommand="grdPatient_RowCommand" ShowHeader="true" PageSize="10" CssClass="table-bordered table-striped gridpager" PagerStyle-CssClass="bs-pagination" AutoGenerateColumns="false">
                                        <HeaderStyle ForeColor="Black" Font-Size="Small" BackColor="#428BCA" />
                                        <RowStyle Font-Size="small" />
                                        <Columns>
                                            <asp:TemplateField>
                                                <HeaderTemplate>&nbsp;Patient Name&nbsp;</HeaderTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox runat="server" Text='<%#Bind("PatientName") %>' ID="PtName_Edit" AutoComplete="off" Placeholder="Patient Name" CssClass="form-control" TextMode="SingleLine" />
                                                    <asp:RequiredFieldValidator runat="server" ValidationGroup="editVG" ControlToValidate="PtName_Edit"
                                                        CssClass="text-danger" ErrorMessage="*" />
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDrName" runat="server" Text='<%#Bind("PatientName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>&nbsp;Patient Gender&nbsp;</HeaderTemplate>
                                                <EditItemTemplate>
                                                    <asp:RadioButton ID="rbtnMale_Edit" GroupName="Sex" Text="&nbsp; Male" runat="server" Checked="true" />
                                                    <asp:RadioButton ID="rbtnFemale_Edit" GroupName="Sex" Text="&nbsp;Female" runat="server" />
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPtGender" runat="server" Text='<%#Bind("Gender") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>&nbsp;Patient Age&nbsp;</HeaderTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox runat="server" Text='<%#Bind("Age") %>' ID="PtAge_Edit" AutoComplete="off" Placeholder="PatientAge" CssClass="form-control" TextMode="SingleLine" />
                                                    <asp:RequiredFieldValidator runat="server" ValidationGroup="editVG" ControlToValidate="PtAge_Edit"
                                                        CssClass="text-danger" ErrorMessage="*" />
                                                    <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="*" ValidationGroup="editVG" ControlToValidate="PtAge_Edit"
                                                        CssClass="text-danger" Display="Dynamic" MaximumValue="100" MinimumValue="1" Type="Integer"></asp:RangeValidator>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDrAddress" runat="server" Text='<%#Bind("Age") %>'></asp:Label>
                                                </ItemTemplate>
                                                <FooterTemplate></FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>&nbsp;MR# (OPD/WRD)&nbsp;</HeaderTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox runat="server" Text='<%#Bind("Phone") %>' ID="PtPhone_Edit" AutoComplete="off" Placeholder="Enter (OPD/WRD)" CssClass="form-control" TextMode="SingleLine" />
                                                    <asp:RequiredFieldValidator runat="server" ValidationGroup="editVG" ControlToValidate="PtPhone_Edit"
                                                        CssClass="text-danger" ErrorMessage="*" />
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" CssClass="text-danger" ControlToValidate="PtPhone_Edit" Display="Dynamic" ValidationExpression="\d{4}-\d{7}" ValidationGroup="editVG" runat="server" ErrorMessage="*"></asp:RegularExpressionValidator>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDrPhoneNo" runat="server" Text='<%#Bind("Phone") %>'></asp:Label>
                                                </ItemTemplate>
                                                <FooterTemplate></FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>&nbsp;Actions&nbsp;</HeaderTemplate>
                                                <EditItemTemplate>
                                                    <asp:ImageButton ID="updateDoctor" runat="server" ValidationGroup="editVG" ImageUrl="~/Images/updateImage.png" Height="30" Width="30" CommandName="updateRow" CommandArgument='<% #Eval("PatientID")%>' />
                                                    <asp:ImageButton ID="cancelDoctor" runat="server" ImageUrl="~/Images/cancelImage.png" Height="30" Width="30" CommandName="cancelRow" CommandArgument='<% #Eval("PatientID")%>' />
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="editDoctor" runat="server" ImageUrl="~/Images/editImage.png" Height="30" Width="30" CommandName="editRow" CommandArgument='<% #Eval("PatientID")%>' />
                                                    <%--<asp:ImageButton ID="deleteDoctor" runat="server" ImageUrl="~/Images/deleteImage.png" Height="30" Width="30" CommandName="deleteRow" CommandArgument='<% #Eval("DoctorId")%>' />--%>
                                                </ItemTemplate>
                                                <FooterTemplate></FooterTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <PagerStyle HorizontalAlign="Center"></PagerStyle>
                                    </asp:GridView>
                                    <br />
                                    <br />
                                    <div class="clearfix col-sm-10 col-sm-offset-1" style="border-bottom: 1.5px double #ccc; margin-bottom: 30px;">
                                        <p class="pull-right" style="font-size: 16px; color: #666; font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif">&copy;<%: DateTime.Now.Year%>-All Rights Reserved at <b>Zamp Technologies</b></p>
                                    </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="grdPatient" EventName="RowCommand" />
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
