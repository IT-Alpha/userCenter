
let genderBTN1 = document.querySelector('#ctl00_Main_GenderRBTN1');
let genderBTN2 = document.querySelector('#ctl00_Main_GenderRBTN2');
let email = document.querySelector('#ctl00_Main_ActLB');

genderBTN1.classList.add('custom-control-input')
genderBTN2.classList.add('custom-control-input')
// document.querySelector('#email').textContent = email.textContent;

let mobile_Re = /^09[0-9]{8}$/;
let number_Re = /^[0-9]*$/;
let mail_Re = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z]+$/;
let paycardNumIsNone = document.querySelector('#ctl00_Main_CardLB').textContent;

if(paycardNumIsNone == 'None'){
    document.querySelector('#paycardNumShow').textContent = '未填寫';
}

//欄位自動focus下一個
$(".paycard").keyup(function () {
    if (this.value.length == this.maxLength) {
        let $next = $(this).next('.paycard');
        if ($next.length ){
            $(this).next('.paycard').focus();
        }else if($next.length == 0){
            $(this).closest('.paycard-set').next().find('.paycard').eq(0).focus();
        }else{
            $(this).blur();
        }
    }
});

//戶籍地址驗證
$('#reAddressData').click(function(){
    reAddTest();
})
$('#ctl00_Main_AddressTBX1').focus(function(){
    $(this).keypress(function(event){
        if(event.keyCode == 13){
            reAddTest();
        }
    })
})

//通訊地址驗證
$('#maAddressData').click(function(){
    maAddTest();
})
$('#ctl00_Main_AddressTBX2').focus(function(){
    $(this).keypress(function(event){
        if(event.keyCode == 13){
            maAddTest()
        }
    })
})

//手機驗證
$('#saveMobileData').click(function(){
    mobileTest();
})
$('#ctl00_Main_PhoneTBX').focus(function(){
    $(this).keypress(function(event){
        if(event.keyCode == 13){
            mobileTest();
        }
    })
})

//email驗證
$('#saveEmailData').click(function(){
    emailTest();
})
//修正後端點擊enter會跑去檢測信用卡問題 
$('#ctl00_Main_EmailTBX').focus(function(){
    $(this).keypress(function(event){
        emailTest();
    })
})

$('.paycard').focus(function(){
    $(this).keypress(function(event){
        if(event.keyCode == 13){
            payCardTest();
        }
    })
})
$('.pwd').focus(function(){
    $(this).keypress(function(event){
        if(event.keyCode == 13){
            document.querySelector('#ctl00_Main_PwdBTN').click();
            event.preventDefault();
            return false;
        }
    })
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
    payCardTest();
})
function maAddTest(){
    let maAddress = $('#ctl00_Main_AddressTBX2').val();
    let sendMaAddBtn = $('#ctl00_Main_AddressBTN2');
    let maAddAlert = $('#maAddAlert');
    if(maAddress!=''){
        maAddAlert.text('');
        sendMaAddBtn.click();
        event.preventDefault();
        return false;
    }else{
        maAddAlert.text('請填寫通訊地址')
    }
        event.preventDefault();
        return false;
}

function reAddTest(){
    let reAddress = $('#ctl00_Main_AddressTBX1').val();
    let sendReAddBtn = $('#ctl00_Main_AddressBTN1');
    let reAddAlert = $('#reAddAlert');
    if(reAddress!=''){
        reAddAlert.text('');
        sendReAddBtn.click();
        event.preventDefault();
        return false;
    }else{
        reAddAlert.text('請填寫戶籍地址')
        event.preventDefault();
        return false;
    }
}

function emailTest(){
    let email = $('#ctl00_Main_EmailTBX').val();
    let sendEmailBtn = $('#ctl00_Main_EmailBTN');
    let isPass = mail_Re.test(email);
    let emailAlert = $('#emailAlert');

    // console.log('123')
    if(isPass && email!=''){
        emailAlert.text('')
        sendEmailBtn.click();
        event.preventDefault();
        return false;
    }else{
        emailAlert.text('請填寫正確Email')
        event.preventDefault();
        return false;
    }
}

function mobileTest(){
    let mobile = $('#ctl00_Main_PhoneTBX').val();
    let sendMobileBtn = $('#ctl00_Main_PhoneBTN');
    let mobileAlert = $('#mobileAlert');
    let isPass = mobile_Re.test(mobile);
    if(isPass && mobile!=''){
        mobileAlert.text('')
        sendMobileBtn.click();
        event.preventDefault();
        return false;
    }else{
        mobileAlert.text('請填寫正確手機號碼');
        event.preventDefault();
        return false;
    }
}
function payCardTest(){
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
        event.preventDefault();
        return false;
    }else if(cardNum1.length != 4 || cardNum2.length != 4 || cardNum3.length != 4 || cardNum4.length != 4){
        cardAlert.text('請填寫正確卡號')
        event.preventDefault();
        return false;
    }else if(!number_Re.test(cardNum1) || !number_Re.test(cardNum2) || !number_Re.test(cardNum3) || !number_Re.test(cardNum4)){
        cardAlert.text('請填寫正確卡號')
        event.preventDefault();
        return false;
    }else if(exMon.length != 2 || exYear.length != 2){
        cardAlert.text('請填寫正確到期日')
        event.preventDefault();
        return false;
    }else if(exMon > 12){
        cardAlert.text('請填寫正確到期日')
        event.preventDefault();
        return false;
    }else if(ccv.length != 3){
        cardAlert.text('請填寫正確安全碼')
        event.preventDefault();
        return false;
    }else if(bankName == ''){
        bankName.text('請填寫發卡銀行(ex.國泰世華)')
        event.preventDefault();
        return false;
    }else{
        cardAlert.text('')
        sendCardBtn.click()
        event.preventDefault();
        return false;
    }
}

