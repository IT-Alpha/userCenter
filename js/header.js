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
//資料格式
//[訂單編號,投資目標,投資狀態,達成率]
//link
//?PID=訂單編號
let header = new Vue({
  el: 'header',
  data: {
    active: location.pathname.indexOf('order') >= 0 ? location.search.replace('?PID=', '') : false,
    sidebar: Boolean(document.querySelector('#sidebarDataLB').textContent) ? eval(document.querySelector('#sidebarDataLB').textContent) : '',
  },
  filters: {
    goalIcon: function (value) {
      switch (value) {
        case '1':
          return 'mdi-airballoon';
        case '2':
          return 'mdi-cash-usd';
        case '3':
          return 'mdi-shield';
        case '4':
          return 'mdi-school';
        case '5':
          return 'mdi-home';
        case '6':
          return 'mdi-account-multiple-plus';
      }
    },
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
        case '1':
          return '退休金準備';
        case '2':
          return '穩定累積財富';
        case '3':
          return '財產保值抗通膨';
        case '4':
          return '子女教育金';
        case '5':
          return '存錢買房';
        case '6':
          return '其他目標';
      }
    }
  }
});

