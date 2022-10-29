import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:flutter/material.dart';

@immutable
@entity
class Todo extends Equatable{
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String? name;
  final String? description;
  final bool? isDone;
  final bool? isDeleted;

  const Todo({this.id, required this.name, required this.description,this.isDone,this.isDeleted});

  @override
  List<Object?> get props => [id,name,description,isDone,isDeleted];


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'isDone': isDone,
      'isDeleted': isDeleted,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      isDone: map['isDone'] as bool,
      isDeleted: map['isDeleted'] as bool,
    );
  }

  Todo copyWith({
    int? id,
    String? name,
    String? description,
    bool? isDone,
    bool? isDeleted,
  }) {
    return Todo(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}