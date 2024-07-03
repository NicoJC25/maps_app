part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class OnActivateManualMarkerEvent extends SearchEvent {}

class OnDeactivateManualMarkerEvent extends SearchEvent {}

//EXPLICACION DE TODO EL CODIGO:
/**
 * 
 * Un evento comun y corriente, se declaran los 2 eventos cuando se use la
 * ubicacion manual y cuando no.
 * 
 */