import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sima_app/src/datasource/aset_remote_datasource.dart';
import 'package:sima_app/src/model/peminjaman_response_model.dart';
import 'package:sima_app/src/presentation/screen/home/widgets/empty_data_widget.dart';

part 'peminjaman_event.dart';
part 'peminjaman_state.dart';

class PeminjamanBloc extends Bloc<PeminjamanEvent, PeminjamanState> {
  final AsetRemoteDataSource asetRemoteDataSource;

  PeminjamanBloc({required this.asetRemoteDataSource}) : super(PeminjamanInitial()) {
    on<PeminjamanEvent>((event, emit) async {
      if (event is GetPeminjamanEvent) {
        emit(PeminjamanLoading());

        try {
          final result = await asetRemoteDataSource.loadPeminjamanData(event.userId, event.token);

          if (result.peminjaman != null && result.peminjaman!.isNotEmpty) {
            emit(PeminjamanSuccess(peminjamanResponse: result));
          } else {
             emit(PeminjamanFailed(errorWidget: const EmptyDataWidget())); 
          }
        } catch (e) {
           emit(PeminjamanFailed(errorWidget: const EmptyDataWidget())); 
        }
      }
    });
  }
}
