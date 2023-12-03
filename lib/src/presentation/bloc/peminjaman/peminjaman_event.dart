part of 'peminjaman_bloc.dart';

abstract class PeminjamanEvent {}

class GetPeminjamanEvent extends PeminjamanEvent {
  final String userId;
  final String token;
  GetPeminjamanEvent({required this.userId, required this.token});
}