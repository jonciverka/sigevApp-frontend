import 'package:sigev/domain/models/chats.dart';
import 'package:sigev/domain/models/tramite.dart';

abstract class TramiteSupportState {
  TramiteSupportState({required this.tramite, required this.chats});

  final Tramite tramite;
  final List<Mensaje> chats;
  TramiteSupportState copyWith();
}

class TramiteSupportInitial extends TramiteSupportState {
  TramiteSupportInitial({required super.tramite}) : super(chats: []);

  @override
  TramiteSupportState copyWith() => TramiteSupportInitial(tramite: tramite);
}

class TramiteSupportLoading extends TramiteSupportState {
  TramiteSupportLoading({Tramite? tramite, List<Mensaje>? chats})
    : super(tramite: tramite ?? Tramite(), chats: chats ?? []);

  @override
  TramiteSupportState copyWith({Tramite? tramite, List<Mensaje>? chats}) =>
      TramiteSupportLoading(
        tramite: tramite ?? this.tramite,
        chats: chats ?? this.chats,
      );
}

class TramiteSupportData extends TramiteSupportState {
  TramiteSupportData({required super.tramite, required super.chats}) : super();

  @override
  TramiteSupportState copyWith({Tramite? tramite, List<Mensaje>? chats}) =>
      TramiteSupportData(tramite: tramite ?? this.tramite, chats: chats ?? []);
}

class TramiteSupportError extends TramiteSupportState {
  TramiteSupportError() : super(tramite: Tramite(), chats: []);

  @override
  TramiteSupportState copyWith({Tramite? tramite, List<Mensaje>? chats}) =>
      TramiteSupportError();
}

class TramiteSupportEmpty extends TramiteSupportState {
  TramiteSupportEmpty({required super.tramite}) : super(chats: []);

  @override
  TramiteSupportState copyWith({Tramite? tramite, List<Mensaje>? chats}) =>
      TramiteSupportEmpty(tramite: tramite ?? this.tramite);
}
