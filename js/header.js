// goal
// switch (value) {
//   case 1:
//     return '退休金準備';
//   case 2:
//     return '穩定累積財富';
//   case 3:
//     return '財產保值抗通膨';
//   case 4:
//     return '子女教育金';
//   case 5:
//     return '存錢買房';
//   case 6:
//     return '其他目標';
// }

//link
//?PID=訂單編號
let header = new Vue({
  el: 'header',
  data: {
    active: location.pathname.toLowerCase().indexOf('/order.') >= 0 ? location.search.replace('?PID=', '') : false,
    sidebar: Boolean(document.querySelector('header #ctl00_ResultLB').textContent) ? eval(document.querySelector('header #ctl00_ResultLB').textContent) : '',
    name: document.querySelector('#ctl00_LoginLB') ? document.querySelector('#ctl00_LoginLB').textContent : '',
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
    statusClass: function (value) {
      //    PS.計畫狀態：1已儲存、2已下單、9已結束；
      //    訂單狀態：0委託成功、1已成交、2部分成交、8委託失敗、9交易失敗
      //    -1無、0委託送出成功、1委託成功、2已成交、3部分成交、8委託失敗、9交易失敗
      if (value[0] == '2' && value[1] != '2') {   //  已下單但未已成交
        return ''; // return 'un-success'; 部份成交 先移除驚嘆號
      } else if (value[0] == '2' && value[1] == '2') {    //已下單且已成交
        return 'order';
      } else {
        return 'un-order';
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
    }
  },
  // mounted: function () {
  //   let sidebar = document.querySelectorAll('.rd-navbar-sidebar');
  //   sidebar[0].style.bottom = sidebar[1].clientHeight + 'px';
  // }

});

