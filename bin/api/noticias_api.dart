import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/noticia_model.dart';
import '../services/generic_service.dart';
import 'api.dart';

class NoticiasAPI extends Api {
  final GenericService<NoticiaModel> _service;

  NoticiasAPI(
    this._service,
  );

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = true}) {
    Router router = Router();

    //Listagem
    router.get('/noticia', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);
      var noticias = await _service.findOne(int.parse(id));

      if (noticias == null) return Response(400 );
      return Response.ok(jsonEncode(noticias.toJson()));
    });

    router.get('/noticias/all', (Request req) async {
      List<NoticiaModel> noticias = await _service.findAll();
      List<Map> noticiasMap = noticias.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(noticiasMap));
    });

    //Nova noticia
    router.post('/noticia', (Request req) async {
      var body = await req.readAsString();
      var result =
          await _service.save(NoticiaModel.fromRequest(jsonDecode(body)));
      return result ? Response(201) : Response(500);
    });

    //Atualizar noticia
    router.put('/noticia', (Request req) async {
      var body = await req.readAsString();
      var result =
          await _service.save(NoticiaModel.fromRequest(jsonDecode(body)));
      return result ? Response(201) : Response(500);
    });
    //Delete noticia  /blog/noticias?id=1
    router.delete('/noticia', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);
      var result = await _service.delete(int.parse(id));
      return result ? Response(200) : Response.internalServerError();
    });
    return createHandler(
      isSecurity: isSecurity,
      router: router,
      middlewares: middlewares,
    );
  }
}
