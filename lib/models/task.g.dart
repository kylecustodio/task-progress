// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task(
      json['title'] as String,
      Color(json['color']),
      json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String))
    ..complete = json['complete'] as bool
    ..isParent = json['isParent'] as bool
    ..progress = (json['progress'] as num)?.toDouble()
    ..dueDate = json['dueDate'] == null
        ? null
        : DateTime.parse(json['dueDate'] as String)
    ..subtasks = (json['subtasks'] as List)
        ?.map(
            (e) => e == null ? null : Task.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'title': instance.title,
      'complete': instance.complete,
      'isParent': instance.isParent,
      'progress': instance.progress,
      'color': instance.color.value,
      'startDate': instance.startDate?.toIso8601String(),
      'dueDate': instance.dueDate?.toIso8601String(),
      'subtasks': instance.subtasks
    };
