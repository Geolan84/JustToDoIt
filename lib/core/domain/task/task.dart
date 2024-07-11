// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

/// Task model.
@immutable
@JsonSerializable()
class Task {
  /// UUID.
  final String id;

  /// Text of task.
  final String text;

  /// Priority of task.
  final Importance importance;

  /// Deadline of task.
  final int? deadline;

  /// Task status.
  @JsonKey(name: 'done')
  final bool isDone;

  /// Time of creation.
  @JsonKey(name: 'created_at')
  final int createdAt;

  /// Time of last change.
  @JsonKey(name: 'changed_at')
  final int changedAt;

  /// Device id of last changer.
  @JsonKey(name: 'last_updated_by')
  final String deviceId;

  /// Constructor for Task model.
  const Task({
    required this.id,
    required this.text,
    required this.importance,
    required this.createdAt,
    required this.changedAt,
    required this.deviceId,
    this.isDone = false,
    this.deadline,
  });

  /// Factory to create the task from json representation.
  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  /// Converts task to json representation.
  Map<String, dynamic> toJson() => _$TaskToJson(this);

  Task copyWith({
    String? id,
    String? text,
    Importance? importance,
    int? deadline,
    bool? isDone,
    int? createdAt,
    int? changedAt,
    String? deviceId,
    bool resetDeadline = false,
  }) {
    return Task(
      id: id ?? this.id,
      text: text ?? this.text,
      importance: importance ?? this.importance,
      deadline: resetDeadline ? null : deadline ?? this.deadline,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
      changedAt: changedAt ?? this.changedAt,
      deviceId: deviceId ?? this.deviceId,
    );
  }
}

/// Priority levels enum.
enum Importance {
  /// Low priority.
  low,

  /// Basic priority.
  basic,

  /// High priority.
  important;

  @override
  String toString() {
    return switch (this) {
      Importance.low => 'low',
      Importance.basic => 'basic',
      _ => 'important',
    };
  }

  factory Importance.fromName(String name) {
    return switch (name) {
      'low' => Importance.low,
      'basic' => Importance.basic,
      _ => Importance.important,
    };
  }
}
