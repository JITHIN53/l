import 'package:flutter/material.dart';
import 'package:news_api/Services/api_news.dart';
import 'package:news_api/models/news_class_model.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<NewsModels> _newsModels;

  @override
  void initState() {
    _newsModels = ApiManager().getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueGrey,
        title: const Center(child: Text('News')),
        toolbarHeight: 100,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(35),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: FutureBuilder<NewsModels>(
            future: _newsModels,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.articles.length,
                  itemBuilder: (context, index) {
                    var articlez = snapshot.data!.articles[index];
                    var formattedTime = DateFormat('dd MMM - HH:mm')
                        .format(articlez.publishedAt);
                    return Container(
                      padding: EdgeInsets.all(12),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            articlez.title,
                            style:  TextStyle(
                                color: Colors.blueGrey[900],
                                fontSize: 22,
                                fontWeight: FontWeight.w800),
                          ),
                          Text(formattedTime),
                          Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: AspectRatio(
                              aspectRatio: 2,
                              child: Image.network(
                                articlez.urlToImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            articlez.description,
                            style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(articlez.content),
                          Text(articlez.url),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
