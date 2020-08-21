function update_price () {
  const inputPrice = document.getElementById("edit-item-price");
  inputPrice.addEventListener("input", (e) => {
    // 販売手数料
    const completedCommission =  document.getElementById("add-commission");
    const commissionPrice = document.getElementById("add-tax-price")
    // 販売利益
    const completedProfit =  document.getElementById("add-profit");
    const profitPrice = document.getElementById("profit");
    // 入力ごとに表示されている文字を消す
    // if (completedCommission){
    //   completedCommission.textContent("円")
    // }
    const price = inputPrice.value
    const commission = Math.floor(price * 0.1)
    const profit = price - commission 
    commissionPrice.textContent = commission+"円";
    profitPrice.textContent = profit +"円";
  })
}
window.addEventListener("load", update_price);