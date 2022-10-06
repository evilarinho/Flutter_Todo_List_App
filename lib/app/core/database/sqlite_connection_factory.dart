// ignore_for_file: constant_identifier_names

import 'package:flutter_todo_list_provider/app/core/database/sqlite_migration_factory.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';

class SqliteConnectionFactory {
  // =====================================================================================
  // ===================== Constantes da versão e nome do database =======================
  // =====================================================================================
  static const int _VERSION = 1;
  static const String _DATABASE_NAME = 'TODO_LIST_PROVIDER';

  // =====================================================================================
  // ================== Única instancia que iremos criar da classe (static) ==============
  // ============================ Apenas uma conexão com o SqLite ========================
  // =====================================================================================
  static SqliteConnectionFactory? _instance;

  // =====================================================================================
  // ============= Variáveis criação doe um database e instância do lock =================
  // =====================================================================================
  Database? _db;
  final Lock _lock = Lock();

  // =====================================================================================
  // =============================== Construtor privado ==================================
  // =====================================================================================

  SqliteConnectionFactory._();

  // =====================================================================================
  // ============================ Controle da instância ==================================
  // =====================================================================================

  factory SqliteConnectionFactory() {
    // Checa se o _instance é nulo, e se for transforma o _instance
    _instance ??= SqliteConnectionFactory._();
    return _instance!;
  }

  // =====================================================================================
  // =================== Função que abre a conexão do database ===========================
  // =====================================================================================

  Future<Database> openConnection() async {
    String databasePath = await getDatabasesPath();
    String databasePathFinal = join(databasePath, _DATABASE_NAME);
    if (_db == null) {
      _lock.synchronized(() async {
        // Checa se o _db é nulo, e se for transforma o _db
        _db ??= await openDatabase(
          databasePathFinal,
          version: _VERSION,
          onConfigure: _onConfigure,
          onCreate: _onCreate,
          onUpgrade: _onUpgrade,
          onDowngrade: _onDowngrade,
        );
      });
    }
    return _db!;
  }

  // =====================================================================================
  // =================== Função que fecha a conexão do database ==========================
  // =====================================================================================

  void closeConnection() {
    _db?.close();
    _db = null;
  }

  // ? ===================================================================================
  // =====================================================================================
  // * =============== FUNÇÕES RELACIONADAS À CRIAÇÃO DO DATABASE ========================
  // =====================================================================================
  // ? ===================================================================================

  // =====================================================================================
  // =================== Função de Configuração do banco de dados ========================
  // =====================================================================================

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  // =====================================================================================
  // ====================== Função de Criação do banco de dados ==========================
  // =====================================================================================

  Future<void> _onCreate(Database db, int version) async {
    final batch = db.batch();
    final migrations = SqliteMigrationFactory().getCreateMigration();
    for (var migration in migrations) {
      migration.create(batch);
    }
    batch.commit();
  }

  // =====================================================================================
  // ==================== Função de Atualização do banco de dados ========================
  // =====================================================================================

  Future<void> _onUpgrade(Database db, int oldVersion, int version) async {
    final batch = db.batch();
    final migrations = SqliteMigrationFactory().getUpgradeMigration(oldVersion);
    for (var migration in migrations) {
      migration.upgrade(batch);
    }
    batch.commit();
  }

  // =====================================================================================
  // ================= Função de Desatualização do banco de dados ========================
  // =====================================================================================

  Future<void> _onDowngrade(Database db, int oldVersion, int version) async {}
}

  // =====================================================================================
