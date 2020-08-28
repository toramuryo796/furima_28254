function preview () {
  const imagePreview = document.getElementById("img-preview");  // 追加した写真が表示される場所
  const itemImage = document.getElementById("item-image");  // 写真選択のボタン
  const addBtnPlace = document.getElementById("click-upload");  // 「写真を追加」テキストの置き場所

  // 出品時の処理
  const createHTML = (blob) => {
    // debugger
    let addBtn = document.getElementById("item-image") 
    const changeText = document.getElementById("add-text")
    changeText.innerHTML = "<p> 写真を変更 </p>"
    // 元のclass, idを削除
    addBtn.removeAttribute("class")
    addBtn.removeAttribute("id")
    addBtn.className = "exist-item-image"
    addBtn.id = "exist-item-image"
    
    // 写真を入れるdivを作成
    const imageElement = document.createElement("div"); 
    imageElement.setAttribute('id', 'addImageElement')
    // 選択された画像及びボタンがいくつあるか
    let imageElementNum = document.querySelectorAll('.exist-item-image').length 
    console.log(imageElementNum)
    let imageNum = document.querySelectorAll('.exist-image').length
    // 追加する写真を取得
    const blobImage = document.createElement("img");
    blobImage.setAttribute("src", blob);
    blobImage.setAttribute("class", "exist-image exist-item-image"); 
    blobImage.setAttribute("data-num", imageNum+1); 
    // 追加ボタンのアナウンスを作成
    const addImageText = document.createElement('p');
    addImageText.innerHTML = "写真を追加" 
    addImageText.setAttribute("id", "add-text");
    // 追加BTNを作成
    const addImage = document.createElement('input'); 
    addImage.setAttribute("id", 'item-image')  
    addImage.setAttribute("class", 'item-image') 
    addImage.setAttribute("data-num", imageElementNum+1) 
    addImage.setAttribute("name", "item[images][]");
    addImage.setAttribute("type", "file");
  
    // 画像を表示
    imageElement.appendChild(blobImage);
    imagePreview.appendChild(imageElement);
  
    // 追加ボタンを表示
    addBtnPlace.appendChild(addImageText);
    addBtnPlace.appendChild(addImage);
    
    // 画像変更の際
    let addExistBtn = document.querySelectorAll(".exist-item-image")
    addExistBtn.forEach(function(btn){
      btn.addEventListener("change", (e) => {
        const id_num = btn.dataset.num; // 選択ボタンのdata-numの数字
        console.log(id_num)
        const file = e.target.files[0];
        const imageUrl = window.URL.createObjectURL(file);
        editHTML(imageUrl, id_num);
      });
    })

    // 追加HTMLでも出品時の発火させる
    addImage.addEventListener("change", (e) => {
      if (addImage.id === "item-image" ){
        file = e.target.files[0];
        blob = window.URL.createObjectURL(file);
        createHTML(blob);
      }
    });
  } 

  // 出品時 
  const addImageBtn = document.getElementById("item-image")
  // 写真を選択したら,createHTMLが起動する
  addImageBtn.addEventListener("change", (e) =>{
    if ( addImageBtn.id === "item-image" ){
      const file = e.target.files[0];
      const imageUrl = window.URL.createObjectURL(file);
      createHTML(imageUrl);
    }


  });

 //=================================================================================================
  const existImagePreview = document.getElementById("exist-image-preview"); 

  //画像変更時の処理
  const editHTML = (blob, id_num) => {
    let count = document.querySelectorAll(".item-image").length // 写真数
   
    let existImages = document.querySelectorAll(".exist-image")  //既にある写真を取得
    // すでにあるデータを削除
    existImages.forEach(function(image){
      // 表示されている写真から選択された番号のものを指定
      if (image.dataset.num === id_num){
        image.remove();
        
        const blobImage = document.createElement("img");  // 追加する写真を取得
        blobImage.setAttribute("src", blob);
        blobImage.setAttribute("class", "exist-image"); 
        blobImage.setAttribute("data-num", id_num); 
        if (id_num <= count){
          // 画像を表示
          existImagePreview.appendChild(blobImage);
        } else {
          const imageElement = document.createElement("div");
          imageElement.setAttribute('id', 'addImageElement')
          imagePreview.appendChild(blobImage);
        }

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
  
  // const deleteImage = document.getElementsByClassName("exist-image").dataset.num(id_num);
  // 写真を入れるdivを作成
  // 選択ボタン取得
  // 画面上の全ての選択ボタン取得
  let btns = document.querySelectorAll(".exist-item-image")

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
}

window.addEventListener("load",preview)