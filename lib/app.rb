class App
  HTML = <<~HEREDOC
    <!DOCTYPE html>
    <html>
      <head>
        <script src='build/app.js'></script>
      </head>
      <body>
        <div id="root"></div>
      </body>
    </html>
  HEREDOC

  def call (_env)
    [200, { 'Content-Type' => 'text/html; charset=utf-8' }, [HTML]]
  end
end