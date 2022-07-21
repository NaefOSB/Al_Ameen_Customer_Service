class Chat {
  final int id;
  final DateTime date;
  final String message;
  final int type;
  final int roomId;
  final String userId;
  final String userName;

  Chat({this.id, this.date, this.message, this.type, this.roomId, this.userId,this.userName});

  factory Chat.fromJson(dynamic jsonObj) {
    return Chat(
        id: jsonObj['id'] as int,
        userId: jsonObj['userId'] as String,
        message: jsonObj['message'] as String,
        type: jsonObj['type'] as int,
        date: DateTime.parse(jsonObj['date']),
        roomId: jsonObj['roomId'] as int,
        userName: jsonObj['userName'] as String
    );
  }
}
