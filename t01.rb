require 'webrick'
config = {
    :Port => 8080,
    :DocumentRoot => '.'
}

server = WEBrick::HTTPServer.new(config)
server.mount_proc "/" do |req, res|
    res.body = <<EOF
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="utf-8">
    </head>
    <body>
    <form action="/aaa" method = "get">
    <p>
        サブミットボタン:<input type="submit" name="sb" value ="決定"/>
    </p>
    コメント:<textarea name="ta" rows="5" cols="30"></textarea>
    </form>
    </body>
    </html>
EOF
end

server.mount_proc "/aaa" do |req, res|
    res.body = <<EOF
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
    </head><body>
    <p>コメント : #{req.query["ta"].force_encoding("utf-8")} </p>
    </body>
    </html>
EOF
end

trap(:INT) do 
    server.shutdown
end
server.start