<%@ Page Title="Doctor" Language="C#" MasterPageFile="~/naveedLab.Master" AutoEventWireup="true" CodeBehind="doctor.aspx.cs" Inherits="naveedLab.doctor" %>

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
            <h1 class="page-header">Doctor
            </h1>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div id="bannersTop">
                        <div runat="server" class="alert alert-success" visible="false" role="alert" id="naveed_popup">
                            <img src="Images/check-mark.png" width="36" height="36" />
                            <span runat="server" id="naveed_popup_text"></span>
                        </div>
                        <div runat="server" class="alert alert-danger" visible="false" role="alert" id="naveed_Danger">
                            <img src="Images/1194985624696670932tasto_10_architetto_fran_01.svg.med.png" width="36" height="36" />
                            <span runat="server" id="naveed_Danger_Text">&nbsp;</span>
                        </div>
                    </div>
                    <br />
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="drName" CssClass="col-md-2 control-label">Doctor Name</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" Width="32%" ID="drName" AutoComplete="off" Placeholder="Enter Doctor Name" CssClass="form-control" TextMode="SingleLine" />
                            <asp:RequiredFieldValidator runat="server" ValidationGroup="vg" ControlToValidate="drName"
                                CssClass="text-danger" ErrorMessage="The Doctor Name is Required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="rbtnMale" CssClass="col-md-2 control-label">Doctor Gender</asp:Label>
                        <div class="col-md-10">
                            <asp:RadioButton ID="rbtnMale" GroupName="sex" Checked="true" Text="&nbsp; Male" runat="server" />
                            <asp:RadioButton ID="rbtnFemale" GroupName="sex" Text="&nbsp;Female" runat="server" />
                            <br />
                            <br />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="ddlDrType" CssClass="col-md-2 control-label">Doctor Type</asp:Label>
                        <div class="col-md-10">
                            <asp:DropDownList ID="ddlDrType" runat="server" CssClass="form-control" Width="32%">
                                <asp:ListItem Value="-Select-">- Select -</asp:ListItem>
                                <asp:ListItem Value="Pharmacist">Pharmacist</asp:ListItem>
                                <asp:ListItem Value="Surgeon">Surgeon</asp:ListItem>
                                <asp:ListItem Value="Specialist">Specialist</asp:ListItem>
                                <asp:ListItem Value="Other">Other</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator runat="server" ValidationGroup="vg" ControlToValidate="ddlDrType"
                                CssClass="text-danger" InitialValue="-Select-" ErrorMessage="The Doctor Type is Required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="drAddress" CssClass="col-md-2 control-label">Doctor Address</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" Width="32%" ID="drAddress" AutoComplete="off" Placeholder="Enter Doctor Address" CssClass="form-control" TextMode="MultiLine" />
                            <asp:RequiredFieldValidator runat="server" ValidationGroup="vg" ControlToValidate="drAddress"
                                CssClass="text-danger" ErrorMessage="The Doctor Address is Required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="drPercentage" CssClass="col-md-2 control-label">Doctor %age</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" Width="32%" ID="drPercentage" AutoComplete="off" Placeholder="Enter %age" CssClass="form-control bottomSpacetxtBox" TextMode="SingleLine" />
                            <asp:RequiredFieldValidator runat="server" ValidationGroup="vg" ControlToValidate="drPercentage" Display="Dynamic"
                                CssClass="text-danger" ErrorMessage="The Doctor %age is Required." />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" CssClass="text-danger" ControlToValidate="drPercentage" Display="Dynamic" ValidationExpression="^[0-9]*$" ValidationGroup="vg" runat="server" ErrorMessage="Only No [ 0 - 9 ]"></asp:RegularExpressionValidator>
                        </div>
                    </div>
                    <div class="form-group">
                        <br />
                        <asp:Label runat="server" AssociatedControlID="drNo" CssClass="col-md-2 control-label">Doctor Phone#</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" Width="32%" ID="drNo" AutoComplete="off" Placeholder="Enter Phone#" CssClass="form-control" TextMode="SingleLine" />
                            <asp:RequiredFieldValidator runat="server" ValidationGroup="vg" ControlToValidate="drNo" Display="Dynamic"
                                CssClass="text-danger" ErrorMessage="The Doctor Phone# is Required." />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" CssClass="text-danger" ControlToValidate="drNo" Display="Dynamic" ValidationExpression="\d{4}-\d{7}" ValidationGroup="vg" runat="server" ErrorMessage="XXXX-XXXXXXX"></asp:RegularExpressionValidator>
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
                            <asp:GridView ID="grdDoctor" runat="server" AllowPaging="true" ShowHeader="true" PageSize="10" OnRowCommand="grdDoctor_RowCommand" OnPageIndexChanging="grdDoctor_PageIndexChanging" CssClass="table-bordered table-striped gridpager" PagerStyle-CssClass="bs-pagination" AutoGenerateColumns="false">
                                <HeaderStyle ForeColor="Black" Font-Size="Small" BackColor="#428BCA" />
                                <RowStyle Font-Size="small" />
                                <Columns>
                                    <asp:TemplateField>
                                        <HeaderTemplate>&nbsp;Doctor Name&nbsp;</HeaderTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox runat="server" Text='<%#Bind("DoctorName") %>' ID="drName_Edit" AutoComplete="off" Placeholder="Doctor Name" CssClass="form-control" TextMode="SingleLine" />
                                            <asp:RequiredFieldValidator runat="server" ValidationGroup="editVG" ControlToValidate="drName_Edit"
                                                CssClass="text-danger" ErrorMessage="*" />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblDrName" runat="server" Text='<%#Bind("DoctorName") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>&nbsp;Doctor Gender&nbsp;</HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblDrGender" runat="server" Text='<%#Bind("Gender") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>&nbsp;Doctor Address&nbsp;</HeaderTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox runat="server" Text='<%#Bind("Address") %>' ID="drAddress_Edit" AutoComplete="off" Placeholder="Doctor Address" CssClass="form-control" TextMode="SingleLine" />
                                            <asp:RequiredFieldValidator runat="server" ValidationGroup="editVG" ControlToValidate="drAddress_Edit"
                                                CssClass="text-danger" ErrorMessage="*" />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblDrAddress" runat="server" Text='<%#Bind("Address") %>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate></FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>&nbsp;Doctor Type&nbsp;</HeaderTemplate>
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="ddlDrType_Edit" runat="server" CssClass="form-control" Width="100%">
                                                <asp:ListItem Value="-Select-">- Select -</asp:ListItem>
                                                <asp:ListItem Value="Pharmacist">Pharmacist</asp:ListItem>
                                                <asp:ListItem Value="Surgeon">Surgeon</asp:ListItem>
                                                <asp:ListItem Value="Specialist">Specialist</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator runat="server" ValidationGroup="editVG" ControlToValidate="ddlDrType_Edit"
                                                CssClass="text-danger" InitialValue="-Select-" ErrorMessage="T*" />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblDrStatus" runat="server" Text='<%#Bind("DoctorType") %>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate></FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>&nbsp;Doctor Phone#&nbsp;</HeaderTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox runat="server" Text='<%#Bind("Phone") %>' ID="drPhone_Edit" AutoComplete="off" Placeholder="Doctor Address" CssClass="form-control" TextMode="SingleLine" />
                                            <asp:RequiredFieldValidator runat="server" ValidationGroup="editVG" ControlToValidate="drPhone_Edit"
                                                CssClass="text-danger" ErrorMessage="*" />
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" CssClass="text-danger" ControlToValidate="drPhone_Edit" Display="Dynamic" ValidationExpression="\d{4}-\d{7}" ValidationGroup="editVG" runat="server" ErrorMessage="*"></asp:RegularExpressionValidator>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblDrPhoneNo" runat="server" Text='<%#Bind("Phone") %>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate></FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>&nbsp;Doctor %age&nbsp;</HeaderTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox runat="server" Text='<%#Bind("SharePercentage") %>' ID="drSharePercentage_Edit" AutoComplete="off" Placeholder="Doctor Address" CssClass="form-control" TextMode="SingleLine" />
                                            <asp:RequiredFieldValidator runat="server" ValidationGroup="editVG" ControlToValidate="drSharePercentage_Edit"
                                                CssClass="text-danger" ErrorMessage="*" />
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator15" CssClass="text-danger" ControlToValidate="drSharePercentage_Edit" Display="Dynamic" ValidationExpression="^[0-9]*$" ValidationGroup="editVG" runat="server" ErrorMessage="*"></asp:RegularExpressionValidator>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblDrPercentage" runat="server" Text='<%#Bind("SharePercentage") %>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate></FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>&nbsp;Actions&nbsp;</HeaderTemplate>
                                        <EditItemTemplate>
                                            <asp:ImageButton ID="updateDoctor" runat="server" ValidationGroup="editVG" ImageUrl="~/Images/updateImage.png" Height="30" Width="30" CommandName="updateRow" CommandArgument='<% #Eval("DoctorId")%>' />
                                            <asp:ImageButton ID="cancelDoctor" runat="server" ImageUrl="~/Images/cancelImage.png" Height="30" Width="30" CommandName="cancelRow" CommandArgument='<% #Eval("DoctorId")%>' />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:ImageButton ID="editDoctor" runat="server" ImageUrl="~/Images/editImage.png" Height="30" Width="30" CommandName="editRow" CommandArgument='<% #Eval("DoctorId")%>' />
                                            <asp:ImageButton ID="deleteDoctor" runat="server" ImageUrl="~/Images/deleteImage.png" Height="30" Width="30" CommandName="deleteRow" CommandArgument='<% #Eval("DoctorId")%>' />
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
                        </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="grdDoctor" EventName="RowCommand" />
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
