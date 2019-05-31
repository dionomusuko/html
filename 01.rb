require 'webrick'
config = {
    :Port => 8080,
    :DocumentRoot => '.'
}

server = WEBrick::HTTPServer.new(config)
server.mount_proc ("/") do|req, res|
    res.body = <<EOF
    <!DOCTYPE html>
    <html lang = "ja">
    
        <head>
            <meta charset="utf-8">
                <title>
                    旅行計画表
                </title>
            旅行計画表
        </head>
        <body>
            <form action="/aaa" method = "get">
            <p>
                サブミットボタン:<input type="submit" name="sb" value ="決定"/>
            </p>
            <p>
                リセットボタン:<input type="reset" />
            </p>
            
            <p>
                氏名:<input type="text" name="tb" value="初期値"/>
            </p>
    
            <p>
                パスワードボックス:<input type="password" name="pb" value="初期値"/>
            </p>
            <p>
                行ってみたい場所:<input type="radio" name="rb" value="国内" checked>国内
                <input type="radio" name="rb" value="国外" checked>国外
                <input type="radio" name="rb" value="その他" checked>その他
            </p>
            <p>
                乗り物:<input type="checkbox" name="cb" value="飛行機" checked>飛行機
                <input type="checkbox" name="cb" value="新幹線" unchecked>新幹線
                <input type="checkbox" name="cb" value="船" unchecked>船
                <input type="checkbox" name="cb" value="車" unchecked>車
                <input type="checkbox" name="cb" value="その他" unchecked>その他
            </p>
            <p>
                予算:<select name="combo" >
                    <option value="¥10000未満" checked>¥10000未満
                    <option value="¥10000から¥50000" checked>¥10000から¥50000
                    <option value="¥50000以上" checked>¥50000以上
                </select>
            </p>
            <p>
                目的:<select name="list" size="3" multiple>
                    <option value="留学" checked>留学
                        <option value = "旅行">旅行
                        <option value = "その他">その他   
                </select>
            </p>
            <p>
                行きたい国があれば記載して下さい:<textarea name="ta" rows="5" cols="30"></textarea>
            </p>
            </form>
        
        
        
        </body>
    
    </html>
    
EOF
end

server.mount_proc("/aaa") do |req, res|
    res.body = <<EOF
    <!DOCTYPE html>
<html>
    <head> 
        <meta charset="utf-8">
    </head>
   <body>
       <p>サブミットボタン : #{req.query["sb"].force_encoding("utf-8")}</p>
       <p>氏名 : #{req.query["tb"].force_encoding("utf-8")}</p>
       <p>パスワードボックス : #{req.query["pb"].force_encoding("utf-8")}</p>
       <p>行ってみたい場所 : #{req.query["rb"].force_encoding("utf-8")}</p>
       <p>乗り物 : #{req.query["cb"].force_encoding("utf-8")}</p>
       <p>予算 : #{req.query["combo"].force_encoding("utf-8")}</p>
       <p>目的 : #{req.query["list"].force_encoding("utf-8")}</p>
       <p>行きたい国があれば記載して下さい : #{req.query["ta"].force_encoding("utf-8")}</p>
   </body>
</html>
EOF
end

trap(:INT) do 
    server.shutdown
end
server.start