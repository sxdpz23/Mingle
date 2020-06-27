import 'dart:math';

Random random = Random();

List names = [
  "George Abraham",
  "James Solomon",
  "Shantanu Pawar",
  "Kevin Thomas",
  "Alan Thomas",
  "Brandon Rodrigues",
  "Shreyas Patil",
  "Ranjit Rathore",
  "Kevin Lobo",
  "Johnathan Alexander",
  "Sharon Alexander",
];

List citoto_ids = [
  "CIT9023451",
  "CIT9023452",
  "CIT9023453",
  "CIT9023454",
  "CIT9023455",
  "CIT9023456",
  "CIT9023457",
  "CIT9023458",
  "CIT9023459",
  "CIT9023460",
  "CIT9023461",
];

List messages = [
  "Hey, how are you doing?",
  "Are you available tomorrow?",
  "It's late. Go to bed!",
  "This cracked me up 😂😂",
  "Flutter Rocks!!!",
  "The last rocket🚀",
  "OnePlus 10T Pro MacLaren Edition ❤️❤️",
  "Will you be attending the meetup tomorrow?",
  "Are you angry at something?",
  "You are a very lazy guy",
  "Were you able to hear my voice?",
];

List notifs = [
  "${names[random.nextInt(10)]} and ${random.nextInt(100)} others liked your post",
  "${names[random.nextInt(10)]} mentioned you in a comment",
  "${names[random.nextInt(10)]} shared your post",
  "${names[random.nextInt(10)]} commented on your post",
  "${names[random.nextInt(10)]} replied to your comment",
  "${names[random.nextInt(10)]} reacted to your comment",
  "${names[random.nextInt(10)]} asked you to join a Group️",
  "${names[random.nextInt(10)]} asked you to like a page",
  "You have memories with ${names[random.nextInt(10)]}",
  "${names[random.nextInt(10)]} Tagged you and ${random.nextInt(100)} others in a post",
  "${names[random.nextInt(10)]} Sent you a friend request",
];

List notifications = List.generate(13, (index)=>{
  "name": names[random.nextInt(10)],
  "dp": "assets/sx${random.nextInt(10)}.jpeg",
  "time": "${random.nextInt(50)} min ago",
  "notif": notifs[random.nextInt(10)]
});

List posts = List.generate(13, (index)=>{
  "name": names[random.nextInt(10)],
  "dp": "assets/sx${random.nextInt(10)}.jpeg",
  "time": "${random.nextInt(50)} min ago",
  "img": "assets/sx${random.nextInt(10)}.jpeg",
  "citoto_id": citoto_ids[random.nextInt(11)]
});

List chats = List.generate(13, (index)=>{
  "name": names[random.nextInt(10)],
  "dp": "assets/sx${random.nextInt(10)}.jpeg",
  "msg": messages[random.nextInt(10)],
  "counter": random.nextInt(20),
  "time": "${random.nextInt(50)} min ago",
  "isOnline": random.nextBool(),
  "newMsg": random.nextBool(),
});

List searchbar = List.generate(1, (index) => {
  "name": names[random.nextInt(10)],
  "dp": "assets/sx${random.nextInt(10)}.jpeg",
});

List groups = List.generate(13, (index)=>{
  "name": "Group ${random.nextInt(20)}",
  "dp": "assets/sx${random.nextInt(10)}.jpeg",
  "msg": messages[random.nextInt(10)],
  "counter": random.nextInt(20),
  "time": "${random.nextInt(50)} min ago",
  "isOnline": random.nextBool(),
});

List types = ["text", "image"];

List conversation = List.generate(10, (index)=>{
  "username": "Group ${random.nextInt(20)}",
  "time": "${random.nextInt(50)} min ago",
  "type": types[random.nextInt(2)],
  "replyText": messages[random.nextInt(10)],
  "isMe": random.nextBool(),
  "isGroup": false,
  "isReply": random.nextBool(),
});

List friends = List.generate(13, (index)=>{
  "name": names[random.nextInt(10)],
  "dp": "assets/sx${random.nextInt(10)}.jpeg",
  "status": "Anything could be here",
  "isAccept": random.nextBool(),
});
