let rebalance = new Vue({
  el: "#rebalance",
  data: {
    main: eval(document.querySelector("#ctl00_Main_RebalanceLB").textContent),
    assets: eval(document.querySelector("#ctl00_Main_DetailLB").textContent).reverse(),
  },
  mounted: function(){
    console.log(this.main)
    console.log(this.assets)
  },
  methods: {
    buyAndSell: function(type) {
      if(type === 'B') {
        return '買進'
      }else if(type === 'S'){
        return '賣出'
      }
    },
    clickSubmit: function() {
      document.querySelector('#ctl00_Main_OrderBTN').click();
    },
    goalText: function (value) {
      switch (value) {
        case 'Retirement':
          return '提早過退休的生活';
        case 'Long':
          return '累積長期財富';
        case 'Preservation':
          return '守護財富財產保值';
        case 'Edu':
          return '當孩子教育的後盾';
        case 'Production':
          return '實現擁有家的願望';
        case 'SpecificGoal':
          return '快速存下第一桶金';
      }
    }
  }
})