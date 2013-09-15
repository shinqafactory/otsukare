$(function(){
  loadEntry();
  $("#more").click(function(){
    loadEntry();
  });
});

function loadEntry() {
  var count;
  var lim = 20;
  var ofs;

  count = $("#content_list span").children().length;
//  console.log(count);
  
  if(count == 0) {
    ofs = 0;
  } else {
    ofs = count - 1;
  }
//  console.log("ofs:" + String(ofs));
  
  $.ajax({
    dataType: "json",
    url: "http://localhost:3000/api/entry/" + String(lim) + "/" + String(ofs) + ".json",
    success: function(data) {
      for(var i = 0; i < 20; i++) {
        if(data.results[i] === undefined) {
          $("#more").hide();
          break;
        }
        getList(data.results[i]);
      }
    },
    error: function() {
      alert("データの読み込みに失敗しました");
    }
  });
}

function getList(result) {
  
  var list = new String();
  // 1段目
  list += "<span><div class='content page-solid entry-list'>";
  list += "<div class='row show-grid'>";
  list += "<div class='span7'><h3><small>";
  list += result.name;
  list += "</small></h3></div>";
  list += "<div class='span2'><h3><small class='time'>";
  list += toLocaleString(new Date(result.created_at));
  list += "</small></h3></div></div>";
  // 2段目
  list += "<div class='row show-grid'>";
  list += "<div class='span9'><p class='js-tweet-text tweet-text'>";
  list += result.content;
  list += "</p></div></div>";
  
  list += "</span>";
  
  $("div#content_list")
    .append(list)
}

//出力例:YYYY/MM/DD HH:MI:SS
function toLocaleString( date )
{
  // sysdate
  var today = new Date();
  // 比較結果
  var diffDate = Math.ceil(today.getTime() - date.getTime()) / 1000;
  // 返却値
  var rtnDate = new String();
  // 一日の秒数
  var dayNum = 86400;
  
  console.log(diffDate);
  if (diffDate < 60) {
    rtnDate = "1分前"
  } else if (60 < diffDate && diffDate < 120) {
    rtnDate = "2分前"
  } else if (120 < diffDate && diffDate < 240) {
    rtnDate = "4分前"
  } else if (240 < diffDate && diffDate < 480) {
    rtnDate = "8分前"
  } else if (480 < diffDate && diffDate < 900) {
    rtnDate = "15分前"
  } else if (900 < diffDate && diffDate < 1800) {
    rtnDate = "30分前"
  } else if (1800 < diffDate && diffDate < 3600) {
    rtnDate = "1時間前"
  } else if (3600 < diffDate && diffDate < 7200) {
    rtnDate = "2時間前"
  } else if (7200 < diffDate && diffDate < 14400) {
    rtnDate = "4時間前"
  } else if (14400 < diffDate && diffDate < 43200) {
    rtnDate = "12時間前"
  } else if (43200 < diffDate && diffDate < dayNum) {
    rtnDate = "1日前"
  } else if (dayNum < diffDate && diffDate < dayNum * 2) {
    rtnDate = "2日前"
  } else if (dayNum * 2 < diffDate && diffDate < dayNum * 4) {
    rtnDate = "4日前"
  } else if (dayNum * 4 < diffDate && diffDate < dayNum * 10) {
    rtnDate = "10日前"
  } else if (dayNum * 10 < diffDate && diffDate < dayNum * 20) {
    rtnDate = "20日前"
  } else if (dayNum * 20 < diffDate && diffDate < dayNum * 30) {
    rtnDate = "30日前"
  } else {
    rtnDate = "1ヶ月以降"
  }
  
  return rtnDate;
}
