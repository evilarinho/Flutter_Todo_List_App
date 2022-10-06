import 'package:flutter_todo_list_provider/app/core/database/migrations/migration_model.dart';
import 'package:sqflite/sqflite.dart';

class MigrationV1 implements MigrationModel {
  @override
  void create(Batch batch) {
    batch.execute('''
      create table todo(
        id Integer primary key autoincrement,
        descricao varchar(500) not null,
        data_hora datetime,
        finalizado integer
      )
  ''');
  }

  @override
  void upgrade(Batch batch) {}
}
