require 'webrick'

config = {
    :Port => 8080,
    :DocumentRoot => '.'
}

server = WEBrick::HTTPServer.new(config)

server.mount_proc "/" do |req , res|
    res.body = <<EOF
    <!DOCTYPE html>
<html>
    <body>
        <head>
            <meta charset="utf-8">
        </head>
        <form action="/calc" method="post">
        <input type = "text" name = "v1">
        <input type = "text" name = "v2">
        <input type = "submit" value = "計算">
        </form>
    </body>
</html>
EOF
end

    server.mount_proc "/calc" do |req , res|
        res.body = <<EOF
    <!DOCTYPE html>
    <html>
        <body>
            <head>
                <meta charset="utf-8">
            </head>
                #{req.query["v1"]} + #{req.query["v2"]} = #{req.query["v1"].to_i + req.query["v2"].to_i}
        </body>
    </html>
EOF
    end

trap(:INT) do 
    server.shutdown
end
server.start

