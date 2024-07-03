part of 'search_bloc.dart';

class SearchState extends Equatable {
  final bool displayManualMarker;

  const SearchState({this.displayManualMarker = false});

  SearchState copyWith({bool? displayManualMarker}) => SearchState(
      displayManualMarker: displayManualMarker ?? this.displayManualMarker);

  @override
  List<Object> get props => [displayManualMarker];
}

//EXPLICACION DE TODO EL CODIGO:
/**
 * 
 * Un gestor de estado comun y corriente. Se gestiona la pantalla que se va a
 * mostrar al usar la ubicacion manual.
 * 
 */