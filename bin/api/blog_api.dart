import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/noticia_model.dart';
import '../services/generic_service.dart';
import 'api.dart';

class BlogApi extends Api {
  final GenericService<NoticiaModel> _service;

  BlogApi(
    this._service,
  );

  @override
  Handler getHandler({
    List<Middleware>? middlewares,
    bool isSecurity = true,
  }) {
    Router router = Router();

    //Listagem
    router.get('/blog/noticias', (Request req)async {
      List<NoticiaModel> noticias = await _service.findAll();

      List<Map> noticiasMap = noticias.map((e) => e.toJson()).toList();
      return Response.ok(
        jsonEncode(noticiasMap),
      );
    });
    //Nova noticia
    router.post('/blog/noticias', (Request req) async {
      var body = await req.readAsString();
      _service.save(
        NoticiaModel.fromJson(
          jsonDecode(body),
        ),
      );
      return Response(201);
    });
    //Update noticia  /blog/noticias?id=1
    router.put('/blog/noticias', (Request req) {
      // _service.save();

      String? id = req.url.queryParameters['id'];
      return Response.ok('Choveu hoje');
    });
    //Delete noticia  /blog/noticias?id=1
    router.delete('/blog/noticias', (Request req) {
      // _service.delete(1);
      String? id = req.url.queryParameters['id'];
      _service.delete(int.parse(id!));
      return Response.ok(200);
    });
    return createHandler(
      isSecurity: isSecurity,
      router: router,
      middlewares: middlewares,
    );
  }
}
