import 'package:flutter/material.dart';

import '../screens/home/Market/grow.dart';
import '../screens/home/Market/invest.dart';

class PostItem_market extends StatefulWidget {
  final String dp;
  final String name;
  final String time;
  final String img;
  final String postdata;
  final String role;
  PostItem_market({
    super.key,
    required this.dp,
    required this.name,
    required this.time,
    required this.img,
    required this.postdata,
    required this.role
  });

  @override
  _PostItem_marketState createState() => _PostItem_marketState();
}

class _PostItem_marketState extends State<PostItem_market> {
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
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                       if(widget.role=="farmer")
                        TextButton.icon(
                          icon: Icon(Icons.business_sharp,size: 15,),
                          label: Text('Grow'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => GrowPage(dp:widget.dp,name: widget.name,img: widget.img,postdata:widget.postdata)),
                            );
                          },
                        )
                        else
                         TextButton.icon(
                           icon: Icon(Icons.business_sharp,size: 15,),
                           label: Text('Invest'),
                           onPressed: () {
                             Navigator.push(
                               context,
                               MaterialPageRoute(builder: (context) => InvestPage(dp:widget.dp,name: widget.name,img: widget.img,postdata:widget.postdata)),
                             );
                           },
                         )
                          ,

                        TextButton.icon(
                          icon: Icon(Icons.more,size: 15,),
                          label: Text('More'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => InvestPage(dp:widget.dp,name: widget.name,img: widget.img,postdata:widget.postdata)),
                            );
                          },
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
