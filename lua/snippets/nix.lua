local ls = require("luasnip")
local s = ls.snippet
-- local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local l = require("luasnip.extras").lambda
-- local rep = require("luasnip.extras").rep
-- local p = require("luasnip.extras").partial
-- local m = require("luasnip.extras").match
-- local n = require("luasnip.extras").nonempty
-- local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
-- local types = require("luasnip.util.types")
-- local conds = require("luasnip.extras.conditions")
-- local conds_expand = require("luasnip.extras.conditions.expand")

-- local function is_flake()
--   return vim.fn.expand("%:t") == "flake.nix"
-- end

local system = "x86_64-linux"
local flake_packages = s("packages",
  fmt([[packages."{}"."{}" = {};]], {
    i(1, system),
    i(2, "default"),
    i(3, "derivation")
  })
)
local flake_apps = s("apps",
  fmt(
    [[
      apps."{}"."{}" = {{
        type = {};
        program = {};
      }};
      ]], {
      i(1, system),
      i(2, "default"),
      i(3, "app"),
      i(4, "<store-path>"),
    })
)
local mkShell = s("mkShell",
  fmt([[
  mkShell {{
    packages = with pkgs; [{}];
    inputsFrom = with pkgs; [{}];
    shellHook = ''
      {}
    ''
  }}
  ]], {
    i(1),
    i(2),
    i(3),
  })
)
local mkDerivation = s("mkDerivation",
  fmt([[
mkDerivation {{
  name = "{}";
  src = {};
  buildInputs = with pkgs; [{}];
  phases = ["installPhase" {}];
  installPhase = ''
    mkdir -p $out
    {}
  '';
}}
]], {
    i(1, "name"),
    i(2, "./."),
    i(3),
    i(4),
    i(5),
  }
  )
)

ls.add_snippets("nix", {
  flake_packages,
  flake_apps,
  mkShell,
  mkDerivation,

})

-- { self, ... }@inputs:
-- {
--   # Executed by `nix flake check`
--   checks."<system>"."<name>" = derivation;
--   # Executed by `nix build .#<name>`
--   packages."<system>"."<name>" = derivation;
--   # Executed by `nix build .`
--   packages."<system>".default = derivation;
--   # Executed by `nix run .#<name>`
--   apps."<system>"."<name>" = {
--     type = "app";
--     program = "<store-path>";
--   };
--   # Executed by `nix run . -- <args?>`
--   apps."<system>".default = { type = "app"; program = "..."; };
--
--   # Formatter (alejandra, nixfmt or nixpkgs-fmt)
--   formatter."<system>" = derivation;
--   # Used for nixpkgs packages, also accessible via `nix build .#<name>`
--   legacyPackages."<system>"."<name>" = derivation;
--   # Overlay, consumed by other flakes
--   overlays."<name>" = final: prev: { };
--   # Default overlay
--   overlays.default = final: prev: { };
--   # Nixos module, consumed by other flakes
--   nixosModules."<name>" = { config, ... }: { options = {}; config = {}; };
--   # Default module
--   nixosModules.default = { config, ... }: { options = {}; config = {}; };
--   # Used with `nixos-rebuild switch --flake .#<hostname>`
--   # nixosConfigurations."<hostname>".config.system.build.toplevel must be a derivation
--   nixosConfigurations."<hostname>" = {};
--   # Used by `nix develop .#<name>`
--   devShells."<system>"."<name>" = derivation;
--   # Used by `nix develop`
--   devShells."<system>".default = derivation;
--   # Hydra build jobs
--   hydraJobs."<attr>"."<system>" = derivation;
--   # Used by `nix flake init -t <flake>#<name>`
--   templates."<name>" = {
--     path = "<store-path>";
--     description = "template description goes here?";
--   };
--   # Used by `nix flake init -t <flake>`
--   templates.default = { path = "<store-path>"; description = ""; };
-- }
