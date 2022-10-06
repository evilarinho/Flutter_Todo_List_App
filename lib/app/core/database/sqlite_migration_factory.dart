import 'package:flutter_todo_list_provider/app/core/database/migrations/migration_v1.dart';
import 'migrations/migration_model.dart';

class SqliteMigrationFactory {
  List<MigrationModel> getCreateMigration() => [
        MigrationV1(),
      ];

  List<MigrationModel> getUpgradeMigration(int version) => [];
}
