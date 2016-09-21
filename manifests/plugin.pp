#
# A helper resource for creating Jerakia policies

define jerakia::plugin (
  $template,
  $plugin_dir = $::jerakia::plugin_dir,
  $params     = {},
  $replace    = true,
) {

  file { "${::jerakia::plugin_dir}/jerakia/lookup/plugin/${name}.rb":
    ensure  => file,
    replace => $replace,
    content => template($template),
  }
}
