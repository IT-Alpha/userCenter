
let genderBTN1 = document.querySelector('#ctl00_Main_GenderRBTN1');
let genderBTN2 = document.querySelector('#ctl00_Main_GenderRBTN2');
let email = document.querySelector('#ctl00_Main_ActLB');

genderBTN1.classList.add('custom-control-input')
genderBTN2.classList.add('custom-control-input')
document.querySelector('#email').textContent = email.textContent;

let mobile_Re = /^09[0-9]{8}$/;
let number_Re = /^[0-9]*$/;
let mail_Re = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z]+$/;




//欄位自動focus下一個
$(".paycard").keyup(function () {
    // console.log('siblings length',$(this).siblings().length)
    // console.log('index', $('.paycard-set .paycard').index(this))

    if (this.value.length == this.maxLength) {
        let $next = $(this).next('.paycard');
        // console.log($next.length)
        // let $nextSet = $(this).closest('.paycard-set')
        if ($next.length ){
            $(this).next('.paycard').focus();
        }else if($next.length == 0){
            $(this).closest('.paycard-set').next().find('.paycard').eq(0).focus();
            // $(this).closest('.paycard-set').find('.paycard').focus();
        }else{
            $(this).blur();
        }
            
        
    }
});

//戶籍地址驗證
$('#reAddressData').click(function(){
    let reAddress = $('#ctl00_Main_AddressTBX1').val();
    let sendReAddBtn = $('#ctl00_Main_AddressBTN1');
    let reAddAlert = $('#reAddAlert');
    if(reAddress!=''){
        reAddAlert.text('');
        sendReAddBtn.click();
    }else{
        reAddAlert.text('請填寫戶籍地址')
    }
})
//通訊地址驗證
$('#maAddressData').click(function(){
    let maAddress = $('#ctl00_Main_AddressTBX2').val();
    let sendMaAddBtn = $('#ctl00_Main_AddressBTN2');
    let maAddAlert = $('#maAddAlert');
    if(maAddress!=''){
        maAddAlert.text('');
        sendMaAddBtn.click();
    }else{
        maAddAlert.text('請填寫通訊地址')
    }
})


//手機驗證
$('#saveMobileData').click(function(){
    let mobile = $('#ctl00_Main_PhoneTBX').val();
    let sendMobileBtn = $('#ctl00_Main_PhoneBTN');
    let mobileAlert = $('#mobileAlert');
    let isPass = mobile_Re.test(mobile);
    if(isPass && mobile!=''){
        mobileAlert.text('')
        sendMobileBtn.click();
    }else{
        mobileAlert.text('請填寫正確手機號碼')
    }
})


//email驗證
$('#saveEmailData').click(function(){
    let email = $('#ctl00_Main_EmailTBX').val();
    let sendEmailBtn = $('#ctl00_Main_EmailBTN');
    let isPass = mail_Re.test(email);
    let emailAlert = $('#emailAlert');
    if(isPass && email!=''){
        emailAlert.text('')
        sendEmailBtn.click();
    }else{
        emailAlert.text('請填寫正確Email')
    }
})

//選擇卡別
 $('input[type=radio][name=cardType]').change(function() {
    let cardType = $(this).val();
    let cardTypeLB = document.querySelector('#ctl00_Main_CardTypeTBX')
    cardTypeLB.value = cardType;
    $('.paycard').eq(0).focus()

});

//信用卡 簡易驗證
$('#saveCardData').click(function(){
    let cardTypeVal = $('#ctl00_Main_CardTypeTBX').val();
    let cardNum1 = $('#ctl00_Main_CardNumTBX1').val();
    let cardNum2 = $('#ctl00_Main_CardNumTBX2').val();
    let cardNum3 = $('#ctl00_Main_CardNumTBX3').val();
    let cardNum4 = $('#ctl00_Main_CardNumTBX4').val();
    let exMon = $('#ctl00_Main_MonthTBX').val();
    let exYear = $('#ctl00_Main_YearTBX').val();
    let ccv = $('#ctl00_Main_CardCodeTBX').val();
    let bankName = $('#ctl00_Main_BankNameTBX').val();
    let cardAlert = $('#cardAlert');

    let sendCardBtn = $('#ctl00_Main_CardBTN');

    if(cardTypeVal =='' || cardNum1 =='' || cardNum2 =='' || cardNum3 =='' || cardNum4 =='' || exMon =='' || exYear =='' || ccv =='' || bankName ==''){
        cardAlert.text('請輸入完整信用卡資料')
    }else if(cardNum1.length != 4 || cardNum2.length != 4 || cardNum3.length != 4 || cardNum4.length != 4){
        cardAlert.text('請填寫正確卡號')
    }else if(!number_Re.test(cardNum1) || !number_Re.test(cardNum2) || !number_Re.test(cardNum3) || !number_Re.test(cardNum4)){
        cardAlert.text('請填寫正確卡號')
    }else if(exMon.length != 2 || exYear.length != 2){
        cardAlert.text('請填寫正確到期日')
    }else if(exMon > 12){
        cardAlert.text('請填寫正確到期日')
    }else if(ccv.length != 3){
        cardAlert.text('請填寫正確安全碼')
    }else if(bankName == ''){
        bankName.text('請填寫發卡銀行(ex.國泰世華)')
    }else{
        cardAlert.text('')
        sendCardBtn.click()
    }
    
})

