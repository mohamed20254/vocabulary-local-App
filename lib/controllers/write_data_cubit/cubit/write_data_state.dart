part of 'write_data_cubit.dart';

sealed class WriteDataState extends Equatable {
  const WriteDataState();

  @override
  List<Object> get props => [];
}

final class WriteDataInitial extends WriteDataState {}

final class WriteDataLoadngState extends WriteDataState {}

final class WriteDataFinishState extends WriteDataState {}

final class WriteDataFailure extends WriteDataState {
  final String message;

  const WriteDataFailure({required this.message});

  @override
  List<Object> get props => [message];
}
