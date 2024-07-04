import 'package:aplikasi_rumah_sakit/models/City_model.dart';

sealed class CityState {}

final class CityInitial extends CityState {}

final class CityLoading extends CityState {}

final class CityLoaded extends CityState {
  final City city;

  CityLoaded(this.city);
}

final class CityError extends CityState {
  final String message;

  CityError(this.message);
}
