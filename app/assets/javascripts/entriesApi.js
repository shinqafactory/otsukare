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
  console.log(count);
  
  if(count == 0) {
    ofs = 0;
  } else {
    ofs = count;
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
        getList(data.results[i], data.loginUserId);
      }
    },
    error: function() {
      alert("データの読み込みに失敗しました");
    }
  });
}

function getList(result, loginUserId) {
  
  var list = new String();
  // 1段目
  list += "<span><div class='content page-solid entry-list'>";
  list += "<div class='row show-grid'>";
	  list += "<div class='span5'>";
	  list += "<div class='row show-grid'>";
	  list += "<div class='span4'>";
	  list += "<h3><small>" + result.name + "</small></h3></div>";
	  list += "<div class='span1'><h3><small class='time'>";
	  list += toLocaleString(new Date(result.created_at));
	  list += "</small></h3></div>";
	  list += "</div>";
	  list += "<div class='row show-grid'>";
	  list += "<div class='span5'><p class='js-tweet-text tweet-text'>" + result.content + "</p></div>";
	  list += "</p></div>";
	  list += "</div>";
	  // 右
	  list += "<div class='span2'>";
		  list += "<div class='row show-grid padding20'>";
		  // 自分のつぶやきだった場合や既に押した場合は押すことが出来ない
		  if ((result.check_count == null || result.check_count == 0) && result.user_id != loginUserId) {
			  list += "<button class='gjOff btn btn-primary btn-small' consent_user_id='" + loginUserId
			  	+ "' entry_id='" + result.id
			  	+ "' user_id='" + result.user_id + "' onclick=''>おつかれ</button>";
			  list += "<span class='gjCounter badge badge-info'>" + getNumber(result.consent_count) + "</span>";
		  } else {
			  list += "<button class='gjOff btn btn-primary btn-small' disabled='true'>おつかれ</button>";
			  list += "<span class='gjCounter badge badge-info'>" + getNumber(result.consent_count) + "</span>";
		  }
		  list += "</div>";
		  list += "<div class='row show-grid padding10'>";
		  // 自分のつぶやきの場合は表示しない
		  if (result.user_id != loginUserId) {
			  list += "<form method='get' action='/messages/send_messege/"+ result.id +"/ " + result.user_id + "'  class='button_to'>";
			  list += "<button class='btn btn-primary btn-small'>言葉を贈る</button></form>";
		  }
		  list += "</div>";
	  list += "</div>";
	  list += "<div class='padding20'>";
	  // 自分のつぶやきの場合は表示
	  if (result.user_id == loginUserId) {
		  list += "<a href='/tops/" + result.id + "' data-method='delete' rel='nofollow' ><i class='icon-trash icon-red'></i></a>";
	  }
	  list += "</div>";
  list += "</div>";
  
  
  list += "</div>"
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
  
//  console.log(diffDate);
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


//おつかれボタン
$(function() {
	$(document).on(
			'click',
			'button.gjOff',
			function() {

				var consent_user_id = $(this).attr('consent_user_id');
				var entry_id = $(this).attr('entry_id');
				var user_id = $(this).attr('user_id');

				$(this).attr('disabled', 'true');
				var num = incrementNum($(this).next().text(), consent_user_id, entry_id, user_id);
				$(this).next().text(num);
			});

})

//加算
function incrementNum(cnt, consent_user_id, entry_id, user_id) {

	var num = parseInt(cnt.replace(/,/g, ""));
	var url = "http://localhost:3000/consents/insConsent/" + consent_user_id + "/" + entry_id + "/" + user_id + "/";

	//APIに接続
	$.ajax({
		type : "POST",
		url : url,
		success : function(res) {
		}
	});

	num = (num + 1);
	return String(num);
}

function getNumber(num) {
	if (num == null) {
		return 0;
	}
	return num;
}