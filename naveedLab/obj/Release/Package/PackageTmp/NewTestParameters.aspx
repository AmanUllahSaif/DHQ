<%@ Page Title=" New Test Parameter" Language="C#" MasterPageFile="~/naveedLab.Master" AutoEventWireup="true" CodeBehind="NewTestParameters.aspx.cs" Inherits="naveedLab.NewTestParameters" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headerData" runat="server">
    <script src="Scripts/bootstrap.js"></script>
    <%--<script type="text/javascript">
        function pageLoad() {
            $('.bs-pagination td table').each(function (index, obj) {
                convertToPagination(obj)
            });
        }
    </script>--%>
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
    </style>
    <script type="text/javascript">

        $(document).ready(function () {
            $("#OpenModal").click(function () {
                $("#myModal").modal('show');
            });
        });



    </script>
    <script type="text/javascript">

        function showError(textVal) {
            $("#myModal").modal();

            $('#msg').text("");
            $('#msg').append('<h4><p class="text-info text-lg">' + textVal + '</p></h4>');

        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyData" runat="server">
    <br />
    <br />
    <br />

    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 text-center">

        <h3 class="text-info">New Tests</h3>
    </div>

    <br />
    <br />
    <br />





    <div class=" col-xs-8 col-sm-4 col-md-4 col-lg-4">

        <div class="form-group">
            <label>Select Branch</label>

            <asp:DropDownList ID="ddlBranch" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlBranch_SelectedIndexChanged" ValidationGroup="z" CssClass="form-control" AppendDataBoundItems="true">
                <asp:ListItem>Select One</asp:ListItem>

            </asp:DropDownList>

            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" InitialValue="Select One" runat="server" ErrorMessage="Choose Catogary" ForeColor="Red" ValidationGroup="z" ControlToValidate="ddlBranch"></asp:RequiredFieldValidator>

        </div>
    </div>

    <div class=" col-xs-8 col-sm-4 col-md-4 col-lg-4">

        <div class="form-group">
            <label>Select Test Name</label>

            <asp:DropDownList ID="ddlTestName" runat="server" AppendDataBoundItems="true" Enabled="false" AutoPostBack="true" OnSelectedIndexChanged="ddlTestName_SelectedIndexChanged" ValidationGroup="z" CssClass="form-control">
                <%--<asp:ListItem>Choose</asp:ListItem>--%>
            </asp:DropDownList>

            <asp:RequiredFieldValidator ID="RequiredFieldValidator11" InitialValue="Choose" runat="server" ErrorMessage="Choose Test" ForeColor="Red" ValidationGroup="z" ControlToValidate="ddlTestName"></asp:RequiredFieldValidator>

        </div>

    </div>


    <div class="col-xs-12 col-sm-12 col-md-8 col-md-offset-3  col-lg-8 col-lg-offset-3 table-responsive">

        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <%--Modal--%>

                <div id="myModal" class="modal fade">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header" style="background: #5CB85C ; border-top-left-radius: 4px; border-top-right-radius: 4px;">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                <h4 class="modal-title" style="color: #fff">Message</h4>
                            </div>
                            <div id="msg">
                                <h4>&nbsp;&nbsp;&nbsp;Your Record has been Saved Successfully</h4>
                            </div>
                            <div class="modal-footer">
                                <%--<button type="button" class="btn btn-primary" runat="server"  onclick="" data-dismiss="modal">OK</button>--%>
                                <asp:Button ID="btnModelResponseRedirect" runat="server" Text="Close" CssClass="btn btn-primary" UseSubmitBehavior="false" data-dismiss="modal" OnClick="btnModelResponseRedirect_Click" />

                            </div>
                        </div>
                    </div>
                </div>



                <%--//Modal--%>

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
                <asp:GridView ID="dgvNewTest" runat="server" AutoGenerateColumns="False" ShowFooter="true" OnRowDeleting="dgvNewTest_RowDeleting" OnRowEditing="dgvNewTest_RowEditing" OnRowCancelingEdit="dgvNewTest_RowCancelingEdit" OnRowUpdating="dgvNewTest_RowUpdating" ShowHeader="true" CssClass=" col-md-7 col-md-offset-0 table-bordered table-striped gridpager margin" PagerStyle-CssClass="bs-pagination">
                    <HeaderStyle ForeColor="Black" Font-Size="Small" BackColor="#428BCA" />
                    <RowStyle Font-Size="small" />
                    <Columns>

                        <%--   <asp:BoundField DataField="Hidden1" HeaderText="AddressID" Visible="False" />
                        <asp:BoundField DataField="Hidden2" HeaderText="AddressID"  Visible="False" />--%>


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

                                <asp:TextBox ID="txtTestName" CssClass="form-control" Text='<% #bind("Name")%>' runat="server"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <%--<asp:HiddenField ID="hidden_pid"  ItemStyle-CssClass="hidden" Value='<%# Eval("Name") %>'  runat="server" />--%>

                                <asp:Label ID="lblTestName" Text='<% #bind("Name")%>' runat="server"></asp:Label>
                            </ItemTemplate>

                            <FooterTemplate>
                                <asp:TextBox ID="txtFooterTestName" CssClass="form-control" runat="server"></asp:TextBox>

                            </FooterTemplate>
                        </asp:TemplateField>
                        <%-- End Test Name--%>

                        <%----%>

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
                            <asp:ImageButton ID="btnAdd" class="btn btn-primary btn-sm" ImgAlign="middle" ValidationGroup="validateFooterFields" AlternateText="Add" OnClick="btnAdd_Click"  ImageUrl="~/imagesAndIcons/Admission.png" runat="server" />
                        <%--<asp:LinkButton ID="btnAdd" ValidationGroup="validateFooterFields" Text="Add" runat="server" OnClick="btnAdd_Click" />--%>
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
        <br />
        <br />
        <br />
    </div>
    <br />
    <br />
    <div style="margin-top: 30px;" class=" col-xs-6 col-xs-offset-4 col-sm-3 col-sm-offset-5   col-md-3 col-md-offset-4  col-lg-4 col-lg-offset-5  ">
        <asp:Button ID="btnSave" runat="server" Text="Save" ValidationGroup="z" OnClick="btnSave_Click" CssClass="btn btn-primary btnlg" />
        <br />
        <br />
    </div>

    <%--End Grid Two--%>

    <div class="clearfix col-sm-10 col-sm-offset-1" style="border-bottom: 1.5px double #ccc; margin-bottom: 30px;">
        <p class="pull-right" style="font-size: 16px; color: #666; font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif">&copy;<%: DateTime.Now.Year%>-All Rights Reserved at <b>Zamp Technologies</b></p>
    </div>
    <br />
    <br />
</asp:Content>
