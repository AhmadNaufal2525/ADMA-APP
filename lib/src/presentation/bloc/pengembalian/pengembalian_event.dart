part of 'pengembalian_bloc.dart';

abstract class PengembalianEvent {}

class GetPengembalianEvent extends PengembalianEvent {
  final String userId;
  final String token;
  GetPengembalianEvent({required this.userId, required this.token});
}