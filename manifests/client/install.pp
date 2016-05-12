# rdiff_backup::install class
class rdiff_backup::client::install(
  $package,
  $path,
  $rdiffbackuptag,
  $rdiff_server = $rdiff_backup::params::rdiff_server,
  $remote_path,
  $rdiff_user,
) {
  validate_string($package)

  # We need some variables out of rdiff_backup::params
  include rdiff_backup::params

  # Install rdiff_backup and
  ensure_packages( [$package] )
  
  create_resources('sshkeys::create_key', { $rdiff_user => {
    home        => "/var/lib/rdiff/${::fqdn}/",
    ssh_keytype => 'rsa',
  }})

  create_resources('sshkeys::set_authorized_key', {"${rdiff_user}@${::fqdn} to ${rdiff_user}@${rdiff_server}" => {
    local_user  => $rdiff_user,
    remote_user => "${rdiff_user}@${rdiff_server}",
    home        => '/var/lib/rdiff/',
    options     => "command='rdiff-backup --server --restrict ${remote_path}/${::fqdn}'",
  }})


  create_resources('@@file', {"/var/lib/rdiff/${::fqdn}" => {
    ensure => directory,
    tag    => $rdiffbackuptag,
  }})

}
