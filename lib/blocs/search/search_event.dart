part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class OnActivateManualMarkerEvent extends SearchEvent {}

class OnDeactivateManualMarkerEvent extends SearchEvent {}

class OnNewPlacesFoundEvent extends SearchEvent {
  final List<Feature> places;
  const OnNewPlacesFoundEvent(this.places);
}

class AddToHistoryEvent extends SearchEvent {
  final Feature place;
  const AddToHistoryEvent(this.place);
}

//EXPLICACION DE TODO EL CODIGO:
/**
 * 
 * Lineas 14 a la 17: Creacion de la clase corrrespondiente al evento de las
 * ubicaciones. Se manda una lista donde iran las ubicaciones.
 * 
 * Lineas 19 a la 22: Creacion de la clase correspondiente al evento del
 * historial de busqueda. Se manda un objeto tipo "Feature" para ya agarrar
 * el objeto con la busqueda como tal.
 * 
 */