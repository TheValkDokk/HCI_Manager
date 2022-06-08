// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hci_manager/models/pharmacyUser.dart';

class Message {
  PharmacyUser user;
  String? msg;
  DateTime time;
  Message({
    required this.user,
    this.msg,
    required this.time,
  });

  Message copyWith({
    PharmacyUser? user,
    String? msg,
    DateTime? time,
  }) {
    return Message(
      user: user ?? this.user,
      msg: msg ?? this.msg,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toMap(),
      'msg': msg,
      'time': time.millisecondsSinceEpoch,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      user: PharmacyUser.fromMap(map['user'] as Map<String, dynamic>),
      msg: map['msg'] != null ? map['msg'] as String : null,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Message(user: $user, msg: $msg, time: $time)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Message &&
        other.user == user &&
        other.msg == msg &&
        other.time == time;
  }

  @override
  int get hashCode => user.hashCode ^ msg.hashCode ^ time.hashCode;
}
