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

Get the seed.iso file
cloud-localds seed.iso user-data.yml meta-data.yml --network-config=network-config.yml

Get the ubuntu image
curl -LO https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img

