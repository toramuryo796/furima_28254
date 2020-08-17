function update_price () {
  const inputPrice = document.getElementById("edit-item-price");
  inputPrice.addEventListener("input", (e) => {
    const completedCommission =  document.getElementById("add-commission");
    const commissionPrice = document.getElementById("add-tax-price")
    // 入力ごとに表示されている文字を消す
    if (completedCommission){
      completedCommission.textContent("円")
    }
    const price = inputPrice.value
    const commission = price * 0.1
    commissionPrice.textContent = commission+"円";
  })
}
window.addEventListener("load", update_price);