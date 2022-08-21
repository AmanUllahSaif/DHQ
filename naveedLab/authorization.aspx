<%@ Page Title="Authorized" Language="C#" MasterPageFile="~/naveedLab.Master" AutoEventWireup="true" CodeBehind="authorization.aspx.cs" Inherits="naveedLab.authorization" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headerData" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyData" runat="server">
    <div class="row">
        <div class="col-lg-12" id="topMove">
            <h2 id="h3_Status" runat="server" style="text-align: center; margin-top: 14%; margin-bottom: 5%;">You Have No Rights to Access this Content ! </h2>
            <br />
            <div class="clearfix col-sm-10 col-sm-offset-1" style="border-bottom: 1.5px double #ccc; margin-top:28.2%; margin-bottom: 30px;">
                <p class="pull-right" style="font-size: 16px; color: #666; font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif">&copy;<%: DateTime.Now.Year%>-All Rights Reserved at <b>Zamp Technologies</b></p>
            </div>
        </div>
    </div>
</asp:Content>
