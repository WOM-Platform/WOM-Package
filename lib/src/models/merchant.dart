import 'package:wom_package/src/models/pos.dart';

class Merchant {
  final String id;
  final String name;
  final String address;
  final String cap;
  final String city;
  final String vatNumber;
  final String profileImgUrl;
  final List<Pos> posList;

  Merchant(
      {this.id,
      this.name,
      this.address,
      this.cap,
      this.city,
      this.vatNumber,
      this.profileImgUrl,
      this.posList});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Merchant &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          address == other.address &&
          cap == other.cap &&
          city == other.city &&
          vatNumber == other.vatNumber &&
          profileImgUrl == other.profileImgUrl &&
          posList == other.posList);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      address.hashCode ^
      cap.hashCode ^
      city.hashCode ^
      vatNumber.hashCode ^
      profileImgUrl.hashCode ^
      posList.hashCode;

  @override
  String toString() {
    return 'Merchant{' +
        ' id: $id,' +
        ' name: $name,' +
        ' address: $address,' +
        ' cap: $cap,' +
        ' city: $city,' +
        ' vatNumber: $vatNumber,' +
        ' profileImgUrl: $profileImgUrl,' +
        ' posList: $posList,' +
        '}';
  }

  Merchant copyWith({
    String id,
    String name,
    String address,
    String cap,
    String city,
    String vatNumber,
    String profileImgUrl,
    List<Pos> posList,
  }) {
    return Merchant(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      cap: cap ?? this.cap,
      city: city ?? this.city,
      vatNumber: vatNumber ?? this.vatNumber,
      profileImgUrl: profileImgUrl ?? this.profileImgUrl,
      posList: posList ?? this.posList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'address': this.address,
      'cap': this.cap,
      'city': this.city,
      'vatNumber': this.vatNumber,
      'profileImgUrl': this.profileImgUrl,
      'posList': this.posList,
    };
  }

  factory Merchant.fromMap(Map<String, dynamic> map) {
    return new Merchant(
      id: map['id'] as String,
      name: map['name'] as String,
      address: map['address'] as String,
      cap: map['cap'] as String,
      city: map['city'] as String,
      vatNumber: map['vatNumber'] as String,
      profileImgUrl: map['profileImgUrl'] as String,
      posList: map['posList'] as List<Pos>,
    );
  }
}
