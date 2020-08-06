Vue.component('coupon-use',{
    template:'#couponUse',
    props:['couponData'],
    data:function(){
        return{
            
        }
    },
    computed:{
        //優惠券背景顏色
        background(){
            let vm = this;
            if(vm.couponData == undefined){
                return 'coupon-bg-g';
            }else{
                switch(vm.couponData[12]){
                    case 0:
                        return 'coupon-bg-b';
                    case 1:
                        return 'coupon-bg-b';
                    case 2:
                        return 'coupon-bg-g';
                    case 3:
                        return 'coupon-bg-g';
                    default:
                        return 'coupon-bg-g';
                }
            }
        },
        titleColor(){
            //優惠券標題顏色
            let vm = this;
            if(vm.couponData == undefined){
                return 'text-muted';
            }else{
                switch(vm.couponData[12]){
                    case 0:
                        return 'text-primary';
                    case 1:
                        return 'text-primary';
                    case 2:
                        return 'text-muted';
                    case 3:
                        return 'text-muted';
                    default:
                        return 'text-muted';
                }
            }
        }
    }
})
let couponApp = new Vue({
    el:'#coupon',
    data:{
        promoCode:'',
        isRepeat:false,
        norepeatText:'優惠將於 『下個月』 開始生效，您確定要使用此優惠券嗎?',
        repeatText:'您的優惠期間已重疊，系統將自動幫您擇優計算，您確定要使用嗎?'
    },
    mounted(){
        let vm = this;
        let checkedMsg = document.querySelector('#ctl00_Main_CkLB');
        if(checkedMsg.textContent == 'Repeat'){
            // console.log('重複')
            vm.isRepeat = true;
            setTimeout(function(){
                // console.log('12345')
                document.querySelector('#couponModalBtn').click();
            },1000)
            
        }
    },
    methods:{
        //兌換配對控制項
        exChange(){
            let exChangeBtn = document.querySelector('#ctl00_Main_ExchBTN');
            exChangeBtn.click();
        },
        //優惠碼輸入框控制項
        promoCodeText(){
            let vm = this;
            let promoCodeInput = document.querySelector('#ctl00_Main_NumTBX');
            promoCodeInput.value = vm.promoCode;
        },
        checkCoupon(){
            let checkCouponBtn = document.querySelector('#ctl00_Main_CkBTN');
            checkCouponBtn.click();
            // console.log('123');
            // let couponModalBtn = document.querySelector('#couponModalBtn');
            // couponModalBtn.click();
        },
        //使用優惠券
        useCoupon(){
            let useCouponBtn = document.querySelector('#ctl00_Main_UseBTN');
            useCouponBtn.click();
        }
    },
    computed:{
        carryCouponList(){
            let backendList = document.querySelector('#ctl00_Main_CPDataLB');
            return backendList.textContent == '[]'?
                []:eval(backendList.textContent);
        },
        couponNotUse(){
            let vm = this;
            return vm.carryCouponList == []?
                []: vm.carryCouponList.filter(coupon => coupon[12] == 0);
        },
        couponUsing(){
            let vm = this;
            return vm.carryCouponList == []?
                []: vm.carryCouponList.filter(coupon => coupon[12] == 1);
        },
        couponUsed(){
            let vm = this;
            return vm.carryCouponList == []?
                []: vm.carryCouponList.filter(coupon => coupon[12] == 2);
        },
        couponExpired(){
            let vm = this;
            return vm.carryCouponList == []?
                []: vm.carryCouponList.filter(coupon => coupon[12] == 3);
        }
    
    }
})