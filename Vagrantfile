Vagrant.configure("2") do |config|
  ## Define the master node
  config.vm.define "master" do |master|
    master.vm.box = "centos/7"
    master.vm.network "private_network", ip: "192.168.56.10"
    master.vm.hostname = "ansible-overlord"
    master.vm.synced_folder "./shared", "/vagrant_data"
    master.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 2
    end

    # provisioning with ansible only for master node.
    master.vm.provision "shell", inline: <<-SHELL
     ## Install epel repo
     sudo yum -y install epel-release
     sudo yum update -y 
     sudo yum -y install python3 python3-pip
     sudo pip3 install --upgrade pip 
     sudo pip3 install ansible
     ansible --version
     SHELL
  end

     ## Define the controller node 1
  config.vm.define "controller1" do |controller1|
    controller1.vm.box = "centos/7"
    controller1.vm.network "private_network", ip: "192.168.56.12"
    controller1.vm.hostname = "cyber-drone1"
    controller1.vm.synced_folder "./shared", "/vagrant_data"
    controller1.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.cpus = 1
    end
  end
      
    


   ## Define the controller node 2
  config.vm.define "controller2" do |controller2|
    controller2.vm.box = "centos/7"
    controller2.vm.network "private_network", ip: "192.168.56.14"
    controller2.vm.hostname = "cyber-drone2"
    controller2.vm.synced_folder "./shared", "/vagrant_data"
    controller2.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.cpus = 1
    end
  end
end



