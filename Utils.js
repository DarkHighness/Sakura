function query(platform,name) {
    var url = "https://api.i-meto.com/api/v1/meting?server=%1&type=parse&id=%2"
                .arg(platform)
                .arg(name);
    var request = new XMLHttpRequest();

    request.open("GET",url,true);

    request.onreadystatechange = function(){
        if(request.readyState === XMLHttpRequest.DONE){
            songView.model.clear()
            var json = JSON.parse(request.responseText.toString())
            for(var i = 0; i < json.length; i++)
                songView.model.append({name: json[i]["name"], artist: json[i]["artist"], url: json[i]["url"]})
        }
    }

    request.send();
}

function play(url,name,artist){
    player.stop();
    player.playlist.addItem(url);
    var index = player.playlist.itemCount - 1
    player.playlist.currentIndex = index
    player.play()
    playListPage.view.model.append({name: name, artist: artist, url: url, index: index })
    artistDisplay.text = artist
    songNameDisplay.text = name
}

function playAt(index,artist,name){
    player.stop();
    player.playlist.currentIndex = index
    player.play()
    artistDisplay.text = artist
    songNameDisplay.text = name
}

function formatSeconds(value) {
    var secondTime = parseInt(value);
    var minuteTime = 0;
    minuteTime = parseInt(secondTime / 60);
    secondTime = parseInt(secondTime % 60);

    var result = "";
    if(minuteTime < 10)
        result += "0" + minuteTime;
    else result += minuteTime;

    result += ":";

    if(secondTime < 10)
        result += "0" + secondTime;
    else result += secondTime;

    return result;
}
