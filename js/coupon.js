Vue.component('coupon-use',{
    template:'#couponUse',
    props:['couponData','isRepeat','targetCouponData'],
    data:function(){
        return{
            norepeatText:'您確定要使用此優惠券嗎?',
            repeatText:'您目前已有其他優惠券正在『使用中』<br/>若您確定要使用此優惠券<br/>優惠重複期間系統將自動擇優計算',
            selectPlan:'',
            selectPlanAlert:''
        }
    },
    computed:{
        //優惠券背景顏色
        background(){
            let vm = this;
            if(vm.couponData == undefined){
                return 'coupon-bg-g';
            }else{
                switch(vm.couponData[13]){
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
                switch(vm.couponData[13]){
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
        },
        orderedPlans(){
            let orderedList = document.querySelector('#ctl00_Main_PDataLB');
            return orderedList.textContent == '[]'?
                []:eval(orderedList.textContent);
        },
        couponCategory(){
            let vm = this;

            switch(vm.couponData[5]){
                case 'ALL':
                    return '所有計畫';
                break;
                case 'Edu':
                    return '當孩子教育的後盾';
                break;
                case 'Long':
                    return '累積長期財富';
                break;
                case 'Preservation':
                    return '守護財富財產保值';
                break;
                case 'Production':
                    return '實現擁有家的願望';
                break;
                case 'Retirement':
                    return '提早過退休生活';
                break;
                case 'SpecificGoal':
                    return '其他個人化的目標';
                break;
                case 'Wallet':
                    return '金額優惠';
                break;
                case 'Plan':
                    return '單一計畫';
                break;
                case 'FPlan':
                    return '單一計畫首次下單';
                break;
            }
            
            
        }
    },
    watch:{
        selectPlan(){
            //當客戶選擇好適用的計畫
            let vm = this;
            let targetPlan = document.querySelector('#ctl00_Main_PIDTBX');
            targetPlan.value = vm.selectPlan;
        }
    },
    methods:{
        //檢查優惠券
        checkCoupon(){
            //先清空
            localStorage.setItem('couponData','');
            //將優惠券代碼與編號存入控制項
            let codeValueBtn = document.querySelector('#ctl00_Main_IDTBX1');
            let numValueBtn = document.querySelector('#ctl00_Main_IDTBX2');
            codeValueBtn.value = this.couponData[0];
            numValueBtn.value = this.couponData[1];

            localStorage.setItem('couponData',JSON.stringify(this.couponData));

            setTimeout(function(){
                let checkCouponBtn = document.querySelector('#ctl00_Main_CkBTN');
                checkCouponBtn.click();
            },800)
            
            // let couponModalBtn = document.querySelector('#couponModalBtn');
            // couponModalBtn.click();
        },
        //使用優惠券
        useCoupon(){
            let targetPlan = document.querySelector('#ctl00_Main_PIDTBX');
            let vm = this;
            //判斷該優惠券是否需綁定單一計畫
            // if(vm.couponData[5] == 'Plan' || vm.couponData[5] == 'FPlan'){
            //     //若未選擇計畫的防呆機制
            //     if(vm.couponData[5] != 'Retirement'){
            //         if(targetPlan.value == ''){
            //             vm.selectPlanAlert ='請選擇使用優惠計畫';
            //         }else{
            //             let useCouponBtn = document.querySelector('#ctl00_Main_UseBTN');
            //             useCouponBtn.click();
            //             localStorage.setItem('couponData','');
            //         }
            //     }
                
            // }else{
            //     let useCouponBtn = document.querySelector('#ctl00_Main_UseBTN');
            //     useCouponBtn.click();
            //     localStorage.setItem('couponData','');
            // }
            let useCouponBtn = document.querySelector('#ctl00_Main_UseBTN');
            useCouponBtn.click();
            localStorage.setItem('couponData','');
        }
    }
})
let couponApp = new Vue({
    el:'#coupon',
    data:{
        promoCode:'',
        isRepeat:false,
        targetCouponData:[]
    },
    mounted(){
        let vm = this;
        let checkedMsg = document.querySelector('#ctl00_Main_CkLB');

        if(checkedMsg.textContent == 'Repeat'){
            // console.log('重複')
            vm.isRepeat = true;

            setTimeout(function(){
                let targetCoupon = localStorage.getItem('couponData') || [];
                vm.targetCouponData = JSON.parse(targetCoupon);
                document.querySelector('#couponModalBtn').click();
            },1000)
            
        }else if(checkedMsg.textContent == 'Success'){
            vm.isRepeat = false;
            setTimeout(function(){
                let targetCoupon = localStorage.getItem('couponData') || [];
                vm.targetCouponData = JSON.parse(targetCoupon);
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
                []: vm.carryCouponList.filter(coupon => coupon[13] == 0);
        },
        //客戶持有使用中優惠券
        couponUsing(){
            let vm = this;
            return vm.carryCouponList == []?
                []: vm.carryCouponList.filter(coupon => coupon[13] == 1);
        },
        //客戶持有已使用優惠券
        couponUsed(){
            let vm = this;
            return vm.carryCouponList == []?
                []: vm.carryCouponList.filter(coupon => coupon[13] == 2);
        },
        //客戶持有已過期優惠券
        couponExpired(){
            let vm = this;
            return vm.carryCouponList == []?
                []: vm.carryCouponList.filter(coupon => coupon[13] == 3);
        }
    
    }
})