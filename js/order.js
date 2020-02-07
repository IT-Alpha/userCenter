let order = new Vue({
  el: '#order',
  data: {
    tab1Data: eval(document.querySelector('#tab1DataLB').textContent),
    tab2Data: document.querySelector('#tab2DataLB').textContent ? eval(document.querySelector('#tab2DataLB').textContent) : [[0, 0], [0, 0, 0], [0, 0, 0,]],
    tab22: true,
    tableData: eval(document.querySelector('#tableDataLB').textContent),
    progressData: eval(document.querySelector('#progressDataLB').textContent),
  },
  computed: {
    status: function () {
      if (!location.search) {
        if (!document.querySelector('#tab1DataLB').textContent) {
          return 'noData'
        }
        return 'overView'
      } else {
        let el = document.querySelector('.rd-navbar-nav .active').children;
        return el[0].className.replace('rd-navbar-link ', '');
      }
    },
    slideData: function () {
      let overViewSlick = '{"arrows":false,"dots":true,"slidesToShow":2,"slidesToScroll":2,"vertical":true,"verticalSwiping":true,"infinite":false}'
      let orderSlick = '{"arrows":false,"dots":true,"slidesToShow":1,"slidesToScroll":2,"vertical":true,"verticalSwiping":true,"infinite":false}'
      return this.status == 'overView' ? overViewSlick : orderSlick;
    },
    tab1: function () {
      if (this.tab1Data) {
        let vm = this;
        let newTabData = this.tab1Data;
        if (this.status == 'overView') {
          newTabData.forEach(function (element) {
            element[2] = { title: '預計投入金額', text: 'USD $ ' + vm.$options.filters.commaFormat(element[2]) }
            switch (element[0]) {
              case 1:
                element[3] = { title: '預計退休年齡', text: element[3] + '歲' }
                element[4] = { title: '退休後月花費', text: 'USD $ ' + vm.$options.filters.commaFormat(element[4]) + ' / 月' }
                break;
              case 2:
              case 3:
                element[3] = { title: '預計投資期間', text: element[3] + '年' }
                element[4] = { title: '預計投資期間', text: '' }
                break;
              case 4:
                element[3] = { title: '距離大學期間', text: element[3] + '年' }
                element[4] = { title: '小孩目前歲數', text: element[4] + '歲' }
                break;
              case 5:
                element[3] = { title: '距離買房時間', text: element[3] + '年' }
                element[4] = { title: '房屋總價值', text: 'USD $ ' + vm.$options.filters.commaFormat(element[4]) + ' / 月' }
                break;
              case 6:
                element[3] = { title: '預計目標年限', text: element[3] + '年' }
                element[4] = { title: '預計目標金額', text: 'USD $ ' + vm.$options.filters.commaFormat(element[4]) + ' / 月' }
                break;
              default:
                return;
            }
          })

        } else {
          newTabData.forEach(function (element) {
            element[2] = { title: '預計投資金額', text: 'USD $ ' + vm.$options.filters.commaFormat(element[2]) }
            switch (element[0]) {
              case 1:
                element[3] = { title: '預計退休年齡', text: element[3] + '歲' }
                element[4] = { title: '退休後月花費', text: 'USD $ ' + vm.$options.filters.commaFormat(element[4]) + ' / 月' }
                element[5] = { title: '距離退休時間', text: element[5] + '年' }
                element[6] = { title: '風險等級', text: element[6] }
                element[7] = { title: '預期軌道', text: element[7] }
                break;
              case 2:
              case 3:
                element[3] = { title: '預計投資期間', text: element[3] + '年' }
                element[4] = { title: '風險等級', text: element[4] }
                element[5] = { title: '預期軌道', text: element[5] }
                break;
              case 4:
                element[3] = { title: '距離大學期間', text: element[3] + '年' }
                element[4] = { title: '小孩目前歲數', text: element[4] + '歲' }
                element[5] = { title: '預計所需金額', text: 'USD $ ' + vm.$options.filters.commaFormat(element[5]) }
                element[6] = { title: '風險等級', text: element[6] }
                element[7] = { title: '預期軌道', text: element[7] }
                break;
              case 5:
                element[3] = { title: '距離買房時間', text: element[3] + '年' }
                element[4] = { title: '目標達成金額', text: 'USD $ ' + vm.$options.filters.commaFormat(element[4]) }
                element[5] = { title: '房屋總價值', text: 'USD $ ' + vm.$options.filters.commaFormat(element[5]) }
                element[6] = { title: '風險等級', text: element[6] }
                element[7] = { title: '預期軌道', text: element[7] }
                break;
              case 6:
                element[3] = { title: '預計目標年限', text: element[3] + '年' }
                element[4] = { title: '預計目標金額', text: 'USD $ ' + vm.$options.filters.commaFormat(element[4]) }
                element[5] = { title: '風險等級', text: element[5] }
                element[6] = { title: '預期軌道', text: element[6] }
                break;
              default:
                return;
            }
          })
        }
        return newTabData;
      }
    },
    tab2: function () {
      return this.tab22 ? [this.tab2Data[0], this.tab2Data[1]] : [this.tab2Data[0], this.tab2Data[2]];
    },
    tableTotal: function () {
      if (this.tableData) {
        let vm = this;
        let totalArray = this.tableData.map(function (element) {
          return [element[6], element[7], element[8]];
        });
        let total = totalArray.reduce(function (previousValue, currentValue, index) {
          return [vm.accAdd(previousValue[0],currentValue[0]), vm.accAdd(previousValue[1],currentValue[1]), vm.accAdd(previousValue[2] ,currentValue[2])];
        },[0,0,0]);
        return total;
      }
    },
    progressTextArray: function () {
      if (this.tab1Data) {
        switch (this.tab1Data[0][0]) {
          case 1:
            return [['風險等級', '成功機率', '距離退休時間'], ['您的風險等級', '所有計畫平均風險等級'], ['您的成功機率', '所有計畫平均成功機率'], ['距離你退休的時間', '所有計畫平均退休時間']];
          case 2:
            return [['風險等級', '投資期間'], ['您的風險等級', '所有計畫平均風險等級'], ['您預計累積財富時間', '所有計畫平均投資時間']];
          case 3:
            return [['風險等級', '投資期間'], ['您的風險等級', '所有計畫平均風險等級'], ['您保值財產時間', '所有計畫平均投資時間']];
          case 4:
            return [['風險等級', '成功機率', '投資期間'], ['您的風險等級', '所有計畫平均風險等級'], ['您的成功機率', '所有計畫平均成功機率'], ['您的孩子距離大學時間', '所有計畫平均投資時間']];
          case 5:
            return [['風險等級', '成功機率', '投資期間'], ['您的風險等級', '所有計畫平均風險等級'], ['您的成功機率', '所有計畫平均成功機率'], ['距離你買房時間', '所有計畫平均投資時間']];
          case 6:
            return [['風險等級', '成功機率', '投資期間'], ['您的風險等級', '所有計畫平均風險等級'], ['您的成功機率', '所有計畫平均成功機率'], ['您投資目標時間', '所有計畫平均投資時間']];
        }
      }
    },
    ETFtypeTotal:function(){
      let vm = this;
      
      let stocksArray = this.tableData.filter(function (element) {
        return element[2] == 'stocks'
      });
      
      let REITsArray = this.tableData.filter(function (element) {
        return element[2] == 'REITs'
      });
      let bondsArray = this.tableData.filter(function (element) {
        return element[2] == 'bonds'
      });
      let stocksTotal = 0,REITsTotal = 0,bondsTotal = 0;
      stocksArray.forEach(function(item){
        stocksTotal = stocksTotal + item[6];
      })
      REITsArray.forEach(function(item){
        REITsTotal = REITsTotal + item[6];
      })
      bondsArray.forEach(function(item){
        bondsTotal = bondsTotal + item[6];
      })
      return [stocksTotal, REITsTotal,bondsTotal];
    }
  },
  filters: {
    statusClass: function (value) {
      switch (value) {
        case '0':
          return 'un-order'
        case '1':
          return 'un-success';
        case '2':
          return 'order';
      }
    },
    ETFtype:function (value) {
      switch (value) {
        case 'stocks':
          return '股票'
        case 'REITs':
          return '不動產';
        case 'bonds':
          return '債券';
      }
    },
    progressClass: function (value) {
      switch (value) {
        case 0:
          return 'progress-primary'
        case 1:
          return 'progress-secondary';
        case 2:
          return 'progress-info';
      }
    },
    progressText: function (value) {
      switch (value) {
        case 0:
          return 'progress-primary'
        case 1:
          return 'progress-secondary';
        case 2:
          return 'progress-info';
      }
    },
    goalText: function (value) {
      switch (value) {
        case 1:
          return '退休金準備';
        case 2:
          return '穩定累積財富';
        case 3:
          return '財產保值抗通膨';
        case 4:
          return '子女教育金';
        case 5:
          return '存錢買房';
        case 6:
          return '其他目標';
      }
    },
    commaFormat: function (value) { // 加上千分位符號
      return value.toString().replace(/^(-?\d+?)((?:\d{3})+)(?=\.\d+$|$)/, function (all, pre, groupOf3Digital) {
        return pre + groupOf3Digital.replace(/\d{3}/g, ',$&');
      })
    },
    decimalFormat: function (value) {//小數點兩位
      return value.toFixed(2);
    },
    
    test:function(value){
      return value.toFixed(2);
    }
  },
  methods: {
    accAdd:function(num1,num2){
      var r1,r2,m;
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
      m = Math.pow(10,Math.max(r1,r2));
      return Math.round(num1 * m + num2 * m) / m ;
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