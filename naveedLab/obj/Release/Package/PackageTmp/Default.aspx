<%@ Page Title="Home" Language="C#" MasterPageFile="~/naveedLab.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="naveedLab.Default" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headerData" runat="server">


    <script type="text/javascript">

        function TotalEmployess(textVal) {


            $('#TotalEmployess').text("");
            $('#TotalEmployess').append('<h4><p class=" text-right " style="color:#ffffff;font-size:x-large;">' + textVal + '</p></h4>');

        }

        function TotalPatients(textVal) {


            $('#TotalPatients').text("");
            $('#TotalPatients').append('<h4><p class=" text-right " style="color:#ffffff;font-size:x-large;">' + textVal + '</p></h4>');

        }

        function TotalDoctors(textVal) {


            $('#TotalDoctors').text("");
            $('#TotalDoctors').append('<h4><p class=" text-right " style="color:#ffffff;font-size:x-large;">' + textVal + '</p></h4>');

        }

        function TotalDaySale(textVal) {


            $('#DaySale').text("");
            $('#DaySale').append('<h4><p class=" text-right " style="color:#ffffff;font-size:x-large;">' + textVal + '</p></h4>');

        }
    </script>



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyData" runat="server">

    <!-- Page Heading -->
    <div class="row">
        <div class="col-lg-12">
            <br />
            <br />
            <h1 class="page-header">Welcome <small>DHQ Teaching Hospital !</small>
            </h1>
        </div>
    </div>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-3 col-md-3">
            <div class="panel panel-primary">
                <div class="panel-heading" style="height: 130px;">
                    <div class="row">
                        <div class="col-xs-3">
                            <span class="glyphicon glyphicon-user" style="font-size: 50px;" aria-hidden="true"></span>
                        </div>
                        <div class="col-xs-9 text-right">
                            <div class="huge" style="font-size: 15px!important" id="TotalEmployess">
                                <%-- Code from behind page --%>
                            </div>
                            <div style="font-size: 15px">Total Employees</div>
                        </div>
                    </div>
                </div>
                <a href="">
                    <div class="panel-footer">
                        <span class="pull-left"></span>
                        <span class="pull-right"></span>
                        <div class="clearfix"></div>
                    </div>
                </a>
            </div>
        </div>
        <div class="col-lg-3 col-md-3">
            <div class="panel panel-green">
                <div class="panel-heading" style="height: 130px;">
                    <div class="row">
                        <div class="col-xs-3">
                            <span class="glyphicon glyphicon-th-list" style="font-size: 50px;" aria-hidden="true"></span>
                        </div>
                        <div class="col-xs-9 text-right">
                            <div class="huge" style="font-size:15px!important" id="TotalPatients">

                                <%-- Code from behind page --%>
                            </div>
                            <div style="font-size: 15px!important">Total Patients</div>
                        </div>
                    </div>
                </div>
                <a href="">
                    <div class="panel-footer">
                        <span class="pull-left"></span>
                        <span class="pull-right"></span>
                        <div class="clearfix"></div>
                    </div>
                </a>
            </div>
        </div>
        <div class="col-lg-3 col-md-3">
            <div class="panel panel-yellow">
                <div class="panel-heading" style="height: 130px;">
                    <div class="row">
                        <div class="col-xs-3">
                            <span class="glyphicon glyphicon-user" style="font-size: 50px;" aria-hidden="true"></span>
                        </div>
                        <div class="col-xs-9 text-right">
                            <div class="huge" style="font-size: 15px!important" id="TotalDoctors">
                                <%-- Code from behind page --%>
                            </div>
                            <div style="font-size: 15px!important">Total Doctors</div>
                        </div>
                    </div>
                </div>
                <a href="">
                    <div class="panel-footer">
                        <span class="pull-left"></span>
                        <span class="pull-right"></span>
                        <div class="clearfix"></div>
                    </div>
                </a>
            </div>
        </div>
        <div class="col-lg-3 col-md-3">
            <div class="panel panel-red">
                <div class="panel-heading" style="height: 130px;">
                    <div class="row">
                        <div class="col-xs-3">
                            <span class="glyphicon glyphicon-euro" style="font-size: 50px;" aria-hidden="true"></span>
                        </div>
                        <div class="col-xs-9 text-right">
                            <div class="huge" style="font-size: 15px!important" id="DaySale">

                                <%-- Code from behind page --%>
                            </div>
                            <div style="font-size: 15px!important">Today’s Sale</div>
                        </div>
                    </div>
                </div>
                <a href="">
                    <div class="panel-footer">
                        <span class="pull-left"></span>
                        <span class="pull-right"></span>
                        <div class="clearfix"></div>
                    </div>
                </a>
            </div>
        </div>

        <br />
        <br />

        <div style="margin:0 auto; text-align:center; margin-top:15% !important;">
            <img src="LogoImages/Punjab-government1.jpg" alt="DHQ Hospital" />
        </div>
    </div>
    <br />
    <br />
    <br />
    <div class="clearfix col-sm-10 col-sm-offset-1" style="border-bottom: 1.5px double #ccc; margin-bottom: 30px;">
        <p class="pull-right" style="font-size: 16px; color: #666; font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif">&copy;<%: DateTime.Now.Year%>-All Rights Reserved at <b>Zamp Technologies</b></p>
    </div>
    <br />
    <br />

</asp:Content>
