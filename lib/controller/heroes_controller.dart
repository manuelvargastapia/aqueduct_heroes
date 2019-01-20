import 'package:heroes/heroes.dart';
import '../model/hero_model.dart';

class HeroesController extends ResourceController {
  HeroesController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllHeroes({@Bind.query('name') String name}) async {
    final heroQuery = Query<HeroModel>(context);
    if (name != null)
      heroQuery.where((h) => h.name).contains(name, caseSensitive: false);
    final heroes = await heroQuery.fetch();
    return Response.ok(heroes);
  }

  @Operation.get('id')
  Future<Response> getHeroByID(@Bind.path('id') int id) async {
    final heroQuery = Query<HeroModel>(context)
      ..where((hm) => hm.id).equalTo(id);
    final hero = await heroQuery.fetchOne();
    if (hero == null) {
      return Response.notFound();
    }
    return Response.ok(hero);
  }
}
