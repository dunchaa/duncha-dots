# Catppuccin Mocha palette — статическая референс-палитра.
# Используется вместо config.lib.catppuccin.getColors, которого в текущей
# версии catppuccin/nix не существует. Палитра — публичная спецификация,
# значения зафиксированы навсегда.
#
# Usage:
#   let colors = import ../lib/palette.nix;
#   in "rgba(${colors.mauve.hex}ff)"
{
  rosewater = { hex = "f5e0dc"; rgb = "245,224,220"; };
  flamingo  = { hex = "f2cdcd"; rgb = "242,205,205"; };
  pink      = { hex = "f5c2e7"; rgb = "245,194,231"; };
  mauve     = { hex = "cba6f7"; rgb = "203,166,247"; };
  red       = { hex = "f38ba8"; rgb = "243,139,168"; };
  maroon    = { hex = "eba0ac"; rgb = "235,160,172"; };
  peach     = { hex = "fab387"; rgb = "250,179,135"; };
  yellow    = { hex = "f9e2af"; rgb = "249,226,175"; };
  green     = { hex = "a6e3a1"; rgb = "166,227,161"; };
  teal      = { hex = "94e2d5"; rgb = "148,226,213"; };
  sky       = { hex = "89dceb"; rgb = "137,220,235"; };
  sapphire  = { hex = "74c7ec"; rgb = "116,199,236"; };
  blue      = { hex = "89b4fa"; rgb = "137,180,250"; };
  lavender  = { hex = "b4befe"; rgb = "180,190,254"; };
  text      = { hex = "cdd6f4"; rgb = "205,214,244"; };
  subtext1  = { hex = "bac2de"; rgb = "186,194,222"; };
  subtext0  = { hex = "a6adc8"; rgb = "166,173,200"; };
  overlay2  = { hex = "9399b2"; rgb = "147,153,178"; };
  overlay1  = { hex = "7f849c"; rgb = "127,132,156"; };
  overlay0  = { hex = "6c7086"; rgb = "108,112,134"; };
  surface2  = { hex = "585b70"; rgb = "88,91,112"; };
  surface1  = { hex = "45475a"; rgb = "69,71,90"; };
  surface0  = { hex = "313244"; rgb = "49,50,68"; };
  base      = { hex = "1e1e2e"; rgb = "30,30,46"; };
  mantle    = { hex = "181825"; rgb = "24,24,37"; };
  crust     = { hex = "11111b"; rgb = "17,17,27"; };
}
