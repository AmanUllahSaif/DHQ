<%@ Page Title="Reference Value Updation" Language="C#" MasterPageFile="~/naveedLab.Master" AutoEventWireup="true" CodeBehind="ReferenceValueUpdation.aspx.cs" Inherits="naveedLab.ReferenceValueUpdation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headerData" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyData" runat="server">
    <div style="height: 640px !important">
        <div class="row">
            <div class="col-lg-12">
                <br />
                <h1 class="page-header">Reference Value
                </h1>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <asp:UpdateProgress ID="UpdateProgress3" runat="server" AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="10">
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
                            <asp:Label runat="server" AssociatedControlID="ddlChapter" CssClass="col-md-2 control-label">Branch</asp:Label>
                            <div class="col-md-10">
                                <asp:DropDownList ID="ddlChapter" AutoPostBack="true" AppendDataBoundItems="true" OnSelectedIndexChanged="ddlChapter_SelectedIndexChanged" runat="server" CssClass="form-control" Width="32%">
                                    <asp:ListItem Value="-Select-">- Select Chapter -</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <br />
                        <br />
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="ddlAgeFactor" CssClass="col-md-2 control-label">Age Factor</asp:Label>
                            <div class="col-md-10">
                                <asp:DropDownList ID="ddlAgeFactor" Enabled="false" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="ddlAgeFactor_SelectedIndexChanged" runat="server" CssClass="form-control" Width="32%">
                                    <asp:ListItem Value="-Select-">- Select Age -</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <br />
                        <br />
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="ddlTest" CssClass="col-md-2 control-label">Tests</asp:Label>
                            <div class="col-md-10">
                                <asp:DropDownList ID="ddlTest" runat="server" Enabled="false" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="ddlTest_SelectedIndexChanged" CssClass="form-control" Width="32%">
                                    <asp:ListItem Value="-Select-">- Select Test -</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <br />
                        <br />
                        <br />
                        <div class="clearfix"></div>
                        <div class="row" id="gridTerms" runat="server" visible="false">
                            <div class="col-lg-12">
                                <div class="col-sm-8 col-sm-offset-2">
                                    <div class="table table-responsive">
                                        <asp:GridView ID="dgvReferenceValue" runat="server" ShowHeader="true" CssClass="table-bordered table-striped" OnRowCommand="dgvReferenceValue_RowCommand" AutoGenerateColumns="false" Width="650px">
                                            <HeaderStyle ForeColor="Black" Font-Size="Small" BackColor="#428BCA" />
                                            <RowStyle Font-Size="small" />
                                            <Columns>
                                                <asp:TemplateField ItemStyle-Width="40%">
                                                    <HeaderTemplate>&nbsp;Term&nbsp;</HeaderTemplate>
                                                    <EditItemTemplate></EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:HiddenField runat="server" ID="hlblID" Value='<%#Eval("Id") %>'></asp:HiddenField>
                                                        <asp:Label ID="lblTerm" runat="server" Text='<%#Eval("Name") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <FooterTemplate></FooterTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField ItemStyle-Width="30%">
                                                    <HeaderTemplate>&nbsp;Value&nbsp;</HeaderTemplate>
                                                    <EditItemTemplate></EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtValue" CssClass="form-control" runat="server" Text='<%#Eval("StandardValue") %>'></asp:TextBox>
                                                    </ItemTemplate>
                                                    <FooterTemplate></FooterTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField ItemStyle-Width="30%">
                                                    <HeaderTemplate>
                                                        <center>Save</center>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <center>
                                                    <center><asp:ImageButton ID="editReferenceValue" runat="server" ImageUrl="~/Images/editImage.png" Height="30" Width="30" CommandName="Add" CommandArgument='<%# Container.DataItemIndex%>' /></center>
                                                   <%-- <asp:ImageButton ID="deleteReferenceValue" runat="server" ImageUrl="~/Images/deleteImage.png" Height="30" Width="30" CommandName="Del" CommandArgument='<%# Container.DataItemIndex %>'/>--%>
                                                        </center>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                        <br />
                                        <br />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix col-sm-10 col-sm-offset-1" style="border-bottom: 1.5px double #ccc;">
                            <p class="pull-right" style="font-size: 16px; color: #666; font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif">&copy;<%: DateTime.Now.Year%>-All Rights Reserved at <b>Zamp Technologies</b></p>
                        </div>
                        <br />
                        <br />
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="dgvReferenceValue" EventName="RowCommand" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
        </div>
</asp:Content>
