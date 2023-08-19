import 'package:firebase_extensions/model/data.dart';
import 'package:flutter/material.dart';

class Blog_Page extends StatefulWidget {
  const Blog_Page({super.key, required this.blogList});
  final DataModel blogList;
  @override
  State<Blog_Page> createState() => _Blog_PageState();
}

class _Blog_PageState extends State<Blog_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.blogList.title.toString()),
      ),
      body: Stack(
        children: [
          Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                widget.blogList.ImageUrl.toString(),
                fit: BoxFit.cover,
              )),
          Builder(
            builder: (context) {
              return SafeArea(
                child: Align(
                  alignment: AlignmentDirectional(0, 1.06),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.65,
                    decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 185, 185, 185),
                            offset: Offset(1, 1),
                            blurRadius: 12,
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40)),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Summary',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              widget.blogList.summary.toString(),
                              style:const TextStyle(
                                fontSize:15,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Discribtion',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              widget.blogList.text.toString(),
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.justify,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}
