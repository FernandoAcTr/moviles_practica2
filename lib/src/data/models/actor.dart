import 'dart:convert';

class Actor {
  int? actorId;
  String? character;
  String? creditId;
  int? gender;
  int? id;
  String name;
  int? order;
  String? profilePath;

  Actor({
    this.actorId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    required this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromMap(Map<String, dynamic> json) : name = '' {
    actorId = json['actor_id'];
    character = json['character'];
    creditId = json['credit_id'];
    gender = json['gender'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    profilePath = json['profile_path'];
  }

  factory Actor.fromJson(String json) => Actor.fromMap(jsonDecode(json));

  String get fullProfilePath => profilePath == null
      ? 'https://camo.githubusercontent.com/341831200626efe3e0cf83317801fcac2200fbe2/68747470733a2f2f662e636c6f75642e6769746875622e636f6d2f6173736574732f323639323831302f323130343036312f34643839316563302d386637362d313165332d393230322d6637333934306431306632302e706e67'
      : 'https://image.tmdb.org/t/p/w500/$profilePath';
}
