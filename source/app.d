import std.stdio;
import std.json;

import vibe.d;
import vibe.appmain;
import vibe.http.server;

import company;


shared static this()
{
	auto router = new URLRouter;
    router.registerRestInterface(new company.Rest);

    auto settings = new HTTPServerSettings;
    settings.port = 8080;
    listenHTTP(settings, router);
}