mode_reg =
  name: 'nix'
  extensions: 'nix'
  create: bundle_load('nix_mode')

howl.mode.register(mode_reg)

unload = -> howl.mode.unregister('nix')

return {
  info:
    author: 'Rok Fajfar',
    description: 'nix mode',
    license: 'MIT',
  :unload
}
