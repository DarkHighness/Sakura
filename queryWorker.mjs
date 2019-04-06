WorkerScript.onMessage = function(msg) {
    if(msg.action == "query"){
        var url = "https://api.i-meto.com/api/v1/meting?server=%1&type=parse&id=%2"
                    .arg(msg.platform)
                    .arg(msg.name);
        var request = new XMLHttpRequest();

        request.open("GET",url,true);

        request.onreadystatechange = function(){
            if(request.readyState === XMLHttpRequest.DONE){
                msg.model.clear()
                var json = JSON.parse(request.responseText.toString())
                for(var i = 0; i < json.length; i++)
                    msg.model.append({name: json[i]["name"], artist: json[i]["artist"], url: json[i]["url"]})
                msg.model.sync()
            }
        }

        request.send();
    }
}
