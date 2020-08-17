function update_price () {
  const inputPrice = document.getElementById("edit-item-price");
  inputPrice.addEventListener("input", (e) => {
    const completedProfit =  document.getElementById("add-profit");
    const profitPrice = document.getElementById("profit");
    // 入力ごとに表示されている文字を消す
    if (completedProfit){
      completedProfit.parentNode.removeChild(completedProfit)
    }
    const price = inputPrice.value
    const commission = price * 0.1
    const profit = price - commission 
    profitPrice.textContent = profit +"円";
  })
}
window.addEventListener("load", update_price);