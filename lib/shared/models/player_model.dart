import 'dart:convert';

class PlayerModel {
  String name;
  String status;
  int roundsUnable;

  PlayerModel({
    this.name = '',
    this.status = 'able',
    this.roundsUnable = 0,
  });

  PlayerModel copyWith({
    String? name,
    String? status,
    int? roundsUnable,
  }) {
    return PlayerModel(
      name: name ?? this.name,
      status: status ?? this.status,
      roundsUnable: roundsUnable ?? this.roundsUnable,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'status': status,
      'roundsUnable': roundsUnable,
    };
  }

  factory PlayerModel.fromMap(Map<String, dynamic> map) {
    return PlayerModel(
      name: map['name'],
      status: map['status'],
      roundsUnable: map['roundsUnable'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PlayerModel.fromJson(String source) =>
      PlayerModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'PlayerModel(name: $name, status: $status, roundsUnable: $roundsUnable)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PlayerModel &&
        other.name == name &&
        other.status == status &&
        other.roundsUnable == roundsUnable;
  }

  @override
  int get hashCode => name.hashCode ^ status.hashCode ^ roundsUnable.hashCode;
}
