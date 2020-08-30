function preview () {
  const imagePreview = document.getElementById("img-preview");  // 追加した写真が表示される場所
  // const itemImage = document.getElementById("item-image");  // 写真選択のボタン
  const addBtnPlace = document.getElementById("click-upload");  // 「写真を追加」テキストの置き場所
  const addImageBtn = document.getElementById("item-image");    //写真選択のボタン
  let addExistBtn;
  let imageNum;
  
  // 出品時の処理
  const createHTML = (blob) => {
    let imageTexts = document.querySelectorAll(".add-text")
    imageTexts.forEach(function (btn){
      btn.innerHTML = "<p>写真を変更</p>"
    });
    // 削除ボタンのクラスにopenを追加
    let deleteBtns = document.querySelectorAll(".hidden-delete-image") 
    deleteBtns.forEach(function(deleteBtn){
      deleteBtn.setAttribute("class", "open-delete-image")
    });
    // 削除ボタンを表示させる
    let deleteSigns = document.querySelectorAll(".open-delete-image")
    deleteSigns.forEach(function(deleteSign){
      deleteSign.setAttribute("style", "display: block;")
    })
    
    //出品時の選択ボタンのId,classを変更する
    let addBtn = document.getElementById("item-image") 
    // 元のclass, idを削除
    addBtn.removeAttribute("class")
    addBtn.removeAttribute("id")
    addBtn.className = "exist-item-image"
    addBtn.id = "exist-item-image"
    
    // 選択された画像及びボタンがいくつあるか
    // let imageElementNum = document.querySelectorAll('.exist-item-image').length  //選択済みのボタン数
    imageNum = document.querySelectorAll('.show-item-image').length //選択済みの写真数
    console.log(imageNum)
    // console.log(imageElementNum)
    // 写真を入れるdiv及び追加写真を作成
    const imageElement = `
    <div id="addImageElement">
      <img src=${blob} class="exist-image show-item-image" data-num="${imageNum+1}">
    </div>` 
    // 追加ボタンのアナウンス及び追加ボタンを作成
    const addImageTextBtn = `
    <div class="guide-box">
      <div class="image-text-box">
        <p id="add-text" class="add-text">
          写真を追加
        </p>
        <a href="#" class="hidden-delete-image" data-num="${imageNum+1}">
          /削除         
       </a>
      </div>
      <input id="item-image" class="item-image" data-num="${imageNum+2}" name="item[images][]" type="file">
    </div>`
    console.log(imageNum)
    // 画像を表示
    imagePreview.insertAdjacentHTML("beforeend",  imageElement)
    // 追加ボタンを表示
    addBtnPlace.insertAdjacentHTML("beforeend", addImageTextBtn)

    // 画像変更の際
    addExistBtn = document.querySelectorAll(".exist-item-image")
    addExistBtn.forEach(function(btn){
      btn.addEventListener("change", (e) => {
        const id_num = btn.dataset.num; // 選択ボタンのdata-numの数字
        const file = e.target.files[0];
        const imageUrl = window.URL.createObjectURL(file);
        editHTML(imageUrl, id_num);
      });
    });

    // 追加HTMLでも出品時の発火させる
    const addImage = document.getElementById("item-image")
    addImage.addEventListener("change", (e) => {
      if (addImage.id === "item-image" ){
        file = e.target.files[0];
        blob = window.URL.createObjectURL(file);
        createHTML(blob);
      }
    });

    // 写真の削除
    const deleteButtons = document.querySelectorAll(".open-delete-image")
    debugger
    deleteButtons.forEach(function(btn){
      debugger
      btn.addEventListener("click", (e) => {
        debugger
        let btnNumber = btn.dataset.num     //削除ボタンの数字
        debugger
        deleteImage(btnNumber)
      })
    });
  } 
  // 出品時処理終わり

  // 出品時 
  // 写真を選択したら,createHTMLが起動する
  addImageBtn.addEventListener("change", (e) =>{
    if ( addImageBtn.id === "item-image" ){
      const file = e.target.files[0];
      const imageUrl = window.URL.createObjectURL(file);
      createHTML(imageUrl);
    }
  });
  
  //============写真変更処理=====================================================================================
  const existImagePreview = document.getElementById("exist-image-preview");     //出品時の写真を入れる箇所を取得
  
  //画像変更時の処理
  const editHTML = (blob, id_num) => {
    // let count = document.querySelectorAll(".item-image").length // 写真数
    let existImages = document.querySelectorAll(".exist-image")  //既にある写真を取得
    // すでにあるデータを削除
    existImages.forEach(function(image){
      // 表示されている写真から選択された番号のものを指定
      if (image.dataset.num === id_num){
        const imageElement = image.parentNode  //変更する写真の置き場所を取得
        image.remove();
        const blobImage = `<img src="${blob}" class="exist-image show-item-image" data-num="${id_num}">`  // 追加する写真を取得
        imageElement.insertAdjacentHTML("beforeend", blobImage)
        
        let addExistBtn = document.querySelectorAll(".exist-item-image")
        addExistBtn.forEach(function(btn){
          btn.addEventListener("change", (e) => {
            const id_num = btn.dataset.num; // 選択ボタンのdata-numの数字
            console.log(id_num)
            const file = e.target.files[0];
            const imageUrl = window.URL.createObjectURL(file);
            editHTML(imageUrl, id_num);
          });
        });
      }
    });
  }
  
  let btns = document.querySelectorAll(".exist-item-image")                     // 画面上の全ての選択ボタン取得
  //写真変更処理
  btns.forEach(function(btn){
    btn.addEventListener("change", (e) => {
      // 選択ボタンのdata-numの数字
      const id_num = btn.dataset.num;
      console.log(id_num);
      const file = e.target.files[0];
      const imageUrl = window.URL.createObjectURL(file);
      editHTML(imageUrl, id_num);
    });
  })
  
  
  // ==========写真削除==================================================================
  const deleteImage = (btnNum) => {
    let imageVolumes = document.querySelectorAll(".show-item-image") 
    let imageBtnVolumes = document.querySelectorAll(".exist-item-image")
    //削除処理
    console.log(imageBtnVolumes)
    debugger
    imageVolumes.forEach(function(image){
      if (image.dataset.num === btnNum){
        debugger
        image.parentNode.remove();
      }
    });
    imageBtnVolumes.forEach(function(btn){
      if (btn.dataset.num === btnNum ){
        debugger
        btn.parentNode.remove()
      }
    });
  }
  
  const deleteImages = document.querySelectorAll(".open-delete-image")
  deleteImages.forEach(function(btn){
    btn.addEventListener("click", (e) => {
      const btnNum = btn.dataset.num    //削除ボタンの数字
      debugger
      deleteImage(btnNum)
    })
  });
}

window.addEventListener("load",preview)