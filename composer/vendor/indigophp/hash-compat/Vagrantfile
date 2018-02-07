Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty64"

  config.vm.provision :shell, inline: <<-shell
    sudo apt-get install software-properties-common

    sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449
    sudo add-apt-repository 'deb http://dl.hhvm.com/ubuntu trusty main'
    sudo apt-get update
    sudo apt-get -qq -y install hhvm

  shell
end
