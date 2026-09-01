defmodule YokerhoodUI.ChromeTest do
  use ExUnit.Case, async: true

  import Phoenix.Component
  import Phoenix.LiveViewTest

  alias YokerhoodUI.Chrome

  # Real slots can only be built through actual HEEx `<:slot>` syntax, not
  # by hand-constructing the internal slot map shape, so each test renders
  # a tiny wrapper component defined here with `~H`.
  defp header_with_nav(assigns) do
    ~H"""
    <Chrome.header brand={@brand} home_href={@home_href}>
      <:nav>
        <li><a href="/blog">Blog</a></li>
      </:nav>
    </Chrome.header>
    """
  end

  defp footer_with_no_nav(assigns) do
    ~H"""
    <Chrome.footer>
      Copyright text
    </Chrome.footer>
    """
  end

  defp footer_with_nav(assigns) do
    ~H"""
    <Chrome.footer>
      <:nav>
        <li><a href="/uses">Uses</a></li>
      </:nav>
      Copyright text
    </Chrome.footer>
    """
  end

  describe "header/1" do
    test "renders the brand link and caller-supplied nav items" do
      html = render_component(&header_with_nav/1, brand: "Test Site", home_href: "/")

      assert html =~ "Test Site"
      assert html =~ ~s(href="/")
      assert html =~ "<header"
      assert html =~ "<nav"
      assert html =~ "/blog"
    end

    test "home_href overrides the default brand link target" do
      html = render_component(&header_with_nav/1, brand: "Test Site", home_href: "/start")

      assert html =~ ~s(href="/start")
    end
  end

  describe "footer/1" do
    test "renders inner content with no nav when none is given" do
      html = render_component(&footer_with_no_nav/1, %{})

      assert html =~ "Copyright text"
      assert html =~ "<footer"
      refute html =~ "<nav"
    end

    test "renders an optional nav above the inner content" do
      html = render_component(&footer_with_nav/1, %{})

      assert html =~ "<nav"
      assert html =~ "/uses"
      assert html =~ "Copyright text"
    end
  end
end
