defmodule TicketCounter.TidByt do

  @tidbyt_url "https://api.tidbyt.com/v0/devices/"
  @tidbyt_height 32
  @tidbyt_width 64

  def total_dimensions do
    @tidbyt_width * @tidbyt_height
  end

  def update_tidbyt({:error, _reason} = error, _event), do: error

  def update_tidbyt({:ok, ticket}) do
    # device_id = Application.fetch_env!(:tidbyt_config, :device_id)
    # token = Application.fetch_env!(:tidbyt_config, :api_token)
    render_pixlet()
    {:ok, ticket}
  end

  def render_pixlet() do
    tidbyt_device_id = System.get_env("TIDBYT_DEVICE_ID", "")
    tidbyt_token = System.get_env("TIDBYT_API_TOKEN", "")
    IO.puts("-----")
    IO.inspect System.cmd("./ls", [])
    IO.inspect System.cmd("./pixlet", ["render", "counter.star"])

    {:ok, file} = File.read "counter.webp"
    json_data = Jason.encode!(%{"image" => Base.encode64(file), "installationID" => "ticketcounter", "background" => false}, [])
    {:ok, resp} = HTTPoison.post(@tidbyt_url <> tidbyt_device_id <> "/push", json_data, [{"Content-Type", "application/json"}, {"Authorization", "Bearer " <> tidbyt_token}])
    IO.inspect file
    IO.inspect resp
    IO.puts("-----")
  end
end