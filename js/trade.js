let trade = new Vue({
  el: '#trade',
  data: {
    list: eval(document.querySelector('#ctl00_Main_ResultLB').textContent),
    ETFlist: eval(document.querySelector('#ctl00_Main_PoDataLB').textContent),
    whichDetail: 0,
    content:false
  },
  filters: {
    goalIcon: function (value) {
      switch (value) {
        case 'Retirement':
          return 'mdi-airballoon';
        case 'Long':
          return 'mdi-cash-usd';
        case 'Preservation':
          return 'mdi-shield';
        case 'Edu':
          return 'mdi-school';
        case 'Production':
          return 'mdi-home';
        case 'SpecificGoal':
          return 'mdi-account-multiple-plus';
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
    orderTypeCh: function (value) {
      switch (value) {
        case 1:
          return '當日有效價格區間';
        default:
          return value
      }
    },
    ETFtypeClass: function (value) {
      switch (value) {
        case '股票':
          return 'stocks';
        case '不動產信託':
          return 'REITs';
        case '債券':
          return 'bonds';
        default:
          break;
      }
    },
    ETFtypeIcon: function (value) {
      switch (value) {
        case '股票':
          return '股';
        case '不動產信託':
          return '房';
        case '債券':
          return '債';
        default:
          break;
      }
    },
    ETFtypeCh: function (value) {
      switch (value) {
        case 1:
          return '未成交';
        case 2:
          return '部分成交';
        case 3:
          return '已成交';
        default:
          break;
      }
      
    }
  },
  methods: {
    detailModal: function (value) {
      let vm = this;
      this.whichDetail = value;
      this.content = true
      $('#contentModal').modal();
      $('#contentModal').on('hidden.bs.modal',function(e){
        vm.content = false;
        $('#parent-carousel-1').slick('slickGoTo',0,true);
      })
      setTimeout(function () {
        $('.carousel-child').slick('setPosition')
        $('.carousel-parent').slick('setPosition');
      }, 150);
    }
  }
});

