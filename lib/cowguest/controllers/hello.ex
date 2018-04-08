defmodule Cowguest.Controllers.Hello do
  @moduledoc false

  import Plug.Conn

  def init(opts),
    do: opts

  def call(conn, _opts),
    do:
      conn
      |> put_resp_content_type("text/html")
      |> send_resp(200, make_body(conn))

  defp make_body(conn),
    do: """
        <html>
          <head>
            <meta charset="utf-8">
            <title>Cowboy Hello!</title>
          </head>
          <body>
            <h1>Cowboy Hello!!</h1>
            <table>
              <tbody>
                <tr>
                  <th>Host</th>
                  <td>#{conn.host}</td>
                </tr>
                <tr>
                  <th>Method</th>
                  <td>#{conn.method}</td>
                </tr>
              </tbody>
            </table>
          </body>
        </html>
"""
end
