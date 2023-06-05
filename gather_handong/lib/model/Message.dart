class Message {
  String content;
  String idFrom;
  String idTo;
  // timeStamp createdTime
  String type;

  Message(
      {required this.content,
      required this.idFrom,
      required this.idTo
      // ,required createdTime
      ,
      required type});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        content: json['content'],
        idFrom: json['idFrom'],
        idTo: json['idTo'],
        // createdTime: json['createdTime'],
        type: json['type']);
  }

  toJson() {
    return {
      'content': content,
      'idFrom': idFrom,
      'idTo': idTo,
      // 'createdTime': createdTime,
      'type': type,
    };
  }
}
