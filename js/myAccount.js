let myAccount = new Vue({
    el:"#myAccount",
    data: {
        email:'',
        reAddress:'',
        maAddress:'',
        phone:'',
        cardType: null,
        cardNum: ['','','',''],// 避免抱錯先放空值
        cardEx: ['',''],
        cardCCV:'',
        cardBank:'',

        cardCheckData1: 0, //type
        cardCheckData2: 0, //number
        cardCheckData3: 0, //expire
        cardCheckData4: 0, //ccv
        cardCheckData5: 0, //bank


        index:0,
        exIndex:0,

        emailNotPass: true,
        reAddressNotPass: true,
        maAddressNotPass: true,
        phoneNotPass: true,
        cardNotPass:true,
        
        regex: {
            email:/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z]+$/,
            phone:/^09[0-9]{8}$/,
            onlyNumber:/^[0-9]*$/,
        },
        alert: {
            email:'',
            reAddress:'',
            maAddress:'',
            phone:'',
            card: {
                type:'',
                number:'',
                expire:'',
                ccv:'',
                bank:''
            }
        }
    },
    methods: {
        preventEnter (e) {
            e.preventDefault();// 防止預設 enter 會送出信用卡欄位問題
        },
        emailChange () {
            $('#ctl00_Main_EmailTBX').val(this.email);
            if(!this.regex.email.test(this.email)) {
                this.alert.email = '電子信箱格式有誤';
                this.emailNotPass = true;
            } else {
                this.alert.email = '';
                this.emailNotPass = false;
            }
        },
        reAddressChange () {
            $('#ctl00_Main_AddressTBX1').val(this.reAddress);
            if(this.reAddress == '' || this.reAddress.length < 6) {
                this.alert.reAddress = '戶籍地址不得為空或者過短';
                this.reAddressNotPass = true;
            } else {
                this.alert.reAddress = '';
                this.reAddressNotPass = false;
            }
        },
        maAddressChange () {
            $('#ctl00_Main_AddressTBX2').val(this.maAddress);
            if(this.maAddress == '' || this.maAddress.length < 6) {
                this.alert.maAddress = '通訊地址不得為空或者過短';
                this.maAddressNotPass = true;
            } else {
                this.alert.maAddress = '';
                this.maAddressNotPass = false;
            }
        },
        phoneChange () {
            $('#ctl00_Main_PhoneTBX').val(this.phone);
            if(!this.regex.phone.test(this.phone)) {
                this.alert.phone = '電話號碼格式有誤';
                this.phoneNotPass = true;
            } else {
                this.alert.phone = '';
                this.phoneNotPass = false;
            }
        },
        cardTypeChange () {
           $('#ctl00_Main_CardTypeTBX').val(this.cardType);
           if(this.cardType !== null) {
                this.cardCheckData1 = 1;
                this.alert.card.type = '';
           } else {
                this.cardCheckData1 = 0;
                this.alert.card.type = '請選擇卡片類別';
           }
        },
        cardNumChange () {
            $('#ctl00_Main_CardNumTBX1').val(this.cardNum[0]);
            $('#ctl00_Main_CardNumTBX2').val(this.cardNum[1]);
            $('#ctl00_Main_CardNumTBX3').val(this.cardNum[2]);
            $('#ctl00_Main_CardNumTBX4').val(this.cardNum[3]);
            
            if( this.cardNum[this.index].length < 4 || !this.regex.onlyNumber.test(this.cardNum[this.index])) {
                this.alert.card.number = '卡號格式有誤';
                this.cardCheckData2 = 0;
            } else {
                this.alert.card.number = '';
                this.$refs.cardEx[0].focus();
                this.cardCheckData2 = 1;
            }
        },
        cardExChange () {   
            $('#ctl00_Main_MonthTBX').val(this.cardEx[0]);
            $('#ctl00_Main_YearTBX').val(this.cardEx[1]);

            if(this.cardEx[this.exIndex].length < 2 || !this.regex.onlyNumber.test(this.cardEx[this.exIndex])) {
                this.alert.card.expire = '有效日期格式有誤';
                this.cardCheckData3 = 0;
            } else {
                this.alert.card.expire = '';
                this.$refs.cardCCV.focus();
                this.cardCheckData3 = 1;
            }
        },
        cardCCVchange () {
            $('#ctl00_Main_CardCodeTBX').val(this.cardCCV);
            if(this.cardCCV.length < 3 || !this.regex.onlyNumber.test(this.cardCCV)) {
                this.alert.card.ccv = '安全碼格式有誤';
                this.cardCheckData4 = 0;
            } else {
                this.alert.card.ccv = '';
                this.$refs.cardBank.focus();
                this.cardCheckData4 = 1;

            }
        },
        cardBankChange () {
            $('#ctl00_Main_BankNameTBX').val(this.cardBank);
            if(this.cardBank === '') {
                this.alert.card.bank = '發卡銀行不得為空';
                this.cardCheckData5 = 0;
            } else {
                this.alert.card.bank = '';
                this.cardCheckData5 = 1;
            }
        },
        cardCheckChange () {
            // 判斷全部的信用卡格式正確
            if(this.cardCheckData1 === 1 && this.cardCheckData2 === 1 && this.cardCheckData3 === 1 && this.cardCheckData4 === 1 && this.cardCheckData5 === 1) {
                this.cardNotPass = false;
            } else {
                this.cardNotPass = true;
            }
        },
        saveEmail () {
            if(!this.emailNotPass || this.email != '') {
                $('#ctl00_Main_EmailBTN').click();
            }
        },
        saveReAddress () {
            if(!this.reAddressNotPass || this.reAddress != '') {
                $('#ctl00_Main_AddressBTN1').click();
            }
        },
        saveMaAddress () {
            if(!this.maAddressNotPass || this.reAddress != '') {
                $('#ctl00_Main_AddressBTN2').click();
            }
        },
        savePhone () {
            if(!this.phoneNotPass || this.phone != '') {
                $('#ctl00_Main_PhoneBTN').click();
            }
        },
        saveCard () {

        },
        cancel () {
            let dataArr = ['email', 'reAddress', 'maAddress', 'phone']
            dataArr.forEach((e) => {
                this.alert[e] = '';
                this[e] = '';
            })
        }
    },
    watch: {
        email () {
            this.emailChange ();
        },
        reAddress () {
            this.reAddressChange ();
        },
        maAddress () {
            this.maAddressChange ();
        },
        phone () {
            this.phoneChange ();
        },
        cardNum () {
            this.cardCheckChange ();
            this.cardTypeChange ();
            if(this.cardNum[this.index].length === 4 && this.index < 3) {
                this.$refs.cardNum[this.index+1].focus();
            } else if (this.cardNum[this.index].length < 4) {
                this.phoneNotPass = true;
            }
            
        },
        cardEx () {
            if(this.cardEx[0].length === 2 ) {
                this.$refs.cardEx[1].focus();
                this.cardTypeChange ();
                this.cardCheckChange ();
            }
        },
        cardCCV () {
            this.cardTypeChange ();
            this.cardCCVchange ();
            this.cardCheckChange ();
        },
        cardBank () {
            this.cardTypeChange ();
            this.cardBankChange ();
            this.cardCheckChange ();
        },
        cardType () {
            this.cardTypeChange ();
            this.cardCheckChange ();
        },
        cardCheckData2 () {
            this.cardCheckChange ();
        }
    },
})