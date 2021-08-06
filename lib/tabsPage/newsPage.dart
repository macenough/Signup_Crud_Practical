import 'package:flutter/material.dart';
import 'package:signup_login_demo/model/newsModel.dart';
import 'package:signup_login_demo/response/client.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  Client _client = Client();
  TextEditingController controller = new TextEditingController();
  TextEditingController localsearchcontroller = new TextEditingController();
  List<Articles> article = [];
  List<Articles> filterarticle = [];
  String country = "us";

  @override
  void initState() {
    _client.fetchUsers(countryName: country).then((value) => {
          setState(() {
            article = value.articles!.toList();
          })
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      child: Column(
        children: [
          TextFormField(
            cursorColor: Colors.black,
            controller: localsearchcontroller,
            keyboardType: TextInputType.name,
            onChanged: (value) {
              setState(() {
                filterarticle.clear();
                article.forEach((element) {
                  if (element.title!
                      .toLowerCase()
                      .contains(value.toLowerCase())) {
                    filterarticle.add(element);
                  }
                });
              });
            },
            decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                hintText: "Search"),
          ),
          localsearchcontroller.value.text.isEmpty
              ? Expanded(
                  flex: 1,
                  child: ListView.builder(
                      padding: EdgeInsets.all(8),
                      itemCount: article.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5),
                          child: GestureDetector(
                            onTap: () {
                              launchURL(article[index].url.toString());
                              print(article[index].url.toString());
                            },
                            child: Card(
                                child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          article[index]
                                              .urlToImage
                                              .toString())),
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Text(
                                              article[index].title.toString(),
                                              overflow: TextOverflow.clip,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            article[index]
                                                .description
                                                .toString(),
                                            overflow: TextOverflow.clip,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            article[index].author.toString(),
                                            overflow: TextOverflow.clip,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                            )),
                          ),
                        );
                      }),
                )
              : Expanded(
                  flex: 1,
                  child: filterarticle.isNotEmpty
                      ? ListView.builder(
                          padding: EdgeInsets.all(8),
                          itemCount: filterarticle.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 5),
                              child: GestureDetector(
                                onTap: () {
                                  launchURL(
                                      filterarticle[index].url.toString());
                                  print(filterarticle[index].url.toString());
                                },
                                child: Card(
                                    child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              filterarticle[index]
                                                  .urlToImage
                                                  .toString())),
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Text(
                                                  filterarticle[index]
                                                      .title
                                                      .toString(),
                                                  overflow: TextOverflow.clip,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                filterarticle[index]
                                                    .description
                                                    .toString(),
                                                overflow: TextOverflow.clip,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                filterarticle[index]
                                                    .author
                                                    .toString(),
                                                overflow: TextOverflow.clip,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                            ]),
                                      ),
                                    ],
                                  ),
                                )),
                              ),
                            );
                          })
                      : Center(
                          child: Text("No search result"),
                        ),
                ),
        ],
      ),
    )));
  }

  launchURL(String urlname) async {
    print(urlname);
    if (await canLaunch(urlname)) {
      await launch(urlname);
    } else {
      throw "Could not launch $urlname";
    }
  }
}
