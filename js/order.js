//-1無、0委託送出成功、1委託成功、2已成交、3部分成交、8委託失敗、9交易失敗；
// tab1[9]
let order = new Vue({
  el: '#order',
  data: {
    tab1Data: document.querySelector('#order #ctl00_Main_ResultLB').textContent ? eval(document.querySelector('#order #ctl00_Main_ResultLB').textContent) : null,
    tab2Data: document.querySelector('#ctl00_Main_TotalRateLB').textContent ? eval(document.querySelector('#ctl00_Main_TotalRateLB').textContent) : [[0, 0], [0, 0, 0], [0, 0, 0,]],
    tableData: eval(document.querySelector('#ctl00_Main_PoDataLB').textContent),
    tab22: true,
    overView: !Boolean(location.search),
  },
  computed: {
    tab1: function () { //財務規劃顯示的資料
      let vm = this;
      let newTabData = [];
      let tab1Array = [];
      if (this.overView) {
        tab1Array = this.tab1Data.filter(function (e) {
          return e[9] == 2
        })
      } else {
        tab1Array = this.tab1Data
      }
      tab1Array.forEach(function (item, index) {
        let plan = {
          title: vm.$options.filters.goalText(item[0]),
          progress: item[1],
          element: [
            {
              title: '預計投入金額',
              text: 'USD $ ' + vm.$options.filters.commaFormat(vm.$options.filters.decimalFormat(item[2]))
            },
          ]
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
          case 'Retirement':
            //沒距離退休時間
            plan.element.push({
              title: '預計退休年齡',
              text: item[4] + '歲'
            });
            plan.element.push({
              title: '退休後月花費',
              text: 'USD $ ' + vm.$options.filters.commaFormat(vm.$options.filters.decimalFormat(item[6])) + ' / 月'
            });
            if (!vm.overView) {
              plan.element.push({
                title: '風險等級',
                text: item[10]
              });
              if (vm.tab1Data[9] == 2) {
                plan.element.push({
                  title: '預期軌道',
                  text: vm.tab1Data[12] > 50 ? 'Ontrack' : 'Offtrack'
                });
              } else {
                plan.element.push({
                  title: '預期軌道',
                  text: 'N/A'
                });
              }

            }
            break;
          case 'Long':
          case 'Preservation':
            //沒預期軌道
            plan.element.push({
              title: '預計投資期間',
              text: item[4] + '年'
            });
            plan.element.push({
              title: '預計投資期間',
              text: ''
            });
            if (!vm.overView) {
              plan.element.splice(2, 1, {
                title: '風險等級',
                text: item[10]
              });
            }
            break;
          case 'Edu':
            //沒小孩目前歲數
            plan.element.push({
              title: '距離大學期間',
              text: item[4] + '年'
            });
            plan.element.push({
              title: '預計目標金額',
              text: 'USD $ ' + vm.$options.filters.commaFormat(vm.$options.filters.decimalFormat(item[6]))
            });
            if (!vm.overView) {
              plan.element.push({
                title: '風險等級',
                text: item[10]
              });
              plan.element.push({
                title: '小孩目前歲數',
                text: 18 - item[4] + '歲'
              });
              if (vm.tab1Data[9] == 2) {
                plan.element.push({
                  title: '預期軌道',
                  text: vm.tab1Data[12] > 50 ? 'Ontrack' : 'Offtrack'
                });
              } else {
                plan.element.push({
                  title: '預期軌道',
                  text: 'N/A'
                });
              }
            }
            break;
          case 'Production':
            // 沒房屋總價值
            plan.element.push({
              title: '距離買房時間',
              text: item[4] + '年'
            });
            plan.element.push({
              title: '預計目標金額',
              text: 'USD $ ' + vm.$options.filters.commaFormat(vm.$options.filters.decimalFormat(item[6]))
            });
            if (!vm.overView) {
              plan.element.push({
                title: '風險等級',
                text: item[10]
              });
              if (vm.tab1Data[9] == 2) {
                plan.element.push({
                  title: '預期軌道',
                  text: vm.tab1Data[12] > 50 ? 'Ontrack' : 'Offtrack'
                });
              } else {
                plan.element.push({
                  title: '預期軌道',
                  text: 'N/A'
                });
              }
            }
            break;
          case 'SpecificGoal':
            plan.element.push({
              title: '預計目標年限',
              text: item[4] + '年'
            });
            plan.element.push({
              title: '預計目標金額',
              text: 'USD $ ' + vm.$options.filters.commaFormat(vm.$options.filters.decimalFormat(item[6]))
            });
            if (!vm.overView) {
              plan.element.push({
                title: '風險等級',
                text: item[10]
              });
              if (vm.tab1Data[9] == 2) {
                plan.element.push({
                  title: '預期軌道',
                  text: vm.tab1Data[12] > 50 ? 'Ontrack' : 'Offtrack'
                });
              } else {
                plan.element.push({
                  title: '預期軌道',
                  text: 'N/A'
                });
              }
            }
            break;
        };
        newTabData.push(plan);
      })
      return newTabData;

    },
    tab2: function () {   // 成長狀況資料切換
      return this.tab22 ? [this.tab2Data[0], this.tab2Data[1]] : [this.tab2Data[0], this.tab2Data[2]];
    },
    tableTotal: function () {   //table footer 計算
      if (this.tableData) {
        let vm = this;
        let totalArray = this.tableData.map(function (element) {
          return [element[6], element[7], element[8]];
        });
        let total = totalArray.reduce(function (previousValue, currentValue, index) {
          return [vm.accAdd(previousValue[0], currentValue[0]), vm.accAdd(previousValue[1], currentValue[1]), vm.accAdd(previousValue[2], currentValue[2])];
        }, [0, 0, 0]);
        return total;
      }
    },
    ETFtypeTotal: function () {   //投資組合種類計算
      let vm = this;

      let stocksArray = this.tableData.filter(function (element) {
        return element[4] == '股票';
        // return element[4] == 'stocks'
      });

      let REITsArray = this.tableData.filter(function (element) {
        return element[4] == '不動產信託'
        // return element[4] == 'REITs'
      });
      let bondsArray = this.tableData.filter(function (element) {
        return element[4] == '債券'
        // return element[4] == 'bonds'
      });
      let stocksTotal = 0, REITsTotal = 0, bondsTotal = 0;
      stocksArray.forEach(function (item) {
        stocksTotal = stocksTotal + item[6];
      })
      REITsArray.forEach(function (item) {
        REITsTotal = REITsTotal + item[6];
      })
      bondsArray.forEach(function (item) {
        bondsTotal = bondsTotal + item[6];
      })
      return [stocksTotal, REITsTotal, bondsTotal];
    },
    progressData: function () { //比較的進度條資料格式轉換
      if (this.tab1Data) {
        switch (this.tab1Data[0][0]) {
          case 'Retirement':
            return [
              {
                title: '風險等級', self: this.tab1Data[0][10],
                selfTitle: '您的風險等級', all: this.tab1Data[0][11],
                allTitle: '所有計畫平均風險等級',
                whatsThis:'為您統整在我們平台上已下單的計畫狀況，供您比較後參考'
              },
              {
                title: '成功機率', self: this.tab1Data[0][12],
                selfTitle: '您的成功機率', all: this.tab1Data[0][13],
                allTitle: '所有計畫平均成功機率',
                whatsThis:'為您統整在我們平台上已下單的計畫狀況，供您比較後參考'
              },
              {
                title: '距離退休時間', self: this.tab1Data[0][14],
                selfTitle: '距離您退休的時間', all: this.tab1Data[0][15],
                allTitle: '所有計畫平均退休時間',
                whatsThis:'為您統整在我們平台上已下單的計畫狀況，供您比較後參考'
              },
            ];
          case 'Long':
            return [
              {
                title: '風險等級', self: this.tab1Data[0][10],
                selfTitle: '您的風險等級', all: this.tab1Data[0][11],
                allTitle: '所有計畫平均風險等級',
                whatsThis:'為您統整在我們平台上已下單的計畫狀況，供您比較後參考'
              },
              {
                title: '投資期間', self: this.tab1Data[0][14],
                selfTitle: '您預計累積財富時間', all: this.tab1Data[0][15],
                allTitle: '所有計畫平均投資時間',
                whatsThis:'為您統整在我們平台上已下單的計畫狀況，供您比較後參考'
              },
            ];
          case 'Preservation':
            return [
              {
                title: '風險等級', self: this.tab1Data[0][10],
                selfTitle: '您的風險等級', all: this.tab1Data[0][11],
                allTitle: '所有計畫平均風險等級',
                whatsThis:'為您統整在我們平台上已下單的計畫狀況，供您比較後參考'
              },
              {
                title: '投資期間', self: this.tab1Data[0][14],
                selfTitle: '您保值財產時間', all: this.tab1Data[0][15],
                allTitle: '所有計畫平均投資時間',
                whatsThis:'為您統整在我們平台上已下單的計畫狀況，供您比較後參考'
              },
            ];
          case 'Edu':
            return [
              {
                title: '風險等級', self: this.tab1Data[0][10],
                selfTitle: '您的風險等級', all: this.tab1Data[0][11],
                allTitle: '所有計畫平均風險等級',
                whatsThis:'為您統整在我們平台上已下單的計畫狀況，供您比較後參考'
              },
              {
                title: '成功機率', self: this.tab1Data[0][12],
                selfTitle: '您的成功機率', all: this.tab1Data[0][13],
                allTitle: '所有計畫平均成功機率',
                whatsThis:'為您統整在我們平台上已下單的計畫狀況，供您比較後參考'
              },
              {
                title: '投資期間', self: this.tab1Data[0][14],
                selfTitle: '您的孩子距離大學時間', all: this.tab1Data[0][15],
                allTitle: '所有計畫平均投資時間',
                whatsThis:'為您統整在我們平台上已下單的計畫狀況，供您比較後參考'
              },
            ];
          case 'Production':
            return [
              {
                title: '風險等級', self: this.tab1Data[0][10],
                selfTitle: '您的風險等級', all: this.tab1Data[0][11],
                allTitle: '所有計畫平均風險等級',
                whatsThis:'為您統整在我們平台上已下單的計畫狀況，供您比較後參考'
              },
              {
                title: '成功機率', self: this.tab1Data[0][12],
                selfTitle: '您的成功機率', all: this.tab1Data[0][13],
                allTitle: '所有計畫平均成功機率',
                whatsThis:'為您統整在我們平台上已下單的計畫狀況，供您比較後參考'
              },
              {
                title: '投資期間', self: this.tab1Data[0][14],
                selfTitle: '距離你買房時間', all: this.tab1Data[0][15],
                allTitle: '所有計畫平均投資時間',
                whatsThis:'為您統整在我們平台上已下單的計畫狀況，供您比較後參考'
              },
            ];
          case 'SpecificGoal':
            return [
              {
                title: '風險等級', self: this.tab1Data[0][10],
                selfTitle: '您的風險等級', all: this.tab1Data[0][11],
                allTitle: '所有計畫平均風險等級',
                whatsThis:'為您統整在我們平台上已下單的計畫狀況，供您比較後參考'
              },
              {
                title: '成功機率', self: this.tab1Data[0][12],
                selfTitle: '您的成功機率', all: this.tab1Data[0][13],
                allTitle: '所有計畫平均成功機率',
                whatsThis:'為您統整在我們平台上已下單的計畫狀況，供您比較後參考'
              },
              {
                title: '投資期間', self: this.tab1Data[0][14],
                selfTitle: '您投資目標時間', all: this.tab1Data[0][15],
                allTitle: '所有計畫平均投資時間',
                whatsThis:'為您統整在我們平台上已下單的計畫狀況，供您比較後參考'
              },
            ];
        }
      }
    }
  },
  filters: {
    slideData: function (value) { //切換slide顯示數量
      let overViewSlick = '{"arrows":false,"dots":true,"slidesToShow":2,"slidesToScroll":2,"vertical":true,"verticalSwiping":true,"infinite":false}'
      let orderSlick = '{"arrows":false,"dots":false,"slidesToShow":1,"slidesToScroll":1,"vertical":true,"verticalSwiping":true,"infinite":false}'
      return value ? overViewSlick : orderSlick;
    },
    ETFtype: function (value) { //ETF種類換字
      switch (value) {
        case '股票':
          return '股票'
        case '不動產信託':
          return '不動產';
        case '債券':
          return '債券';
        // case 'stocks':
        //   return '股票'
        // case 'REITs':
        //   return '不動產';
        // case 'bonds':
        //   return '債券';
      }
    },
    progressClass: function (value) {   //比較的進度條換顏色
      switch (value) {
        case 0:
          return 'progress-primary'
        case 1:
          return 'progress-secondary';
        case 2:
          return 'progress-info';
      }
    },
    goalText: function (value) {  //目標轉換為中文字
      switch (value) {
        case 'Retirement':
          return '退休金準備';
        case 'Long':
          return '穩定累積財富';
        case 'Preservation':
          return '財產保值抗通膨';
        case 'Edu':
          return '子女教育金';
        case 'Production':
          return '存錢買房';
        case 'SpecificGoal':
          return '其他目標';
      }
    },
    commaFormat: function (value) { // 加上千分位符號
      return value.toString().replace(/^(-?\d+?)((?:\d{3})+)(?=\.\d+$|$)/, function (all, pre, groupOf3Digital) {
        return pre + groupOf3Digital.replace(/\d{3}/g, ',$&');
      })
    },
    decimalFormat: function (value) { //小數點兩位
      return value == '0' ? 0 : value.toFixed(2);
    },
  },
  methods: {
    accAdd: function (num1, num2) {
      var r1, r2, m;
      try {
        r1 = num1.toString().split('.')[1].length;
      } catch (e) {
        r1 = 0;
      }
      try {
        r2 = num2.toString().split('.')[1].length;
      } catch (e) {
        r2 = 0;
      }
      m = Math.pow(10, Math.max(r1, r2));
      return Math.round(num1 * m + num2 * m) / m;
    },
    accMul: function (arg1, arg2) {
      var m = 0, s1 = arg1.toString(), s2 = arg2.toString();
      try {
        m += s1.split(".")[1].length;
      }
      catch (e) {
      }
      try {
        m += s2.split(".")[1].length;
      }
      catch (e) {
      }
      return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m);
    },
  }
});