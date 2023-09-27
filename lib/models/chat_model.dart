class ChatMessage {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final String timestamp;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.timestamp,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'].toString(),
      senderId: json['sender_id'].toString(),
      receiverId: json['reciever_id'].toString(),
      content: json['content'].toString(),
      timestamp: json['created_at'].toString(),
    );
  }
}
