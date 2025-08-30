{ disks ? [ "/dev/sda" ], ... }:

{
	disko.devices = {
		disk = {
			live-disk = {
				device = builtins.elemAt disks 0;
				type = "disk";
				content = {
					type = "table";
					format = "gpt";
					efiGptPartitionFirst = false;
					partitions = [
						{
							name = "compat";
							type = "EF00";
							size = "32MiB";
							priority = 1;
							content = {
								type = "filesystem";
								format = "vfat";
								mountpoint = null;
							};
							hybrid = {
								mbrPartitionType = "0x0c";
								mbrBootableFlag = false;
							};
						}
						{
							name = "ESP";
							size = "512MiB";
							bootable = true;
							content = {
								type = "filesystem";
								format = "vfat";
								mountpoint = "/boot";
								mountOptions = [
									"defaults"
								];
							};
						}
						{
							name = "iso";
							size = "10240MiB"; # 10GiB
							part-type = "primary";
							content = {
								type = "filesystem";
								format = "tmpfs";
								mountpoint = "/iso";
							};
						}
						{
							name = "persistent";
							size = "100%";
							part-type = "primary";
							content = {
								type = "filesystem";
								format = "ext4";
								mountpoint = "/persistent";
							};
						}
					];
				};
			};
		};
	};
}
