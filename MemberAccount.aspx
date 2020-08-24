<%@ Page Title="阿爾發-個人資料" Language="vb" AutoEventWireup="false"
    MasterPageFile="~/MainBack.Master" CodeBehind="MemberAccount.aspx.vb"
    Inherits="Financial_Robots.MemberAccount" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainStyle" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <section class="pt-4 pt-xl-0 pb-3">
                <div class="d-none">
                    
                    <!-- 信用卡別 1.visa 2.masterCard 3.Jcb -->
                    <asp:TextBox ID="CardTypeTBX" runat="server" MaxLength="1"></asp:TextBox>
                    <!-- 信用卡確認按鈕 -->
                    <asp:Button ID="CardBTN" runat="server" class="btn btn-primary" Text="確定" />
                    <!-- 手機號碼確認 -->
                    <asp:Button ID="PhoneBTN" runat="server" class="btn btn-primary" Text="確定" />
                    <!-- 戶籍地址確認 -->
                    <asp:Button ID="AddressBTN1" runat="server" class="btn btn-primary" Text="確定" />
                    <!-- 通訊地址確認 -->
                    <asp:Button ID="AddressBTN2" runat="server" class="btn btn-primary" Text="確定" />
                    <!-- Email確認 -->
                    <asp:Button ID="EmailBTN" runat="server" class="btn btn-primary" Text="確定" />
                </div>
                
                <div class="container-fluid">
                    <div class="row row-30">
                        <div class="col-12">
                            <div class="panel admin-panel">
                                <div class="panel-header">
                                    <div class="panel-title">
                                        <a class="text-dark mdi mdi-24px mdi-account-outline" href="#"></a>
                                        個人資料
                                    </div>
                                </div>
                                <div class="panel-body">
                                    <div class="container-fluid">
                                        <div class="row">
                                            <!-- 註冊日期欄位 -->
                                            <div class="col-12 col-md-6 px-0">
                                                <div class="d-flex flex-column flex-sm-row border-bottom">
                                                    <div class="py-2 py-sm-3 text-center bg-200" style="min-width: 8rem;">註冊日期</div>
                                                    <div class="py-3 pl-sm-4 text-center text-sm-left">
                                                        <asp:Label ID="RegDayLB" runat="server"></asp:Label>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- 姓名欄位(不能改) -->
                                            <div class="col-12 col-md-6 px-0">
                                                <div class="d-flex flex-column flex-sm-row align-items-sm-center border-bottom">
                                                    <div class="py-2 py-sm-3 text-center bg-200" style="min-width: 8rem;">姓名</div>
                                                    <div class="py-3 pl-sm-4 text-center text-sm-left flex-grow-1">
                                                        <asp:Label ID="NameLB" runat="server"></asp:Label>
                                                    </div>
                                                    <div class="text-center mb-3 mb-sm-0">
                                                        <div class="modal fade px-0" id="nameModal" tabindex="-1" role="dialog">
                                                            <div class="modal-dialog" role="document">
                                                                <div class="modal-content">
                                                                    <div class="modal-header bg-primary">
                                                                        <h4 class="modal-title flex-grow-1 text-center text-light">修改姓名</h4>
                                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                            <span aria-hidden="true">&times;</span>
                                                                        </button>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <div class="mx-auto" style="max-width: 180px">
                                                                            <asp:TextBox ID="NameTBX" runat="server" MaxLength="20"
                                                                                class="form-control p-3 mb-2" placeholder="請輸入您的姓名" />
                                                                        </div>
                                                                    </div>
                                                                    <div class="modal-footer border-top-0 justify-content-center">
                                                                        <button type="button" class="btn btn-outline-primary" data-dismiss="modal">
                                                                            取消
                                                                        </button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- 帳號欄位 -->
                                            <div class="col-12 col-md-6 px-0">
                                                <div class="d-flex flex-column flex-sm-row border-bottom">
                                                    <div class="py-2 py-sm-3 text-center bg-200" style="min-width: 8rem;">帳號</div>
                                                    <div class="py-3 pl-sm-4 text-center text-sm-left">
                                                        <asp:Label ID="ActLB" runat="server"></asp:Label>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- 密碼欄位 -->
                                            <div class="col-12 col-md-6 px-0">
                                                <div class="d-flex flex-column flex-sm-row align-items-sm-center border-bottom">
                                                    <div class="py-2 py-sm-3 text-center bg-200" style="min-width: 8rem;">密碼</div>
                                                    <div class="py-3 pl-sm-4 text-center text-sm-left flex-grow-1">******</div>
                                                    <div class="text-center mb-3 mb-sm-0">
                                                        <button type="button" class="btn btn-outline-primary py-1 mr-2" data-toggle="modal"
                                                            data-target="#passwordModal">
                                                            修改
                                                        </button>
                                                        <div class="modal fade px-0" id="passwordModal" tabindex="-1" role="dialog">
                                                            <div class="modal-dialog" role="document">
                                                                <div class="modal-content">
                                                                    <div class="modal-header bg-primary">
                                                                        <h4 class="modal-title flex-grow-1 text-center text-light">修改密碼</h4>
                                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                            <span aria-hidden="true">&times;</span>
                                                                        </button>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <div class="mx-auto" style="max-width: 180px">
                                                                            <asp:TextBox ID="PwdTBX" runat="server" MaxLength="20"
                                                                                class="form-control p-3 mb-2" TextMode="Password" placeholder="請輸入重設密碼" />
                                                                            <asp:TextBox ID="NewPwdTBX1" runat="server" MaxLength="20"
                                                                                class="form-control p-3 mb-2" TextMode="Password" placeholder="請輸入新密碼" />
                                                                            <asp:TextBox ID="NewPwdTBX2" runat="server" MaxLength="20"
                                                                                class="form-control p-3" TextMode="Password" placeholder="請再次輸入新密碼" />
                                                                        </div>
                                                                    </div>
                                                                    <div class="modal-footer border-top-0 justify-content-center">
                                                                        <asp:Button ID="PwdBTN" runat="server" class="btn btn-primary" Text="確定" />
                                                                        <button type="button" class="btn btn-outline-primary" data-dismiss="modal">
                                                                            取消
                                                                        </button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- 性別欄位 -->
                                            <div class="col-12 col-md-6 px-0">
                                                <div class="d-flex flex-column flex-sm-row align-items-sm-center border-bottom">
                                                    <div class="py-2 py-sm-3 text-center bg-200" style="min-width: 8rem;">
                                                        性別
                                                    </div>
                                                    <div class="py-3 pl-sm-4 text-center text-sm-left flex-grow-1">
                                                        <asp:Label ID="GenderLB" runat="server"></asp:Label>
                                                    </div>
                                                    <div class="text-center mb-3 mb-sm-0">
                                                        <button type="button" class="btn btn-outline-primary py-1 mr-2" data-toggle="modal" data-target="#genderModal">
                                                            修改
                                                        </button>
                                                        <div class="modal fade px-0" id="genderModal" tabindex="-1" role="dialog">
                                                            <div class="modal-dialog" role="document">
                                                                <div class="modal-content">
                                                                    <div class="modal-header bg-primary">
                                                                        <h4 class="modal-title flex-grow-1 text-center text-light">修改性別</h4>
                                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                            <span aria-hidden="true">&times;</span>
                                                                        </button>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <div class="mx-auto" style="max-width: 180px">
                                                                            <div class="custom-control custom-radio custom-radio-info d-inline-block mr-3">
                                                                                <asp:RadioButton ID="GenderRBTN1" runat="server" GroupName="gender" />
                                                                                <label class="custom-control-label" for="ctl00_Main_GenderRBTN1">
                                                                                    男性
                                                                                </label>
                                                                            </div>
                                                                            <div class="custom-control custom-radio custom-radio-info d-inline-block">
                                                                                <asp:RadioButton ID="GenderRBTN2" runat="server" GroupName="gender" />
                                                                                <label class="custom-control-label" for="ctl00_Main_GenderRBTN2">
                                                                                    女性
                                                                                </label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="modal-footer border-top-0 justify-content-center">
                                                                        <asp:Button ID="GenderBTN" runat="server" class="btn btn-primary" Text="確定" />
                                                                        <button type="button" class="btn btn-outline-primary" data-dismiss="modal">
                                                                            取消
                                                                        </button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- email欄位 -->
                                            <div class="col-12 col-md-6 px-0">
                                                <div class="d-flex flex-column flex-sm-row align-items-sm-center border-bottom">
                                                    <div class="py-2 py-sm-3 text-center bg-200" style="min-width: 8rem;">
                                                        Email
                                                    </div>
                                                    <div class="py-3 pl-sm-4 text-center text-sm-left flex-grow-1">
                                                        <!-- <span id="email"></span> -->
                                                        <!-- email資料 -->
                                                        <asp:Label ID="EmailLB" runat="server"></asp:Label>
                                                    </div>
                                                    <div class="text-center mb-3 mb-sm-0">
                                                        <button type="button" class="btn btn-outline-primary py-1 mr-2" data-toggle="modal" data-target="#emailModal">
                                                            修改
                                                        </button>
                                                        <div class="modal fade px-0" id="emailModal" tabindex="-1" role="dialog">
                                                            <div class="modal-dialog" role="document">
                                                                <div class="modal-content">
                                                                    <div class="modal-header bg-primary">
                                                                        <h4 class="modal-title flex-grow-1 text-center text-light">修改Email</h4>
                                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                            <span aria-hidden="true">&times;</span>
                                                                        </button>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <div class="mx-auto" style="max-width: 180px">
                                                                            <asp:TextBox ID="EmailTBX" runat="server" MaxLength="50" placeholder="請輸入新的Email" class="form-control p-3 mb-2"></asp:TextBox>
                                                                        </div>
                                                                        <h4 class="text-secondary" id="emailAlert"></h4>
                                                                    </div>
                                                                    <div class="modal-footer border-top-0 justify-content-center">
                                                                        <button type="button" class="btn btn-primary" id="saveEmailData">確認</button>
                                                                        <button type="button" class="btn btn-outline-primary" data-dismiss="modal">
                                                                            取消
                                                                        </button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- 戶籍地欄位 -->
                                            <div class="col-12 col-md-6 px-0">
                                                <div class="d-flex flex-column flex-sm-row align-items-sm-center border-bottom">
                                                    <div class="py-2 py-sm-3 text-center bg-200" style="min-width: 8rem;">
                                                        戶籍地址
                                                    </div>
                                                    <div class="py-3 pl-sm-4 text-center text-sm-left flex-grow-1">
                                                        <!-- 戶籍地址： -->
                                                        <asp:Label ID="AddressLB1" runat="server" class="text-center text-sm-left flex-grow-1"></asp:Label>
                                                        <!-- <div class="text-center text-sm-left flex-grow-1">******</div> -->
                                                    </div>
                                                    <div class="text-center mb-3 mb-sm-0">
                                                        <button type="button" class="btn btn-outline-primary py-1 mr-2" data-toggle="modal" data-target="#reAddressModal">
                                                            修改
                                                        </button>
                                                        <div class="modal fade px-0" id="reAddressModal" tabindex="-1" role="dialog">
                                                            <div class="modal-dialog" role="document">
                                                                <div class="modal-content">
                                                                    <div class="modal-header bg-primary">
                                                                        <h4 class="modal-title flex-grow-1 text-center text-light">修改戶籍地址</h4>
                                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                            <span aria-hidden="true">&times;</span>
                                                                        </button>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <div class="mx-auto" style="width: 80%">
                                                                            <asp:TextBox ID="AddressTBX1" runat="server" MaxLength="100" placeholder="請輸入戶籍地址" class="form-control p-3 mb-2"></asp:TextBox>
                                                                        </div>
                                                                        <h4 class="text-secondary" id="reAddAlert"></h4>
                                                                    </div>
                                                                    <div class="modal-footer border-top-0 justify-content-center">
                                                                        <button type="button" class="btn btn-primary" id="reAddressData">確認</button>
                                                                        <button type="button" class="btn btn-outline-primary" data-dismiss="modal">
                                                                            取消
                                                                        </button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- 通訊地欄位 -->
                                            <div class="col-12 col-md-6 px-0">
                                                <div class="d-flex flex-column flex-sm-row align-items-sm-center border-bottom">
                                                    <div class="py-2 py-sm-3 text-center bg-200" style="min-width: 8rem;">
                                                        通訊地址
                                                    </div>
                                                    <div class="py-3 pl-sm-4 text-center text-sm-left flex-grow-1">
                                                        <!-- 通訊地址： -->
                                                        <asp:Label ID="AddressLB2" runat="server" class="text-center text-sm-left flex-grow-1"></asp:Label>
                                                        <!-- <div class="text-center text-sm-left flex-grow-1">******</div> -->
                                                    </div>
                                                    <div class="text-center mb-3 mb-sm-0">
                                                        <button type="button" class="btn btn-outline-primary py-1 mr-2" data-toggle="modal" data-target="#maAddressModal">
                                                            修改
                                                        </button>
                                                        <div class="modal fade px-0" id="maAddressModal" tabindex="-1" role="dialog">
                                                            <div class="modal-dialog" role="document">
                                                                <div class="modal-content">
                                                                    <div class="modal-header bg-primary">
                                                                        <h4 class="modal-title flex-grow-1 text-center text-light">修改戶籍地址</h4>
                                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                            <span aria-hidden="true">&times;</span>
                                                                        </button>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <div class="mx-auto" style="width: 80%">
                                                                            <asp:TextBox ID="AddressTBX2" runat="server" MaxLength="100" placeholder="請輸入通訊地址" class="form-control p-3 mb-2"></asp:TextBox>
                                                                        </div>
                                                                        <h4 class="text-secondary" id="maAddAlert"></h4>
                                                                    </div>
                                                                    <div class="modal-footer border-top-0 justify-content-center">
                                                                        <button type="button" class="btn btn-primary" id="maAddressData">確認</button>
                                                                        <button type="button" class="btn btn-outline-primary" data-dismiss="modal">
                                                                            取消
                                                                        </button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- 手機號碼欄位 -->
                                            <div class="col-12 col-md-6 px-0">
                                                <div class="d-flex flex-column flex-sm-row align-items-sm-center border-bottom">
                                                    <div class="py-2 py-sm-3 text-center bg-200" style="min-width: 8rem;">
                                                        手機號碼
                                                    </div>
                                                    <div class="py-3 pl-sm-4 text-center text-sm-left flex-grow-1">
                                                        <!-- 聯絡電話： -->
                                                        <asp:Label ID="PhoneLB" runat="server"></asp:Label>
                                                    </div>
                                                    <div class="text-center mb-3 mb-sm-0">
                                                        <button type="button" class="btn btn-outline-primary py-1 mr-2" data-toggle="modal" data-target="#mobileModal">
                                                            修改
                                                        </button>
                                                        <div class="modal fade px-0" id="mobileModal" tabindex="-1" role="dialog">
                                                            <div class="modal-dialog" role="document">
                                                                <div class="modal-content">
                                                                    <div class="modal-header bg-primary">
                                                                        <h4 class="modal-title flex-grow-1 text-center text-light">修改手機號碼</h4>
                                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                            <span aria-hidden="true">&times;</span>
                                                                        </button>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <div class="mx-auto" style="max-width: 180px">
                                                                            <asp:TextBox ID="PhoneTBX" runat="server" MaxLength="10" placeholder="請輸入新的手機號碼" class="form-control p-3 mb-2"></asp:TextBox>
                                                                        </div>
                                                                        <h4 class="text-secondary" id="mobileAlert"></h4>
                                                                    </div>
                                                                    <div class="modal-footer border-top-0 justify-content-center">
                                                                        <button type="button" class="btn btn-primary" id="saveMobileData">確認</button>
                                                                        <button type="button" class="btn btn-outline-primary" data-dismiss="modal">
                                                                            取消
                                                                        </button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- 信用卡欄位 -->
                                            <div class="col-12 col-md-6 px-0">
                                                <div class="d-flex flex-column flex-sm-row align-items-sm-center border-bottom">
                                                    <div class="py-2 py-sm-3 text-center bg-200" style="min-width: 8rem;">
                                                        信用卡資訊
                                                    </div>
                                                    <div class="py-3 pl-sm-4 text-center text-sm-left flex-grow-1" id="paycardNumShow">
                                                        **** **** **** ****
                                                    </div>
                                                    <div class="text-center mb-3 mb-sm-0">
                                                        <button type="button" class="btn btn-outline-primary py-1 mr-2" data-toggle="modal" data-target="#payCardModal">
                                                            修改
                                                        </button>
                                                        <div class="modal fade px-0" id="payCardModal" tabindex="-1" role="dialog">
                                                            <div class="modal-dialog" role="document">
                                                                <div class="modal-content">
                                                                    <div class="modal-header bg-primary">
                                                                        <h4 class="modal-title flex-grow-1 text-center text-light">修改信用卡資訊</h4>
                                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                            <span aria-hidden="true">&times;</span>
                                                                        </button>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <div class="mx-auto" style="width:100%">
                                                                        
                                                                            <div class="paycard-set mb-3">
                                                                                <!-- 信用卡別 -->
                                                                                <h5 class="pb-2 text-primary">信用卡卡別</h5>
                                                                                <div class="mx-auto d-flex justify-content-start flex-wrap" style="width: 70%">
                                                                                    <div class="custom-control custom-radio custom-radio-info d-inline-block col-12 col-sm-4 px-1">
                                                                                        <input type="radio" id="cardTypeVISA" class="custom-control-input" name="cardType" value="1">
                                                                                        <label class="custom-control-label" for="cardTypeVISA">
                                                                                            VISA
                                                                                        </label>
                                                                                    </div>
                                                                                    <div class="custom-control custom-radio custom-radio-info d-inline-block col-12 col-sm-4 px-1">
                                                                                        <input type="radio" id="cardTypeMC" class="custom-control-input" name="cardType" value="2">
                                                                                        <label class="custom-control-label" for="cardTypeMC">
                                                                                            MasterCard
                                                                                        </label>
                                                                                    </div>
                                                                                    <div class="custom-control custom-radio custom-radio-info d-inline-block col-12 col-sm-4 px-1">
                                                                                        <input type="radio" id="cardTypeJCB" class="custom-control-input" name="cardType" value="3">
                                                                                        <label class="custom-control-label" for="cardTypeJCB">
                                                                                            JCB
                                                                                        </label>
                                                                                    </div>
                                                                                    
                                                                                </div>
                                                                                <hr style="opacity:.3">
                                                                            </div>
                                                                            
                                                                            <!-- 信用卡卡號 -->
                                                                            <asp:Label ID="CardLB" runat="server" class="d-none"></asp:Label>
                                                                            <div class="paycard-set mb-3">
                                                                                <h5 class="pb-2 text-primary">信用卡卡號</h5>
                                                                                <div class="d-flex">
                                                                                    <!-- 信用卡號 -->
                                                                                    <asp:TextBox ID="CardNumTBX1" runat="server" MaxLength="4" class="form-control mb-2 px-0 text-center paycard" inputmode="numeric" type="number"></asp:TextBox>
                                                                                    <asp:TextBox ID="CardNumTBX2" runat="server" MaxLength="4" class="form-control mb-2 px-0 text-center paycard" inputmode="numeric"></asp:TextBox>
                                                                                    <asp:TextBox ID="CardNumTBX3" runat="server" MaxLength="4" class="form-control mb-2 px-0 text-center paycard" inputmode="numeric"></asp:TextBox>
                                                                                    <asp:TextBox ID="CardNumTBX4" runat="server" MaxLength="4" class="form-control mb-2 px-0 text-center paycard" inputmode="numeric"></asp:TextBox>
                                                                                </div>
                                                                                <hr style="opacity:.3">
                                                                            </div>
                                                                            <div class="paycard-set mb-3 w-100">
                                                                                <h5 class="pb-2 text-primary">信用卡有效 月 / 年</h5>
                                                                                <!-- 有效月/年 -->
                                                                                <div class="d-flex col-6 px-0 mx-auto">
                                                                                    <asp:TextBox ID="MonthTBX" runat="server" MinLength="2" MaxLength="2" class="form-control p-3 mb-2 mr-2 paycard text-center px-0" placeholder="00" inputmode="numeric"></asp:TextBox>
                                                                                    <asp:TextBox ID="YearTBX" runat="server" MinLength="2" MaxLength="2" class="form-control p-3 mb-2 paycard text-center px-0" placeholder="00" inputmode="numeric"></asp:TextBox>
                                                                                </div>
                                                                                <hr style="opacity:.3">
                                                                            </div>
                                                                            <div class="d-flex flex-wrap w-100 paycard-set">
                                                                                <div class="col-4 px-0 pr-2">
                                                                                    <h5 class="pb-2 text-primary">安全碼</h5>
                                                                                    <!-- 安全碼 -->
                                                                                    <asp:TextBox ID="CardCodeTBX" runat="server" MaxLength="3" class="form-control p-3 mr-2 text-center paycard" inputmode="numeric"></asp:TextBox>
                                                                                </div>
                                                                                <div class="col-8 px-0">
                                                                                    <h5 class="pb-2 text-primary">發卡銀行</h5>
                                                                                     <!-- 發卡銀行 -->
                                                                                    <asp:TextBox ID="BankNameTBX" runat="server" MaxLength="20" class="form-control p-3 text-center paycard"></asp:TextBox>
                                                                                </div>
                                                                                <hr style="opacity:.3">
                                                                            </div>
                                                                            <h4 class="text-secondary" id="cardAlert"></h4>
                                                                        </div>
                                                                    </div>
                                                                    <div class="modal-footer border-top-0 justify-content-center">
                                                                        <button type="button" class="btn btn-primary" id="saveCardData">確認</button>
                                                                        <button type="button" class="btn btn-outline-primary" data-dismiss="modal">
                                                                            取消
                                                                        </button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
            </section>
            <div class="d-none">
                <span>距離上次登入</span>
                <asp:Label ID="TimeLB1" class="h3" runat="server"></asp:Label>天
        <asp:Label ID="TimeLB2" class="h3" runat="server"></asp:Label>時
        <asp:Label ID="TimeLB3" class="h3" runat="server"></asp:Label>分
        <asp:Label ID="TimeLB4" class="h3" runat="server"></asp:Label>秒
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="PwdBTN" />
            <asp:PostBackTrigger ControlID="PhoneBTN" />
            <asp:PostBackTrigger ControlID="EmailBTN" />
            <asp:PostBackTrigger ControlID="AddressBTN1" />
            <asp:PostBackTrigger ControlID="AddressBTN2" />
            <asp:PostBackTrigger ControlID="CardBTN" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainJS" runat="server">
    <script src="components/base/script.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/vue@2.6.10/dist/vue.js"></script>
    <script src="js/header.js"></script>
    <script src="js/memberAccount.js"></script>


</asp:Content>
