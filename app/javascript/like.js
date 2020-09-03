function like() {
  const likeBox = document.getElementById("favorite-box")                  // 91行目/お気に入りボタンが大外のdiv
  const likeBtns = document.querySelectorAll(".like-btn")                  // 98行目.109行目/いいねボタン
  likeBtns.forEach(function (btn){            
    btn.addEventListener("click", () => {            
      const itemNum = likeBox.dataset.num                                  // 91行目/itemのid          
      const XHR = new XMLHttpRequest();
      console.log(itemNum)             
      XHR.open("POST", `/items/${itemNum}/likes`, true);                   // itemのcreateに指定
      XHR.requestType = "json";                                           // レスポンスはjson形式
      XHR.send();        

      XHR.onload = () => {            
        if (XHR.status != 200){                                            //正常にレスポンスを受け取れなかった場合、アラートだす
          alert(`Error ${XHR.status}: ${XHR.statusText}`);
          return null; 
        }
        const likeData = XHR.response.post;
        let favBox = document.getElementById("fav-box")
        
        if (likeData === nil) {
          let likeCount =  btn.dataset.num                                //解除ボタンの数字
          let onLike = `
            <div id="fav-box">
              <div class="open-back-white">
                <img src="star.png" class="favorite-star-icon" style="width='20'; height='20';" >
                <span>
                  <a href="#" class="like-a like-btn">
                    お気に入り ${likeCount}
                  </a>
                </span>  
              </div>
            </div>`
          favBox.remove();
          likeBox.insertAdjacentElement("beforeend", onLike); 
        }else{  
          let Count =  document.getElementById("count").dataset.num
          let likeId = btn.dataset.num
          let disLike = `
            <div id="fav-box">
              <div class="open-back-yellow">
                <img src="star.png" class="favorite-star-icon" style="width='20'; height='20';" >
                <span>
                  <a href="#" class="like-a like-btn" data-num=${likeId}>
                    お気に入り解除 ${Count}
                  </a>
                </span>  
              </div>
            </div>`
          favBox.remove();
          likeBox.insertAdjacentElement("beforeend", disLike);
        }
      }
    })
  })
}
// setInterval(like, 1000);
window.addEventListener("load",like )