<%@ Page Title="Add New Test" Language="C#" MasterPageFile="~/naveedLab.Master" AutoEventWireup="true" CodeBehind="AddNewTest.aspx.cs" Inherits="naveedLab.AddNewTest" %>

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

    <style>
        .hidden {
            display: none;
        }

        .btnFormat {
            width: 80px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyData" runat="server">
    <br />
    <br />
    <br />
    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 text-center">

        <h3 class="text-info">Test Category</h3>
    </div>

    <br />
    <br />
    <br />
    <div class="  col-md-3 col-lg-3">

        <div class="form-group">
            <label>Select Branch</label>

            <asp:DropDownList ID="ddlBranch" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlBranch_SelectedIndexChanged" ValidationGroup="z" CssClass="form-control" AppendDataBoundItems="true">
                <asp:ListItem>Select One</asp:ListItem>

            </asp:DropDownList>

            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" InitialValue="Select One" runat="server" ErrorMessage="Choose Catogary" ForeColor="Red" ValidationGroup="z" ControlToValidate="ddlBranch"></asp:RequiredFieldValidator>

        </div>
    </div>


    <div class="  col-md-3 col-lg-3">

        <div class="form-group">
            <label id="lblTestName" runat="server">Enter Test Name</label>


            <asp:TextBox ID="txtTestName" runat="server" class="form-control" placeholder=""></asp:TextBox>
            <asp:Label ID="lblDuplicate" runat="server" Text="" CssClass="alert-danger"></asp:Label>

            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter Test Name" ForeColor="Red" ValidationGroup="z" ControlToValidate="txtTestName"></asp:RequiredFieldValidator>

        </div>
    </div>

    <br />
    <br />
    <br />
    <div class="col-lg-8 col-lg-offset-4  col-md-8 col-md-offset-4 col-lg-8 col-lg-offset-4  ">

        <asp:Button ID="btnSave" runat="server" ValidationGroup="z" OnClick="btnSave_Click" CssClass="btn btn-primary btn-md" Text="Save" />
        <br />
        <br />
        <br />
    </div>



    <div class="col-xs-12 col-sm-12 col-md-8 col-md-offset-3  col-lg-8 col-lg-offset-3 table-responsive">

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
                <asp:GridView ID="dgvNewTest" runat="server" AutoGenerateColumns="False" ShowFooter="true" OnRowDeleting="dgvNewTest_RowDeleting" OnRowEditing="dgvNewTest_RowEditing" OnRowCancelingEdit="dgvNewTest_RowCancelingEdit" OnRowUpdating="dgvNewTest_RowUpdating" ShowHeader="true" CssClass=" col-md-7 col-md-offset-0 table-bordered table-striped gridpager margin">
                    <HeaderStyle ForeColor="Black" Font-Size="Small" BackColor="#428BCA" />
                    <RowStyle Font-Size="small" />
                    <Columns>

                        <%--Sr--%>
                        <%--<asp:TemplateField>
                            <HeaderTemplate>Test ID</HeaderTemplate>


                            <ItemTemplate>
                                <asp:Label ID="lblSr" Text='<% #bind("Id")%>' runat="server"></asp:Label>
                            </ItemTemplate>


                        </asp:TemplateField>--%>
                        <%-- End Sr--%>

                        <%--Test Name--%>
                        <asp:TemplateField>
                            <HeaderTemplate>Test-Name</HeaderTemplate>
                            <EditItemTemplate>

                                <asp:TextBox ID="txtTestName" CssClass="form-control" Text='<% #bind("TestName")%>' runat="server"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblTestName" Text='<% #bind("TestName")%>' runat="server"></asp:Label>
                            </ItemTemplate>

                        </asp:TemplateField>
                        <%-- End Test Name--%>

                        <asp:TemplateField>
                            <ItemTemplate>
                                <center>
                        <asp:ImageButton ID="btnEdit" AlternateText="Edit" CommandName="Edit" ImageUrl="~/images/editImage.png" style="width:28px; height:28px" runat="server" />
                      
                              <asp:ImageButton ID="btnDelete" AlternateText="Delete" CommandName="Delete" style="width:28px; height:28px" ImageUrl="~/images/deleteImage.png" runat="server" />
                        <%--<asp:LinkButton ID="btnEdit" Text="Edit" runat="server" CommandName="Edit" />
                        <asp:LinkButton ID="btnDelete" Text="Delete" runat="server" CommandName="Delete" />--%>
                            <center>
                            </ItemTemplate>

                            <EditItemTemplate>
                                <center>
                         <asp:ImageButton ID="btnUpdate" ValidationGroup="validateEditFields" CommandName="Update" style="width:28px; height:28px" AlternateText="Update" ImageUrl="~/images/updateImage.png" runat="server" />
                        <asp:ImageButton ID="btnCancel" runat="server" AlternateText="Cancel" ImageUrl="~/images/cancelImage.png" style="width:28px; height:28px" CommandName="Cancel" />
                        <%--<asp:LinkButton ID="btnUpdate" ValidationGroup="validateEditFields" Text="Update" runat="server" CommandName="Update" />
                        <asp:LinkButton ID="btnCancel" Text="Cancel" runat="server" CommandName="Cancel" />--%>
                            <center>
                            </EditItemTemplate>

                            <FooterTemplate>
                                <center class="">
                           
                            </center>
                            </FooterTemplate>

                        </asp:TemplateField>






                        <%-- End Name--%>
                    </Columns>
                    <PagerStyle HorizontalAlign="Center"></PagerStyle>
                </asp:GridView>
                <br />
                <br />
                <br />


            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="dgvNewTest" EventName="RowCommand" />

            </Triggers>
        </asp:UpdatePanel>
    </div>

    <div class="clearfix col-sm-10 col-sm-offset-1" style="border-bottom: 1.5px double #ccc; margin-top: 30px; margin-bottom: 30px;">
        <p class="pull-right" style="font-size: 16px; color: #666; font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif">&copy;<%: DateTime.Now.Year%>-All Rights Reserved at <b>Zamp Technologies</b></p>
    </div>

    <%--GidView--%>
</asp:Content>
