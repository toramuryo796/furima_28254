function preview () {
  // 追加した写真が表示される場所
  const imagePreview = document.getElementById("img-preview");
  // 写真選択のボタン
  const itemImage = document.getElementById("item-image");
  // 「写真を追加」テキストの置き場所
  const addBtnPlace = document.getElementById("click-upload");
  
  const createHTML = (blob) => {
    // 写真を入れるdivを作成
    const imageElement = document.createElement("div");
    imageElement.setAttribute('id', 'addImageElement')
    // 選択された画像及びボタンがいくつあるか
    let imageElementNum = document.querySelectorAll('.item-image').length +1
    let imageNum = document.querySelectorAll('.exist-image').length
    // 追加する写真を取得
    const blobImage = document.createElement("img");
    blobImage.setAttribute("src", blob);
    blobImage.setAttribute("class", "exist-image"); 
    blobImage.setAttribute("data-id", imageNum+1); 
    // 追加ボタンのアナウンスを作成
    const addImageText = document.createElement('p');
    addImageText.innerHTML = "写真を追加" 
    addImageText.setAttribute("class", "add-text");
    // 追加BTNを作成
    const addImage = document.createElement('input'); 
    addImage.setAttribute("id", 'exist-item-image')  
    addImage.setAttribute("class", 'item-image') 
    addImage.setAttribute("data-id", imageElementNum+1) 
    addImage.setAttribute("name", "item[images][]");
    addImage.setAttribute("type", "file");
    // 画像を表示
    imageElement.appendChild(blobImage);
    imagePreview.appendChild(imageElement);
    // 追加ボタンを表示
    addBtnPlace.appendChild(addImageText);
    addBtnPlace.appendChild(addImage);
    // 追加HTMLでも発火させる
    addImage.addEventListener("change", (e) => {
      file = e.target.files[0];
      blob = window.URL.createObjectURL(file);
      createHTML(blob);
    });
  }
  
  const addImageBtns = document.getElementById("item-image")
  // 写真を選択したら,createHTMLが起動する
  addImageBtns.addEventListener("change", (e) =>{
    const file = e.target.files[0];
    const imageUrl = window.URL.createObjectURL(file);
    createHTML(imageUrl);
  });
}
window.addEventListener("load",preview );