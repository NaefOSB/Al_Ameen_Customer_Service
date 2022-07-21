import 'package:al_ameen_customer_service/model/user.dart';

class Message {
  final User sender;
  final String time; // Would usually be type DateTime or Firebase Timestamp in production apps
  final String text;
  final bool unread;

  Message({
    this.sender,
    this.time,
    this.text,
    this.unread,
  });
}

// EXAMPLE CHATS ON HOME SCREEN
List<Message> chats = [
  Message(
    sender: ironMan,
    time: '5:30 PM',
    text: 'Hey dude! Even dead I\'m the hero. Love you 3000 guys.',
    unread: true,
  ),
  Message(
    sender: captainAmerica,
    time: '4:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    unread: true,
  ),
  Message(
    sender: blackWindow,
    time: '3:30 PM',
    text: 'WOW! this soul world is amazing, but miss you guys.',
    unread: false,
  ),
  Message(
    sender: spiderMan,
    time: '2:30 PM',
    text: 'I\'m exposed now. Please help me to hide my identity.',
    unread: true,
  ),
  Message(
    sender: hulk,
    time: '1:30 PM',
    text: 'HULK SMASH!!',
    unread: false,
  ),
  Message(
    sender: thor,
    time: '12:30 PM',
    text: 'I\'m hitting gym bro. I\'m immune to mortal deseases. Are you coming?',
    unread: false,
  ),
  Message(
    sender: scarletWitch,
    time: '11:30 AM',
    text: 'My twins are giving me headache. Give me some time please.',
    unread: false,
  ),
  Message(
    sender: captainMarvel,
    time: '12:45 AM',
    text: 'You\'re always special to me nick! But you know my struggle.',
    unread: false,
  ),
];

// EXAMPLE MESSAGES IN CHAT SCREEN
List<Message> messages = [





  Message(
    sender: currentUser,
    time: '2:30 PM',
    text: 'ddddd',
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '2:30 PM',
    text: ',',
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '2:30 PM',
    text: '!!!!!wwwwwwwwyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyywwwwwwwwwwwww!',
    unread: true,
  ),
  Message(
    sender: ironMan,
    time: '2:00 PM',
    text: '#########',
    unread: true,
  ),
  Message(
    sender: ironMan,
    time: '3:15 PM',
    text: 'dddddddd',
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '4:30 PM',
    text: 'الحمد لله',
    unread: true,
  ),
  Message(
    sender: ironMan,
    time: '3:45 PM',
    text: 'كيفك',
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '4:30 PM',
    text: 'وعليكم السلام',
    unread: true,
  ),
  Message(
    sender: ironMan,
    time: '5:30 PM',
    text: 'السلام عليكم',
    unread: true,
  ),
];