let order = new Vue({
  el: '#order',
  data: {
    tab1Data: eval(document.querySelector('#tab1Data').textContent),
    tableData: eval(document.querySelector('#tableData').textContent),
  },
  computed: {
    status: function () {
      if (!location.search) {
        return 'overView'
      } else {
        let el = document.querySelector('.rd-navbar-nav .active').children;
        return el[0].className.replace('rd-navbar-link ', '');
      }
    },
    tab1: function () {
      let vm = this;
      let newTabData = this.tab1Data;
      if (this.status == 'overView') {
        newTabData.forEach(function (element) {
          element[2] = { title: '總投入金額', text: 'USD $ ' + vm.$options.filters.commaFormat(element[2]) }
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
          element[2] = { title: '總投入金額', text: 'USD $ ' + vm.$options.filters.commaFormat(element[2]) }
          switch (element[0]) {
            case 1:
              element[3] = { title: '預計退休年齡', text: element[3] + '歲' }
              element[4] = { title: '退休後月花費', text: 'USD $ ' + vm.$options.filters.commaFormat(element[4]) + ' / 月' }
              element[5] = { title: '風險等級', text: element[5] }
              element[6] = { title: '距離退休時間', text:  element[6] + '年' }
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
      }
      return newTabData;
    },
    tableTotal: function () {
      let totalArray = this.tableData.map(function (element) {
        return [element[3], element[4], element[5]];
      });
      let total = totalArray.reduce(function (previousValue, currentValue) {
        return [previousValue[0] + currentValue[0], previousValue[1] + currentValue[1], previousValue[2] + currentValue[2]];
      });
      return total;
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
      return Math.floor(value * 100) / 100;
    }
  }
});