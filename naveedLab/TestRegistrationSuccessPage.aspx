﻿<%@ Page Title="Success" Language="C#" MasterPageFile="~/naveedLab.Master" AutoEventWireup="true" CodeBehind="TestRegistrationSuccessPage.aspx.cs" Inherits="naveedLab.TestRegistrationSuccessPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headerData" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyData" runat="server">
    <style type="text/css">
        .outDate {
            margin:263px 0px 50px 600px;
            width:20%;
        }
        .outDateLabel {
            margin:263px 0px 50px 600px !important;
            width:20%;
        }
        .lblOutDate {
            text-align:center;
        }
    </style>
    <br />
    <br />
    <asp:HiddenField ID="hdfID" Value="" runat="server" />
    <div class="clearfix"></div>
    <table class="col-sm-offset-4" style="margin-top:263px">
        <tr>
            <td>
                <asp:Label ID="lblId" runat="server"><b > Report Return Date </b> </asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtReturnDate" runat="server" CssClass="form-control" Width="200px"></asp:TextBox>
            </td>
        </tr>
    </table>
    <h2 style="text-align: center; margin-bottom:380px;">Test has been Registered Successfully...<asp:Button ID="btnPrint" runat="server" Text="Print" OnClick="btnPrint_Click" CssClass="btn btn-danger col-sm-offset-1"></asp:Button>
    </h2>
    <br />
    <br />
    <div class="clearfix col-sm-10 col-sm-offset-1" style="border-bottom: 1.5px double #ccc; margin-bottom: 30px;">
        <p class="pull-right" style="font-size: 16px; color: #666; font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif">&copy;<%: DateTime.Now.Year%>-All Rights Reserved at <b>Zamp Technologies</b></p>
    </div>
</asp:Content>
