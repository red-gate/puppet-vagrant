# == Class: vagrant::params
#
# === Copyright
#
# Copyright 2015 North Development AB
#

class vagrant::params {

  $ensure = $::osfamily ? {
    'darwin'  => present,
    default => latest
  }
  $version = undef

  case $::kernel {
    'windows': {
      $path = [ 'C:\Windows\System32\WindowsPowerShell\v1.0', 'C:\Windows\System32', 'C:\HashiCorp\Vagrant\bin' ]
      $grep    = 'findstr.exe /I /R /C:'
      $vagrant = 'cmd /c vagrant' # this will allow us to pipe to findstr.exe :/
    }
    default: {
      $path = [ '/bin', '/sbin', '/usr/bin', '/usr/sbin' ]
      $grep    = 'grep -i '
      $vagrant = 'vagrant'
    }
  }
  $install_from_source = true
  $provider = $::osfamily ? {
    'redhat' => rpm,
    'debian' => dpkg,
    'darwin' => pkgdmg,
    'windows' => windows,
    default => undef
  }
  $source = undef
}
