defmodule HarSurgeonWeb.IndexController do
  use HarSurgeonWeb, :controller
  alias HarSurgeon.Tracker

  #
  # Fresh connection to page
  def home(conn, _params) do
    render(conn, :home)
  end

  #
  # Process uploads via POST
  def upload(conn, params) do
    # Parse json from download
    tid =
      params
      |> Map.fetch!("file")
      |> Map.fetch!(:path)
      |> File.read!()
      |> Tracker.new()

    redirect(conn, to: ~p"/tid/#{tid}")
  end

  #
  # redirects user to the page where they can view the json data
  def json_view(conn, %{"tid" => tid}) do
    # pull JSON data using tid
    # decodes binary data into json object
    # |> :json.decode()
    json = Tracker.get(tid)

    render(conn, :json_view, tid: tid, json: json)
  end
end
