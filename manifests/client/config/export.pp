# rdiff_backup::config::export class
class rdiff_backup::client::config::export (
  $ensure,
  $path,
  $rdiff_user,
  $remote_path,
  $rdiff_server,
  $backup_script,
  $rdiffbackuptag
){
  if ($ensure){
    validate_string($ensure)
  }
  if ($path){
    validate_absolute_path($path)
  }
  if ($rdiff_server){
    validate_string($rdiff_server)
  }
  if ($rdiff_user){
    validate_string($rdiff_user)
  }
  if ($remote_path){
    validate_string($remote_path)
    $_remote_path = $remote_path
  }
  else {
    $_remote_path = '/srv/rdiff'
  }
  if ($rdiffbackuptag){
    validate_string($rdiffbackuptag)
  }

    create_resources('rdiff_backup::rdiff_export', {
      "${::fqdn}_${path}" => {
        ensure         => $ensure,
        path           => $path,
        rdiff_server   => $rdiff_server,
        rdiff_user     => $rdiff_user,
        backup_script  => $backup_script,
        remote_path    => $_remote_path,
        rdiffbackuptag => $rdiffbackuptag,
    }})
}
