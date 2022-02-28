import 'dart:convert';

class Transporter {
  final String userName;
  final String id;
  Transporter({
    required this.userName,
    required this.id,
  });

  Transporter copyWith({
    String? userName,
    String? id,
  }) {
    return Transporter(
      userName: userName ?? this.userName,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'id': id,
    };
  }

  factory Transporter.fromMap(Map<String, dynamic> map) {
    return Transporter(
      userName: map['userName'] ?? '',
      id: map['_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Transporter.fromJson(String source) =>
      Transporter.fromMap(json.decode(source));

  @override
  String toString() => 'Transporter(userName: $userName, id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Transporter && other.userName == userName && other.id == id;
  }

  @override
  int get hashCode => userName.hashCode ^ id.hashCode;
}
