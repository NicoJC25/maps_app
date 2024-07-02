import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  StreamSubscription? gpsServiceSubscription;

  GpsBloc()
      : super(const GpsState(
            isGpsEnabled: false, isGpsPermissionGranted: false)) {
    on<GpsAndPermissionEvent>((event, emit) => emit(state.copyWith(
        isGpsEnabled: event.isGpsEnabled,
        isGpsPermissionGranted: event.isGpsPermissionGranted)));

    _init();
  }

  Future<void> _init() async {
    final gpsInitStatus = await Future.wait([
      _checkGpsStatus(),
      _isPermissionGranted(),
    ]);

    add(GpsAndPermissionEvent(
      isGpsEnabled: gpsInitStatus[0],
      isGpsPermissionGranted: gpsInitStatus[1],
    ));
  }

  Future<bool> _isPermissionGranted() async {
    final isGranted = await Permission.location.isGranted;
    return isGranted;
  }

  Future<bool> _checkGpsStatus() async {
    final isEnable = await Geolocator.isLocationServiceEnabled();

    gpsServiceSubscription =
        Geolocator.getServiceStatusStream().listen((event) {
      final isEnabled = (event.index == 1) ? true : false;
      add(GpsAndPermissionEvent(
        isGpsEnabled: isEnabled,
        isGpsPermissionGranted: state.isGpsPermissionGranted,
      ));
    });

    return isEnable;
  }

  Future<void> askGpsAccess() async {
    final status = await Permission.location.request();

    switch (status) {
      case PermissionStatus.granted:
        add(GpsAndPermissionEvent(
            isGpsEnabled: state.isGpsEnabled, isGpsPermissionGranted: true));
        break;

      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.provisional:
        add(GpsAndPermissionEvent(
            isGpsEnabled: state.isGpsEnabled, isGpsPermissionGranted: false));
        openAppSettings();
    }
  }

  @override
  Future<void> close() {
    gpsServiceSubscription?.cancel();
    return super.close();
  }
}


//EXPLICACION DE TODO EL CODIGO:
/**
 * 
 * NOTA: Para la creacion de este y los demas blocs, se utiliza un comando ya sea
 * en la parte superior del VSC o, dandole click derecho a alguna de las carpetas,
 * se selecciona una opcion llamada "Bloc: New Bloc" o, se escribe a mano en el
 * buscador superior y se selecciona la carpeta a crear el bloc. Estos comandos
 * estan disponibles si se instala la extension "bloc" en VSC.
 * 
 * Lineas 11 a la 22: Se crea una clase mayor llamada "GpsBloc", la cual se crea
 * de forma automatica con el uso de comandos aclarados anteriormente, adicional
 * a los otros 2 archivos que se crean a la par de este. 
 * 
 * En el constructor, se llamada al archivo correspondiente a los estados del bloc
 * y se establece que los booleanos correspondientes a ambos permisos, estaran en
 * false o desactivados. Se establece una emision que es como mandar estados de
 * algo en la clase padre, ya que el metodo "emit" no funciona en otras clases
 * diferentes. Se hace una copia de 2 eventos, uno para cada booleano tambien
 * llamando a la clase del archivo de los eventos. Por ultimo, se llama
 * a una funcion asignada para correr las clases.
 * 
 * Lineas 24 a la 34: Se crea la clase "_init" correspondiente a correr
 * las otras clases y procesos alternos pero que se requieran al inicio del 
 * programa, mas que todo para que la clase padre se vea organizada. Esta
 * clase será una promesa, en donde se hará espera de que los otros procesos
 * finalicen para acceder a esta lista, y, llamar a las 2 clases correspondientes
 * a los procesos de verificacion de los permisos.
 * 
 * Luego, por medio de un "add", se ejecuta la clase correspondiente a los
 * estados para asignar los nuevos estados de los permisos, pasando ambas
 * clases como argumentos de acuerdo a sus posiciones en la lista de antes.
 * 
 * Lineas 36 a la 39: Se crea una clase "_isPermissionGranted", que va a tener
 * el valor de el permiso de la ubicacion en positivo, o true.
 * 
 * Lineas 41 a la 54: Se crea una clase "_checkGpsStatus" que va a verificar
 * el estado del gps si esta activo o no, en este caso, crea una variable
 * que tendrá como valor una validacion hecha por un metodo integrado de
 * "geolocator" para el gps activo o inactivo. Luego, mediante una variable
 * de tipo "StreamSubscription" que se estableció al principio de la clase
 * padre, se le dará como valor una validacion con el metodo integrado
 * "getServiceStatusStream", que escuchará el evento del stream o flujo
 * del gps, por medio de un condicional se indica que si la respuesta es
 * "1", esta activo y es "true", si no, es "false".
 * 
 * Finalmente, por medio de un "add" a la clase de los estados de los permisos,
 * se le manda el valor obtenido anteriormente en la validacion del gps activo,
 * y, para la validacion del permiso de la ubicacion, se manda a si mismo el
 * estado que lleve esa variable hasta el momento.
 * 
 * Lineas 56 a la 74: Se crea una clase "askGpsAccess" que va a hacer la 
 * solicitud del permiso de la ubicacion, asignando esta solicitud en una
 * variable al inicio de la clase con metodos integrados "Permission.location.request();"
 * para luego, asignarlo a un switch case: Si el estado es garantizado o habilitado,
 * se manda a la clase de los estados el valor del permiso como true y el estado
 * del gps habilitado como el que ya venga ejecutando desde antes, pero, si se
 * va por medio de cualquier otra situacion donde el permiso no sea garantizado,
 * se establece en falso y adicional, con el metodo integrado "openAppSettings",
 * se manda a las configuraciones del dispositivo para activarlo alli manualmente.
 * 
 * Lineas 76 a la 81: Se crea una clase privada "close" que tomará la variable
 * definida al inicio de la clase padre y, le indica, que cierre el flujo del
 * gps cuando ya no se este en uso la aplicacion u ocurra otro proceso que no
 * la este ejecutando.
 * 
 */