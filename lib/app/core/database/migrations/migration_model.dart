import 'package:sqflite/sqflite.dart';

abstract class MigrationModel {
  void create(Batch batch);
  void upgrade(Batch batch);
}
