<%@ Page Title="List" Language="C#" MasterPageFile="~/naveedLab.Master" AutoEventWireup="true" CodeBehind="FlagListPage.aspx.cs" Inherits="naveedLab.FlagListPage" %>

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
        .col-md-5 {
            padding-left:0px !important;
            padding-right:0px !important;
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
            <h2 class="page-header">OverAll Patient List [ Feeding / Printing ]
            </h2>
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-lg-12">

            <div class="panel panel-success col-md-5" style="margin-left:4% !important;">
                <div class="panel-heading">Patient Feeding</div>
                <div class="panel-body">
                    <asp:UpdatePanel ID="UpdatePanel" runat="server">
                        <ContentTemplate>
                            <br />
                            <br />

                            <div class="col-sm-12">
                                <div class="table table-responsive">
                                    <asp:GridView ID="grdFeeding" runat="server" AllowPaging="true" ShowHeader="true" PageSize="30" OnRowCommand="grdFeeding_RowCommand" OnPageIndexChanging="grdFeeding_PageIndexChanging" CssClass="table-bordered table-striped gridpager" PagerStyle-CssClass="bs-pagination" AutoGenerateColumns="false">
                                        <HeaderStyle ForeColor="Black" Font-Size="Small" BackColor="#428BCA" />
                                        <RowStyle Font-Size="small" />
                                        <Columns>
                                            <asp:TemplateField>
                                                <HeaderTemplate>&nbsp;Patient ID&nbsp;</HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPatientID" runat="server" Text='<%#Bind("PatientID") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>&nbsp;Patient Name&nbsp;</HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPatientName" runat="server" Text='<%#Bind("PatientName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>&nbsp;Registered Date&nbsp;</HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDate" runat="server" Text='<%#Bind("Date") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>&nbsp;OPD/WARD #&nbsp;</HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPhone" runat="server" Text='<%#Bind("Phone") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>&nbsp;Gender&nbsp;</HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblGender" runat="server" Text='<%#Bind("Gender") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>&nbsp;Age&nbsp;</HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAddress" runat="server" Text='<%#Bind("Age") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>&nbsp;Actions&nbsp;</HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="RedirectRow" runat="server" ImageUrl="~/Images/feeding.png" Height="30" Width="30" CommandName="RedirectRow" CommandArgument='<% #Eval("PatientID")%>' />
                                                </ItemTemplate>
                                                <FooterTemplate></FooterTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <PagerStyle HorizontalAlign="Center"></PagerStyle>
                                    </asp:GridView>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
            <div class="panel panel-warning col-md-5 col-sm-offset-1">
                <div class="panel-heading">Patient Printing</div>
                <div class="panel-body">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <br />
                            <br />

                            <div class="col-sm-12">
                                <div class="table table-responsive">
                                    <asp:GridView ID="grdPrinting" runat="server" AllowPaging="true" ShowHeader="true" PageSize="30" OnRowCommand="grdPrinting_RowCommand" OnPageIndexChanging="grdPrinting_PageIndexChanging" CssClass="table-bordered table-striped gridpager" PagerStyle-CssClass="bs-pagination" AutoGenerateColumns="false">
                                        <HeaderStyle ForeColor="Black" Font-Size="Small" BackColor="#428BCA" />
                                        <RowStyle Font-Size="small" />
                                        <Columns>
                                            <asp:TemplateField>
                                                <HeaderTemplate>&nbsp;Patient ID&nbsp;</HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPatientID" runat="server" Text='<%#Bind("PatientID") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>&nbsp;Patient Name&nbsp;</HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPatientName" runat="server" Text='<%#Bind("PatientName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>&nbsp;Registered Date&nbsp;</HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDate1" runat="server" Text='<%#Bind("Date") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>&nbsp;OPD/WARD #&nbsp;</HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPhone1" runat="server" Text='<%#Bind("Phone") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>&nbsp;Gender&nbsp;</HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblGender" runat="server" Text='<%#Bind("Gender") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>&nbsp;Age&nbsp;</HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAddress" runat="server" Text='<%#Bind("Age") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>&nbsp;Actions&nbsp;</HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="RedirectRow" runat="server" ImageUrl="~/Images/printer.png" Height="30" Width="30" CommandName="RedirectRow" CommandArgument='<% #Eval("PatientID")%>' />
                                                </ItemTemplate>
                                                <FooterTemplate></FooterTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <PagerStyle HorizontalAlign="Center"></PagerStyle>
                                    </asp:GridView>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>

            <br />
            <br />
            <div class="clearfix col-sm-10 col-sm-offset-1" style="border-bottom: 1.5px double #ccc; margin-bottom: 30px;">
                <p class="pull-right" style="font-size: 16px; color: #666; font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif">&copy;<%: DateTime.Now.Year%>-All Rights Reserved at <b>Zamp Technologies</b></p>
            </div>
        </div>
    </div>
</asp:Content>
