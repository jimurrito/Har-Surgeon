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
    file_data =
      params
      |> Map.fetch!("file")

    json_data =
      file_data
      |> Map.fetch!(:path)
      |> File.read!()
      |> :json.decode()

    payload = %{
      filename: file_data |> Map.fetch!(:filename),
      json: json_data
    }

    tid = Tracker.new(payload)

    redirect(conn, to: ~p"/tid/#{tid}")
  end

  #
  # redirects user to the page where they can view the json data
  def json_view(conn, %{"tid" => tid}) do
    # pull JSON data using tid
    tracker_data = Tracker.get(tid)
    payload = tracker_data |> Map.fetch!(:json) |> Map.fetch!("log")
    # deconstruct payload
    entries = payload |> Map.fetch!("entries")
    browser = payload |> Map.fetch!("browser")
    pages = payload |> Map.fetch!("pages")

    render(conn, :json_view,
      tid: tid,
      filename: tracker_data.filename,
      entries: entries,
      browser: browser,
      pages: pages
    )
  end
end
