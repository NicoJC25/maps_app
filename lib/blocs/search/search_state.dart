part of 'search_bloc.dart';

class SearchState extends Equatable {
  final bool displayManualMarker;
  final List<Feature> places;
  final List<Feature> history;

  const SearchState(
      {this.displayManualMarker = false,
      this.places = const [],
      this.history = const []});

  SearchState copyWith({
    bool? displayManualMarker,
    List<Feature>? places,
    List<Feature>? history,
  }) =>
      SearchState(
        displayManualMarker: displayManualMarker ?? this.displayManualMarker,
        places: places ?? this.places,
        history: history ?? this.history,
      );

  @override
  List<Object> get props => [displayManualMarker, places, history];
}

//EXPLICACION DE TODO EL CODIGO.
/**
 * 
 * Lineas 5 y 6: Creacion de las variables necesarias para los lugares y el historial.
 * 
 * Lineas 8 a la 11: Implementacion de estas variables al constructor
 * 
 * Lineas 13 a la 22: Implementacion de estas variables al "copyWith"
 * 
 */