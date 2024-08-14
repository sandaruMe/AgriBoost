import 'package:flutter/material.dart';

class GrowPage extends StatefulWidget {

  final String dp;
  final String name;
  final String img;
  final String postdata;


  GrowPage({
    super.key,
    required this.dp,
    required this.name,
    required this.img,
    required this.postdata,
  });
  @override
  _GrowPageState createState() => _GrowPageState();
}

class _GrowPageState extends State<GrowPage> {
  // Example string variable
  String displayText = "This is some display text.";

  // Controller for the message input field
  TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grow'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Row with avatar and name
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(widget.dp), // Replace with your image asset
                  ),
                  SizedBox(width: 16),
                  Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              // Display text
              Text(
                widget.postdata,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16),
              // Image
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.img), // Replace with your image asset
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              SizedBox(height: 16),
              // Text input field
              TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Message',
                ),
              ),
              SizedBox(height: 16),
              // Send button
              ElevatedButton(
                onPressed: () {
                  // Handle send action
                  print('Send button pressed');
                  print('Message Field: ${_messageController.text}');
                },
                child: Text('Send'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
