part of 'peminjaman_bloc.dart';

abstract class PeminjamanState {}

class PeminjamanInitial extends PeminjamanState {}

final class PeminjamanLoading extends PeminjamanState {}

final class PeminjamanSuccess extends PeminjamanState{
 final PeminjamanResponseModel peminjamanResponse;

  PeminjamanSuccess({required this.peminjamanResponse});
}

final class PeminjamanFailed extends PeminjamanState{
  final Widget errorWidget;

  PeminjamanFailed({required this.errorWidget});
}