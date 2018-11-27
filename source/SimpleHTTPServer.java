// Original source from package com.stackoverflow.q3732109;

import java.io.IOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;

import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpServer;


public class SimpleHTTPServer {


    public static void main(String[] args) throws Exception {

        System.out.print("Starting HTTP server...\n");

        HttpServer server = HttpServer.create(new InetSocketAddress(8000), 0);

        server.createContext("/", new SimpleHandler());
        server.setExecutor(null); // creates a default executor
        server.start();

    }


    static class SimpleHandler implements HttpHandler {
        @Override
        public void handle(HttpExchange t) throws IOException {

            System.out.print(String.format("URI: %s\n", t.getRequestURI()));

            String response = "Hellow, World!\n";

            t.sendResponseHeaders(200, response.length());

            OutputStream os = t.getResponseBody();
            os.write(response.getBytes());
            os.close();

        }
    }

}

