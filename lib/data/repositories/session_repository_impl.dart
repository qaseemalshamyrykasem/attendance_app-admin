/// تنفيذ مستودع الجلسات - يربط قاعدة البيانات بالطبقة الدومين
library;

import 'package:drift/drift.dart' as drift;
import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';
import '../../services/database/local_database.dart';

class SessionRepositoryImpl implements SessionRepository {
  final AppDatabase _database;

  SessionRepositoryImpl(this._database);

  @override
  Future<List<SessionEntity>> getAllSessions() async {
    final sessions = await _database.getAllSessions();
    return sessions.map(_toEntity).toList();
  }

  @override
  Future<List<SessionEntity>> getActiveSessions() async {
    final sessions = await _database.getActiveSessions();
    return sessions.map(_toEntity).toList();
  }

  @override
  Future<SessionEntity?> getSessionById(String id) async {
    final session = await _database.getSessionById(id);
    return session != null ? _toEntity(session) : null;
  }

  @override
  Future<SessionEntity?> getSessionByToken(String token) async {
    final session = await _database.getSessionByToken(token);
    return session != null ? _toEntity(session) : null;
  }

  @override
  Future<SessionEntity> createSession(SessionEntity session) async {
    final companion = SessionsCompanion(
      id: drift.Value(session.id),
      courseId: drift.Value(session.courseId),
      sectionId: drift.Value(session.sectionId),
      date: drift.Value(session.date),
      startTime: drift.Value(session.startTime),
      endTime: drift.Value(session.endTime),
      status: drift.Value(session.status),
      ip: drift.Value(session.ip),
      port: drift.Value(session.port),
      token: drift.Value(session.token),
      qrData: drift.Value(session.qrData),
      createdAt: drift.Value(session.createdAt ?? DateTime.now()),
    );
    await _database.insertSession(companion);
    return session;
  }

  @override
  Future<SessionEntity> updateSession(SessionEntity session) async {
    final dbSession = await _database.getSessionById(session.id);
    if (dbSession == null) {
      throw Exception('الجلسة غير موجودة');
    }
    final updated = dbSession.copyWith(
      courseId: session.courseId,
      sectionId: session.sectionId,
      date: session.date,
      startTime: session.startTime,
      endTime: session.endTime ?? dbSession.endTime,
      status: session.status,
      ip: session.ip ?? dbSession.ip,
      port: session.port ?? dbSession.port,
      token: session.token ?? dbSession.token,
      qrData: session.qrData ?? dbSession.qrData,
      updatedAt: DateTime.now(),
    );
    await _database.updateSession(updated);
    return _toEntity(updated);
  }

  @override
  Future<SessionEntity> closeSession(String id) async {
    final session = await _database.getSessionById(id);
    if (session == null) {
      throw Exception('الجلسة غير موجودة');
    }
    final closed = session.copyWith(
      status: 'closed',
      endTime: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await _database.updateSession(closed);
    return _toEntity(closed);
  }

  /// تحويل نموذج قاعدة البيانات إلى كيان الدومين
  SessionEntity _toEntity(Session session) {
    return SessionEntity(
      id: session.id,
      courseId: session.courseId,
      sectionId: session.sectionId,
      date: session.date,
      startTime: session.startTime,
      endTime: session.endTime,
      status: session.status,
      ip: session.ip,
      port: session.port,
      token: session.token,
      qrData: session.qrData,
      createdAt: session.createdAt,
      updatedAt: session.updatedAt,
    );
  }
}
