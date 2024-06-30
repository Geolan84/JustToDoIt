import 'dart:convert';
import 'package:equatable/equatable.dart';

/// Task model.
class Task extends Equatable {
  /// UUID.
  final String id;

  /// Title of task.
  final String title;

  /// Priority of task.
  final Priority priority;

  /// Deadline of task.
  final DateTime? date;

  /// Task status.
  final bool isDone;

  /// Time of creation.
  final int createdAt;

  /// Time of last change.
  final int changedAt;

  /// Device id of last changer.
  final String deviceId;

  /// Constructor for Task model.
  const Task({
    required this.id,
    required this.title,
    required this.priority,
    required this.createdAt,
    required this.changedAt,
    required this.deviceId,
    this.isDone = false,
    this.date,
  });

  /// Creates a copy of task with new arguments.
  Task copyWith({
    String? id,
    String? title,
    Priority? priority,
    DateTime? date,
    int? createdAt,
    int? changedAt,
    bool? isDone,
    String? deviceId,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      priority: priority ?? this.priority,
      date: date ?? this.date,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
      changedAt: changedAt ?? this.changedAt,
      deviceId: deviceId ?? this.deviceId,
    );
  }

  @override
  List<Object?> get props => [
        title,
        priority,
        date,
        isDone,
      ];

  /// Converts task to map.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'text': title,
      'importance': priority.toString(),
      'deadline': date == null ? date : date!.millisecondsSinceEpoch ~/ 1000,
      'done': isDone,
      'created_at': createdAt,
      'changed_at': changedAt,
      'last_updated_by': deviceId
    };
  }

  /// Restore task from map.
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as String,
      title: map['text'] as String,
      priority: Priority.fromName(map['importance'] as String),
      date: map['deadline'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['deadline'] as int)
          : null,
      isDone: map['done'] as bool,
      createdAt: map['created_at'] as int,
      changedAt: map['changed_at'] as int,
      deviceId: map['last_updated_by'] as String,
    );
  }

  /// Serialize task to json.
  String toJson() => json.encode(toMap());

  /// Deserialize task from json.
  factory Task.fromJson(source) => Task.fromMap(source as Map<String, dynamic>);
}

/// Priority levels enum.
enum Priority {
  /// No priority.
  no,

  /// Low priority.
  low,

  /// High priority.
  high;

  @override
  String toString() {
    return switch (this) {
      Priority.no => 'low',
      Priority.low => 'basic',
      _ => 'important',
    };
  }

  factory Priority.fromName(String name) {
    return switch (name) {
      'low' => Priority.no,
      'basic' => Priority.low,
      _ => Priority.high,
    };
  }
}
