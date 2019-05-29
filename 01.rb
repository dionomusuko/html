require 'webrick'
config = {
    :Port => 8080,
    :DocumentRoot => '.'
}

server = WEBrick::HTTPServer.new(config)
server.mount_proc("/aaa"){|req, res|
    res.body = <<EOF
    <!DOCTYPE html>
<html>
    <head> 
        <meta charset="utf-8">
    </head>
   <body>
       <p>サブミットボタン : #{req.query["sb"].force_encoding("utf-8")}</p>
       <p>テキストボタン : #{req.query["tb"].force_encoding("utf-8")}</p>
       <p>パスワードボタン : #{req.query["pb"].force_encoding("utf-8")}</p>
       <p>ラジオボタン : #{req.query["rb"].force_encoding("utf-8")}</p>
       <p>チェックボックス : #{req.query["cb"].force_encoding("utf-8")}</p>
       <p>コンボボックス : #{req.query["combo"].force_encoding("utf-8")}</p>
       <p>リストボックス : #{req.query["list"].force_encoding("utf-8")}</p>
       <p>テキストエリア : #{req.query["ta"].force_encoding("utf-8")}</p>
       <p>隠しフィールド : #{req.query["hi"].force_encoding("utf-8")}</p>
   </body>
</html>
EOF
}
trap(:INT) do 
    server.shutdown
end
server.start