defmodule Issues.GithubIssues do
  require Logger

  @user_agent [{"User-agent", "Elixir muel.toms@gmail.com"}]
  @github_url Application.compile_env(:issues, :github_url)

  def fetch(user, project) do
    Logger.info("Fetching #{user}'s project #{project}")

    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response()
  end

  def issues_url(user, project) do
    "#{@github_url}/#{user}/#{project}/issues"
  end

  def handle_response({_, %{status_code: status_code, body: body}}) do
    Logger.info("Got response: status code=#{status_code}")
    Logger.debug(fn -> inspect(body) end)

    {
      status_code |> check_for_error(),
      body |> Jason.decode!()
    }
  end

  defp check_for_error(200), do: :ok
  defp check_for_error(_), do: :error
end
