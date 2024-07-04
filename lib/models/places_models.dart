import 'dart:convert';

class PlacesResponse {
  final String type;
  final List<String> query;
  final List<Feature> features;
  final String attribution;

  PlacesResponse({
    required this.type,
    required this.query,
    required this.features,
    required this.attribution,
  });

  factory PlacesResponse.fromJson(String str) =>
      PlacesResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlacesResponse.fromMap(Map<String, dynamic> json) => PlacesResponse(
        type: json["type"],
        query: List<String>.from(json["query"].map((x) => x)),
        features:
            List<Feature>.from(json["features"].map((x) => Feature.fromMap(x))),
        attribution: json["attribution"],
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "query": List<dynamic>.from(query.map((x) => x)),
        "features": List<dynamic>.from(features.map((x) => x.toMap())),
        "attribution": attribution,
      };
}

class Feature {
  final String id;
  final String type;
  final List<String> placeType;
  //final int relevance;
  final Properties properties;
  final String textEs;
  final String placeNameEs;
  final String text;
  final String placeName;
  final List<double> center;
  final Geometry geometry;
  final List<Context> context;

  Feature({
    required this.id,
    required this.type,
    required this.placeType,
    //required this.relevance,
    required this.properties,
    required this.textEs,
    required this.placeNameEs,
    required this.text,
    required this.placeName,
    required this.center,
    required this.geometry,
    required this.context,
  });

  factory Feature.fromJson(String str) => Feature.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Feature.fromMap(Map<String, dynamic> json) => Feature(
        id: json["id"],
        type: json["type"],
        placeType: List<String>.from(json["place_type"].map((x) => x)),
        //relevance: json["relevance"],
        properties: Properties.fromMap(json["properties"]),
        textEs: json["text_es"],
        placeNameEs: json["place_name_es"],
        text: json["text"],
        placeName: json["place_name"],
        center: List<double>.from(json["center"].map((x) => x?.toDouble())),
        geometry: Geometry.fromMap(json["geometry"]),
        context:
            List<Context>.from(json["context"].map((x) => Context.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        "place_type": List<dynamic>.from(placeType.map((x) => x)),
        //"relevance": relevance,
        "properties": properties.toMap(),
        "text_es": textEs,
        "place_name_es": placeNameEs,
        "text": text,
        "place_name": placeName,
        "center": List<dynamic>.from(center.map((x) => x)),
        "geometry": geometry.toMap(),
        "context": List<dynamic>.from(context.map((x) => x.toMap())),
      };
}

class Context {
  final String id;
  final String mapboxId;
  final String textEs;
  final String text;
  final String? wikidata;
  final String? shortCode;
  final Language? languageEs;
  final Language? language;

  Context({
    required this.id,
    required this.mapboxId,
    required this.textEs,
    required this.text,
    this.wikidata,
    this.shortCode,
    this.languageEs,
    this.language,
  });

  factory Context.fromJson(String str) => Context.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Context.fromMap(Map<String, dynamic> json) => Context(
        id: json["id"],
        mapboxId: json["mapbox_id"],
        textEs: json["text_es"],
        text: json["text"],
        wikidata: json["wikidata"],
        shortCode: json["short_code"],
        languageEs: languageValues.map[json["language_es"]],
        language: languageValues.map[json["language"]],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "mapbox_id": mapboxId,
        "text_es": textEs,
        "text": text,
        "wikidata": wikidata,
        "short_code": shortCode,
        "language_es": languageValues.reverse[languageEs],
        "language": languageValues.reverse[language],
      };
}

enum Language { ES }

final languageValues = EnumValues({"es": Language.ES});

class Geometry {
  final List<double> coordinates;
  final String type;

  Geometry({
    required this.coordinates,
    required this.type,
  });

  factory Geometry.fromJson(String str) => Geometry.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Geometry.fromMap(Map<String, dynamic> json) => Geometry(
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
        type: json["type"],
      );

  Map<String, dynamic> toMap() => {
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "type": type,
      };
}

class Properties {
  final String? foursquare;
  final bool? landmark;
  final String? address;
  final String? category;

  Properties({
    required this.foursquare,
    required this.landmark,
    required this.address,
    required this.category,
  });

  factory Properties.fromJson(String str) =>
      Properties.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Properties.fromMap(Map<String, dynamic> json) => Properties(
        foursquare: json["foursquare"],
        landmark: json["landmark"],
        address: json["address"],
        category: json["category"],
      );

  Map<String, dynamic> toMap() => {
        "foursquare": foursquare,
        "landmark": landmark,
        "address": address,
        "category": category,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}


//Configuracion traida del quick.io al hacer la peticion get en postman
//IMPORTANTE: 
/**
 * 
 * Si se esta creando una aplicacion como esta que tiene funcionalidades de mapa,
 * hay que recordar modificar este archivo ya sea comentando parametros o
 * cambiandolos si se tiene el conocimiento, por si al ejecutar, el programa
 * falla en este archivo.
 * 
 */