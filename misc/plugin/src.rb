# Copyright (C) 2003 TAKEUCHI Hitoshi <hitoshi@namaraii.com>

def src
  sources = <<EOS
<!DOCTYPE html
    PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ja">
<head>
  <meta http-equiv="Content-Language" content="#{@conf.lang}">
  <meta http-equiv="Content-Type" content="text/html; charset= #{@conf.charset}">
  <title>#{h(page_name(@page))}</title>
</head>
<body>
<div>
EOS
  page = @db.load( @page )
  sources << (page ? h(page).gsub(/\n/, "<br>\n").gsub(/ /, '&nbsp;') : 'load error.')
  sources  << <<EOS
</div>
</body>
</html>
EOS

  header = {}
  header['Last-Modified'] = CGI.rfc1123_date(Time.now)
  header['type']          = 'text/html'
  header['charset']       =  @conf.charset
  header['Content-Language'] = @conf.lang
  header['Pragma']           = 'no-cache'
  header['Cache-Control']    = 'no-cache'

  ::Hiki::Response.new(sources, 200, header)
end

add_body_enter_proc(Proc.new do
  add_plugin_command('src', src_label, {'p' => true})
end)
