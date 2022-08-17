import '../../api/item_api.dart';
import '../../api/login_api.dart';
import '../../api/user_api.dart';
import '../../dao/item_dao.dart';
import '../../dao/user_dao.dart';
import '../../services/item_service.dart';
import '../../services/login_service.dart';
import '../../services/user_service.dart';
import '../database/db_configuration.dart';
import '../database/mysql_db_configuration.dart';
import '../security/security_service.dart';
import '../security/security_service_imp.dart';
import 'dependency_injector.dart';

class Injects {
  static DependencyInjector initialize() {
    var di = DependencyInjector();

    ///
    /// Classe para injetar as dependencias, seguindo o conceito de DIP so SOLID
    ///

    ///Banco de dados
    di.register<DBConfiguration>(() => MysqlDbConfiguration());

    ///Seguranca
    di.register<SecurityService>(() => SecurityServiceImp());

    ///Usuario
    di.register<UserDao>(() => UserDao(di<DBConfiguration>()));
    di.register<UserService>(() => UserService(di<UserDao>()));
    di.register<UserApi>(() => UserApi(di<UserService>()));

    ///Login
    di.register<LoginService>(() => LoginService(di<UserService>()));
    di.register<LoginApi>(
      () => LoginApi(di<SecurityService>(), di<LoginService>()),
    );

    ///Itens
    di.register<ItemDao>(() => ItemDao(di<DBConfiguration>()));
    di.register<ItemService>(() => ItemService(di<ItemDao>()));
    di.register<ItemApi>(() => ItemApi(di<ItemService>()));

    return di;
  }
}
