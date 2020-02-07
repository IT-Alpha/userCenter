<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MainStatic.Master" CodeBehind="MemberAccount.aspx.vb" Inherits="Financial_Robots.MemberAccount" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainStyle" runat="server">
  <link href="css/sb-admin_v1.min.css" rel="stylesheet">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
  <asp:ScriptManager ID="ScriptManager1" runat="server">
  </asp:ScriptManager>
  <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
      <div id="wrapper">
        <div id="content-wrapper" class="d-flex flex-column">
          <div id="content">
            <div class="container-fluid">
              <!-- Page Heading -->
              <div class="row">
                <div class="col-12">
                  <div class="alert alert-info text-center mb-0">
                    <span>距離上次登入</span>
                    <asp:Label ID="TimeLB1" class="h3" runat="server"></asp:Label>天
                    <asp:Label ID="TimeLB2" class="h3" runat="server"></asp:Label>時
                    <asp:Label ID="TimeLB3" class="h3" runat="server"></asp:Label>分
                    <asp:Label ID="TimeLB4" class="h3" runat="server"></asp:Label>秒
                  </div>
                </div>
              </div>
              <div class="card bg-transparent shadow mb-5">
                <div class="card-header">
                  <h6 class="m-0 font-weight-bold text-primary">基本資料</h6>
                </div>
                <div class="card-body">
                  <div class="row">
                    <div class="col-xl-4 col-md-6 mb-4">
                      <div class="card">
                        <div class="card-body">
                          <div class="mb-1">
                            <small>E-mail</small>
                          </div>
                          <a class="h6 mb-0 font-weight-bold text-gray-800">
                            <asp:Label ID="ActLB" runat="server"></asp:Label>
                          </a>
                        </div>
                      </div>
                    </div>
                    <div class="col-xl-4 col-md-6 mb-4">
                      <div class="card">
                        <div class="card-body">
                          <div class="mb-1">
                            <small>密碼</small>
                            <small class="float-right">
                              <a class="text-primary" data-toggle="collapse" href=".password-collapse" role="button">
                                編輯
                                <i class="fas fa-edit"></i>
                              </a>
                            </small>
                          </div>
                          <div class="collapse password-collapse">
                            <div class="my-3">
                              <asp:TextBox ID="PwdTBX" runat="server" MaxLength="20" class="input w-100 pl-3"
                                TextMode="Password" placeholder="請輸入舊密碼" />
                            </div>
                            <div class="mb-3">
                              <asp:TextBox ID="NewPwdTBX1" runat="server" MaxLength="20" class="input w-100 pl-3"
                                TextMode="Password" placeholder="請輸入新密碼" />
                            </div>
                            <div class="mb-3">
                              <asp:TextBox ID="NewPwdTBX2" runat="server" MaxLength="20" class="input w-100 pl-3"
                                TextMode="Password" placeholder="請再次輸入新密碼" />
                            </div>
                            <div class="text-center">
                              <button class="btn btn-primary mr-3 cancel">取消</button>
                              <asp:Button ID="PwdBTN" runat="server" class="btn btn-primary" Text="確定" />
                            </div>
                          </div>
                          <a class="h6 mb-0 font-weight-bold text-gray-800">＊＊＊＊＊＊</a>
                        </div>
                      </div>
                    </div>
                    <div class="col-xl-4 col-md-6 mb-4">
                      <div class="card">
                        <div class="card-body">
                          <div class="mb-1">
                            <small>姓名</small>
                            <small class="float-right">
                              <a class="text-primary" data-toggle="collapse" href=".name-collapse" role="button">
                                編輯
                                <i class="fas fa-edit"></i>
                              </a>
                            </small>
                          </div>
                          <div class="collapse name-collapse">
                            <div class="my-3">
                              <asp:TextBox ID="NameTBX" runat="server" MaxLength="20" class="input w-100 pl-3"
                                placeholder="請輸入您的姓名" />
                            </div>
                            <div class="text-center">
                              <button class="btn btn-primary mr-3 cancel">取消</button>
                              <asp:Button ID="NameBTN" runat="server" class="btn btn-primary" Text="確定" />
                            </div>
                          </div>
                          <a class="h6 mb-0 font-weight-bold text-gray-800">
                            <asp:Label ID="NameLB" runat="server"></asp:Label>
                          </a>
                        </div>
                      </div>
                    </div>
                    <div class="col-xl-4 col-md-6 mb-4">
                      <div class="card">
                        <div class="card-body">
                          <div class="mb-1">
                            <small>生日</small>
                            <small class="float-right">
                              <a class="text-primary" data-toggle="collapse" href=".birthday-collapse" role="button">
                                編輯
                                <i class="fas fa-edit"></i>
                              </a>
                            </small>
                          </div>
                          <div class="collapse birthday-collapse">
                            <div class="my-3 new_birthday">
                              <p>
                                <asp:DropDownList ID="YearDDL" runat="server" AutoPostBack="True"
                                  Font-Names="DFLiHeiLight,Medium" Font-Size="16pt" Width="100px" Height="40">
                                </asp:DropDownList>
                                年<asp:DropDownList ID="MonthDDL" runat="server" AutoPostBack="True"
                                  Font-Names="DFLiHeiLight,Medium" Font-Size="16pt" Width="100px" Height="40">
                                  <asp:ListItem Value="0">請選擇</asp:ListItem>
                                  <asp:ListItem>01</asp:ListItem>
                                  <asp:ListItem>02</asp:ListItem>
                                  <asp:ListItem>03</asp:ListItem>
                                  <asp:ListItem>04</asp:ListItem>
                                  <asp:ListItem>05</asp:ListItem>
                                  <asp:ListItem>06</asp:ListItem>
                                  <asp:ListItem>07</asp:ListItem>
                                  <asp:ListItem>08</asp:ListItem>
                                  <asp:ListItem>09</asp:ListItem>
                                  <asp:ListItem>10</asp:ListItem>
                                  <asp:ListItem>11</asp:ListItem>
                                  <asp:ListItem>12</asp:ListItem>
                                </asp:DropDownList>
                                月<asp:DropDownList ID="DayDDL" runat="server" Font-Names="DFLiHeiLight,Medium"
                                  Font-Size="16pt" Width="100px" Height="40">
                                  <asp:ListItem Value="0">請選擇</asp:ListItem>
                                </asp:DropDownList>日
                              </p>
                            </div>
                            <div class="text-center">
                              <button class="btn btn-primary mr-3 cancel">取消</button>
                              <asp:Button ID="BirthdayBTN" runat="server" class="btn btn-primary" Text="確定" />
                            </div>
                          </div>
                          <a class="h6 mb-0 font-weight-bold text-gray-800">
                            <asp:Label ID="BirthdayLB" runat="server"></asp:Label>
                          </a>
                        </div>
                      </div>
                    </div>
                    <div class="col-xl-4 col-md-6 mb-4">
                      <div class="card">
                        <div class="card-body">
                          <div class="mb-1">
                            <small>性別</small>
                            <small class="float-right">
                              <a class="text-primary" data-toggle="collapse" href=".gender-collapse" role="button">
                                編輯
                                <i class="fas fa-edit"></i>
                              </a>
                            </small>
                          </div>
                          <div class="collapse gender-collapse">
                            <div class="my-3">
                              <asp:RadioButton ID="GenderRBTN1" runat="server" GroupName="gender" Text="男" />
                              <asp:RadioButton ID="GenderRBTN2" runat="server" GroupName="gender" Text="女" />
                            </div>
                            <div class="text-center">
                              <button class="btn btn-primary mr-3 cancel">取消</button>
                              <asp:Button ID="GenderBTN" runat="server" class="btn btn-primary" Text="確定" />
                            </div>
                          </div>
                          <a class="h6 mb-0 font-weight-bold text-gray-800">
                            <asp:Label ID="GenderLB" runat="server"></asp:Label>
                          </a>
                        </div>
                      </div>
                    </div>
                    <div class="col-xl-4 col-md-6 mb-4">
                      <div class="card">
                        <div class="card-body">
                          <div class="mb-1">
                            <small>註冊日期</small>
                          </div>
                          <a class="h6 mb-0 font-weight-bold text-gray-800">
                            <asp:Label ID="RegDayLB" runat="server"></asp:Label>
                          </a>
                        </div>
                      </div>
                    </div>
                    <div class="col-xl-4 col-md-6 mb-4">
                      <div class="card">
                        <div class="card-body">
                          <div class="mb-1">
                            <small>理財顧問</small>
                            <small class="float-right">
                              <a class="text-primary" data-toggle="collapse" href=".advisor-collapse" role="button">
                                編輯
                                <i class="fas fa-edit"></i>
                              </a>
                            </small>
                          </div>
                          <div class="collapse advisor-collapse">
                            <div class="my-3">
                              <asp:TextBox ID="AIDTBX" runat="server" MaxLength="7" class="input w-100 pl-3"
                                placeholder="請輸入顧問編號" />
                            </div>
                            <div class="text-center">
                              <button class="btn btn-primary mr-3 cancel">取消</button>
                              <asp:Button ID="AdvisorBTN" runat="server" class="btn btn-primary" Text="確定" />
                            </div>
                          </div>
                          <a class="h6 mb-0 font-weight-bold text-gray-800">
                            <asp:Label ID="AdvisorLB" runat="server"></asp:Label>
                          </a>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="card bg-transparent shadow">
                <div class="card-header">
                  <h6 class="m-0 font-weight-bold text-primary">帳戶資料</h6>
                </div>
                <div class="card-body">
                  <div class="p-4 text-center">
                    <a class="h3">尚未開放</a>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <script src="https://cdn.jsdelivr.net/npm/vue@2.6.10/dist/vue.js"></script>
      <script src="https://unpkg.com/element-ui/lib/index.js"></script>
      <script src="https://code.jquery.com/jquery-3.4.1.min.js"
        integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"
        type="text/javascript"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>
      <script>
        $(document).ready(function () {
          if ($('#ctl00_Main_BirthdayLB').text() !== "未填寫") {
            let parents = $('#ctl00_Main_BirthdayLB').parents('.card-body')[0];
           
            $(parents).find('small.float-right')[0].remove();
            $(parents).find('.collapse')[0].remove();
          }
          if ($('#ctl00_Main_GenderLB').text() !== "未填寫") {
            let parents = $('#ctl00_Main_GenderLB').parents('.card-body')[0];
            $(parents).find('small.float-right')[0].remove();
            $(parents).find('.collapse')[0].remove();
          }
          if ($('#ctl00_Main_AdvisorLB').text() !== "未填寫") {
            let parents = $('#ctl00_Main_AdvisorLB').parents('.card-body')[0];
            $(parents).find('small.float-right')[0].remove();
            $(parents).find('.collapse')[0].remove();
          }
          $('[data-toggle="collapse"]').click(function (e) {
            e.preventDefault();
            var target = $(this).attr('href');
            var parent = $(this).parents('.card-body')[0];
            $(parent).find('.h6').toggleClass('d-none');
            $(target).find('.input').val("");
            $(target).children('.active').removeClass('active');
            $(target).find('.bg-danger').removeClass('bg-danger');
            $(target).children('.text-light').removeClass('text-light');
          });

          $('.cancel').click(function (e) {
            e.preventDefault();
            var target = $(this).parents('.collapse').parent();
            $(target).find('[data-toggle="collapse"]').trigger('click');

          });
        });
      </script>
    </ContentTemplate>
    <Triggers>
      <asp:PostBackTrigger ControlID="PwdBTN" />
      <asp:PostBackTrigger ControlID="NameBTN" />
      <asp:PostBackTrigger ControlID="BirthdayBTN" />
    </Triggers>
  </asp:UpdatePanel>
</asp:Content>