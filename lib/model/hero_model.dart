import 'package:heroes/heroes.dart';

class HeroModel extends ManagedObject<_HeroModel> implements _HeroModel {}

class _HeroModel {
  @primaryKey
  int id;

  @Column(unique: true)
  String name;
}
