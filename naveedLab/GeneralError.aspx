<%@ Page Title="" Language="C#" MasterPageFile="~/naveedLab.Master" AutoEventWireup="true" CodeBehind="GeneralError.aspx.cs" Inherits="naveedLab.GeneralError" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headerData" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyData" runat="server">
    <div class="row">
        <div class="col-lg-12" id="topMove">
            <br />
            <br />
            <h2 style="margin-top:20% !important;" class="page-header text-danger">Ooops :( Something Went Wrong ! Please Contact Site Admin </h2>
        </div>
        <br />
        <div class="clearfix col-sm-10 col-sm-offset-1" style="border-bottom: 1.5px double #ccc; margin-top: 25%; margin-bottom: 2px;">
            <p class="pull-right" style="font-size: 16px; color: #666; font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif">&copy;<%: DateTime.Now.Year%>-All Rights Reserved at <b>Zamp Technologies</b></p>
        </div>
    </div>
</asp:Content>
