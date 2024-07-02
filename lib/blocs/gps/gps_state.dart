part of 'gps_bloc.dart';

class GpsState extends Equatable {
  final bool isGpsEnabled;
  final bool isGpsPermissionGranted;

  bool get isAllGranted => isGpsEnabled && isGpsPermissionGranted;

  const GpsState(
      {required this.isGpsEnabled, required this.isGpsPermissionGranted});

  GpsState copyWith(
          {bool? isGpsEnabled, bool? isGpsPermissionGranted}) =>
      GpsState(
          isGpsEnabled: isGpsEnabled ?? this.isGpsEnabled,
          isGpsPermissionGranted:
              isGpsPermissionGranted ?? this.isGpsPermissionGranted);

  @override
  List<Object> get props => [isGpsEnabled, isGpsPermissionGranted];
}

//EXPLICACION DE TODO EL CODIGO:
/**
 * 
 * Se utiliza la clase que crea el comando, "GpsState", la cual se extiende de 
 * "Equatable", donde, se definen las variables del archivo "gps_event" y,
 * se define un booleano tipo "get" que solo se pondra en "true" si los
 * dos permisos estan en "true".
 * 
 * Se crea un constructor para las variables de antes y luego, se genera una
 * copia de las variables con sus valores. Se crean las 2 copias de las variables
 * hechas anteriormente, solo que ahora pueden tener valor nulo.
 * 
 * Se envia un estado en donde se establecen sus valores como nulos, o como se
 * traigan de acuerdo a los otros archivos donde se hagan sus validaciones.
 * 
 * Por ultimo, se envian en la lista de objetos tipo "get" vista en el otro
 * archivo tambien, con sus valores ya definidos.
 * 
 */