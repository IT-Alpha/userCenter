<%@ Page Title="" Language="vb" AutoEventWireup="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainStyle" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
  <asp:ScriptManager ID="ScriptManager1" runat="server">
  </asp:ScriptManager>
  <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
      <section id="order">
        <div class="d-none">
          <div id="tab1Data">
            <!-- 總攬 -->
            <!-- [[1,25,16500,65,1500],[2,25,16500,20],[3,25,12000,20],[4,25,16500,65,15],[5,25,16500,65,1500],[6,25,16500,65,1500]] -->
            <!-- [退休金準備(1),達成率,投入金額,預計退休年齡,退休後月花費] -->
            <!-- [穩定累積財富跟財產保值抗通膨(2.3),達成率,投入金額,預計投資期間] -->
            <!-- [子女教育金(4),達成率,投入金額,距離大學期間,小孩目前歲數] -->
            <!-- [存錢買房(5),達成率,投入金額,距離買房時間,房屋總價值] -->
            <!-- [其他目標(6),達成率,投入金額,預計目標年限,預計目標金額] -->
            <!-- 單計畫 -->
            <!-- [距離退休時間,風險等級,計畫軌道] -->
            <!-- [風險等級,計畫軌道] -->
            <!-- [預計所需金額,風險等級,計畫軌道] -->
            <!-- [房屋總價值,風險等級,計畫軌道] -->
            <!-- [風險等級,計畫軌道] -->
            [[1,25,16500,65,1500,70,32]]
          </div>

          <div id="tab2Data">
            <!-- 第一個array為[總投入金額,資產淨值] 第二個array為累積 第三個是年度,都是[淨值報酬率,含息報酬率,配息金額] -->
            [[51650,1650],[6.5,7.3,1500],[10,11.5,3000]]
          </div>
          <div id="progressData">
            <!-- [[風險等及,整體風險等及],[成功機率,整體成功機率],[投資期間,整體投資期間]]] -->
            [[30,32],[50,50],[32,32]]
          </div>
          <div id="lineChartData">
            <!-- 第一個array為x軸(年份) 第二個array為圖表資料,該年無資料傳null -->
            [[2020, 2021, '2022', '2023', '2024', '2025', '2026', '2027', '2028', '2029', '2030', '2031', '2032',
            '2033',
            '2034', '2035', '2036', '2037', '2038', '2039', '2040',
            '2041'],[{name:'退休金準備',data:[30000,40000,55000,70000,100000,140000,185000,230000,300000,380000]},{name:
            '子女教育金',data:[20000,30000,45000,60000,120000,160000,215000,270000,350000,430000,]}]]
          </div>
          <div id="columnChartData">
            <!-- 第一個array為x軸(年份) 第二個array為圖表資料,該年無資料傳null -->
            <!-- [[2020, 2021, '2022', '2023', '2024', '2025', '2026', '2027', '2028', '2029', '2030', '2031', '2032', '2033', '2034', '2035', '2036', '2037', '2038', '2039', '2040', '2041'],[{name:'退休金準備',data:[30000,40000,55000,70000,100000,140000,185000,230000,300000,380000]},{name: '子女教育金',data:[20000,30000,45000,60000,120000,160000,215000,270000,350000,430000,]}]] -->
          </div>
          <div id="tableData">
            <!-- 色碼,代碼,中文,持有比例,基金費用,持有價值 -->
            <!-- 未下單跟未成交狀態持有價為0 -->
            [[ '#F97C6B','VEA','全球已開發國家股票型基金（不含美國）', 18.75,0.07,1500
            ],['#FFACA1','VSS','全球小型股',19,0.07,1500],['#FDD6CF','VTI','全球小型股',19,0.07,1500],['#FFBC49','VNQ','全球小型股',19,0.07,1500],['#FFD678','VNQI','全球小型股',19,0.07,1500],['#88EE74','BNDW','全球小型股',19,0.07,1500],]
          </div>
        </div>
        <div class="container-fluid">
          <div class="row row-30">
            <div class="col-12">
              <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo01">
                  <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarTogglerDemo01">

                  <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
                    <li class="nav-item active">
                      <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link" href="#">Link</a>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
                    </li>
                  </ul>

                </div>
              </nav>
            </div>
            <div class="col-12 text-right pt-4 pt-xl-0">
              <button class="btn btn-outline-secondary">新增計畫</button>
              <button class="btn btn-secondary ml-3" v-if="status == 'un-order'">下單此計畫</button>
              <button class="btn btn-secondary ml-3" v-if="status == 'order'">調整計畫</button>
              <button class="btn btn-secondary ml-3" v-if="status == 'un-success'">
                下單中
                <span class="mdi mdi-bell-outline"></span>
              </button>
            </div>
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
                              <!-- <div class="list-block-container list-block-lg">
                                <h5 class="list-block-title d-flex justify-content-between align-items-baseline">
                                  <span class="font-weight-bold">子女教育金</span>
                                  <small class="text-secondary font-weight-bold text-capitalize">達成率:25%</small>
                                </h5>
                                <div class="list-block">
                                  <div class="list-block-item d-flex justify-content-between">
                                    <div>
                                      <small class="align-middle pr-3 text-shadow-500 fa-circle"></small>
                                      <span>總投入金額</span>
                                    </div><strong class="text-dark">USD $ 16,500</strong>
                                  </div>
                                  <div class="list-block-item d-flex justify-content-between">
                                    <div>
                                      <small class="align-middle pr-3 text-shadow-500 fa-circle"></small>
                                      <span>距離大學期間</span>
                                    </div><strong class="text-dark">65歲</strong>
                                  </div>
                                  <div class="list-block-item d-flex justify-content-between">
                                    <div>
                                      <small class="align-middle pr-3 text-shadow-500 fa-circle"></small>
                                      <span>小孩目前歲數</span>
                                    </div><strong class="text-dark">8歲</strong>
                                  </div>
                                </div>
                              </div>
                              <div class="list-block-container list-block-lg">
                                <h5 class="list-block-title d-flex justify-content-between align-items-baseline">
                                  <span class="font-weight-bold">其他目標</span>
                                  <small class="text-secondary font-weight-bold text-capitalize">達成率:25%</small>
                                </h5>
                                <div class="list-block">
                                  <div class="list-block-item d-flex justify-content-between">
                                    <div>
                                      <small class="align-middle pr-3 text-shadow-500 fa-circle"></small>
                                      <span>總投入金額</span>
                                    </div><strong class="text-dark">USD $ 16,500</strong>
                                  </div>
                                  <div class="list-block-item d-flex justify-content-between">
                                    <div>
                                      <small class="align-middle pr-3 text-shadow-500 fa-circle"></small>
                                      <span>預計目標年限</span>
                                    </div><strong class="text-dark">10年</strong>
                                  </div>
                                  <div class="list-block-item d-flex justify-content-between">
                                    <div>
                                      <small class="align-middle pr-3 text-shadow-500 fa-circle"></small>
                                      <span>預計目標金額</span>
                                    </div><strong class="text-dark">NTD $ 1,000萬</strong>
                                  </div>
                                </div>
                              </div>
                              <div class="list-block-container list-block-lg">
                                <h5 class="list-block-title d-flex justify-content-between align-items-baseline">
                                  <span class="font-weight-bold">存錢買房</span>
                                  <small class="text-secondary font-weight-bold text-capitalize">達成率:25%</small>
                                </h5>
                                <div class="list-block">
                                  <div class="list-block-item d-flex justify-content-between">
                                    <div>
                                      <small class="align-middle pr-3 text-shadow-500 fa-circle"></small>
                                      <span>總投入金額</span>
                                    </div><strong class="text-dark">USD $ 16,500</strong>
                                  </div>
                                  <div class="list-block-item d-flex justify-content-between">
                                    <div>
                                      <small class="align-middle pr-3 text-shadow-500 fa-circle"></small>
                                      <span>距離買房時間</span>
                                    </div><strong class="text-dark">10年</strong>
                                  </div>
                                  <div class="list-block-item d-flex justify-content-between">
                                    <div>
                                      <small class="align-middle pr-3 text-shadow-500 fa-circle"></small>
                                      <span>房屋總價值</span>
                                    </div><strong class="text-dark">NTD $ 1,000萬</strong>
                                  </div>
                                </div>
                              </div>
                              <div class="list-block-container list-block-lg">
                                <h5 class="list-block-title d-flex justify-content-between align-items-baseline">
                                  <span class="font-weight-bold">財產保值抗通膨</span>
                                  <small class="text-secondary font-weight-bold text-capitalize">達成率:25%</small>
                                </h5>
                                <div class="list-block">
                                  <div class="list-block-item d-flex justify-content-between">
                                    <div>
                                      <small class="align-middle pr-3 text-shadow-500 fa-circle"></small>
                                      <span>總投入金額</span>
                                    </div><strong class="text-dark">USD $ 16,500</strong>
                                  </div>
                                  <div class="list-block-item d-flex justify-content-between">
                                    <div>
                                      <small class="align-middle pr-3 text-shadow-500 fa-circle"></small>
                                      <span>預計投資期間</span>
                                    </div><strong class="text-dark">20年</strong>
                                  </div>
                                </div>
                              </div>
                              <div class="list-block-container list-block-lg">
                                <h5 class="list-block-title d-flex justify-content-between align-items-baseline">
                                  <span class="font-weight-bold">穩定累積財富</span>
                                  <small class="text-secondary font-weight-bold text-capitalize">達成率:25%</small>
                                </h5>
                                <div class="list-block">
                                  <div class="list-block-item d-flex justify-content-between">
                                    <div>
                                      <small class="align-middle pr-3 text-shadow-500 fa-circle"></small>
                                      <span>總投入金額</span>
                                    </div><strong class="text-dark">USD $ 16,500</strong>
                                  </div>
                                  <div class="list-block-item d-flex justify-content-between">
                                    <div>
                                      <small class="align-middle pr-3 text-shadow-500 fa-circle"></small>
                                      <span>預計投資期間</span>
                                    </div><strong class="text-dark">20年</strong>
                                  </div>
                                </div>
                              </div> -->
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="tab-pane fade" id="dashboardGraph2" role="tabpanel">
                      <div class="container-fluid">
                        <div class="row">
                          <div class="col-lg-7 col-xl-8">
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
                                  </div><strong :class="tab2[0][1] == 0 ? 'text-secondary' : 'text-dark'">USD $
                                    {{tab2[0][1] | decimalFormat | commaFormat}}</strong>
                                </div>
                              </div>
                            </div>
                            <div class="list-block-container list-block-lg">
                              <h5 class="list-block-title">
                                <span class="font-weight-bold pointer-event" @click="tab22 = true">累積(Cumulative)</span>
                                <span class="font-weight-bold">|</span>
                                <span class="font-weight-bold pointer-event"
                                  @click="tab22 = false">年度(Annualized)</span>
                              </h5>
                              <div class="list-block">
                                <div class="list-block-item d-flex justify-content-between">
                                  <div>
                                    <small class="align-middle pr-3 text-shadow-500 fa-circle"></small>
                                    <a>淨值報酬率</a>
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
                                  <th scope="col">資產名稱</th>
                                  <th scope="col">持有比例</th>
                                  <th scope="col">基金費用/年%</th>
                                  <th scope="col">持有價值</th>
                                </tr>
                              </thead>
                              <tfoot>
                                <tr>
                                  <th scope="row" colspan="2">總計</th>
                                  <td></td>
                                  <td>{{tableTotal[0] | decimalFormat}}%</td>
                                  <td>{{tableTotal[1] | decimalFormat}}%</td>
                                  <td :class="tableTotal[2] == 0 ? 'text-secondary' : null">USD $
                                    {{tableTotal[2] | commaFormat}}</td>
                                </tr>
                              </tfoot>
                              <tbody>
                                <tr v-for="(item) in tableData">
                                  <th scope="row" width="5px" class="p-0" :style="{'background-color' : item[0]}"></th>
                                  <th scope="row">{{item[1]}}</th>
                                  <td>{{item[2]}}</td>
                                  <td>{{item[3]}}%</td>
                                  <td>{{item[4]}}%</td>
                                  <td :class="tableTotal[2] == 0 ? 'text-secondary' : null">USD $
                                    {{ item[5] | commaFormat}}</td>
                                </tr>
                                <!-- <tr>
                                    <th scope="row" class="VSS">VSS</th>
                                    <td>全球小型股</td>
                                    <td>19%</td>
                                    <td>0.07%</td>
                                    <td>USD $ 1,500</td>
                                  </tr>
                                  <tr>
                                    <th scope="row" class="VTI">VTI</th>
                                    <td>美國股票型基金</td>
                                    <td>28%</td>
                                    <td>0.04%</td>
                                    <td>USD $ 1,500</td>
                                  </tr>
                                  <tr>
                                    <th scope="row" class="VNQ">VNQ</th>
                                    <td>美國不動產基金</td>
                                    <td>13.5%</td>
                                    <td>0.05%</td>
                                    <td>USD $ 1,500</td>
                                  </tr>
                                  <tr>
                                    <th scope="row" class="VNQI">VNQI</th>
                                    <td>全球不動產基金(不含美國)</td>
                                    <td>6.5%</td>
                                    <td>0.05%</td>
                                    <td>USD $ 1,500</td>
                                  </tr>
                                  <tr>
                                    <th scope="row" class="BNDW">BNDW</th>
                                    <td>全世界債券</td>
                                    <td>10%</td>
                                    <td>0.04%</td>
                                    <td>USD $ 1,500</td>
                                  </tr> -->
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

            <div class="col-lg-4" v-if="status !== 'overView'">
              <div class="panel admin-panel">
                <div class="panel-body">
                  <div class="mb-4">
                    風險等級
                  </div>
                  <div>70</div>
                  <div>您的風險等級</div>
                  <div class="progress progress-sm progress-primary mt-2 mb-3">
                    <div class="progress-bar" role="progressbar" style="width: 70%"></div>
                  </div>
                  <div>80</div>
                  <div>此計畫平均風險等級</div>
                  <div class="progress progress-sm progress-primary mt-2">
                    <div class="progress-bar" role="progressbar" style="width: 80%"></div>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-lg-4" v-if="status !== 'overView'">
              <div class="panel admin-panel">
                <div class="panel-body">
                  <div class="mb-4">
                    成功機率
                  </div>
                  <div>70%</div>
                  <div>您的成功機率</div>
                  <div class="progress progress-sm progress-secondary mt-2 mb-3">
                    <div class="progress-bar" role="progressbar" style="width: 70%"></div>
                  </div>
                  <div>80%</div>
                  <div>此計畫平均成功機率</div>
                  <div class="progress progress-sm progress-secondary mt-2">
                    <div class="progress-bar" role="progressbar" style="width: 80%"></div>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-lg-4" v-if="status !== 'overView'">
              <div class="panel admin-panel">
                <div class="panel-body">
                  <div class="mb-4">
                    距離退休時間
                  </div>
                  <div>32年</div>
                  <div>距離你退休的時間</div>
                  <div class="progress progress-sm progress-info mt-2 mb-3">
                    <div class="progress-bar" role="progressbar" style="width: 70%"></div>
                  </div>
                  <div>27年</div>
                  <div>此計畫平均退休時間</div>
                  <div class="progress progress-sm progress-info mt-2">
                    <div class="progress-bar" role="progressbar" style="width: 80%"></div>
                  </div>
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
                  <div class="highcharts-container highcharts-container-1" data-highcharts-type="pie">
                  </div>
                  <div class="row row-15 justify-content-center">
                    <div class="col-4 col-sm-3 col-xxl-2">
                      <div class="progress-circle-wrap">
                        <div class="progress-circle-inner">
                          <div class="progress-counter-wrap">
                            <div class="progress-counter-value"><span class="progress-counter">26</span></div>
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
                            <div class="progress-counter-value"><span class="progress-counter">34</span></div>
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
                            <div class="progress-counter-value"><span class="progress-counter">40</span></div>
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
            <div class="col-lg-6" v-if="status == 'overView'">
              <div class="panel admin-panel">
                <div class="panel-header">
                  <div class="h3 font-weight-bold panel-title flex-grow-1">我們幫您做了什麼？</div>
                </div>
                <div class="panel-body">
                  <div class="container-fluid">
                    <div class="row">
                      <div class="col-12 px-0 d-flex justify-content-between">
                        <div>
                          <small class="align-middle pr-3 text-shadow-500 fa-circle"></small><a class="link-black"
                            href="#">資產全球多元化配置</a>
                        </div>
                        <div class="lead text-right pr-0">+ USD $ 1,650</div>
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
                        <div class="lead text-right pr-0">+ USD $ 650</div>
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
                        <div class="lead text-right pr-0">+ USD $ 650</div>
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
                        <div class="lead text-right pr-0">+ USD $ 650</div>
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
          </div>
        </div>
      </section>
      <script src="js/scriptBack.js"></script>
      <script src="https://cdn.jsdelivr.net/npm/vue@2.6.10/dist/vue.js"></script>
      <script src="js/header.js"></script>
      <script src="js/order.js"></script>
    </ContentTemplate>
    <Triggers>
    </Triggers>
  </asp:UpdatePanel>
</asp:Content>