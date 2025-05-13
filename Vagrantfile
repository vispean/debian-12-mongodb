Vagrant.configure("2") do |config|
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  config.vm.define "database" do |database|
    database.vm.box = "loch-tech/debian-12-bookworm-ch"
    #database.vm.box = "debian-12-bookworm-ch"
    database.vm.network "private_network", ip: "192.168.56.10"

    database.vm.provider "virtualbox" do |vb|
      vb.name = "debian-12-mongodb-server"
      #vb.gui = true
      #vb.memory = "8192"
      vb.customize ["modifyvm", :id, "--vram", "128"]
    end

    database.vm.provision "shell", path: "scripts/mongodb_server.sh"
  end

  config.vm.define "remote-access", primary: true do |access|
    access.vm.box = "loch-tech/debian-12-bookworm-ch-kde"
    #access.vm.box = "debian-12-bookworm-ch-kde"
    access.vm.network "private_network", ip: "192.168.56.11"
    

    access.vm.provider "virtualbox" do |vb|
      vb.name = "debian-12-mongodb-remote-access"
      vb.gui = true
      vb.memory = "4096"
      vb.customize ["modifyvm", :id, "--vram", "128"]
    end

    access.vm.provision "shell", path: "scripts/mongodb_remote_access.sh"
  end
end
