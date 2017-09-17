defmodule PhoenixBert.Mixfile do
  use Mix.Project

  @version "1.0.0"
  @github "https://github.com/veyond-card/phoenix_bert"

  def project do
    [
      app: :phoenix_bert,
      version: @version,
      elixir: "~> 1.3",
      name: "BERT Phoenix",
      description: "BERT encoder/decoder for Phoenix",
      package: package(),
      deps: deps(),
      docs: docs()
    ]
  end

  def application, do: []

  defp deps do
    [
      {:bertex, "~> 1.2"},
      {:plug, "~> 1.4"},
      {:ex_doc, "~> 0.15", only: :docs},
      {:inch_ex, ">= 0.0.0", only: :docs}
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      maintainers: ["Jonathan Lima"],
      links: %{"Github" => @github}
    ]
  end

  defp docs do
    [
      extras: ["README.md"],
      main: "readme",
      source_ref: "v#{@version}",
      source_url: @github
    ]
  end
end
