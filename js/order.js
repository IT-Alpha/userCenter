let order = new Vue({
  el: '#order',
  data: {
    tab1Data: eval(document.querySelector('#tab1DataLB').textContent),
    tab2Data: document.querySelector('#TotalRateLB').textContent ? eval(document.querySelector('#TotalRateLB').textContent) : [[0, 0], [0, 0, 0], [0, 0, 0,]],
    tab22: true,
    tableData: eval(document.querySelector('#PoDataLB').textContent),
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
        let newTabData = [];

        this.tab1Data.forEach(function (item, index) {
          let plan = {
            title: vm.$options.filters.goalText(item[0]),
            progress: item[1] + '%',
            element: [
              {
                title: '預計投入金額',
                text: 'USD $ ' + vm.$options.filters.commaFormat(item[2])
              },
            ]
          };
          switch (item[0]) {
            case 'Retirement':
              plan.element.push({
                title: '預計退休年齡',
                text: item[3] + '歲'
              });
              plan.element.push({
                title: '退休後月花費',
                text: 'USD $ ' + vm.$options.filters.commaFormat(item[5]) + ' / 月'
              });
              if (vm.status !== 'overView') {
                plan.element.push({
                  title: '距離退休時間',
                  text: '1年'
                });
                plan.element.push({
                  title: '風險等級',
                  text: item[9]
                });
                plan.element.push({
                  title: '預期軌道',
                  text: 'ontrack'
                });
              }
              break;
            case 'Long':
            case 'Preservation':
              plan.element.push({
                title: '預計投資期間',
                text: item[3] + '年'
              });
              plan.element.push({
                title: '預計投資期間',
                text: ''
              });
              if (vm.status !== 'overView') {
                plan.element.push({
                  title: '風險等級',
                  text: item[9]
                });
              }
              break;
            case 'Edu':
              plan.element.push({
                title: '距離大學期間',
                text: item[3] + '年'
              });
              plan.element.push({
                title: '預計目標金額',
                text: 'USD $ ' + vm.$options.filters.commaFormat(item[5])
              });
              if (vm.status !== 'overView') {
                plan.element.push({
                  title: '風險等級',
                  text: item[9]
                });
                plan.element.push({
                  title: '風險軌道',
                  text: 'ontrack'
                });
              }
              break;
            case 'Production':
              plan.element.push({
                title: '距離買房時間',
                text: item[3] + '年'
              });
              plan.element.push({
                title: '預計目標金額',
                text: 'USD $ ' + vm.$options.filters.commaFormat(item[5])
              });
              if (vm.status !== 'overView') {
                plan.element.push({
                  title: '風險等級',
                  text: item[9]
                });
                plan.element.push({
                  title: '風險軌道',
                  text: 'ontrack'
                });
              }
              break;
            case 'SpecificGoal':
              plan.element.push({
                title: '預計目標年限',
                text: item[3] + '年'
              });
              plan.element.push({
                title: '預計目標金額',
                text: 'USD $ ' + vm.$options.filters.commaFormat(item[5])
              });
              if (vm.status !== 'overView') {
                plan.element.push({
                  title: '風險等級',
                  text: item[9]
                });
                plan.element.push({
                  title: '風險軌道',
                  text: 'ontrack'
                });
              }
              break;
          };
          newTabData.push(plan);
        })
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
          return [vm.accAdd(previousValue[0], currentValue[0]), vm.accAdd(previousValue[1], currentValue[1]), vm.accAdd(previousValue[2], currentValue[2])];
        }, [0, 0, 0]);
        return total;
      }
    },

    ETFtypeTotal: function () {
      let vm = this;

      let stocksArray = this.tableData.filter(function (element) {
        return element[4] == 'stocks'
      });

      let REITsArray = this.tableData.filter(function (element) {
        return element[4] == 'REITs'
      });
      let bondsArray = this.tableData.filter(function (element) {
        return element[4] == 'bonds'
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
    progressData: function () {
      if (this.tab1Data) {
        switch (this.tab1Data[0][0]) {
          case 'Retirement':
            return [
              { title: '風險等級', self: this.tab1Data[0][9], selfTitle: '您的風險等級', all: this.tab1Data[0][10], allTitle: '所有計畫平均風險等級' },
              { title: '成功機率', self: this.tab1Data[0][11], selfTitle: '您的成功機率', all: this.tab1Data[0][12], allTitle: '所有計畫平均成功機率' },
              { title: '距離退休時間', self: this.tab1Data[0][13], selfTitle: '距離您退休的時間', all: this.tab1Data[0][14], allTitle: '所有計畫平均退休時間' },
            ];
          case 'Long':
            return [
              { title: '風險等級', self: this.tab1Data[0][9], selfTitle: '您的風險等級', all: this.tab1Data[0][10], allTitle: '所有計畫平均風險等級' },
              { title: '投資期間', self: this.tab1Data[0][11], selfTitle: '您預計累積財富時間', all: this.tab1Data[0][12], allTitle: '所有計畫平均投資時間' },
            ];
          case 'Preservation':
            return [
              { title: '風險等級', self: this.tab1Data[0][9], selfTitle: '您的風險等級', all: this.tab1Data[0][10], allTitle: '所有計畫平均風險等級' },
              { title: '投資期間', self: this.tab1Data[0][11], selfTitle: '您保值財產時間', all: this.tab1Data[0][12], allTitle: '所有計畫平均投資時間' },
            ];
          case 'Edu':
            return [
              { title: '風險等級', self: this.tab1Data[0][9], selfTitle: '您的風險等級', all: this.tab1Data[0][10], allTitle: '所有計畫平均風險等級' },
              { title: '成功機率', self: this.tab1Data[0][11], selfTitle: '您的成功機率', all: this.tab1Data[0][12], allTitle: '所有計畫平均成功機率' },
              { title: '投資期間', self: this.tab1Data[0][13], selfTitle: '您的孩子距離大學時間', all: this.tab1Data[0][14], allTitle: '所有計畫平均投資時間' },
            ];
          case 'Production':
            return [
              { title: '風險等級', self: this.tab1Data[0][9], selfTitle: '您的風險等級', all: this.tab1Data[0][10], allTitle: '所有計畫平均風險等級' },
              { title: '成功機率', self: this.tab1Data[0][11], selfTitle: '您的成功機率', all: this.tab1Data[0][12], allTitle: '所有計畫平均成功機率' },
              { title: '投資期間', self: this.tab1Data[0][13], selfTitle: '距離你買房時間', all: this.tab1Data[0][14], allTitle: '所有計畫平均投資時間' },
            ];
          case 'SpecificGoal':
            return [
              { title: '風險等級', self: this.tab1Data[0][9], selfTitle: '您的風險等級', all: this.tab1Data[0][10], allTitle: '所有計畫平均風險等級' },
              { title: '成功機率', self: this.tab1Data[0][11], selfTitle: '您的成功機率', all: this.tab1Data[0][12], allTitle: '所有計畫平均成功機率' },
              { title: '投資期間', self: this.tab1Data[0][13], selfTitle: '您投資目標時間', all: this.tab1Data[0][14], allTitle: '所有計畫平均投資時間' },
            ];
        }
      }
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
    ETFtype: function (value) {
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
    goalText: function (value) {
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
    decimalFormat: function (value) {//小數點兩位
      return value.toFixed(2);
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