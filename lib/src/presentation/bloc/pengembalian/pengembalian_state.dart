part of 'pengembalian_bloc.dart';

abstract class PengembalianState {}

class PengembalianInitial extends PengembalianState {}

final class PengembalianLoading extends PengembalianState {}

final class PengembalianSuccess extends PengembalianState{
  final PengembalianResponseModel pengembalianResponse;

  PengembalianSuccess({required this.pengembalianResponse});
}

class PengembalianFailed extends PengembalianState {
  final Widget errorWidget;

  PengembalianFailed({required this.errorWidget});
}