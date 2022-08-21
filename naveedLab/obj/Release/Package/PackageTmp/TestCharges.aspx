<%@ Page Title="Test Charges" Language="C#" MasterPageFile="~/naveedLab.Master" AutoEventWireup="true" CodeBehind="TestCharges.aspx.cs" Inherits="naveedLab.TestCharges" %>

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

    <br />
    <h3 class="page-header">Test Charges</h3>    
    <br />
    <br />

    <div class=" col-xs-8 col-sm-4 col-md-4 col-lg-4">

        <div class="form-group">
            <label>Select Branch</label>

            <asp:DropDownList ID="ddlBranch" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlBranch_SelectedIndexChanged" ValidationGroup="z" CssClass="form-control" AppendDataBoundItems="true">
                <asp:ListItem>Choose</asp:ListItem>

            </asp:DropDownList>

            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" InitialValue="Choose" runat="server" ErrorMessage="Choose Catogary" ForeColor="Red" ValidationGroup="z" ControlToValidate="ddlBranch"></asp:RequiredFieldValidator>

        </div>

    </div>
    <%--Grid Two--%>
    <div class="col-md-12 table table-responsive">


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
        <asp:GridView ID="dgv" runat="server"   OnRowEditing="dgv_RowEditing" OnRowCancelingEdit="dgv_RowCancelingEdit" OnRowUpdating="dgv_RowUpdating" ShowHeader="true" CssClass=" col-md-7 col-md-offset-2 table-bordered table-striped gridpager margin" PagerStyle-CssClass="bs-pagination" AutoGenerateColumns="false">
            <HeaderStyle ForeColor="Black" Font-Size="Small" BackColor="#428BCA" />
                                <RowStyle Font-Size="small" />
            <Columns>
                <%--Sr No--%>
                <%--<asp:TemplateField>
                    <HeaderTemplate>Sr</HeaderTemplate>

                    <ItemTemplate>
                        <asp:Label ID="lbl2" ControlStyle-CssClass="btn btn-primary btn-xs" Text='<% #bind("ChapterID")%>' runat="server"></asp:Label>
                    </ItemTemplate>


                </asp:TemplateField>--%>
                <%-- End Sr No--%>


                <%--Subject--%>
                <asp:TemplateField>
                    <HeaderTemplate>Test-Name</HeaderTemplate>

                    <ItemTemplate>
                        <asp:Label ID="lbl1" Text='<% #bind("TestName")%>' runat="server"></asp:Label>
                    </ItemTemplate>


                </asp:TemplateField>
                <%-- End Subject--%>

                <%--Instructor--%>

                <asp:TemplateField>
                    <HeaderTemplate>Fees</HeaderTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtEditFees" CssClass="TextBox form-Control" Text='<% #bind("Charges")%>' runat="server"></asp:TextBox>

                    </EditItemTemplate>

                    <ItemTemplate>
                        <asp:Label ID="lbl" Text='<% #bind("Charges")%>' runat="server"></asp:Label>


                    </ItemTemplate>


                </asp:TemplateField>

                <asp:TemplateField>

                    <HeaderTemplate>Edit-Fees</HeaderTemplate>
                    <ItemTemplate>
                        <center>
                        <asp:ImageButton ID="btnEdit" AlternateText="Edit" CommandName="Edit" ImageUrl="~/images/editImage.png" style="width:28px; height:28px" runat="server" />
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



                </asp:TemplateField>





            </Columns>

              <PagerStyle HorizontalAlign="Center"></PagerStyle>
        </asp:GridView>

        <br />
         <br />
                        <br />
                        
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="dgv" EventName="RowCommand" />
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


    <div class=" col-xs-6 col-xs-offset-4 col-sm-3 col-sm-offset-5   col-md-3 col-md-offset-4  col-lg-4 col-lg-offset-5  ">
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
    <br />
</asp:Content>
