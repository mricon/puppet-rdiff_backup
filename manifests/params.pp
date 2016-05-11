# rdiff_backup::params class
class rdiff_backup::params {

  $ensure = present
  $package = 'rdiff-backup'
  $path = undef
  $remote_path = undef
  $rdiff_server = undef
  $rdiffbackuptag = $::fqdn

}
