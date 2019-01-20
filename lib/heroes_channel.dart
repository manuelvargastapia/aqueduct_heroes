import 'controller/heroes_controller.dart';
import 'heroes.dart';

class HeroesChannel extends ApplicationChannel {
  ManagedContext context;

  @override
  Future prepare() async {
    logger.onRecord.listen(
      (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"),
    );
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final persistentStore = PostgreSQLPersistentStore.fromConnectionInfo(
      "heroes_user",
      "password",
      "localhost",
      5432,
      "heroes",
    );
    context = ManagedContext(dataModel, persistentStore);
  }

  @override
  Controller get entryPoint {
    final router = Router();
    router.route('/heroes/[:id]').link(() => HeroesController(context));
    return router;
  }
}
