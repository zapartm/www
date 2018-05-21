
function Search() {
    var div = document.getElementById("list");
    div.innerHTML = "";
    document.getElementById("err").innerHTML = "";

    var fname = document.getElementById("firstname").value;
    var lname = document.getElementById("lastname").value;
    var idfrom = document.getElementById("id_from").value;
    var idto = document.getElementById("id_to").value;
    if (fname == "" || lname == "") return;

    var lat;
    var long;
    $.ajax({
        async: false,
        type: 'GET',
        url: "http://api.open-notify.org/iss-now.json",
        success: function (data) {
            lat = data.iss_position.latitude;
            long = data.iss_position.longitude;
        }
    });

    for (var i = idfrom; i <= idto; i++) {
        preparePromise(fname, lname, i, lat, long).then(function(){ console.log("after promise resolved"); });
    }

    // próba czekania na wszystkie ale coś nie działało
    //var promisesList = [];
    //for (var i = idfrom; i <= idto; i++) {
    //    promisesList.push(preparePromise(fname, lname, i));
    //}

    var promise = Promise.all(promisesList);
    promise.then(
        function (result) {
            console.log(result);
            var div = document.getElementById("list");
            for (var j = 0; j < result.length; j++) {
                if (result == "" || typeof (result) == "undefinded")
                    continue;
                var li = document.createElement("li");
                li.innerHTML = result;
                div.appendChild(li);
            }
        },
        failure);
}

function failure() {

}

function preparePromise(fname, lname, id, lat, long) {

    str1 = "http://www.poznan.pl/featureserver/featureserver.cgi/groby/all.json?maxFeatures=10&queryable=g_surname,g_name,cm_id&g_surname=";
    str2 = "&g_name=";
    str3 = "&cm_id=";
    url = str1 + lname + str2 + fname + str3 + id;

    return new Promise(function (resolve, reject) {
        
        var request = new XMLHttpRequest();
        request.open("GET", url, true);

        request.onreadystatechange = function () {
            if (request.readyState == XMLHttpRequest.DONE) {
                if (request.status == 200 || request.status == 204) {
                    var result = request.response;
                    if (result == "" || typeof(result) == "undefined") return;

                    result = JSON.parse(result);
                    str = "";
                    console.log(result.features.length);
                    var div = document.getElementById("list");
                    for (var i = 0; i < result.features.length; i++) {
                        result2 = result.features[i];
                        str = "Grave: "
                        str += result2.id;
                        str += " " + result2.properties.g_surname;
                        str += " " + result2.properties.g_date_burial;
                        str += " Distance to ISS: "

                        distance = 111196 * Math.sqrt((result2.geometry.coordinates[0][0] - long) * (result2.geometry.coordinates[0][0] - long) + (result2.geometry.coordinates[0][1] - lat) * (result2.geometry.coordinates[0][1] - lat));
                        str += distance;

                        var li = document.createElement("li");
                        li.innerHTML = str;
                        div.appendChild(li);
                    }
                    
                    resolve(str);

                } else if (request.status == 400 || request.status == 500) {
                    document.getElementById("err").innerHTML = "BŁĄD!!!";
                }else{
                    failure();
                }
            }
        }

        request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        request.send();
    });
}