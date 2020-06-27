import 'dart:convert';

// import 'package:mongo_dart/mongo_dart.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';

class User {
  String username;
  String citID;

  User(this.username, this.citID);
}

class Message {
  final String text;
  final String senderCitotoID;
  final String receiverCitotoID;

  Message(this.text, this.senderCitotoID, this.receiverCitotoID);
}

class Conversation {
  final List<Message> chats;
  final String firstParticipant;
  final String secondParticipant;

  Conversation(this.chats, this.firstParticipant, this.secondParticipant);
}

class ChatModel extends Model {
  List<User> users = [
    User('James Solomon', 'CIT001'),
    User('Abraham George', 'CIT002'),
    User('Shantanu Pawar', 'CIT003'),
    User('Saif Ali', 'CIT004'),
    User('Vikas', 'CIT005'),
  ];

  User _currentUser;
  List<User> friendList = List<User>();
  List<Message> messages = List<Message>();
  List<Conversation> conversation = List<Conversation>();
  SocketIO socketIO;
  String _currentCitotoID = "";

  void init(String id) {
    _currentCitotoID = id;
    // for (int i = 0; i < (users.length - 1); i++) {
    //   if (currentCitotoID == users[i + 1].citID) {
    //     currentUser = users[i + 1];
    //     break;
    //   }
    // }
    int i = 0;
    while (i < (users.length - 1)) {
      if (_currentCitotoID.contains(users[i].citID)) {
        _currentUser = users[i];
        break;
      }
      i++;
    }
    // currentUser = users[1];
    print('\nINIT wala - \"$_currentCitotoID\"\n');

    friendList =
        users.where((user) => user.citID != _currentUser.citID).toList();

    socketIO = SocketIOManager().createSocketIO(
        'https://citoto-app.herokuapp.com/', //<ENTER THE URL OF YOUR DEPLOYED APP>
        '/',
        query: 'citID=${_currentUser.citID}');
    socketIO.init();

    socketIO.subscribe('receive_message', (jsonData) {
      Map<String, dynamic> data = json.decode(jsonData);
      messages.add(Message(
          data['content'], data['senderCitotoID'], data['receiverCitotoID']));
      notifyListeners();
    });

    socketIO.connect();
  }

  void sendMessage(String text, String receiverCitotoID) {
    messages.add(Message(text, _currentUser.citID, receiverCitotoID));
    socketIO.sendMessage(
      'send_message',
      json.encode({
        'receiverCitotoID': receiverCitotoID,
        'senderCitotoID': _currentUser.citID,
        'content': text,
      }),
    );
    notifyListeners();
  }

  List<Message> getMessagesForCitotoID(String citID) {
    return messages
        .where((msg) =>
            msg.senderCitotoID == citID || msg.receiverCitotoID == citID)
        .toList();
  }

  List<Conversation> getConversationForCitotoID(String citID) {
    return conversation.where((convo) =>
        (convo.firstParticipant == _currentUser.citID &&
            convo.secondParticipant == citID) ||
        (convo.firstParticipant == citID && convo.secondParticipant == citID));
  }
}
