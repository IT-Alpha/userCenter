<%@ Page Title="" Language="vb" AutoEventWireup="false"
  MasterPageFile="~/MainBack.Master" CodeBehind="MemberAccount.aspx.vb"
  Inherits="Financial_Robots.MemberAccount" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainStyle" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
  <asp:ScriptManager ID="ScriptManager1" runat="server"> </asp:ScriptManager>
  <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
    <section class="pt-4 pt-xl-0 pb-3">
        <div class="d-none">
        </div>
        <div class="container-fluid">
          <div class="row row-30">
            <div class="col-12">
              <div class="panel admin-panel">
                <div class="panel-header">
                  <div class="panel-title">
                    <a class="text-dark mdi mdi-24px mdi-account-outline" href="#"></a>
                    個人資料
                  </div>
                </div>
                <div class="panel-body">
                  <div class="container-fluid">
                    <div class="row">
                      <div class="col-12 col-md-6 px-0">
                        <div class="d-flex flex-column flex-sm-row border-bottom">
                          <div class="py-2 py-sm-3 text-center bg-200" style="min-width: 8rem;">註冊日期</div>
                          <div class="py-3 pl-sm-4 text-center text-sm-left">
                            <asp:Label ID="RegDayLB" runat="server"></asp:Label>
                          </div>
                        </div>
                      </div>
                      <div class="col-12 col-md-6 px-0">
                        <div class="d-flex flex-column flex-sm-row align-items-sm-center border-bottom"> 
                          <div class="py-2 py-sm-3 text-center bg-200" style="min-width: 8rem;">姓名</div>
                          <div class="py-3 pl-sm-4 text-center text-sm-left flex-grow-1">
                            <asp:Label ID="NameLB" runat="server"></asp:Label>
                          </div>
                          <div class="text-center mb-3 mb-sm-0">
                            <button type="button"  class="btn btn-outline-primary py-1" data-toggle="modal"
                              data-target="#nameModal">修改</button>
                            <div class="modal fade px-0" id="nameModal" tabindex="-1" role="dialog">
                              <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                  <div class="modal-header bg-primary">
                                    <h4 class="modal-title flex-grow-1
                                        text-center text-light">修改姓名</h4>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                      <span aria-hidden="true">&times;</span>
                                    </button>
                                  </div>
                                  <div class="modal-body">
                                    <div class="mx-auto" style="max-width:180px">
                                      <asp:TextBox ID="NameTBX" runat="server" MaxLength="20"
                                        class="form-control p-3 mb-2" placeholder="請輸入您的姓名" />
                                    </div>
                                  </div>
                                  <div class="modal-footer border-top-0
                                        justify-content-center">
                                    <asp:Button ID="NameBTN" runat="server" class="btn btn-primary" Text="確定" />
                                    <button type="button" class="btn
                                            btn-outline-primary" data-dismiss="modal">取消</button>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                      <div class="col-12 col-md-6 px-0">
                        <div class="d-flex flex-column flex-sm-row
                                border-bottom">
                          <div class="py-2 py-sm-3 text-center bg-200" style="min-width: 8rem;">帳號</div>
                          <div class="py-3 pl-sm-4 text-center text-sm-left">
                            <asp:Label ID="ActLB" runat="server"></asp:Label>
                          </div>
                        </div>
                      </div>
                      <div class="col-12 col-md-6 px-0">
                        <div class="d-flex flex-column flex-sm-row
                                align-items-sm-center border-bottom">
                          <div class="py-2 py-sm-3 text-center bg-200" style="min-width: 8rem;">密碼</div>
                          <div class="py-3 pl-sm-4 text-center text-sm-left flex-grow-1">******</div>
                          <div class="text-center mb-3 mb-sm-0">
                            <button type="button"  class="btn btn-outline-primary py-1" data-toggle="modal"
                              data-target="#passwordModal">修改</button>
                            <div class="modal fade px-0" id="passwordModal" tabindex="-1" role="dialog">
                              <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                  <div class="modal-header bg-primary">
                                    <h4 class="modal-title flex-grow-1
                                            text-center text-light">修改密碼</h4>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                      <span aria-hidden="true">&times;</span>
                                    </button>
                                  </div>
                                  <div class="modal-body">
                                    <div class="mx-auto" style="max-width:180px">
                                      <asp:TextBox ID="PwdTBX" runat="server" MaxLength="20"
                                        class="form-control p-3 mb-2" TextMode="Password" placeholder="請輸入重設密碼" />
                                      <asp:TextBox ID="NewPwdTBX1" runat="server" MaxLength="20"
                                        class="form-control p-3 mb-2" TextMode="Password" placeholder="請輸入新密碼" />
                                      <asp:TextBox ID="NewPwdTBX2" runat="server" MaxLength="20"
                                        class="form-control p-3" TextMode="Password" placeholder="請再次輸入新密碼" />
                                    </div>
                                  </div>
                                  <div class="modal-footer border-top-0 justify-content-center">
                                    <asp:Button ID="PwdBTN" runat="server" class="btn btn-primary" Text="確定" />
                                    <button type="button" class="btn
                                                    btn-outline-primary" data-dismiss="modal">取消</button>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                      <div class="col-12 col-md-6 px-0">
                        <div class="d-flex flex-column flex-sm-row border-bottom align-items-sm-center">
                          <div class="py-2 py-sm-3 text-center bg-200" style="min-width: 8rem;">出生日期</div>
                          <div class="py-3 pl-sm-4 text-center text-sm-left flex-grow-1">
                            <asp:Label ID="BirthdayLB" runat="server"></asp:Label>
                          </div>
                          <div class="text-center mb-3 mb-sm-0">
                            <button type="button"  class="btn btn-outline-primary py-1 mr-2" data-toggle="modal"
                              data-target="#birthModal">修改</button>
                            <div class="modal fade px-0" id="birthModal" tabindex="-1" role="dialog">
                              <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                  <div class="modal-header bg-primary">
                                    <h4 class="modal-title flex-grow-1
                                            text-center text-light">修改生日</h4>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                      <span aria-hidden="true">&times;</span>
                                    </button>
                                  </div>
                                  <div class="modal-body">
                                    <div class="mx-auto" style="max-width:180px">
                                       <asp:DropDownList ID="YearDDL" runat="server" AutoPostBack="True" Font-Names="DFLiHeiLight,Medium" Font-Size="16pt" Width="100px" Height="40">
                            </asp:DropDownList>年
                            <asp:DropDownList ID="MonthDDL" runat="server" AutoPostBack="True" Font-Names="DFLiHeiLight,Medium" Font-Size="16pt" Width="100px" Height="40">
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
                            </asp:DropDownList>月
                            <asp:DropDownList ID="DayDDL" runat="server" Font-Names="DFLiHeiLight,Medium" Font-Size="16pt" Width="100px" Height="40">
                              <asp:ListItem Value="0">請選擇</asp:ListItem>
                            </asp:DropDownList>日
                                    </div>
                                  </div>
                                  <div class="modal-footer border-top-0 justify-content-center">
                                                       <asp:Button ID="BirthdayBTN" runat="server" class="btn btn-outline-primary" Text="確定" />

                                    <button type="button" class="btn
                                                    btn-outline-primary" data-dismiss="modal">取消</button>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                      <%-- <div class="col-12 col-md-6 px-0">
                        <div class="d-flex flex-column flex-sm-row border-bottom align-items-sm-center">
                          <div class="py-2 py-sm-3 text-center bg-200" style="min-width: 8rem;">出生日期</div>
                          <div class="py-3 pl-sm-4 text-center text-sm-left">
                            <asp:Label ID="BirthdayLB" runat="server"></asp:Label>
                          </div>
                        </div>
                      </div> --%>
                      <div class="col-12 col-md-6 px-0">
                        <div class="d-flex flex-column flex-sm-row
                                        align-items-sm-center border-bottom">
                          <div class="py-2 py-sm-3 text-center
                                          bg-200" style="min-width: 8rem;">性別</div>
                          <div class="py-3 pl-sm-4 text-center text-sm-left flex-grow-1">
                            <asp:Label ID="GenderLB" runat="server"></asp:Label>
                          </div>
                          <div class="text-center mb-3 mb-sm-0">
                            <button type="button"  class="btn btn-outline-primary py-1" data-toggle="modal"
                              data-target="#genderModal">修改</button>
                            <div class="modal fade px-0" id="genderModal" tabindex="-1" role="dialog">
                              <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                  <div class="modal-header bg-primary">
                                    <h4 class="modal-title flex-grow-1
                                            text-center text-light">修改性別</h4>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                      <span aria-hidden="true">&times;</span>
                                    </button>
                                  </div>
                                  <div class="modal-body">
                                    <div class="mx-auto" style="max-width:180px">
                                      <div class="custom-control custom-radio custom-radio-info d-inline-block mr-3">
                                        <asp:RadioButton ID="GenderRBTN1" runat="server" GroupName="gender" />
                                        <label class="custom-control-label" for="ctl00_Main_GenderRBTN1">男性
                                        </label>
                                      </div>
                                      <div class="custom-control custom-radio custom-radio-info d-inline-block">
                                        <asp:RadioButton ID="GenderRBTN2" runat="server" GroupName="gender"  />
                                        <label class="custom-control-label" for="ctl00_Main_GenderRBTN2">女性
                                        </label>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="modal-footer border-top-0 justify-content-center">
                                    <asp:Button ID="GenderBTN" runat="server" class="btn btn-primary" Text="確定" />
                                    <button type="button" class="btn
                                                    btn-outline-primary" data-dismiss="modal">取消</button>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                      <div class="col-12 px-0">
                        <div class="d-flex flex-column flex-sm-row
                                        align-items-sm-center border-bottom">
                          <div class="py-2 py-sm-3 text-center
                                          bg-200" style="min-width: 8rem;">Email</div>
                          <div class="py-3 pl-sm-4 text-center text-sm-left">
                            <span id="email"></span>
                          </div>
                        </div>
                      </div>
                      
                      
                    </div>
                  </div>
                </div>
                <div class="panel-header">
                  <div class="panel-title">
                    <a class="text-dark mdi mdi-24px mdi-file-download" href="#"></a>
                    會員條款
                  </div>
                </div>
                <div class="panel-body">
                  <div class="container-fluid">
                    <div class="row">
                      <div class="col-12 px-0">
                        <div class="d-flex flex-column
                                        flex-sm-row">
                          
                          <div class="py-3 pl-4">
                            <div class="d-inline-block mr-sm-3
                                            mr-md-4 mr-lg-5 pb-3">
                              <a class="text-primary" href="#">個人資料保護法</a>
                              <small>ver20200114</small>
                            </div>
                            <div class="d-inline-block mr-sm-3
                                            mr-md-4 mr-lg-5 pb-3">
                              <a class="text-primary" href="#">個人資料保護法</a>
                              <small>ver20200114</small>
                            </div>
                            <div class="d-inline-block mr-sm-3
                                            mr-md-4 mr-lg-5 pb-3">
                              <a class="text-primary" href="#">個人資料保護法</a>
                              <small>ver20200114</small>
                            </div>
                            <div class="d-inline-block mr-sm-3
                                            mr-md-4 mr-lg-5 pb-3">
                              <a class="text-primary" href="#">個人資料保護法</a>
                              <small>ver20200114</small>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
      </section>
      <div class="d-none">
        <span>距離上次登入</span>
        <asp:Label ID="TimeLB1" class="h3" runat="server"></asp:Label>天
        <asp:Label ID="TimeLB2" class="h3" runat="server"></asp:Label>時
        <asp:Label ID="TimeLB3" class="h3" runat="server"></asp:Label>分
        <asp:Label ID="TimeLB4" class="h3" runat="server"></asp:Label>秒
      </div>
      <div class="d-none">
        <span>修改出生日期</span>
                            <%-- <asp:DropDownList ID="YearDDL" runat="server" AutoPostBack="True" Font-Names="DFLiHeiLight,Medium" Font-Size="16pt" Width="100px" Height="40">
                            </asp:DropDownList>年
                            <asp:DropDownList ID="MonthDDL" runat="server" AutoPostBack="True" Font-Names="DFLiHeiLight,Medium" Font-Size="16pt" Width="100px" Height="40">
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
                            </asp:DropDownList>月
                            <asp:DropDownList ID="DayDDL" runat="server" Font-Names="DFLiHeiLight,Medium" Font-Size="16pt" Width="100px" Height="40">
                              <asp:ListItem Value="0">請選擇</asp:ListItem>
                            </asp:DropDownList>日
                   <asp:Button ID="BirthdayBTN" runat="server" class="btn btn-outline-primary py-1" Text="確定" /> --%>
      </div>
      
      <div class="d-none">
        <small>理財顧問</small>
        <asp:Label ID="AdvisorLB" runat="server"></asp:Label>
        <asp:TextBox ID="AIDTBX" runat="server" MaxLength="7" class="input w-100 pl-3" placeholder="請輸入顧問編號" />
        <asp:Button ID="AdvisorBTN" runat="server" class="btn btn-primary" Text="確定" />
      </div>
    </ContentTemplate>
    <Triggers>
      <asp:PostBackTrigger ControlID="PwdBTN" />
      <asp:PostBackTrigger ControlID="NameBTN" />
      <asp:PostBackTrigger ControlID="BirthdayBTN" />
    </Triggers>
  </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainJS" runat="server">
  <script src="components/base/script.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/vue@2.6.10/dist/vue.js"></script>
  <script src="js/header.js"></script>
  <script>
    let genderBTN1 = document.querySelector('#ctl00_Main_GenderRBTN1');
    let genderBTN2 = document.querySelector('#ctl00_Main_GenderRBTN2');
    let email = document.querySelector('#ctl00_Main_ActLB');

    genderBTN1.classList.add('custom-control-input')
    genderBTN2.classList.add('custom-control-input')
    document.querySelector('#email').textContent = email.textContent;
  </script>
</asp:Content>
