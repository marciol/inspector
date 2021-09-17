defmodule Inspector.MixProject do
  use Mix.Project

  @version "0.1.0"
  @url "https://github.com/marciol/inspector"

  def project do
    [
      app: :inspector,
      version: @version,
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      name: "Inspector",
      description: description(),
      deps: deps(),
      docs: docs(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  def description do
    "A simple module that allows a more friendly debugging experience"
  end

  def package do
    [
      licenses: ["MIT"],
      maintainers: ["Márcio Faria"],
      links: %{
        "Github" => @url
      }
    ]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp docs do
    [
      main: "Inspector",
      source_ref: "v#{@version}",
      source_url: @url
    ]
  end
end
