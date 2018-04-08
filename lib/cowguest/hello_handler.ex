defmodule Cowguest.HelloHandler do
  @moduledoc false

  def init(req, opts) do
    {:ok, reply} = make_resp(req)
    {:ok, reply, opts}
  end

  defp make_resp(req) do
    header = %{"Content-Type" => "text/html"}

    method = :cowboy_req.method(req)
    param = :cowboy_req.binding(:html, req)

    body = """
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
                <th>Method</th>
                <td>#{method}</td>
              </tr>
              <tr>
                <th>Param</th>
                <td>#{param}</td>
              </tr>
            </tbody>
          </table>
        </body>
      </html>
    """

    {:ok, _} = :cowboy_req.reply(200, header, body, req)
  end
end
