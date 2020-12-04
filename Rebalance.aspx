<%@ Page Title="阿爾發-投資組合再平衡" Language="vb" AutoEventWireup="false" MasterPageFile="~/MainBack.Master" CodeBehind="Rebalance.aspx.vb" Inherits="Financial_Robots.Rebalance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainStyle" runat="server">
    <style>
    .order-form{
        background: #fff;
        width: 800px;
        margin: 0 auto;
      }
  
      .order-header{
        background: #16b6d2;
        width: 100%;
        height: 50px;
        text-align: center;
        color: #fff;
        font-size: 28px;
      }
  
      .order-message-block
      {
        width: 100%;
      }
  
      .order-item
      {
        display: flex;
      }
  
      .order-head
      {
        width: 30%;
        padding:20px;
      }
      
      .order-text
      {
        width: 70%;
        padding:20px;
      }
  
      .stock-block
      {
        width: 100%;
        padding:20px;
      }
      .stock-table
      {
        width: 100%;
      }
      .stock-table tr
      {
        border-bottom: 1px solid #aaa;
      }
      .stock-table td
      {
        padding: 10px 5px;
      }
      .finish-button
      {
        margin: 0 auto;
        padding-bottom: 30px;
        display: table;
      }
   </style>   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="d-none">
                <asp:Label ID="RebalanceLB" runat="server"></asp:Label>
                <asp:Label ID="DetailLB" runat="server"></asp:Label>
                <asp:Button ID="OrderBTN" runat="server" />
            </div>    
            <section id="rebalance" class="pt-4 pt-xl-0 pb-3">
                <div class="container-fluid">
                  <div class="order-form">
                    <div class="order-header"> 再平衡 </div>
                    <div class="order-message-block">
                      <div class="order-item">
                        <div class="order-head">委託帳號</div>
                        <div class="order-text">{{ main[0] }}</div>
                      </div>
                      <div class="order-item">
                        <div class="order-head">下單日期</div>
                        <div class="order-text">{{ main[1] }}</div>
                      </div>
                      <div class="order-item">
                        <div class="order-head">計畫編號</div>
                        <div class="order-text">{{ main[2] }}</div>
                      </div>
                      <div class="order-item">
                        <div class="order-head">目標名稱</div>
                        <div class="order-text">{{ goalText(main[3]) }}</div>
                      </div>
                      <div class="order-item">
                        <div class="order-head">投資總金額</div>
                        <div class="order-text">US $ {{ main[4] }}</div>
                      </div>
                      <div class="order-item">
                        <div class="order-head">投資組合</div>
                        <div class="order-text">{{ main[5] }}</div>
                      </div>
                    </div>
                    <div class="stock-block">
                      <table class="stock-table">
                        <thead>
                            <tr>
                              <th>交易指示</th>
                              <th>股號</th>
                              <th>投資金額</th>
                              <th>委託價格</th>
                              <th>股數</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="(item , index) in assets">
                              <td>{{ buyAndSell(item[0]) }}</td>
                              <td>{{ item[1] }}</td>
                              <td>US $ {{ item[3] }}</td>
                              <td>US $ {{ item[4] }}</td>
                              <td>{{ item[5] }}</td>
                            </tr>
                        </tbody>
                      </table>
                    </div>
                    <div class="finish-button">
                    <button type="button" class="btn btn-outline-primary py-1 mr-2" @click="clickSubmit">
                      完成下單
                    </button>
                    </div>
                  </div>  
                </div>
              </section>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="OrderBTN" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainJS" runat="server">
    <script src="components/base/script.js?202006010"></script>
    <script src="js/header.js?202006010"></script>
	<script src="js/rebalance.js?202006010"></script>
</asp:Content>
