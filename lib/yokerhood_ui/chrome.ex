defmodule YokerhoodUI.Chrome do
  @moduledoc """
  Shared site chrome (header + footer): the markup, landmark roles and
  layout classes are fixed here, while nav content, links, and any extra
  actions (a theme switcher, a keyboard-shortcuts button, ...) come from
  the caller via attrs/slots. Deliberately gettext-agnostic -- callers
  pass already-translated text, since each consuming app owns its own
  Gettext backend and this library has no opinion on locales.
  """

  use Phoenix.Component

  @doc """
  Renders the site header: a `navbar` with a home link/brand on the left
  and caller-supplied nav content (as `<li>` items) plus optional
  right-aligned actions (e.g. a theme switcher) on the right.

  ## Examples

      <YokerhoodUI.Chrome.header brand="Aleksei Matiushkin">
        <:nav>
          <li><a href="/blog">Blog</a></li>
        </:nav>
        <:actions>
          <.theme_switcher theme={@theme} />
        </:actions>
      </YokerhoodUI.Chrome.header>
  """
  attr(:home_href, :string, default: "/", doc: "the href for the brand/home link")
  attr(:brand, :any, required: true, doc: "the site name/brand text or slot")
  attr(:nav_label, :string, default: "Primary", doc: "the nav's accessible label")

  slot(:nav, required: true, doc: "the header's own <li> nav items")

  slot(:actions,
    doc: "optional right-aligned actions (e.g. a theme switcher), separated from the nav"
  )

  def header(assigns) do
    ~H"""
    <header class="navbar px-4 sm:px-6 lg:px-8">
      <div class="flex-1">
        <a
          href={@home_href}
          class="flex-1 flex w-fit items-center gap-2 font-semibold"
          data-kbd-list-item
        >
          {@brand}
        </a>
      </div>
      <div class="flex-none flex items-center gap-4">
        <nav aria-label={@nav_label} class="flex-none">
          <ul class="flex flex-column px-1 space-x-4 items-center">
            {render_slot(@nav)}
          </ul>
        </nav>
        <div :if={@actions != []} class="flex-none border-l border-base-300 pl-4">
          {render_slot(@actions)}
        </div>
      </div>
    </header>
    """
  end

  @doc """
  Renders the site footer: an optional secondary nav (e.g. links to static
  pages) above caller-supplied inner content (e.g. copyright text, a
  keyboard-shortcuts button).

  ## Examples

      <YokerhoodUI.Chrome.footer>
        <:nav>
          <li><a href="/uses">Uses</a></li>
        </:nav>
        &copy; 2026 Aleksei Matiushkin
      </YokerhoodUI.Chrome.footer>
  """
  attr(:nav_label, :string, default: "Footer", doc: "the footer nav's accessible label")

  slot(:nav, doc: "optional <li> nav items rendered above the inner content")
  slot(:inner_block, required: true, doc: "content rendered inside the footer's closing <p>")

  def footer(assigns) do
    ~H"""
    <footer class="px-4 py-10 sm:px-6 lg:px-8 text-sm text-base-content/70 border-t border-base-300">
      <nav :if={@nav != []} aria-label={@nav_label}>
        <ul class="flex flex-wrap gap-4 mb-4">
          {render_slot(@nav)}
        </ul>
      </nav>
      <p>
        {render_slot(@inner_block)}
      </p>
    </footer>
    """
  end
end
