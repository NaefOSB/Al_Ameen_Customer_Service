class VM_Chat {
  final int ChatId;
  final String Message;
  final int Type;
  final int RoomId;
  final String UserId;

  VM_Chat({this.ChatId, this.Message, this.Type, this.RoomId, this.UserId});

  Map<String, dynamic> toJson() => {
        'ChatId': ChatId,
        'Message': '$Message',
        'Type': Type,
        'RoomId': RoomId,
        'UserId': '$UserId'
      };
}
