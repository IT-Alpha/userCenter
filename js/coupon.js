Vue.component('coupon-use',{
    template:'#couponUse',
    props:['couponData','isRepeat'],
    data:function(){
        return{
            norepeatText:'您確定要使用此優惠券嗎?',
            repeatText:'您目前已有其他優惠券正在『使用中』，<br/>若您確定要使用此優惠券，<br/>優惠重複期間系統將自動擇優計算',
            selectPlan:''
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
        },
        modalColor(){
            //視窗顏色
            let vm = this;
            if(!vm.isRepeat){
                return 'bg-primary';
            }else{
                return 'bg-secondary';

            }
        },
        sureBtnColor(){
            //確定按鈕顏色
            let vm = this;
            if(!vm.isRepeat){
                return 'btn-primary';
            }else{
                return 'btn-outline-primary';

            }
        },
        cancelBtnColor(){
            //取消按鈕顏色
            let vm = this;
            if(!vm.isRepeat){
                return 'btn-outline-secondary';
            }else{
                return 'btn-secondary';

            }
        }
    },
    methods:{
        //檢查優惠券
        checkCoupon(){
            //將優惠券代碼與編號存入控制項
            let codeValueBtn = document.querySelector('#ctl00_Main_IDTBX1');
            let numValueBtn = document.querySelector('#ctl00_Main_IDTBX2');
            codeValueBtn.value = this.couponData[0];
            numValueBtn.value = this.couponData[1];


            setTimeout(function(){
                let checkCouponBtn = document.querySelector('#ctl00_Main_CkBTN');
                checkCouponBtn.click();
            },800)
            
            // console.log('123');
            // let couponModalBtn = document.querySelector('#couponModalBtn');
            // couponModalBtn.click();
        },
        //使用優惠券
        useCoupon(){
            let useCouponBtn = document.querySelector('#ctl00_Main_UseBTN');
            useCouponBtn.click();
        }
    }
})
let couponApp = new Vue({
    el:'#coupon',
    data:{
        promoCode:'',
        isRepeat:false
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
        }else if(checkedMsg.textContent == 'Success'){
            vm.isRepeat = true;
            setTimeout(function(){
                // console.log('12345')
                document.querySelector('#couponModalBtn').click();
            },1000)
        }
        // let dropOptions = document.querySelector('#ctl00_Main_PIDDDL');
        // console.log(dropOptions)
        // dropOptions.forEach(function(){
            
        // })
        // let vals = []
        // var sel = document.querySelector('#ctl00_Main_PIDDDL');
        // for (var i=0, n=sel.options.length;i<n;i++) { // looping over the options
        //     if (sel.options[i].value) vals.push(sel.options[i].value);
        // }
        // console.log(vals)
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
    },
    computed:{
        //客戶持有優惠券(輸入歷史)
        carryCouponList(){
            let backendList = document.querySelector('#ctl00_Main_CPDataLB');
            return backendList.textContent == '[]'?
                []:eval(backendList.textContent);
        },
        //客戶持有未使用優惠券
        couponNotUse(){
            let vm = this;
            return vm.carryCouponList == []?
                []: vm.carryCouponList.filter(coupon => coupon[12] == 0);
        },
        //客戶持有使用中優惠券
        couponUsing(){
            let vm = this;
            return vm.carryCouponList == []?
                []: vm.carryCouponList.filter(coupon => coupon[12] == 1);
        },
        //客戶持有已使用優惠券
        couponUsed(){
            let vm = this;
            return vm.carryCouponList == []?
                []: vm.carryCouponList.filter(coupon => coupon[12] == 2);
        },
        //客戶持有已過期優惠券
        couponExpired(){
            let vm = this;
            return vm.carryCouponList == []?
                []: vm.carryCouponList.filter(coupon => coupon[12] == 3);
        }
    
    }
})