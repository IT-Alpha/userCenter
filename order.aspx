<%@ Page Title="" Language="vb" AutoEventWireup="false"  MasterPageFile="~/MainBack.Master" CodeBehind="order".aspx.vb" Inherits="Financial_Robots.order" %>

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
      <section id="order" class="pb-3">
        <div class="d-none">
          <asp:Label ID="ResultLB" runat="server"></asp:Label>
          <asp:Label ID="TotalRateLB" runat="server"></asp:Label>
          <asp:Label ID="PreLB" runat="server"></asp:Label>
          <asp:Label ID="RealLB" runat="server"></asp:Label>
          <asp:Label ID="PoDataLB" runat="server"></asp:Label>
        </div>
        <div class="container-fluid">
          <div class="row row-30">
            <div class="col-12 text-right pt-4 pt-xl-0">
              <button type="button" class="btn btn-outline-secondary">新增計畫</button>
              <button type="button" class="btn btn-secondary ml-3" v-if="status == 'un-order'">下單此計畫</button>
              <button type="button" class="btn btn-secondary ml-3" v-if="status == 'order'">調整計畫</button>
              <template v-if="status == 'un-success'">
                <button type="button" class="btn btn-secondary ml-3" data-toggle="modal" data-target="#unSuccessModal">
                  下單中
                  <span class="mdi mdi-bell-outline"></span>
                </button>
                <div class="modal fade" id="unSuccessModal" tabindex="-1" role="dialog">
                  <div class="modal-dialog" role="document">
                    <div class="modal-content">
                      <div class="modal-header bg-primary">
                        <h2 class="modal-title flex-grow-1  text-center text-light">通知</h2>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                          <span aria-hidden="true">&times;</span>
                        </button>
                      </div>
                      <div class="modal-body">
                        <div class="mx-auto" style="max-width:180px">
                          阿爾發證券投顧採集單限價下單，交易完成後將透過簡訊及電子郵件方式即時通知!
                        </div>
                      </div>
                      <div class="modal-footer border-top-0 justify-content-center">
                        <button type="button" class="btn btn-outline-primary">瞭解更多集單限價</button>
                      </div>
                    </div>
                  </div>
                </div>
              </template>
            </div>
            <template v-if="status !== 'noData'">
              <div class="col-md-12">
                <div class="panel admin-panel">
                  <div class="panel-header">
                    <div class="d-flex align-items-center">
                      <ul class="nav nav-pills scroller scroller-horizontal flex-grow-1" role="tablist">
                        <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#dashboardGraph1"
                            data-href="#dashboardGraph4" role="tab" aria-controls="dashboardGraph1"
                            aria-selected="true">財務規劃</a></li>
                        <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#dashboardGraph2"
                            data-href="#dashboardGraph5" role="tab" aria-controls="dashboardGraph2"
                            aria-selected="false">資產成長狀況</a></li>
                        <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#dashboardGraph3"
                            data-href="#dashboardGraph6" role="tab" aria-controls="dashboardGraph3"
                            aria-selected="false">持有資產</a></li>
                      </ul>
                    </div>
                  </div>
                  <div class="panel-body">
                    <div class="tab-content">
                      <div class="tab-pane fade show active" id="dashboardGraph1" role="tabpanel">
                        <div class="container-fluid">
                          <div class="row">
                            <div class="col-lg-7 col-xl-8">
                              <div class="highcharts-container highcharts-container-2" data-highcharts-type="line">
                              </div>
                            </div>
                            <div class="col-lg-5 col-xl-4 border-lg-left">
                              <div class="slick-slider"
                                data-slick-md='{"slidesToShow":1,"slidesToScroll":1,"vertical":false,"verticalSwiping":false}'
                                :data-slick="slideData">
                                <div class="list-block-container list-block-lg" v-for="(item) in tab1">
                                  <h5 class="list-block-title d-flex justify-content-between align-items-baseline">
                                    <span class="font-weight-bold">{{item[0] | goalText}}</span>
                                    <small
                                      class="text-secondary font-weight-bold text-capitalize">達成率:{{item[1] | decimalFormat}}%</small>
                                  </h5>
                                  <div class="list-block">
                                    <div class="list-block-item d-flex justify-content-between"
                                      v-for="(element,index) in item" v-if="index !==0 && index !== 1">
                                      <div :style="{'visibility': element.text ? '' : 'hidden'}">
                                        <small class="align-middle pr-3 text-shadow-500 fa-circle"></small>
                                        <span>{{element.title}}</span>
                                      </div><strong class="text-dark">{{element.text}}</strong>
                                    </div>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                      <div class="tab-pane fade" id="dashboardGraph2" role="tabpanel">
                        <div class="container-fluid">
                          <div class="row">
                            <div class="col-lg-7 col-xl-8 mb-3 mb-lg-0">
                              <div class="highcharts-container highcharts-container-2" data-highcharts-type="column">
                              </div>
                            </div>
                            <div class="col-lg-5 col-xl-4 border-lg-left">
                              <div class="list-block-container list-block-lg">
                                <h5 class="list-block-title align-items-baseline">
                                  <span class="font-weight-bold">總資產狀況</span>
                                </h5>
                                <div class="list-block">
                                  <div class="list-block-item d-flex justify-content-between">
                                    <div>
                                      <small class="align-middle pr-3 text-shadow-500 fa-circle"></small>
                                      <a>總投入金額</a>
                                    </div><strong :class="tab2[0][0] == 0 ? 'text-secondary' : 'text-dark'">USD $
                                      {{tab2[0][0] | decimalFormat | commaFormat}}</strong>
                                  </div>
                                  <div class="list-block-item d-flex justify-content-between">
                                    <div>
                                      <small class="align-middle pr-3 text-shadow-500 fa-circle"></small>
                                      <a>資產淨值</a>
                                    </div>
                                    <strong :class="tab2[0][1] == 0 ? 'text-secondary' : 'text-dark'">USD $
                                      {{tab2[0][1] | decimalFormat | commaFormat}}</strong>
                                  </div>
                                </div>
                              </div>
                              <div class="list-block-container list-block-lg">
                                <h5 class="list-block-title">
                                  <span class="font-weight-bold pointer-event"
                                    @click="tab22 = true">累積(Cumulative)</span>
                                  <span class="font-weight-bold">|</span>
                                  <span class="font-weight-bold pointer-event"
                                    @click="tab22 = false">年度(Annualized)</span>
                                </h5>
                                <div class="list-block">
                                  <div class="list-block-item d-flex justify-content-between">
                                    <div>
                                      <small class="align-middle pr-3 text-shadow-500 fa-circle"></small>
                                      <a>投資報酬率</a>
                                    </div><strong
                                      :class="tab2[1][0] == 0 ? 'text-secondary' : 'text-dark'">{{tab2[1][0] | decimalFormat}}%</strong>
                                  </div>
                                  <div class="list-block-item d-flex justify-content-between">
                                    <div>
                                      <small class="align-middle pr-3 text-shadow-500 fa-circle"></small>
                                      <a>含息報酬率</a>
                                    </div><strong
                                      :class="tab2[1][1] == 0 ? 'text-secondary' : 'text-dark'">{{tab2[1][1] | decimalFormat}}%</strong>
                                  </div>
                                  <div class="list-block-item d-flex justify-content-between">
                                    <div>
                                      <small class="align-middle pr-3 text-shadow-500 fa-circle"></small>
                                      <a>配息金額</a>
                                    </div><strong :class="tab2[1][2] == 0 ? 'text-secondary' : 'text-dark'">USD $
                                      {{tab2[1][2] | decimalFormat  | commaFormat}}</strong>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                      <div class="tab-pane fade" id="dashboardGraph3" role="tabpanel">
                        <div class="container-fluid">
                          <div class="row">
                            <div class="col-12">
                              <table class="table table-responsive-sm">
                                <thead>
                                  <tr>
                                    <th scope="col" width="5px" class="p-0"></th>
                                    <th scope="col">代碼</th>
                                    <th scope="col" class="d-none d-xl-table-cell">資產名稱</th>
                                    <th scope="col" colspan="2">比例</th>
                                    <th scope="col" class="d-none d-sm-table-cell">持有股數</th>
                                    <th scope="col" class="d-none d-sm-table-cell">持有價值</th>
                                    <th scope="col" class="px-0"></th>
                                  </tr>
                                </thead>
                                <tfoot class="bg-200">
                                  <tr>
                                    <th scope="row" colspan="2"></th>
                                    <td class="d-none d-xl-table-cell"></td>
                                    <td colspan="2">總計</td>
                                    <td class="d-none d-sm-table-cell">{{tableTotal[1] | commaFormat}}</td>
                                    <td class="d-none d-sm-table-cell"
                                      :class="tableTotal[2] == 0 ? 'text-secondary' : null">
                                      USD $ {{tableTotal[2] | commaFormat}}</td>
                                    <td class="px-0 text-right">
                                      <a class="mdi-18px mdi mdi-chevron-down d-sm-none" data-toggle="collapse"
                                        href="tr.total" role="button">
                                      </a>
                                    </td>
                                  </tr class="bg-200">
                                  <tr class="collapse total">
                                    <td colspan="2">
                                      <small>持有股數</small><br>
                                      {{tableTotal[1] | commaFormat}}
                                    </td>
                                    <td colspan="3" :class="tableTotal[2] == 0 ? 'text-secondary' : null">
                                      <small>持有價值</small><br>
                                      USD $ {{tableTotal[2] | commaFormat}}</td>
                                  </tr>
                                </tfoot class="bg-200">
                                <tbody>
                                  <template v-for="(item) in tableData">
                                    <tr>
                                      <th scope="row" width="5px" class="p-0" :style="{'background-color' : item[0]}">
                                      </th>
                                      <td>{{item[1]}}</td>
                                      <td class="d-none d-xl-table-cell">{{item[2] | ETFtype}}－{{item[4]}}</td>
                                      <td style="width:1%;">{{item[6]}}%</td>
                                      <td class="pl-0">
                                        <div class="d-inline-block" style="min-width:90px">
                                          <div class="progress progress-sm justify-content-end"
                                            style="border-radius: 0;"
                                            :style="{'background': 'repeating-linear-gradient(to right,' + item[0] + ',' + item[0] + ' 8%, white 8%, white 10%)'}">
                                            <div class="progress-bar" style="background-color:white"
                                              :style="{'width': 100 - item[6] * 2 + '%'}">
                                            </div>
                                          </div>
                                        </div>
                                      </td>
                                      <td class="d-none d-sm-table-cell">{{item[7] | commaFormat}}</td>
                                      <td class="d-none d-sm-table-cell"
                                        :class="tableTotal[2] == 0 ? 'text-secondary' : null">
                                        USD $ {{ item[8] | commaFormat}}</td>
                                      <td class="px-0 text-right">
                                        <a class="mdi-18px mdi mdi-chevron-down" data-toggle="collapse"
                                          :href="'tr.' + item[1]" role="button">
                                        </a>
                                      </td>
                                    </tr>
                                    <tr class="collapse" :class="item[1]">
                                      <td colspan="8">
                                        <div class="row">
                                          <div class="col-12 d-xl-none">{{item[2] | ETFtype}}－{{item[4]}}</div>
                                          <div class="col-12 col-xl-12 mb-3">{{item[5]}}<small
                                              class="ml-3">{{item[3]}}</small></div>
                                          <div class="col-6 mb-3 d-sm-none">
                                            <div class="">持有股數<br>{{item[7] | commaFormat}}</div>
                                          </div>
                                          <div class="col-6 mb-3 d-sm-none">
                                            <div class="">持有價值<br>USD $ {{ item[8] | commaFormat}}</div>
                                          </div>
                                          <div class="col-6 col-sm-4 col-xl mb-3 mb-sm-0">
                                            <div class="">ETF價格<br>USD $ {{ item[9] | commaFormat}}</div>
                                          </div>
                                          <div class="col-6 col-sm-4 col-xl">
                                            <div class="">已實現報酬率<br>{{item[10]}}%</div>
                                          </div>
                                          <div class="col-6 col-sm-4 col-xl">
                                            <div class="">內含管理費/年<br>{{item[11]}}%</div>
                                          </div>
                                        </div>
                                      </td>
                                    </tr>

                                  </template>
                                </tbody>
                              </table>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-lg-4" v-if="status !== 'overView'" v-for="(item,index) in progressData">
                <div class="panel admin-panel">
                  <div class="panel-body">
                    <div class="mb-4">
                      {{progressTextArray[0][index]}}
                    </div>
                    <template v-for="(element,i) in item">
                      <div>{{element}} <span></span></div>
                      <div>{{progressTextArray[index + 1][i]}}</div>
                      <div class="progress progress-sm mt-2 mb-3" :class="index | progressClass">
                        <div class="progress-bar" role="progressbar" :style="{'width':element + '%'}"></div>
                      </div>
                    </template>
                  </div>
                </div>
              </div>
              <div class="col-lg-6">
                <div class="panel admin-panel">
                  <div class="panel-header">
                    <div class="d-flex align-items-center">
                      <div class="h3 font-weight-bold panel-title flex-grow-1">投資組合</div>
                    </div>
                  </div>
                  <div class="panel-body pb-5 text-center">
                    <div class="highcharts-container highcharts-container-2" data-highcharts-type="pie">
                    </div>
                    <div class="row row-15 justify-content-center">
                      <div class="col-4 col-sm-3 col-xxl-2">
                        <div class="progress-circle-wrap">
                          <div class="progress-circle-inner">
                            <div class="progress-counter-wrap">
                              <div class="progress-counter-value"><span
                                  class="progress-counter">{{ETFtypeTotal[0]}}</span></div>
                            </div>
                            <svg class="progress-circle" x="0" y="0" width="80" height="80" viewbox="0 0 80 80">
                              <circle class="bg" cx="40" cy="40" r="32" style="stroke:#F97C6B;opacity:0.3;"></circle>
                              <circle class="fg clipped" cx="40" cy="40" r="32" style="stroke:#F97C6B;"></circle>
                            </svg>
                          </div>
                          <div class="progress-title">股票型ETF</div>
                        </div>
                      </div>
                      <div class="col-4 col-sm-3 col-xxl-2">
                        <div class="progress-circle-wrap">
                          <div class="progress-circle-inner">
                            <div class="progress-counter-wrap">
                              <div class="progress-counter-value"><span
                                  class="progress-counter">{{ETFtypeTotal[1]}}</span></div>
                            </div>
                            <svg class="progress-circle" x="0" y="0" width="80" height="80" viewbox="0 0 80 80">
                              <circle class="bg" cx="40" cy="40" r="32" style="stroke:#FFBC49;opacity:0.3;"></circle>
                              <circle class="fg clipped" cx="40" cy="40" r="32" style="stroke:#FFBC49;"></circle>
                            </svg>
                          </div>
                          <div class="progress-title">不動產ETF</div>
                        </div>
                      </div>
                      <div class="col-4 col-sm-3 col-xxl-2">
                        <div class="progress-circle-wrap">
                          <div class="progress-circle-inner">
                            <div class="progress-counter-wrap">
                              <div class="progress-counter-value"><span
                                  class="progress-counter">{{ETFtypeTotal[2]}}</span></div>
                            </div>
                            <svg class="progress-circle" x="0" y="0" width="80" height="80" viewbox="0 0 80 80">

                              <circle class="bg" cx="40" cy="40" r="32" style="stroke:#88EE74;opacity:0.3;"></circle>
                              <circle class="fg clipped" cx="40" cy="40" r="32" style="stroke:#88EE74;"></circle>
                            </svg>
                          </div>
                          <div class="progress-title">債券型ETF</div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </template>
            <template v-if="status == 'noData'">
              <div class="col-lg-6">
                <div class="panel admin-panel h-100" style="min-height:250px">
                  <div
                    style="position: absolute;top: 0;right: 0;bottom:0;left: 0;background-color:rgba(22,52,79,0.8);display:flex;justify-content:center;align-items:center">
                    <span style="font-size: 2rem;color:#fff;text-align: center;">請新增計畫<br>來查看詳細資料</span>
                  </div>
                </div>
              </div>
              <div class="col-lg-6">
                <div class="panel admin-panel">
                  <div class="panel-header">
                    <div class="h3 font-weight-bold panel-title flex-grow-1">我們將會幫您做什麼？</div>
                  </div>
                  <div class="panel-body">
                    <div class="container-fluid">
                      <div class="row">
                        <div class="col-12 px-0 d-flex justify-content-between">
                          <div>
                            <small class="align-middle pr-3 text-shadow-500 fa-circle"></small><a class="link-black"
                              href="#">資產全球多元化配置</a>
                          </div>
                          <div class="text-right pr-0">增加 1.4% 利潤</div>
                        </div>
                        <div class="col-12 col-md-7 px-0">
                          <div class="pl-4 text-gray-600">
                            我們將您的資產進行全球多元化配置，由上述所列出包含股票型、不動產型
                            及債券型等三種不同資產類別之ETF指數型基金，所共同組成您的投資組合。
                          </div>
                        </div>
                      </div>
                      <div class="row">
                        <div class="col-12 px-0 d-flex justify-content-between">
                          <div>
                            <small class="align-middle pr-3 text-shadow-500 fa-circle"></small><a class="link-black"
                              href="#">節省投資費用</a>
                          </div>
                          <div class="text-right pr-0">節省 1.25% 費用</div>
                        </div>
                        <div class="col-12 col-md-7 px-0">
                          <div class="pl-4 text-gray-600">
                            阿爾發協助投資人將投資費用大幅降低，平均 0.7 %的 ETF 管理費用可避免投資人
                            被收取過高的投資費用，影響長期投資獲利。
                          </div>
                        </div>
                      </div>
                      <div class="row">
                        <div class="col-12 px-0 d-flex justify-content-between">
                          <div>
                            <small class="align-middle pr-3 text-shadow-500 fa-circle"></small><a class="link-black"
                              href="#">投資組合再平衡</a>
                          </div>
                          <div class="text-right pr-0">增加 0.4% 利潤</div>
                        </div>
                        <div class="col-12 col-md-7 px-0">
                          <div class="pl-4 text-gray-600">
                            根據阿爾發的投資研究顯示為投資人每年進行一次的投資組合再平衡，其對於
                            投資人的投資組合績效表現優於每半年、每季甚至每月都進行再平衡。
                          </div>
                        </div>
                      </div>
                      <div class="row">
                        <div class="col-12 px-0 d-flex justify-content-between">
                          <div>
                            <small class="align-middle pr-3 text-shadow-500 fa-circle"></small><a class="link-black"
                              href="#">降低進場時機錯誤的可能</a>
                          </div>
                          <div class="text-right pr-0">增加 1.25% 利潤</div>
                        </div>
                        <div class="col-12 col-md-7 px-0">
                          <div class="pl-4 text-gray-600">
                            投資人進行長期投資時，應專注保持在市場當中避免擇時錯誤( Market Mistiming )
                            降低可能犯的投資錯誤而損失市場獲利時機。
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </template>
            <div class="col-lg-6" v-if="status == 'overView'">
              <div class="panel admin-panel">
                <div class="panel-header">
                  <div class="h3 font-weight-bold panel-title flex-grow-1">我們幫您做了什麼？</div>
                </div>
                <div class="panel-body">
                  <div class="container-fluid">
                    <div class="row">
                      <div class="col-12 col-md-7 px-0">
                        <div>
                          <small class="align-middle pr-3 text-shadow-500 fa-circle"></small><a class="link-black"
                            href="#">資產全球多元化配置</a>
                        </div>
                      </div>
                      <div class="col-12 col-md-5 px-0">
                        <div class="lead text-right pr-0">
                          <span>增加 1.25% 利潤/年</span>
                        </div>
                      </div>
                      <div class="col-12 col-md-7 px-0 mt-2">
                        <div class="pl-4 text-gray-600">
                          我們將您的資產進行全球多元化配置，由上述所列出包含股票型、不動產型
                          及債券型等三種不同資產類別之ETF指數型基金，所共同組成您的投資組合。
                        </div>
                      </div>
                      <!-- <div class="col-12 col-md-5 px-0 mt-md-2 d-flex justify-content-end align-items-end">
                        <small><a href="#">了解更多</a></small>
                      </div> -->
                    </div>
                    <div class="row">
                      <div class="col-12 col-md-7 px-0">
                        <div>
                          <small class="align-middle pr-3 text-shadow-500 fa-circle"></small><a class="link-black"
                            href="#">節省投資費用</a>
                        </div>
                      </div>
                      <div class="col-12 col-md-5 px-0">
                        <div class="lead text-right pr-0 mt-2">節省 1.25% 費用/年</div>
                      </div>
                      <div class="col-12 col-md-7 px-0 mt-2">
                        <div class="pl-4 text-gray-600">
                          阿爾發協助投資人將投資費用大幅降低，平均 0.7 %的 ETF 管理費用可避免投資人
                          被收取過高的投資費用，影響長期投資獲利。
                        </div>
                      </div>
                    </div>
                    <div class="row">
                      <div class="col-12 col-md-7 px-0">
                        <div>
                          <small class="align-middle pr-3 text-shadow-500 fa-circle"></small><a class="link-black"
                            href="#">投資組合再平衡</a>
                        </div>
                      </div>
                      <div class="col-12 col-md-5 px-0">
                        <div class="lead text-right pr-0">增加 0.4% 利潤/年</div>
                      </div>
                      <div class="col-12 col-md-7 px-0 mt-2">
                        <div class="pl-4 text-gray-600">
                          根據阿爾發的投資研究顯示為投資人每年進行一次的投資組合再平衡，其對於
                          投資人的投資組合績效表現優於每半年、每季甚至每月都進行再平衡。
                        </div>
                      </div>
                    </div>
                    <div class="row">
                      <div class="col-12 col-md-7 px-0">
                        <div>
                          <small class="align-middle pr-3 text-shadow-500 fa-circle"></small><a class="link-black"
                            href="#">降低進場時機錯誤的可能</a>
                        </div>
                      </div>
                      <div class="col-12 col-md-5 px-0">
                        <div class="lead text-right pr-0">增加 1.25% 利潤/年</div>
                      </div>
                      <div class="col-12 col-md-7 px-0 mt-2">
                        <div class="pl-4 text-gray-600">
                          投資人進行長期投資時，應專注保持在市場當中避免擇時錯誤( Market Mistiming )
                          降低可能犯的投資錯誤而損失市場獲利時機。
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

    </ContentTemplate>
    <Triggers>
    </Triggers>
  </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainJS" runat="server">
  <script src="js/components/base/script.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/vue@2.6.10/dist/vue.js"></script>
  <script src="js/header.js"></script>
  <script src="js/order.js"></script>
</asp:Content>