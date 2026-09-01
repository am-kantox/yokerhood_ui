defmodule YokerhoodUI do
  @moduledoc """
  Shared design-system assets for Phoenix sites in this workspace that want
  the same visual identity as yokerhood.com, extracted out of that
  repository in phase 5 of its build:

    * `YokerhoodUI.Chrome` -- generic header/footer HEEx function
      components. Layout and classes are fixed here; nav content, links,
      site name and any extra actions (theme switcher, etc.) come from the
      caller via attrs/slots. Deliberately gettext-agnostic: callers pass
      already-translated text, so this library carries no Gettext
      dependency of its own.
    * `priv/tailwind/nord_abyss_theme.css` -- the daisyUI theme plugin
      declaration restricting a Tailwind v4 build to the `nord`/`abyss`
      theme pair (see the moduledoc comment inside that file for why this
      specific pair). Consuming apps `@import` it as a relative path from
      their own `assets/css/app.css`, since `deps/yokerhood_ui` is a
      regular checkout/symlink on disk like any other Mix dependency, not
      a hex package with an asset-bundling story of its own.

  Currently consumed by yokerhood.com via a `path:` dependency (this
  repository has no hosted git remote yet, only a local git history) --
  see that project's README for the exact wiring. `labyrinth` intentionally
  does not depend on this yet: its own header/theme are a distinct,
  deliberate "tactical exploration" visual identity, and adopting shared
  chrome there is a separate decision, not a mechanical follow-on to this
  extraction.
  """
end
