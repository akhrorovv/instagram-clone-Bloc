import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

class SplashInitialState extends SplashState {}

class SplashLoadingState extends SplashState {}