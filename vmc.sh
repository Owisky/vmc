#!/bin/zsh

set -e
set -u
set -o pipefail

# start vms headless
if [ $# -ne 1 ] && [ $# -ne 2 ]; then
    echo "start guest vms headless with host shared folder..."
    echo "USAGE: $0 <start|stop|suspend|list|mnt> [vmx_path|debian|ubuntu]"
    exit 1
fi

vm_run="/Applications/VMware\ Fusion.app/Contents/Library/vmrun"
vm_type="fusion"
vm_debian="/Users/x/Virtual\ Machines.localized/Debian\ 12.x\ 64-bit.vmwarevm/Debian\ 12.x\ 64-bit.vmx"
vm_ubuntu="/Users/x/Virtual\ Machines.localized/Ubuntu\ 64-bit.vmwarevm/Ubuntu\ 64-bit.vmx"

vm_cmd=$1
vm_target=${2:-$vm_ubuntu}

if [ "$vm_target" = "debian" ]; then
	vm_target=$vm_debian
fi

if [ "$vm_target" = "ubuntu" ]; then
	vm_target=$vm_ubuntu
fi

case $vm_cmd in
	"start")
	/bin/zsh -c "$vm_run -T $vm_type start $vm_target nogui"
	echo vm started headless
	;;
	"stop")
	/bin/zsh -c "$vm_run -T $vm_type stop $vm_target soft"
	echo vm stopped softly
	;;
	"suspend")
	/bin/zsh -c "$vm_run -T $vm_type suspend $vm_target soft"
	echo vm suspended softly
	;;
	"mnt")
	/bin/zsh -c "$vm_run -T $vm_type enableSharedFolders $vm_target"
	echo host shared folder attached to /mnt
	;;
	"list")
	/bin/zsh -c "$vm_run -T $vm_type list"
	;;

	*)
	echo "unsupported params $vm_cmd"
	;;
esac

