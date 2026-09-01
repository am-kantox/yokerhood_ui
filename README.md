# YokerhoodUI

Shared design-system assets (header/footer HEEx components, the
Nord/Abyss daisyUI theme) for Phoenix sites that want yokerhood.com's
visual identity, extracted out of that repository. See the `YokerhoodUI`
module doc for the full rationale.

This repository has no hosted git remote yet -- only local git history --
so it is currently consumed as a `path:` dependency:

```elixir
# mix.exs, in a sibling checkout at ../Elixir/yokerhood_ui
def deps do
  [
    {:yokerhood_ui, path: "../Elixir/yokerhood_ui"}
  ]
end
```

```heex
<%!-- lib/my_app_web/components/layouts.ex --%>
<YokerhoodUI.Chrome.header brand="Your Name">
  <:nav>
    <li><a href="/blog">Blog</a></li>
  </:nav>
</YokerhoodUI.Chrome.header>
```

```css
/* assets/css/app.css of an app checked out as a sibling of this repo
   (e.g. ../Elixir/yokerhood_ui, matching the mix.exs path: dependency).
   Mix path dependencies do not get a `deps/<name>` symlink (only a
   `_build/<env>/lib/<name>` one, which would make the import
   MIX_ENV-dependent), so this references the sibling checkout directly. */
@import "../../../Elixir/yokerhood_ui/priv/tailwind/nord_abyss_theme.css";
```

## Development

```bash
mix deps.get
mix precommit   # compile --warnings-as-errors, format check, credo, test
```
