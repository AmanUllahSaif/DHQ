<%@ Page Title="Clear Payment" Language="C#" MasterPageFile="~/naveedLab.Master" AutoEventWireup="true" CodeBehind="ClearPayment.aspx.cs" Inherits="naveedLab.ClearPayment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headerData" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyData" runat="server">
    <br />
    <h2 class="page-header col-sm-6">Make Remaining Payment<asp:Label ID="lblPayment" runat="server" Text=""></asp:Label></h2>
    <div class="clearfix">
    </div>

    <div class="col-sm-offset-1 col-sm-6">
        <div id="naveed_Danger" runat="server" class="alert alert-danger" role="alert" visible="false">
            <img height="36" src="Images/1194985624696670932tasto_10_architetto_fran_01.svg.med.png" width="36" />
            <asp:Label ID="naveedDangerText" runat="server" Text="">&nbsp;</asp:Label>
        </div>
        <asp:TextBox runat="server" CssClass="form-control col-sm-6" ID="txtPayment" Text="0"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter Amount" ForeColor="Red" Font-Size="18px" SetFocusOnError="true" Display="Dynamic" ValidationGroup="vg" ControlToValidate="txtPayment"></asp:RequiredFieldValidator>
        <div class="clearfix"></div>
        <asp:Button ID="btnSubmit" runat="server" Text="Submit" Style="margin-top: 10px" ValidationGroup="vg" CausesValidation="true" OnClick="btnSubmit_Click" CssClass="btn btn-danger col-sm-offset-1"></asp:Button>
    </div>
    <br />
    <br />
    <div class="clearfix col-sm-10 col-sm-offset-1" style="border-bottom: 1.5px double #ccc; margin-top: 25%; margin-bottom: 2px;">
        <p class="pull-right" style="font-size: 16px; color: #666; font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif">&copy;<%: DateTime.Now.Year%>-All Rights Reserved at <b>Zamp Technologies</b></p>
    </div>

</asp:Content>
