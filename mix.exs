defmodule YokerhoodUI.MixProject do
  use Mix.Project

  def project do
    [
      app: :yokerhood_ui,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  def cli do
    [
      preferred_envs: [precommit: :test]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # Only `Phoenix.Component` (the HEEx function-component macro) is
      # actually used by this library; `phoenix_live_view` is the package
      # that ships it. Version-pinned to match the consuming apps
      # (yokerhood.com, labyrinth) so a single `mix.lock` resolution
      # across a workspace never has to reconcile two incompatible pins.
      {:phoenix_live_view, "~> 1.2.0"},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false}
    ]
  end

  defp aliases do
    [
      precommit: [
        "compile --warnings-as-errors",
        "format --check-formatted",
        "credo --strict",
        "test"
      ]
    ]
  end
end
