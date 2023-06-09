import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technician_seller_side/temp.dart';
import 'package:http/http.dart' as http;
import '../Models/lastMessage.dart';
import '../const.dart';
import 'Person_1.dart';
class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  String? id="";
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 3), (timer) {
      getActiveOrders();
    });
    setState(() {
      initialize();
    });
  }
  StreamController<LastMessages> _streamController = StreamController();
  @override
  void dispose() {
    // stop streaming when app close
    _streamController.close();
  }
  void initialize()async{
    final prefs = await SharedPreferences.getInstance();
    id= await prefs.getString('id');
    setState(() {
      
    });
  }

  Future<void> getActiveOrders() async{
    LastMessages dataModel = await fetchLastMessages(id.toString());
    setState(() {

    });
    _streamController.sink.add(dataModel);
  }

  Future<LastMessages> fetchLastMessages(String senderId) async {
    final response = await http.get(
      Uri.parse('https://dolphin-app-ldyyx.ondigitalocean.app/receivers/${id}'),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final transformedJson = transformLastMessagesResponse(response.body);
      final lastMessages = LastMessages.fromJson(transformedJson);
      return lastMessages;
    } else {
      throw Exception('Failed to load last messages');
    }
  }


  Map<String, dynamic> transformLastMessagesResponse(String responseBody) {
    final jsonMap = jsonDecode(responseBody);
    final List<Map<String, dynamic>> messagesList = [];

    for (final entry in jsonMap['lastMessages'].entries) {
      final receiverId = entry.key;
      final messageData = entry.value;
      final messageMap = {
        'receiverId': receiverId,
        '_id': messageData['_id'],
        'text': messageData['text'],
        'createdAt': messageData['createdAt'],
        'receiverName': messageData['receiverName'],
      };
      messagesList.add(messageMap);
    }

    return {'lastMessages': messagesList};
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 60),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xffF89F5B),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(32),
                      bottomRight: Radius.circular(32)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 3,
                        offset: Offset(1.0, 2.0))
                  ]),
              height: 30,
              width: MediaQuery.of(context).size.width / 2.1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          height: 20,
                          width: 20,
                          child: SvgPicture.asset(
                            "assets/Back Arrow.svg",
                            fit: BoxFit.scaleDown,
                          )),
                    ),
                    Text(
                      "Messages",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 40),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 3,
                      offset: Offset(1.0, 2.0))
                ]),
            height: 40,
            width: MediaQuery.of(context).size.width / 1.1,
            child: TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 5),
                prefixIcon: SvgPicture.asset(
                  "assets/Search box.svg",
                  fit: BoxFit.scaleDown,
                ),
                hintText: "Search Now",
                hintStyle: TextStyle(fontSize: 10, color: Color(0xff97AABD)),
              ),
            ),
          ),
          SizedBox(height: 30),
          StreamBuilder<LastMessages>(
            stream: _streamController.stream,
            builder: (context,snapdata){
              switch(snapdata.connectionState){
                case ConnectionState.waiting: return Center(child: CircularProgressIndicator(),);
                default: if(snapdata.hasError){
                  return Text('Please Wait....');
                }else{
                  final chats = snapdata.data!.messages;
                  chats.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
                  return Expanded(
                    child: ListView.builder(
                        itemCount: chats!.length,
                        itemBuilder: (context, index){
                          final timestamp = chats[index].createdAt;
                          final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp!);
                          final formattedDateTime = DateFormat('MMM dd, yyyy hh:mm a').format(dateTime);
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: InkWell(
                              onTap: () async{
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (BuildContext context) {
                                  return ChatScreen(myUserId: id.toString(),otherUserId: "${chats[index].receiverId}", name:"${chats[index].receiverName}" ,);
                                }));
                              },
                              child: Container(
                                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey, blurRadius: 3, offset: Offset(1.0, 2.0))
                                ]),
                                height: 85,
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 3),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          "${formattedDateTime}",
                                          style:
                                          TextStyle(fontSize: 12, color: Color(0xff3D3D3D)),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage("assets/pic.jpg")),
                                                borderRadius: BorderRadius.circular(100),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0xff2F62BB),
                                                    blurRadius: 2,
                                                  )
                                                ]),
                                            height: 50,
                                            width: 50,
                                          ),
                                          SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${chats[index].receiverName}",
                                                style: TextStyle(
                                                    fontSize: 16, color: Color(0xff3D3D3D)),
                                              ),
                                              Text(
                                                "${chats[index].text}",
                                                style:
                                                TextStyle(fontSize: 12, color: Colors.black),
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
