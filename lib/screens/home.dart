import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'model.dart';
import 'auth/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    List<Model> list = <Model>[];
  String? text;
  final url =
      'https://api.edamam.com/search?q=chicken&app_id=a01bf37f&app_key=3fa6166307f4a44c10dec360b7bed919&from=0&to=100&calories=591-722&health=alcohol-free';
  getApiData() async {
    var response = await http.get(Uri.parse(url));
    Map json = jsonDecode(response.body);
    json['hits'].forEach((e) {
      Model model = Model(
          url: e['recipe']['url'],
          image: e['recipe']['image'],
          source: e['recipe']['source'],
          label: e['recipe']['label']);
      setState(() {
        list.add(model);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getApiData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, title: Text("Aplikasi Resep Makanan"),actions: [
        TextButton(
            onPressed: () async {
              final SharedPreferences? prefs = await _prefs;
              prefs?.clear();
              Get.offAll(AuthScreen());
            },
            child: Text(
              'logout',
              style: TextStyle(color: Colors.white),
            ))
      ]),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                onChanged: (v) {
                  text = v;
                },
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => searchpage(
                                      search: text,
                                    )));
                      },
                      icon: Icon(Icons.search),
                    ),
                    hintText: "Cari Resep Disini",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    fillColor: Colors.green.withOpacity(0.04),
                    filled: true),
              ),
              SizedBox(
                height: 15,
              ),
              GridView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  primary: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5),
                  itemCount: list.length,
                  itemBuilder: (context, i) {
                    final x = list[i];
                    return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => webpage(
                                        url: x.url,
                                      ))));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(x.image.toString())),
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    padding: EdgeInsets.all(3),
                                    height: 40,
                                    color: Colors.black.withOpacity(0.5),
                                    child: Center(
                                      child: Text(x.label.toString()),
                                    )),
                                Container(
                                  padding: EdgeInsets.all(3),
                                  height: 40,
                                  color: Colors.black.withOpacity(0.5),
                                  child:
                                      Text("Source : " + x.source.toString()),
                                )
                              ]),
                        ));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class webpage extends StatelessWidget {
  final url;
  webpage({this.url});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: WebView(
        initialUrl: url,
      )),
    );
  }
}

class searchpage extends StatefulWidget {
  String? search;
  searchpage({this.search});
  @override
  _searchpageState createState() => _searchpageState();
}

class _searchpageState extends State<searchpage> {
  List<Model> list = <Model>[];
  String? text;

  getApiData(search) async {
    final url =
        'https://api.edamam.com/search?q=$search&app_id=a01bf37f&app_key=3fa6166307f4a44c10dec360b7bed919&from=0&to=100&calories=591-722&health=alcohol-free';

    var response = await http.get(Uri.parse(url));
    Map json = jsonDecode(response.body);
    json['hits'].forEach((e) {
      Model model = Model(
          url: e['recipe']['url'],
          image: e['recipe']['image'],
          source: e['recipe']['source'],
          label: e['recipe']['label']);
      setState(() {
        list.add(model);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getApiData(widget.search);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, title: Text("Aplikasi Resep Makanan")),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GridView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  primary: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5),
                  itemCount: list.length,
                  itemBuilder: (context, i) {
                    final x = list[i];
                    return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => webpage(
                                        url: x.url,
                                      ))));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(x.image.toString())),
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    padding: EdgeInsets.all(4),
                                    height: 40,
                                    color: Colors.black.withOpacity(0.5),
                                    child: Center(
                                      child: Text(x.label.toString()),
                                    )),
                                Container(
                                  padding: EdgeInsets.all(4),
                                  height: 40,
                                  color: Colors.black.withOpacity(0.5),
                                  child:
                                      Text("Source : " + x.source.toString()),
                                )
                              ]),
                        ));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
