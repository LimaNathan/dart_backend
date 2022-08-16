import 'dart:io';

import 'package:shelf/shelf.dart';

class MInterception {
  static Middleware get contentTypeJson => createMiddleware(
        responseHandler: (Response res) => res.change(
          headers: {
            'content-type': 'application/json',
            'dev': 'nathan',
          },
        ),
      );

  static Middleware get cors {
    final allowedHeader = {'Access-Control-Allow-Origin': '*'};

    Response? handlerOptions(Request req) =>
        req.method == 'OPTIONS' ? Response(200, headers: allowedHeader) : null;

    Response addCorsHeader(Response res) => res.change(headers: allowedHeader);

    return createMiddleware(
        requestHandler: handlerOptions, responseHandler: addCorsHeader);
  }
}
