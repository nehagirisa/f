import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_extensions/model/data.dart';
import 'package:firebase_extensions/pages/blog_page.dart';
import 'package:firebase_extensions/pages/create_blog.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final ref = FirebaseFirestore.instance.collection('text_documents');
  String networkImage = "";
   String defaultImageUrl =
      'https://cdn.pixabay.com/photo/2016/03/23/15/00/ice-cream-1274894_1280.jpg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Blog App'),
        elevation: 0,
      ),
      body: StreamBuilder(
          stream: ref.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              List<DataModel> blogList = snapshot.data!.docs
                  .map((e) =>
                      DataModel.fromJson(e.data() as Map<String, dynamic>))
                  .toList();
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Wrap(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Blog_Page(blogList: blogList[index])),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color.fromARGB(255, 80, 171, 246),
                              ),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 170,
                                          child: Image.network(
                                            blogList[index].ImageUrl.toString() ,
                                            fit: BoxFit.fill,
                                          ) ),
                                      Container(
                                        height: 170,
                                        decoration: BoxDecoration(
                                            color: Colors.black45
                                                .withOpacity(0.4)),
                                      ),
                                      Container(
                                          child: Column(
                                        children: [
                                          SizedBox(
                                            height: 40,
                                          ),
                                          Center(
                                            child: Text(
                                              blogList[index].title.toString(),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Center(
                                            child: RichText(
                                              text: TextSpan(
                                                text: 'By: ',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: blogList[index]
                                                          .authername
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ))
                                    ],
                                  ),
                                  //summary of blog
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      blogList[index].summary.toString(),
                                      style: TextStyle(color: Colors.white),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 4,
                                    ),
                                     
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    //floating button to create new blog       
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateBlog()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

