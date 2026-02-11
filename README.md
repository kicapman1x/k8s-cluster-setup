# k8s-cluster-setup

Install following virt stack on main machine: 
sudo pacman -S qemu-full libvirt virt-install virt-manager dnsmasq iproute2
sudo systemctl enable --now libvirtd
sudp virsh net-define /home/daddy/apps/virt/network/daddynet.xml 
sudo virsh net-start daddy-net
sudo virsh net-list --all

After this, ensure that its active 

##virtualization##
export LIBVIRT_DEFAULT_URI=qemu:///system
^ add this in profile 

make sure to add urself in libvirt and kvm groups as well
sudo groupadd libvirt 
sudo groupadd kvm 
sudo usermod -a -G libvirt daddy
sudo usermod -a -G kvm daddy

virsh capabilities | grep -i kvm

We can create vm already! 

Add permissions, just to libvert-qemu to access and read these files 
sudo setfacl -R -d -m u:libvirt-qemu:rx /home/daddy/apps/virt/init

Get the ubuntu image
curl -LO https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img

Create ssh key and paste the public key in the user-data.yml file
ssh-keygen -t ed25519 -f ~/.ssh/daddyvm01

Get the seed.iso file
cloud-localds seed.iso user-data.yml meta-data.yml --network-config=network-config.yml

Generate the vm image from the jammy image we downloaded
qemu-img create -f qcow2 -F qcow2 -b ../../image/jammy-server-cloudimg-amd64.img ./daddyvm01.qcow2 25G

Do the installation
virt-install --name daddyvm01 --memory 4096 --vcpus 2 --disk ./daddyvm01.qcow2,format=qcow2 --disk ./seed.iso,device=cdrom --network bridge=daddybr0 --graphics none --import --noautoconsole

virsh list

Ensure IP is contactable (its whatever u put in network-config)
ping 10.69.69.69

ssh in 
ssh -i $HOME/.ssh/daddyvm01 daddy@10.69.69.69

Once ssh in, you can choose to set the password 
sudo passwd daddy