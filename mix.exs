defmodule Minmay.Mixfile do
  use Mix.Project

  def project do
    [
      app: :minmay,
      version: "2.0.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      description: "MIME type lookup: translate a file extension to MIME type or vice versa",
      package: package(),
      deps: deps()
    ]
  end

  def application do
    [mod: {Minmay.Application, []}, extra_applications: [:logger]]
  end

  defp deps do
    [{:ex_doc, "~> 0.30", only: :dev, runtime: false}]
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/davecaos/minmay"},
      files: ~w(lib mix.exs README.md LICENSE)
    ]
  end
end
