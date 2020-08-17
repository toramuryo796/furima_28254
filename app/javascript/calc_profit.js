function profit() {
  const input = document.getElementById("item-price");
  input.addEventListener('input', (e) => {
    // ajaxで返したHTMLの要素を取得
    const showProfit = document.getElementById("show-profit")
    // 出品できてなかったときに記入していた価格を取得
    const completedProfit =  document.getElementById("completed-profit");
    // 入力ごとに表示されている文字を消す
    if (showProfit){
      showProfit.parentNode.removeChild(showProfit)
    }
    // renderで戻ってきた時にすでに記入し終わっている数字を消す
    if (completedProfit){
      completedProfit.parentNode.removeChild(completedProfit)
    }
    const formData = new FormData(document.getElementById("exhibition"));
    const XHR = new XMLHttpRequest();
    // showCommission及びcompletedCommissionの親要素を取得
    const parentProfit= document.getElementById("profit")
    XHR.open("POST", "/items/profit", true);
    XHR.responseType = "json";
    XHR.send(formData);
    
    XHR.onload = () => {
      const item = XHR.response.item;
      const price = item.price
      // 販売手数料
      const commission = Math.floor(price*0.1)
      // 販売利益
      const profit = price - commission ;
      const HTML = `
      <div id="show-profit" data-id=${item.id}>
      ${profit}円
      </div>`;
      // HTMLに反映させる
      parentProfit.insertAdjacentHTML("afterbegin", HTML);
      
      if(XHR.status != 200) {
        alert(`Error ${XHR.status}: ${XHR.statusText}`);
      } else {
        return null; 
      }
    };
  });
}  
window.addEventListener("load", profit);