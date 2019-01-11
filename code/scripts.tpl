var API_ENDPOINT = "${api_gw_url}"

document.getElementById("sayButton").onclick = function(){

	var inputData = {
		"voice": $('#voiceSelected option:selected').val(),
		"text" : $('#postText').val()
	};

	$.ajax({
	      url: API_ENDPOINT,
	      type: 'POST',
	      data:  JSON.stringify(inputData)  ,
	      contentType: 'application/json; charset=utf-8',
	      success: function (response) {
					document.getElementById("postIDreturned").textContent="Post ID: " + response;
					setTimeout(function(){
						get_voice_by_postId(inputData["text"])
					}, 6000);
	      },
	      error: function () {
	          alert("error");
	      }
	  });
}


document.getElementById("searchButton").onclick = function(){

	var searchText = $('#searchText').val();
	get_voice_by_postId(searchText)

}

function get_voice_by_postId(searchText) {

	$.ajax({
				url: API_ENDPOINT + '?searchText='+searchText,
				type: 'GET',
				success: function (response) {

					$('#posts tr').slice(1).remove();

	        jQuery.each(response, function(i,data) {

						var player = "<audio controls><source src='" + data['url'] + "' type='audio/mpeg'></audio>"
						var voice_str = data['text']
						var voice_url = voice_str.link(data['url'])

						if (typeof data['url'] === "undefined") {
	    				var player = ""
						}

						$("#posts").append("<tr> \
								<td>" + data['id'] + "</td> \
								<td>" + data['voice'] + "</td> \
								<td>" + voice_url + "</td> \
								<td>" + data['status'] + "</td> \
								<td>" + player + "</td> \
								</tr>");
	        });
				},
				error: function () {
						alert("error");
				}
		});
}

document.getElementById("postText").onkeyup = function(){
	var length = $(postText).val().length;
	document.getElementById("charCounter").textContent="Characters: " + length;
}

document.getElementById("searchArticle").onclick = function(){

	var searchWord = $('#searchWord').val();

	$.ajax({
				url: API_ENDPOINT + '?searchWord='+searchWord,
				type: 'GET',
				success: function (response) {
					document.getElementById("searchArticlereturned").textContent="Correct article: " + response;
	      },
	      error: function () {
	          alert("error");
	      }
		});
}