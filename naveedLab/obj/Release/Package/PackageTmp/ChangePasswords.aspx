<%@ Page Title="Change Password" Language="C#" MasterPageFile="~/naveedLab.Master" AutoEventWireup="true" CodeBehind="ChangePasswords.aspx.cs" Inherits="naveedLab.ChangePasswords" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headerData" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyData" runat="server">
    <div class="row">
        <div class="col-lg-12" id="topMove">
            <br />
            <br />
            <h1 class="page-header">Change Password
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
                        <div class="col-md-offset-2 col-md-10">
                            <br />
                            <asp:Button runat="server" ID="btnAdd" OnClick="btnAdd_Click" ValidationGroup="vg" Text="Save" CssClass="btn btn-success" />
                        </div>
                    </div>
                    <div class="clearfix col-sm-10 col-sm-offset-1" style="border-bottom: 1.5px double #ccc; margin-top:25%; margin-bottom:2px;">
                        <p class="pull-right" style="font-size: 16px; color: #666; font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif">&copy;<%: DateTime.Now.Year%>-All Rights Reserved at <b>Zamp Technologies</b></p>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
