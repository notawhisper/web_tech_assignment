require 'webrick'
server = WEBrick::HTTPServer.new({
  :DocumentRoot => '.',
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,
  :Port => '3000',
})
['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}
server.mount('/', WEBrick::HTTPServlet::ERBHandler, 'new.html.erb')

server.mount('/new.cgi', WEBrick::HTTPServlet::CGIHandler, 'new.rb')

server.mount('/new2.cgi', WEBrick::HTTPServlet::CGIHandler, 'new2.rb')

server.mount('/test', WEBrick::HTTPServlet::ERBHandler, 'test.html.erb')
# この一行を追記
server.mount('/indicate.cgi', WEBrick::HTTPServlet::CGIHandler, 'indicate.rb')
# この一行を追記
server.mount('/goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya.rb')


server.start
