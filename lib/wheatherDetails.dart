
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wheather/Location.dart';
import 'package:flutter_wheather/Menu.dart';
import 'package:flutter_wheather/Weather.dart';
import 'package:http/http.dart';

class WheatherDetails extends StatefulWidget{
  @override
  WheatherDetailsState createState() => WheatherDetailsState();
}

class WheatherDetailsState extends State<WheatherDetails>{
  String _city = "Delhi";

  void setCity(Location city){
    setState(() {
      _city = describeEnum(city);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: PopupMenuButton<Location>(
          onSelected: setCity,
          itemBuilder: (context) => <PopupMenuEntry<Location>>[
            PopupMenuItem(
              value: Location.Delhi,
              child: Text(describeEnum(Location.Delhi)),
            ),
            PopupMenuItem(
              value: Location.Mumbai,
              child: Text(describeEnum(Location.Mumbai)),
            ),
            PopupMenuItem(
              value: Location.London,
              child: Text(describeEnum(Location.London)),
            ),
            PopupMenuItem(
              value: Location.Patna,
              child: Text(describeEnum(Location.Patna)),
            ),
          ],
        ),
        title: Text("Wheather Details " + _city),
      ),
      body: Center(
        child: FutureBuilder(
          future: fetchWeather(_city),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Image.network(snapshot.data.icon),
                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(snapshot.data.description,
                              style: TextStyle(fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                          ),
                        ),
                        Divider(),
                        ListTile(
                          title: Text(snapshot.data.name,
                              style: TextStyle(fontWeight: FontWeight.w500)),
                          leading: Icon(
                            Icons.location_on,
                            color: Colors.blue[500],
                          ),
                        ),
                        ListTile(
                          title: Text(snapshot.data.temp,
                              style: TextStyle(fontWeight: FontWeight.w500)),
                          leading: Icon(
                            Icons.thermostat_rounded,
                            color: Colors.blue[500],
                          ),
                        ),
                      ]
                    ),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner.
            return CircularProgressIndicator();
            },
        ),
      ),
    );
  }

}

Future<Weather> fetchWeather(String city) async {
  //try {
    Response response = await get("https://api.openweathermap.org/data/2.5/weather?units=metric&appid=154b075c1652f4f2d9c3b7420ab1362a&q="+city);
    if(response.statusCode == 200){
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      Weather weather = new Weather();
      weather.name = responseMap['name'];
      Map<String, dynamic> map = responseMap['main'];
      weather.temp = map['temp'].toString();
      List<dynamic> list= responseMap['weather'];
      map = list[0];
      weather.description = map['description'];
      weather.icon = "https://openweathermap.org/img/wn/"+map['icon']+"@4x.png";
      return weather;
    }
  //} catch(e){
    //print(e);
  //}
}
