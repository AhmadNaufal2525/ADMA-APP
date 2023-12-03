import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sima_app/src/datasource/aset_remote_datasource.dart';
import 'package:sima_app/src/model/pengembalian_response_model.dart';
import 'package:sima_app/src/presentation/screen/home/widgets/empty_data_widget.dart';

part 'pengembalian_event.dart';
part 'pengembalian_state.dart';

class PengembalianBloc extends Bloc<PengembalianEvent, PengembalianState> {
  final AsetRemoteDataSource asetRemoteDataSource;

  PengembalianBloc({required this.asetRemoteDataSource}) : super(PengembalianInitial()) {
    on<PengembalianEvent>((event, emit) async {
      if (event is GetPengembalianEvent) {
        emit(PengembalianLoading());

        try {
          final result = await asetRemoteDataSource.loadPengembalianData(event.userId, event.token);

          if (result.pengembalian != null && result.pengembalian!.isNotEmpty) {
            emit(PengembalianSuccess(pengembalianResponse: result));
          } else {
             emit(PengembalianFailed(errorWidget: const EmptyDataWidget())); 
          }
        } catch (e) {
           emit(PengembalianFailed(errorWidget: const EmptyDataWidget())); 
        }
      }
    });
  }
}
