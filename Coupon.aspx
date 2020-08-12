<%@ Page Title="阿爾發-優惠券" Language="vb" AutoEventWireup="false" MasterPageFile="~/MainBack.Master" CodeBehind="Coupon.aspx.vb" Inherits="Financial_Robots.Coupon" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainStyle" runat="server">
    <style>
		.slick-vertical .slick-slide {
			width: 100% !important;
    }
    select{
      padding:5px 10px;
      border-radius: 30px;
    }
    option:hover {
        box-shadow: 0 0 10px 100px #1882A8 inset;
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
                    <!-- 客戶持有優惠券 -->
                    <asp:Label ID="CPDataLB" runat="server"></asp:Label>
                    <!-- 客戶下單計畫陣列 -->
                    <asp:Label ID="PDataLB" runat="server"></asp:Label>
                    <!-- 資料陣列[0]存取處 -->
                    <asp:TextBox ID="IDTBX1" runat="server" MaxLength="3"></asp:TextBox>
                    <!-- 資料陣列[1]存取處 -->
                    <asp:TextBox ID="IDTBX2" runat="server" MaxLength="7"></asp:TextBox>
                    <!-- 計畫編號存取處 -->
                    <asp:TextBox ID="PIDTBX" runat="server" MaxLength="14"></asp:TextBox>
                    <asp:DropDownList ID="PIDDDL" runat="server" class="btn btn-light dropdown-toggle px-5 mt-4">
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
                                    請輸入優惠碼兌換優惠券
                                </div>
                                <div class="input-group mb-3">
                                    <input type="text" class="form-control" 
                                      @keyup="promoCodeText" v-model="promoCode"
                                    placeholder="輸入優惠代碼" aria-label="Recipient's username" aria-describedby="button-addon2">
                                    <div class="input-group-append">
                                      <button class="btn btn-outline-primary py-1 px-4" type="button" 
                                        @click="exChange">兌換
                                      </button>
                                    </div>
                                </div>
                              </div>
                          </div>
                        </div>

                        <div class="panel admin-panel" v-if="carryCouponList.length !=0">
                          <div class="panel-header pb-0 bg-light">
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
                                  <!-- 未使用 -->
                                  <coupon-use 
                                    v-for="(item, index) in couponNotUse" 
                                    :key="item[2]" 
                                    :coupon-data="item"
                                    :is-repeat="isRepeat"
                                    :target-coupon-data="targetCouponData">
                                  </coupon-use>
                                  <!-- 使用中 -->
                                  <coupon-use 
                                    v-for="(item, index) in couponUsing" 
                                    :key="item[2]" 
                                    :coupon-data="item"
                                    :is-repeat="isRepeat"
                                    :target-coupon-data="targetCouponData">
                                  <!-- <template v-slot:nouse>
                                      <div class="px-0">
                                          <button type="button" class="btn btn-outline-primary py-1 px-4 using-btn" v-if="item[13] == 1"
                                          disabled>
                                              使用中
                                          </button>
                                        </div>
                                  </template> -->
                                </coupon-use>
                                </div>
                              </div>
                              <!-- 已使用 -->
                              <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
                                <div class="d-flex flex-wrap row mx-3">
                                  <coupon-use
                                  v-for="(item, index) in couponUsed" 
                                  :key="item[2]" 
                                    :coupon-data="item"
                                    :is-repeat="isRepeat"
                                    :target-coupon-data="targetCouponData">
                                    <template v-slot:tag>
                                      <div class="coupon-tag">
                                        已使用
                                      </div>
                                    </template>
                                    <!-- 移除按鈕 -->
                                  </coupon-use>
                                </div>
                              </div>
                              <!-- 已過期 -->
                              <div class="tab-pane fade" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab">
                                <div class="d-flex flex-wrap row mx-3">
                                  <coupon-use
                                    v-for="(item, index) in couponExpired" 
                                    :key="item[2]" 
                                    :coupon-data="item"
                                    :is-repeat="isRepeat"
                                    :target-coupon-data="targetCouponData">
                                    <template v-slot:tag>
                                      <div class="coupon-tag">
                                        已過期
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
                              <div class="d-flex flex-wrap">
                                <h3 class="text-primary mb-1">4.有效期限內使用完畢：</h3>
                                <span class="">
                                  請務必留意其優惠券之有效期限，並於期限內使用完畢，以確保您的使用權益
                                </span>
                              </div>
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
            <asp:PostBackTrigger ControlID="CkBTN" />
            <asp:PostBackTrigger ControlID="UseBTN" />
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
        <div class="col-md-6 col-lg-4 p-2 text-left border-0" v-if="couponData">
          <!-- <div class="card coupon-bg-b p-4 text-left border border-primary"></div> -->
          <div class="coupon p-4 position-relative" :class="background">
            <h3 class="mb-3" :class="titleColor">{{ couponData[3] }}</h3>
            <slot name="tag">
            </slot>
            <img v-if="couponData[13] == 1" class="coupon-using-stamp" src="images/coupon-using.svg" alt="">
            <ul>
              <li>優惠碼：{{ couponData[2] }}</li>
              <!-- <li>優惠活動：{{ couponData[3] }}</li> -->
              <!-- <li>內容：{{ couponData[4] }}</li> -->
              <li>
                <div class="d-flex flex-wrap">
                  內容：<div v-html="couponData[4]"></div>
                </div>
                
              </li>
              <li>類別：{{ couponCategory }}</li>
              <!-- <li>優惠時間：{{ couponData[7] }} 個月</li> -->
            </ul>
            <div class="mt-3 d-flex justify-content-between flex-wrap"
              v-if="couponData">
              <!-- 優惠券狀態 - 未使用/已過期 -->
              <div class="mr-3 coupon-date" 
                v-if="couponData[13] == 0 || couponData[13] == 3">
                <p>有效期限至 : {{ couponData[6] }}</p>
                <span class="text-muted hint">請於有效期限內使用
                  完畢</span>
              </div>
              <!-- 優惠券狀態 - 使用中/單一計畫或是單一計畫首次 才顯示綁定計畫 -->
              <div class="mr-3 coupon-period" 
                v-if="couponData[13] != 3 && couponData[5] == 'Plan' || couponData[5] == 'FPlan'">
                <b v-if="couponData[13] != 0">優惠計畫</b>
                <span class="text-primary">
                    {{ couponData[12] }} {{ couponData[11] }}
                </span>
              </div>
              <!-- 優惠券狀態 - 使用中/已使用 -->
              <div class="mr-3 coupon-period" 
                v-if="couponData[13] == 1 || couponData[13] == 2">
                <b>優惠期間</b>
                <span class="text-primary">
                    {{ couponData[9] }}<a class="text-dark mdi mdi-triangle coupon-period-icon"></a> {{ couponData[10] }}
                </span>
              </div>
              
              <div class="px-0">
                  <!-- Button trigger modal -->
                  <button type="button" class="btn btn-primary py-1 px-4" 
                    v-if="couponData[13] == 0" @click="checkCoupon">
                    使用
                  </button>
                  <slot name="nouse">
                  </slot>
                  
                  <button type="button" class="btn btn-primary py-1 px-4 d-none" data-toggle="modal" data-target="#exchangeModal" id="couponModalBtn">
                  </button>

                  <div class="modal fade" id="exchangeModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                      <div class="modal-dialog">
                        <div class="modal-content">
                          <div class="modal-header" :class="modalColor">
                            <h5 class="modal-title flex-grow-1  text-center text-light" id="exampleModalLabel">確定使用?</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                              <span aria-hidden="true">&times;</span>
                            </button>
                          </div>
                          <div class="modal-body text-center">
                            <div v-if="!isRepeat" v-html="norepeatText">
                            </div>
                            <div v-if="isRepeat" v-html="repeatText">
                            </div>
                          </div>
                          <div class="m-auto text-center" 
                            v-if="targetCouponData && couponData[13] != 3">
                            <select class="decorated" name="" id="" 
                              v-model="selectPlan" 
                              v-if="targetCouponData[5] == 'Plan' || targetCouponData[5] == 'FPlan'">
                              <option class="bg-light" value="">請選擇計畫</option>
                              <option 
                                class="bg-light"
                                v-for="(item, index) in orderedPlans" 
                                :value="item[0]">
                                {{ item[1] }} {{ item[0] }}
                              </option>
                            </select>
                            <div class="text-secondary text-center">
                              {{ selectPlanAlert }}
                            </div>
                          </div>
                          <span class="text-center text-muted pt-3">
                            ( 點選確定即視為同意優惠券使用辦法 )
                          </span>
                          <div class="modal-body d-flex justify-content-center">
                            <button type="button" class="btn py-1 px-4 mx-2" :class="sureBtnColor" @click="useCoupon">確定</button>
                            <button type="button" class="btn py-1 px-4 mx-2" :class="cancelBtnColor" data-dismiss="modal">取消</button>
                          </div>
                        </div>
                      </div>
                  </div>
              </div>
                  
            
            </div>
          </div>
        </div>
    </script>
    <script src="js/coupon.js?2020081210"></script>
</asp:Content>
