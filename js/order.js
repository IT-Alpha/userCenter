//-1無、0委託送出成功、1委託成功、2已成交、3部分成交、8委託失敗、9交易失敗；
// tab1[9]

let order = new Vue({
  el: "#order",
  data: {
    tab1Data: document.querySelector("#order #ctl00_Main_ResultLB").textContent
      ? eval(
          document
            .querySelector("#order #ctl00_Main_ResultLB")
            .textContent.replace(/\n/g, "")
        )
      : null,
    tab2Data: document.querySelector("#ctl00_Main_TotalRateLB").textContent
      ? eval(
          document
            .querySelector("#ctl00_Main_TotalRateLB")
            .textContent.replace(/\n/g, "")
        )
      : [
          [0, 0],
          [0, 0, 0],
          [0, 0, 0],
        ],
    tableData: eval(
      document
        .querySelector("#ctl00_Main_PoDataLB")
        .textContent.replace(/\n/g, "")
    ),
    tab22: true,
    overView: !Boolean(location.search),
    money: null,
    cfpNumber: null,
  },
  computed: {
    tab1: function () {
      //財務規劃顯示的資料
      let vm = this;
      let newTabData = [];
      let tab1Array = [];
      if (this.overView) {
        tab1Array = this.tab1Data.filter(function (e) {
          return e[9] == 2;
        });
      } else {
        tab1Array = this.tab1Data;
      }
      tab1Array.forEach(function (item, index) {
        //解bug
        let fuckingBug = header.sidebar.find(function (e) {
          return e[2] == item[7];
        });
        let plan = {
          title: vm.$options.filters.goalText(item[0]),
          // progress: item[1],
          progress: fuckingBug[1],
          element: [
            {
              title: vm.tab2Data[0][0] > 0 ? "投入金額": "預計投入金額",  // 已投入金額 切換顯示字
              text:
                "USD $ " +
                vm.$options.filters.commaFormat(
                  vm.$options.filters.decimalFormat(item[2])
                ),
            },
          ],
        };

        // switch (element[0]) {
        //   case 1:
        //     element[3] = { title: '預計退休年齡', text: element[3] + '歲' }
        //     element[4] = { title: '退休後月花費', text: 'USD $ ' + vm.$options.filters.commaFormat(element[4]) + ' / 月' }
        //     element[5] = { title: '距離退休時間', text: element[5] + '年' }
        //     element[6] = { title: '風險等級', text: element[6] }
        //     element[7] = { title: '預期軌道', text: element[7] }
        //     break;
        //   case 2:
        //   case 3:
        //     element[3] = { title: '預計投資期間', text: element[3] + '年' }
        //     element[4] = { title: '風險等級', text: element[4] }
        //     element[5] = { title: '預期軌道', text: element[5] }
        //     break;
        //   case 4:
        //     element[3] = { title: '距離大學期間', text: element[3] + '年' }
        //     element[4] = { title: '小孩目前歲數', text: element[4] + '歲' }
        //     element[5] = { title: '預計所需金額', text: 'USD $ ' + vm.$options.filters.commaFormat(element[5]) }
        //     element[6] = { title: '風險等級', text: element[6] }
        //     element[7] = { title: '預期軌道', text: element[7] }
        //     break;
        //   case 5:
        //     element[3] = { title: '距離買房時間', text: element[3] + '年' }
        //     element[4] = { title: '目標達成金額', text: 'USD $ ' + vm.$options.filters.commaFormat(element[4]) }
        //     element[5] = { title: '房屋總價值', text: 'USD $ ' + vm.$options.filters.commaFormat(element[5]) }
        //     element[6] = { title: '風險等級', text: element[6] }
        //     element[7] = { title: '預期軌道', text: element[7] }
        //     break;
        //   case 6:
        //     element[3] = { title: '預計目標年限', text: element[3] + '年' }
        //     element[4] = { title: '預計目標金額', text: 'USD $ ' + vm.$options.filters.commaFormat(element[4]) }
        //     element[5] = { title: '風險等級', text: element[5] }
        //     element[6] = { title: '預期軌道', text: element[6] }
        //     break;
        //   default:
        //     return;
        switch (item[0]) {
          case "Retirement":
            //沒距離退休時間
            plan.element.push({
              title: "預計退休年齡",
              text: item[4] + "歲",
            });
            plan.element.push({
              title: "退休後月花費",
              text:
                "USD $ " +
                vm.$options.filters.commaFormat(
                  vm.$options.filters.decimalFormat(item[6])
                ) +
                " / 月",
            });
            if (!vm.overView) {
              plan.element.push({
                title: "風險等級",
                text: item[10],
              });
              if (vm.tab1Data[0][9] == 2) {
                plan.element.push({
                  title: "預期軌道",
                  text: vm.tab1Data[0][12] > 50 ? "Ontrack" : "Offtrack",
                });
              } else {
                plan.element.push({
                  title: "預期軌道",
                  text: "N/A",
                });
              }
            }
            break;
          case "Long":
          case "Preservation":
            //沒預期軌道
            plan.element.push({
              title: "預計投資期間",
              text: item[4] + "年",
            });
            plan.element.push({
              title: "預計投資期間",
              text: "",
            });
            if (!vm.overView) {
              plan.element.splice(2, 1, {
                title: "風險等級",
                text: item[10],
              });
            }
            break;
          case "Edu":
            plan.element.push({
              title: "距離大學期間",
              text: item[4] + "年",
            });
            plan.element.push({
              title: "預計目標金額",
              text:
                "USD $ " +
                vm.$options.filters.commaFormat(
                  vm.$options.filters.decimalFormat(item[6])
                ),
            });
            if (!vm.overView) {
              plan.element.push({
                title: "風險等級",
                text: item[10],
              });
              plan.element.push({
                title: "小孩目前歲數",
                text: 18 - item[4] + "歲",
              });
              if (vm.tab1Data[0][9] == 2) {
                plan.element.push({
                  title: "預期軌道",
                  text: vm.tab1Data[0][12] > 50 ? "Ontrack" : "Offtrack",
                });
              } else {
                plan.element.push({
                  title: "預期軌道",
                  text: "N/A",
                });
              }
            }
            break;
          case "Production":
            // 沒房屋總價值
            plan.element.push({
              title: "距離買房時間",
              text: item[4] + "年",
            });
            plan.element.push({
              title: "預計目標金額",
              text:
                "USD $ " +
                vm.$options.filters.commaFormat(
                  vm.$options.filters.decimalFormat(item[6])
                ),
            });
            if (!vm.overView) {
              plan.element.push({
                title: "風險等級",
                text: item[10],
              });
              if (vm.tab1Data[0][9] == 2) {
                plan.element.push({
                  title: "預期軌道",
                  text: vm.tab1Data[0][12] > 50 ? "Ontrack" : "Offtrack",
                });
              } else {
                plan.element.push({
                  title: "預期軌道",
                  text: "N/A",
                });
              }
            }
            break;
          case "SpecificGoal":
            plan.element.push({
              title: "預計目標年限",
              text: item[4] + "年",
            });
            plan.element.push({
              title: "預計目標金額",
              text:
                "USD $ " +
                vm.$options.filters.commaFormat(
                  vm.$options.filters.decimalFormat(item[6])
                ),
            });
            if (!vm.overView) {
              plan.element.push({
                title: "風險等級",
                text: item[10],
              });
              if (vm.tab1Data[0][9] == 2) {
                plan.element.push({
                  title: "預期軌道",
                  text: vm.tab1Data[0][12] > 50 ? "Ontrack" : "Offtrack",
                });
              } else {
                plan.element.push({
                  title: "預期軌道",
                  text: "N/A",
                });
              }
            }
            break;
        }
        newTabData.push(plan);
      });
      return newTabData;
    },
    tab2: function () {
      // 成長狀況資料切換
      return this.tab22
        ? [this.tab2Data[0], this.tab2Data[1]]
        : [this.tab2Data[0], this.tab2Data[2]];
    },
    tableTotal: function () {
      //table footer 計算
      if (this.tableData) {
        let vm = this;
        let totalArray = this.tableData.map(function (element) {
          return [element[6], element[7], element[8]];
        });
        let total = totalArray.reduce(
          function (previousValue, currentValue, index) {
            return [
              vm.accAdd(previousValue[0], currentValue[0]),
              vm.accAdd(previousValue[1], currentValue[1]),
              vm.accAdd(previousValue[2], currentValue[2]),
            ];
          },
          [0, 0, 0]
        );
        return total;
      }
    },
    ETFtypeTotal: function () {
      //投資組合種類計算
      let vm = this;

      let stocksArray = this.tableData.filter(function (element) {
        return element[4] == "股票";
        // return element[4] == 'stocks'
      });

      let REITsArray = this.tableData.filter(function (element) {
        return element[4] == "不動產信託";
        // return element[4] == 'REITs'
      });
      let bondsArray = this.tableData.filter(function (element) {
        return element[4] == "債券";
        // return element[4] == 'bonds'
      });
      let stocksTotal = 0,
        REITsTotal = 0,
        bondsTotal = 0;
      stocksArray.forEach(function (item) {
        stocksTotal = stocksTotal + item[6];
      });
      REITsArray.forEach(function (item) {
        REITsTotal = REITsTotal + item[6];
      });
      bondsArray.forEach(function (item) {
        bondsTotal = bondsTotal + item[6];
      });
      return [stocksTotal, REITsTotal, bondsTotal];
    },
    progressData: function () {
      //比較的進度條資料格式轉換
      if (this.tab1Data.length != 0) {
        switch (this.tab1Data[0][0]) {
          case "Retirement":
            return [
              //v4
              {
                title: "您的風險等級",
                subtitle: true,
                value: this.tab1Data[0][10],
                circle: false,
                gauge: true,
                svgID: "riskSVG",
                type: "Retirement",
              },
              {
                title: "您的成功機率",
                value: this.tab1Data[0][12],
                circle: true,
                gauge: false,
                svgID: "RateSVG",
                type: "Retirement",
              },
              // {
              //   title: '其他人的平均退休成功機率',
              //   value: this.tab1Data[0][13],
              //   circle: true,
              //   gauge: false,
              //   svgID: 'RateSVG2',
              //   type: 'Retirement',
              // },
              // v2,v3
              // {
              //   title: '風險等級', self: this.tab1Data[0][10],
              //   selfTitle: '您的風險等級',
              //   circle: false,
              //   gauge: true,
              //   svgID: 'riskSVG',
              //   type: 'Retirement',
              //   compare: false,
              // },
              // {
              //   title: '成功機率', self: this.tab1Data[0][12],
              //   selfTitle: '您的成功機率', all: this.tab1Data[0][13],
              //   allTitle: '所有計畫平均成功機率',
              //   circle: true,
              //   gauge: false,
              //   svgID: 'RateSVG',
              //   svgID2: 'RateSVG2',
              //   type: 'Retirement',
              //   compare: true,
              // },
              // v1
              // {
              //   title: '風險等級', self: this.tab1Data[0][10],
              //   selfTitle: '您的風險等級', all: this.tab1Data[0][11],
              //   allTitle: '所有計畫平均風險等級',
              //   whatsThis: '為您統整在我們平台上已下單的計畫狀況，供您比較後參考'
              // },
              // {
              //   title: '成功機率', self: this.tab1Data[0][12],
              //   selfTitle: '您的成功機率', all: this.tab1Data[0][13],
              //   allTitle: '所有計畫平均成功機率',
              // },
              // {
              //   title: '距離退休時間', self: this.tab1Data[0][14],
              //   selfTitle: '距離您退休的時間', all: this.tab1Data[0][15],
              //   allTitle: '所有計畫平均退休時間',
              //   whatsThis: '為您統整在我們平台上已下單的計畫狀況，供您比較後參考'
              // },
            ];
          case "Long":
            //v4
            return [
              {
                title: "您的風險等級",
                subtitle: true,
                value: this.tab1Data[0][10],
                circle: false,
                gauge: true,
                svgID: "riskSVG",
                type: "Long",
              },
            ];
          // v2,3
          // return [
          //   {
          //     title: '風險等級', self: this.tab1Data[0][10],
          //     selfTitle: '您的風險等級',
          //     circle: false,
          //     gauge: true,
          //     svgID: 'riskSVG',
          //     type: 'Long',
          //     compare: false,
          //   },
          // ];
          //v1
          // return [
          //   {
          //     title: '風險等級', self: this.tab1Data[0][10],
          //     selfTitle: '您的風險等級',
          //   },
          //   {
          //     title: '投資期間', self: this.tab1Data[0][14],
          //     selfTitle: '您預計累積財富時間', all: this.tab1Data[0][15],
          //     allTitle: '所有計畫平均投資時間',
          //     whatsThis: '為您統整在我們平台上已下單的計畫狀況，供您比較後參考'
          //   },
          // ];
          case "Preservation":
            // v4
            return [
              {
                title: "您的風險等級",
                subtitle: true,
                value: this.tab1Data[0][10],
                circle: false,
                gauge: true,
                svgID: "riskSVG",
                type: "Preservation",
              },
            ];
          // v2,v3
          // return [
          //   {
          //     title: '風險等級', self: this.tab1Data[0][10],
          //     selfTitle: '您的風險等級',
          //     circle: false,
          //     gauge: true,
          //     svgID: 'riskSVG',
          //     type: 'Preservation',
          //     compare: false,
          //   },
          // ]
          //v1
          // return [
          //   {
          //     title: '風險等級', self: this.tab1Data[0][10],
          //     selfTitle: '您的風險等級',
          //   },
          //   {
          //     title: '投資期間', self: this.tab1Data[0][14],
          //     selfTitle: '您保值財產時間', all: this.tab1Data[0][15],
          //     allTitle: '所有計畫平均投資時間',
          //     whatsThis: '為您統整在我們平台上已下單的計畫狀況，供您比較後參考'
          //   },
          // ];
          case "Edu":
            //v4
            return [
              {
                title: "您的風險等級",
                subtitle: true,
                value: this.tab1Data[0][10],
                circle: false,
                gauge: true,
                svgID: "riskSVG",
                type: "Edu",
              },
              {
                title: "您的成功機率",
                value: this.tab1Data[0][12],
                circle: true,
                gauge: false,
                svgID: "RateSVG",
                type: "Edu",
              },
              // {
              //   title: '其他人的平均目標達成機率',
              //   value: this.tab1Data[0][13],
              //   circle: true,
              //   gauge: false,
              //   svgID: 'RateSVG2',
              //   type: 'Edu',
              // },
            ];
          // v2,v3
          // return [
          //   {
          //     title: '風險等級', self: this.tab1Data[0][10],
          //     selfTitle: '您的風險等級',
          //     circle: false,
          //     gauge: true,
          //     svgID: 'riskSVG',
          //     type: 'Edu',
          //     compare: false,
          //   },
          //   {
          //     title: '成功機率', self: this.tab1Data[0][12],
          //     selfTitle: '您的成功機率', all: this.tab1Data[0][13],
          //     allTitle: '所有計畫平均成功機率',
          //     circle: true,
          //     gauge: false,
          //     svgID: 'RateSVG',
          //     svgID2: 'RateSVG2',
          //     type: 'Edu',
          //     compare: true,
          //   },
          // ]
          // v1
          // return [
          //   {
          //     title: '風險等級', self: this.tab1Data[0][10],
          //     selfTitle: '您的風險等級',
          //   },
          //   {
          //     title: '成功機率', self: this.tab1Data[0][12],
          //     selfTitle: '您的成功機率', all: this.tab1Data[0][13],
          //     allTitle: '所有計畫平均成功機率',
          //     whatsThis: '為您統整在我們平台上已下單的計畫狀況，供您比較後參考'
          //   },
          //   {
          //     title: '投資期間', self: this.tab1Data[0][14],
          //     selfTitle: '您的孩子距離大學時間', all: this.tab1Data[0][15],
          //     allTitle: '所有計畫平均投資時間',
          //     whatsThis: '為您統整在我們平台上已下單的計畫狀況，供您比較後參考'
          //   },
          // ];
          case "Production":
            //v4
            return [
              {
                title: "您的風險等級",
                subtitle: true,
                value: this.tab1Data[0][10],
                circle: false,
                gauge: true,
                svgID: "riskSVG",
                type: "Production",
              },
              {
                title: "您的成功機率",
                value: this.tab1Data[0][12],
                circle: true,
                gauge: false,
                svgID: "RateSVG",
                type: "Production",
              },
              // {
              //   title: '其他人的平均目標達成機率',
              //   value: this.tab1Data[0][13],
              //   circle: true,
              //   gauge: false,
              //   svgID: 'RateSVG2',
              //   type: 'Production',
              // },
            ];
          // v2,v3
          // return [
          //   {
          //     title: '風險等級', self: this.tab1Data[0][10],
          //     selfTitle: '您的風險等級',
          //     circle: false,
          //     gauge: true,
          //     svgID: 'riskSVG',
          //     type: 'Production',
          //     compare: false,
          //   },
          //   {
          //     title: '成功機率', self: this.tab1Data[0][12],
          //     selfTitle: '您的成功機率', all: this.tab1Data[0][13],
          //     allTitle: '所有計畫平均成功機率',
          //     circle: true,
          //     gauge: false,
          //     svgID: 'RateSVG',
          //     svgID2: 'RateSVG2',
          //     type: 'Production',
          //     compare: true,
          //   },
          // ]
          // v1
          // return [
          //   {
          //     title: '風險等級', self: this.tab1Data[0][10],
          //     selfTitle: '您的風險等級',
          //   },
          //   {
          //     title: '成功機率', self: this.tab1Data[0][12],
          //     selfTitle: '您的成功機率', all: this.tab1Data[0][13],
          //     allTitle: '所有計畫平均成功機率',
          //     whatsThis: '為您統整在我們平台上已下單的計畫狀況，供您比較後參考'
          //   },
          //   {
          //     title: '投資期間', self: this.tab1Data[0][14],
          //     selfTitle: '距離你買房時間', all: this.tab1Data[0][15],
          //     allTitle: '所有計畫平均投資時間',
          //     whatsThis: '為您統整在我們平台上已下單的計畫狀況，供您比較後參考'
          //   },
          // ];
          case "SpecificGoal":
            // v4
            return [
              {
                title: "您的風險等級",
                subtitle: true,
                value: this.tab1Data[0][10],
                circle: false,
                gauge: true,
                svgID: "riskSVG",
                type: "SpecificGoal",
              },
              {
                title: "您的成功機率",
                value: this.tab1Data[0][12],
                circle: true,
                gauge: false,
                svgID: "RateSVG",
                type: "SpecificGoal",
              },
              // {
              //   title: '其他人的平均目標達成機率',
              //   value: this.tab1Data[0][13],
              //   circle: true,
              //   gauge: false,
              //   svgID: 'RateSVG2',
              //   type: 'SpecificGoal',
              // },
            ];
          // v2,v3
          // return [
          //   {
          //     title: '風險等級', self: this.tab1Data[0][10],
          //     selfTitle: '您的風險等級',
          //     circle: false,
          //     gauge: true,
          //     svgID: 'riskSVG',
          //     type: 'SpecificGoal',
          //     compare: false,
          //   },
          //   {
          //     title: '成功機率', self: this.tab1Data[0][12],
          //     selfTitle: '您的成功機率', all: this.tab1Data[0][13],
          //     allTitle: '所有計畫平均成功機率',
          //     circle: true,
          //     gauge: false,
          //     svgID: 'RateSVG',
          //     svgID2: 'RateSVG2',
          //     type: 'SpecificGoal',
          //     compare: true,
          //   },
          // ]
          // v1
          // return [
          //   {
          //     title: '風險等級', self: this.tab1Data[0][10],
          //     selfTitle: '您的風險等級',
          //   },
          //   {
          //     title: '成功機率', self: this.tab1Data[0][12],
          //     selfTitle: '您的成功機率', all: this.tab1Data[0][13],
          //     allTitle: '所有計畫平均成功機率',
          //     whatsThis: '為您統整在我們平台上已下單的計畫狀況，供您比較後參考'
          //   },
          //   {
          //     title: '投資期間', self: this.tab1Data[0][14],
          //     selfTitle: '您投資目標時間', all: this.tab1Data[0][15],
          //     allTitle: '所有計畫平均投資時間',
          //     whatsThis: '為您統整在我們平台上已下單的計畫狀況，供您比較後參考'
          //   },
          // ];
        }
      }
    },
  },
  filters: {
    slideData: function (value) {
      //切換slide顯示數量
      let overViewSlick =
        '{"arrows":false,"dots":true,"slidesToShow":2,"slidesToScroll":2,"vertical":true,"verticalSwiping":true,"infinite":false}';
      let orderSlick =
        '{"arrows":false,"dots":false,"slidesToShow":1,"slidesToScroll":1,"vertical":true,"verticalSwiping":true,"infinite":false}';
      return value ? overViewSlick : orderSlick;
    },
    ETFtype: function (value) {
      //ETF種類換字
      switch (value) {
        case "股票":
          return "股票";
        case "不動產信託":
          return "不動產";
        case "債券":
          return "債券";
        // case 'stocks':
        //   return '股票'
        // case 'REITs':
        //   return '不動產';
        // case 'bonds':
        //   return '債券';
      }
    },
    progressClass: function (value) {
      //比較的進度條換顏色
      switch (value) {
        case 0:
          return "progress-primary";
        case 1:
          return "progress-secondary";
        case 2:
          return "progress-info";
      }
    },
    goalText: function (value) {
      //目標轉換為中文字
      switch (value) {
        case "Retirement":
          return "退休金準備";
        case "Long":
          return "穩定累積財富";
        case "Preservation":
          return "財產保值抗通膨";
        case "Edu":
          return "子女教育金";
        case "Production":
          return "存錢買房";
        case "SpecificGoal":
          return "其他目標";
      }
    },
    commaFormat: function (value) {
      // 加上千分位符號
      return value
        .toString()
        .replace(/^(-?\d+?)((?:\d{3})+)(?=\.\d+$|$)/, function (
          all,
          pre,
          groupOf3Digital
        ) {
          return pre + groupOf3Digital.replace(/\d{3}/g, ",$&");
        });
    },
    decimalFormat: function (value) {
      //小數點兩位
      return value == "0" ? 0 : value.toFixed(2);
    },
    riskChinese: function (value) {
      if (value <= 45) {
        return "保守型";
      } else if (value <= 70) {
        return "穩健型";
      } else if (value <= 90) {
        return "積極型";
      }
    },
  },
  methods: {
    accAdd: function (num1, num2) {
      var r1, r2, m;
      try {
        r1 = num1.toString().split(".")[1].length;
      } catch (e) {
        r1 = 0;
      }
      try {
        r2 = num2.toString().split(".")[1].length;
      } catch (e) {
        r2 = 0;
      }
      m = Math.pow(10, Math.max(r1, r2));
      return Math.round(num1 * m + num2 * m) / m;
    },
    accMul: function (arg1, arg2) {
      var m = 0,
        s1 = arg1.toString(),
        s2 = arg2.toString();
      try {
        m += s1.split(".")[1].length;
      } catch (e) {}
      try {
        m += s2.split(".")[1].length;
      } catch (e) {}
      return (
        (Number(s1.replace(".", "")) * Number(s2.replace(".", ""))) /
        Math.pow(10, m)
      );
    },
    addOrder: function () {
      document.querySelector("#ctl00_Main_AddOrderBTN").click();
    },
    delPlan: function () {
      document.querySelector("#ctl00_Main_DelPlanBTN").click();
    },
    circle: function (element, type, value) {
      var svg = d3.select("#" + element);
      var w = svg._groups[0][0].clientWidth;
      var h = w;
      let c = new circleChart(svg, w, h, 40);
      let vm = this;
      c.transition = (sel) =>
        sel
          .transition()
          .duration(2000 + 400 * Math.abs(c.newValue - c.oldValue));
      c.update(0);

      if (type == "Long" || type == "Preservation") {
        c.format = "年";
        c.textMax = 40;
      }
      setTimeout(function () {
        if (type == "Long" || type == "Preservation") {
          c.update(value / 40);
        } else {
          c.update(value / 100);
        }
      }, 500);
    },
    gauge: function (element, value) {
      var svg = d3.select("#" + element);
      var w = svg._groups[0][0].clientWidth;
      var h = w;
      let g = new ArcDonutChart(svg, w, h, 10, [
        -0.5 * Math.PI,
        ((0.5 * 2) / 3) * Math.PI,
      ]);
      g.transition = (sel) =>
        sel
          .transition()
          .duration(1000 + 400 * Math.abs(g.newValue - g.oldValue));
      g.update(0);
      setTimeout(function () {
        g.update(value / 100);
      }, 500);
    },
    addMoney: function () {
      if (this.money && this.cfpNumber) {
        if(this.money < 300000){
          this.$message.error("最小金額30萬台幣");
        }else{
          this.$message("送出");
        }
      } else if (!this.money) {
        this.$message.error("請輸入金額");
      } else if (!this.cfpNumber) {
        this.$message.error('請輸入顧問編號');
      }else{
        this.$message.error("請輸入金額及顧問編號");
      }
    },
  },
  mounted: function () {
    let vm = this;
    if (!this.overView) {
      let circleArray = this.progressData.filter(function (element) {
        return element.circle;
      });
      circleArray.forEach(function (element) {
        vm.circle(element.svgID, element.type, element.value);
        //v2,3
        // vm.circle(element.svgID, element.type, element.self)
        // if(element.compare){
        //   vm.circle(element.svgID2,element.type,element.all)
        // }
      });
      let gaugeArray = this.progressData.filter(function (element) {
        return element.gauge;
      });

      gaugeArray.forEach(function (element) {
        vm.gauge(element.svgID, element.value);

        //v2,3
        // vm.gauge(element.svgID, element.self)
      });
    }
  },
});
