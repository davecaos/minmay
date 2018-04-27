defmodule Minmay.Mixfile do
  use Mix.Project

  def project do
    [
      app: :minmay,
      version: "2.2.0",
      elixir: "~> 1.5",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  def application do
    [
       applications: [],
       env: []
    ]
  end

  defp deps do
    [
      {:jiffy_global, git: "https://github.com/davecaos/jiffy_global", branch: "master"}
    ]
  end

  defp aliases do
    [compile: [&pre_compile_hooks/1, "compile", &post_compile_hooks/1]]
  end

  defp pre_compile_hooks(_) do
    run_hook_cmd [
    ]
  end

  defp post_compile_hooks(_) do
    run_hook_cmd [
    ]
  end

  defp run_hook_cmd(commands) do
    {_, os} = :os.type
    for command <- commands, do: (fn
      ({regex, cmd}) ->
         if Regex.match?(Regex.compile!(regex), Atom.to_string(os)) do
           Mix.Shell.cmd cmd, [], fn(x) -> Mix.Shell.IO.info(String.trim(x)) end
         end
      (cmd) ->
        Mix.Shell.cmd cmd, [], fn(x) -> Mix.Shell.IO.info(String.trim(x)) end
      end).(command)
  end
end
