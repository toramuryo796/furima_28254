function new_price () {
  const inputPrice = document.getElementById("item-price");
  inputPrice.addEventListener("input", (e) => {
    // 販売手数料
    const completedCommission =  document.getElementById("completed-commission");
    const commissionPrice = document.getElementById("add-tax-price")
    // 販売利益
    const completedProfit =  document.getElementById("completed-profit");
    const profitPrice = document.getElementById("profit")
    
    const price = inputPrice.value
    const commission = Math.floor(price * 0.1)
    const profit = Math.floor(price - commission)
    commissionPrice.textContent = commission+"円";
    profitPrice.textContent = profit+"円";
  })
}
window.addEventListener("load", new_price);