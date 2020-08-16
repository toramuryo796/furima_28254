document.addEventListener('turbolinks:load', function(){
  
  function commission() {
    const input = document.getElementById("item-price");
    input.addEventListener('input', (e) => {
      // ajaxで返したHTMLの要素を取得
      const showCommission = document.getElementById("show-commission")
      // 出品できてなかったときに記入していた価格を取得
      const completedCommission =  document.getElementById("completed-commission");
      // 入力ごとに表示されている文字を消す
      if (showCommission){
        showCommission.parentNode.removeChild(showCommission)
      }
      // renderで戻ってきた時にすでに記入し終わっている数字を消す
      if (completedCommission){
        completedCommission.parentNode.removeChild(completedCommission)
      }
      const formData = new FormData(document.getElementById("exhibition"));
      const XHR = new XMLHttpRequest();
      // showCommission及びcompletedCommissionの親要素を取得
      const parentCommission = document.getElementById("add-tax-price")
      XHR.open("POST", "/items/commission", true);
      XHR.responseType = "json";
      XHR.send(formData);
      
      XHR.onload = () => {
        const item = XHR.response.item;
        // 記入価格の10%が販売手数料
        const commission = Math.floor(item.price * 0.1) ;
        const HTML = `
        <div id="show-commission" data-id=${item.id}>
        ${commission}円
        </div>`;
        // HTMLに反映させる
        parentCommission.insertAdjacentHTML("afterbegin", HTML);
        
        if(XHR.status != 200) {
          alert(`Error ${XHR.status}: ${XHR.statusText}`);
        } else {
          return null; 
        }
      };
    });
  }  
  window.addEventListener("load", commission);
});