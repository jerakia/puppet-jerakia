#
# A helper resource for creating Jerakia policies

define jerakia::policy (
  $policy_dir = $::jerakia::policy_dir,
  $params     = {
    'format' => 'yaml',
    'docroot' => '/var/lib/jerakia',
    'searchpath' => [
      'hostname/#{scope[:fqdn]}',
      'environment/#{scope[:environment]}',
      'common',
    ],
  },
  $template = 'jerakia/default_policy.erb',
  $replace  = true,
) {

  file { "${::jerakia::policy_dir}/${name}.rb":
    ensure  => file,
    content => template($template),
  }
}
