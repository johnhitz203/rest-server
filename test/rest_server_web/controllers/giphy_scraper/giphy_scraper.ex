defmodule GiphyScraper.GiphyScraper do
  @type response :: {:ok, HTTPoison.Response.t() | HTTPoison.AsyncResponse.t()} | {:error, HTTPoison.Error.t()}
  @type query :: String.t
  @type quantity :: non_neg_integer

  alias GiphyScraper.GiphyImage

  @spec
  @spec return_gifs_for_search_term(query) :: response
  def return_gifs_for_search_term(query, quantity \\ 25) do
    with {:ok, %{body: body}} <- make_request(query, quantity),
         {:ok, %{"data" => data}} <- decode_response_body_from_json(body) do

      return_data_as_struct(data)

    end
  end

  defp make_request(query, quantity) do
    url = "http://api.giphy.com/v1/gifs/search?q=#{query}&api_key=SVjtbsi8sycHYZ4KhkTtXV2b5Z72ehTG&limit=#{quantity}"
    HTTPoison.get(url)
  end

  defp decode_response_body_from_json(body) do
    {:ok, %{"data" => data}} = Jason.decode(body)
  end

  defp return_data_as_struct(data) do
    Enum.map(data, fn x ->
      %GiphyImage{id: x["id"], url: x["url"], username: x["username"], title: x["title"]}
    end)
  end
end
