import 'package:coronavirus/backend/19Api.dart';
import 'package:coronavirus/main/profile.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

List _postCovid = [];
List _displayCovid = [];

class Corona {
  String provinsi;

  Corona(this.provinsi);

  Corona.fromList(Map<String, dynamic> json) {
    provinsi = json[0];
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  Future _data;
  Corona p;
  Object d;

  Future _getData() async {
    Network corona = Network('https://api.kawalcorona.com/indonesia/provinsi');

    return corona.fetchData();
  }

  _handleAPI() async {
    _data = _getData();
    _data.then((value) {
      for (int i = 0; i < value.length; i++) {
        _postCovid.add(value[i]);
        _displayCovid = _postCovid;
      }
      setState(() {});
      // print(_displayCovid[i]['attributes']['Provinsi']);
    });
  }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: TextField(
        decoration: InputDecoration(
            hintText: 'Provinsi..',
            hintStyle: TextStyle(fontFamily: 'WorkSans-Regular'),
            isDense: true,
            contentPadding: EdgeInsets.all(10),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        onChanged: (value) {
          value = value.toLowerCase();
          setState(() {
            _displayCovid = _postCovid.where((e) {
              var getProvinsi =
                  e['attributes']['Provinsi'].toString().toLowerCase();
              return getProvinsi.contains(value);
            }).toList();
          });
        },
      ),
    );
  }

  Widget _covid() {
    return ListView.builder(
      itemBuilder: (context, int index) {
        return Container(
          padding: EdgeInsets.all(10),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            color: Colors.amber,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 5,
              child: Padding(
                  padding: EdgeInsets.fromLTRB(40, 40, 0, 40),
                  child: ListTile(
                    title: Text(
                      _displayCovid[index]['attributes']['Provinsi'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'WorkSans-Regular'),
                    ),
                    subtitle: Text(
                      'Positif ' +
                          _displayCovid[index]['attributes']['Kasus_Posi']
                              .toString() +
                          '\n' +
                          'Sembuh ' +
                          _displayCovid[index]['attributes']['Kasus_Semb']
                              .toString() +
                          '\n' +
                          'Meninggal ' +
                          _displayCovid[index]['attributes']['Kasus_Meni']
                              .toString(),
                      style: TextStyle(fontFamily: 'WorkSans-Regular'),
                    ),
                  )),
            ),
          ),
        );
      },
      itemCount: _displayCovid.length,
    );
  }

  @override
  void initState() {
    _handleAPI();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ));
      print('kebuka');
    }

    print('tombol kotak');
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            color: Colors.amber,
            icon: Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(pageBuilder: (a, b, c) {
                    return Profile();
                  }, transitionsBuilder: (a, b, c, d) {
                    var begin = Offset(2.0, 0.0);
                    var end = Offset.zero;
                    var tween = Tween(begin: begin, end: end);
                    var offsetAnimation = b.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: d,
                    );
                  }));
            },
          )
        ],
        backgroundColor: Colors.grey[50],
        elevation: 0,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Corona Apps',
                style: TextStyle(
                    color: Colors.black, fontFamily: 'WorkSans-Regular'),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          _searchBar(),
          (_postCovid.isEmpty)
              ? Center(child: CircularProgressIndicator())
              : Expanded(
                  child: RawScrollbar(
                      radius: Radius.circular(20),
                      thumbColor: Colors.grey,
                      child: _covid())),
        ],
      ),
    );
  }
}
