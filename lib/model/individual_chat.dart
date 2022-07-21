class IndividualChatModel {
  final int id;
  final DateTime date;
  final String message;
  final int individualRoomId;
  final String myUserId;

  IndividualChatModel(
      {this.id, this.date, this.message, this.individualRoomId, this.myUserId});

  factory IndividualChatModel.fromJson(dynamic jsonObj) {
    return IndividualChatModel(
        id: jsonObj['id'] as int,
        individualRoomId: jsonObj['userId'] as int,
        message: jsonObj['message'] as String,
        date: DateTime.parse(jsonObj['date']),
        myUserId: jsonObj['myUserId'] as String);
  }
}
