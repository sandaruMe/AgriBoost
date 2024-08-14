import 'package:flutter/material.dart';

class PostItem extends StatefulWidget {
  final String dp;
  final String name;
  final String time;
  final String img;
  final String postdata;

  PostItem({
    super.key,
    required this.dp,
    required this.name,
    required this.time,
    required this.img,
    required this.postdata,
  });

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  bool isLiked = false;
  int likeCount = 0;
  final List<String> comments = [];

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
      likeCount += isLiked ? 1 : -1;
    });
  }

  void addComment(String comment) {
    setState(() {
      comments.add(comment);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(widget.dp),
                ),
                contentPadding: EdgeInsets.all(0),
                title: Text(
                  widget.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Text(
                  widget.time,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 11,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.postdata,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Image.network(
                widget.img,
                height: 200,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 8,),



              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? Colors.red : Colors.grey,
                        ),
                        onPressed: toggleLike,
                      ),
                      Text('$likeCount'),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton.icon(
                          icon: Icon(Icons.comment,size: 15),
                          label: Text('Comment'),
                          onPressed: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                String comment = '';
                                return Padding(
                                  padding: MediaQuery.of(context).viewInsets,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(height: 16), // Add padding to avoid overlap
                                        ListView(
                                          shrinkWrap: true,
                                          children: comments.map((c) => ListTile(title: Text(c))).toList(),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: TextField(
                                                  onChanged: (value) {
                                                    comment = value;
                                                  },
                                                  decoration: InputDecoration(
                                                    hintText: 'Add a comment...',
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.send),
                                                onPressed: () {
                                                  if (comment.isNotEmpty) {
                                                    addComment(comment);
                                                    Navigator.pop(context);
                                                  }
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        TextButton.icon(
                          icon: Icon(Icons.send,size: 15,),
                          label: Text('Send'),
                          onPressed: () {},
                        ),
                        TextButton.icon(
                          icon: Icon(Icons.share,size: 15),
                          label: Text('Share'),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
