<%@ Page Title="阿爾發-優惠券" Language="vb" AutoEventWireup="false" MasterPageFile="~/MainBack.Master" CodeBehind="Coupon.aspx.vb" Inherits="Financial_Robots.Coupon" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainStyle" runat="server">
    <style>
		.slick-vertical .slick-slide {
			width: 100% !important;
		}
	</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <section class="pt-4 pt-xl-0 pb-3" id="coupon">
                <div class="d-none">
                    <asp:TextBox ID="NumTBX" runat="server" MaxLength="17"></asp:TextBox>
                    <asp:Button ID="ExchBTN" runat="server" Text="兌換" />
                    <asp:Label ID="CPDataLB" runat="server">[]</asp:Label>
    
                    <asp:TextBox ID="IDTBX1" runat="server" MaxLength="3"></asp:TextBox>
                    <asp:TextBox ID="IDTBX2" runat="server" MaxLength="7"></asp:TextBox>
                    <asp:DropDownList ID="PIDDDL" runat="server">
                        <asp:ListItem Value="P2020052900006">穩定累積財富</asp:ListItem>
                        <asp:ListItem Value="P2020061600047">退休金準備</asp:ListItem>
                    </asp:DropDownList>
    
                    <asp:Label ID="CkLB" runat="server"></asp:Label>
                    <asp:Button ID="CkBTN" runat="server" Text="檢查" />
                    <asp:Button ID="UseBTN" runat="server" Text="使用" />
                </div>
                <div class="container-fluid">
                    <div class="row row-30">
                      <div class="col-12">
                        <div class="panel admin-panel">
                          <div class="panel-header">
                            <div class="panel-title">
                              <a class="text-dark mdi mdi-24px mdi-tag-outline"></a>
                              專屬優惠
                            </div>
                          </div>
                          <div class="panel-body">
                              <div class="col-md-5 col-xl-4">
                                <div class="panel-title mb-3">
                                    請輸入優惠碼折扣
                                </div>
                                <div class="input-group mb-3">
                                    <input type="text" class="form-control" placeholder="輸入優惠代碼" aria-label="Recipient's username" aria-describedby="button-addon2">
                                    <div class="input-group-append">
                                      <button class="btn btn-outline-primary py-1 px-4" type="button">兌換</button>
                                    </div>
                                </div>
                              </div>
                          </div>
                        </div>
                        <!-- 第一次輸入優惠碼後才出現 -->
                        <div class="panel admin-panel">
                          <div class="panel-header pb-0 bg-light">
                              <!-- <a class="text-dark mdi mdi-24px mdi-tag-outline"></a>
                              可用優惠 -->
                                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                                  <a class="nav-item nav-link active px-4" id="nav-home-tab" data-toggle="tab" href="#nav-home" role="tab" aria-controls="nav-home" aria-selected="true">可使用</a>
                                  <a class="nav-item nav-link px-4" id="nav-profile-tab" data-toggle="tab" href="#nav-profile" role="tab" aria-controls="nav-profile" aria-selected="false">已使用</a>
                                  <a class="nav-item nav-link px-4" id="nav-contact-tab" data-toggle="tab" href="#nav-contact" role="tab" aria-controls="nav-contact" aria-selected="false">過   期</a>
                                </div>
                          </div>
                          <div class="panel-body tab-content coupon-scroll" id="nav-tabContent">
                              <!-- 可使用 -->
                              <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
                                <div class="d-flex flex-wrap row mx-3">
                                  <coupon-use></coupon-use>
                                </div>
                              </div>
                              <!-- 已使用 -->
                              <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
                                <div class="d-flex flex-wrap row mx-3">
                                  <coupon-use>
                                    <template v-slot:tag>
                                      <div class="coupon-tag">
                                        已使用
                                      </div>
                                    </template>
                                    <!-- 移除按鈕 -->
                                    <template v-slot:nouse>
                                      <div>
                                      </div>
                                    </template>
                                  </coupon-use>
                                </div>
                              </div>
                              <!-- 已過期 -->
                              <div class="tab-pane fade" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab">
                                <div class="d-flex flex-wrap row mx-3">
                                  <coupon-use>
                                    <template v-slot:tag>
                                      <div class="coupon-tag">
                                        已過期
                                      </div>
                                    </template>
                                    <template v-slot:nouse>
                                      <div>
                                      </div>
                                    </template>
                                  </coupon-use>
                                </div>
                              </div>
                          </div>
                        </div>
            
                        <div class="panel admin-panel">
                          <div class="panel-header">
                            <div class="panel-title">
                              <a class="text-dark mdi mdi-24px mdi-tag-outline"></a>
                              優惠券使用辦法
                            </div>
                          </div>
                          <div class="panel-body">
                            <div class="panel-title mb-2 col-12">
                              <div class="d-flex flex-wrap  mb-3">
                                <h3 class="text-primary mb-1">1.一個月使用一張：</h3>
                                <span class="">
                                  一個月只能使用一張優惠券
                                </span>
                              </div>
                              <div class="d-flex flex-wrap">
                                <h3 class="text-primary mb-1">2.擇優計算：</h3>
                                <span class="">
                                  當優惠期間重疊時，系統將擇優計算優惠
                                </span>
                              </div>
                              <p class="mt-0 mb-3 text-muted">
                                <span class="text-muted">● </span>
                                例如 : 7/1 使用 「3 個月 9 折」 優惠券，8/1 又使用 「3 個月免費」 優惠券，其中 9、10 月優惠期間重疊，將使用 「3 個月免費」 優惠券
                              </p>
                              <div class="d-flex flex-wrap">
                                <h3 class="text-primary mb-1">3.下個月生效：</h3>
                                <span class="">
                                  優惠券使用後的 ”下一個月” 開始生效 
                                </span>
                              </div>
                              <p class="mt-0 mb-3 text-muted">
                                <span class="text-muted">● </span>
                                例如 : 8/11 使用 「1 個月免費」 優惠券，優惠於 9 月開始生效，故 10 月將免收取 9 月顧問管理費
                              </p>
                            </div>
                          </div>
                        </div>  
                      </div>
                      </div>
                  </div>
            </section>

            
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="ExchBTN" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainJS" runat="server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/d3/5.7.0/d3.min.js"></script>
	<script src="components/base/script.js?202006010"></script>
	<script src="https://cdn.jsdelivr.net/npm/vue@2.6.10/dist/vue.js"></script>
    <script src="js/header.js?202006010"></script>
    <script type="text/x-template" id="couponUse">
        <!-- 一張優惠券 -->
        <div class="col-md-6 col-lg-4 p-2 text-left border-0">
          <!-- <div class="card coupon-bg-b p-4 text-left border border-primary"></div> -->
          <div class="coupon p-4 coupon-bg-b position-relative">
            <h3 class="text-primary mb-3">折抵一個月</h3>
            <slot name="tag">
            </slot>
            <img class="coupon-using-stamp" src="images/coupon-using.svg" alt="">
            <ul>
              <li>優惠碼：45KWL-1W875-HY142</li>
              <li>優惠活動：你下單我買單</li>
              <li>優惠內容：折抵顧問管理費</li>
              <li>優惠時間：一個月</li>
            </ul>
            <div class="d-flex justify-content-between align-items-center mt-3 flex-wrap">
              <div class="mr-3 coupon-date">
                <p>有效期限至 : 2021 年 6 月 15 日</p>
                <span class="text-muted hint">請於有效期限內兌換完畢</span>
              </div>
              <!-- <div class="mr-3">
                <b>優惠期間</b>
                <span class="text-muted hint">
                  2020/9/1 <a class="text-dark mdi mdi-triangle coupon-period-icon"></a>2020/9/30
                </span>
              </div> -->
              <slot name="nouse">
                <div class="px-0">
                  <button class="btn btn-primary py-1 px-4"  data-toggle="modal" data-target="#couponModal">使用</button>
                  <button class="btn btn-outline-primary py-1 bg-white px-4 d-none"  data-toggle="modal" data-target="#couponModal" disabled>使用中</button>
                </div>
                <div class="modal fade px-0" id="couponModal" tabindex="-1" role="dialog">
                  <div class="modal-dialog" role="document">
                    <div class="modal-content">
                      <div class="modal-header bg-primary">
                        <h4 class="modal-title flex-grow-1  text-center text-light">使用確認</h4>
                      </div>
                      <div class="modal-body text-center">
                        提醒您一個月只能使用一張優惠券，您確定要使用此優惠嗎?
                      </div>
                      <div class="modal-footer border-top-0 justify-content-center">
                        <button type="button" class="btn btn-outline-primary px-4">確定</button>
                        <button type="button" class="btn btn-secondary px-4" data-dismiss="modal">取消</button>
                      </div>
                    </div>
                  </div>
                </div>
              </slot>
            </div>
          </div>
        </div>
    </script>
    <script src="js/coupon.js"></script>
</asp:Content>
