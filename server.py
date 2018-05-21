from SimpleHTTPServer import SimpleHTTPRequestHandler
handlerclass=SimpleHTTPRequestHandler
handlerclass.protocol_version="HTTP/1.0"
import BaseHTTPServer
serverclass=BaseHTTPServer.HTTPServer
serveraddr=("127.0.0.1", 8080)
httpd=serverclass(serveraddr, handlerclass)
sa=httpd.socket.getsockname()
print "Serving .."
httpd.serve_forever()
