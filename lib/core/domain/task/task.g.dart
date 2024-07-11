// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      id: json['id'] as String,
      text: json['text'] as String,
      importance: $enumDecode(_$ImportanceEnumMap, json['importance']),
      createdAt: (json['created_at'] as num).toInt(),
      changedAt: (json['changed_at'] as num).toInt(),
      deviceId: json['last_updated_by'] as String,
      isDone: json['done'] as bool? ?? false,
      deadline: (json['deadline'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'importance': _$ImportanceEnumMap[instance.importance]!,
      'deadline': instance.deadline,
      'done': instance.isDone,
      'created_at': instance.createdAt,
      'changed_at': instance.changedAt,
      'last_updated_by': instance.deviceId,
    };

const _$ImportanceEnumMap = {
  Importance.low: 'low',
  Importance.basic: 'basic',
  Importance.important: 'important',
};
