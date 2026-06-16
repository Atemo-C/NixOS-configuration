{ config, lib, ... }: {
	networking = {
		networkmanager = {
			# Whether to manage the network with NetworkManager.
			enable = true;

			# If Blocky is used, set the DNS (resolv.conf) processing mode to none.
			dns = lib.mkIf config.services.blocky.enable "none";
		};

		# If Blocky is used, force requests to be processed locally.
		nameservers = lib.optional config.services.blocky.enable "127.0.0.1";
	};

	# Whether to wait for the networking to be online during the boot process.
	systemd.services.NetworkManager-wait-online.enable = false;

	services.blocky = {
		# Whether to enable the Blocky DNS proxy as ad blocker and more.
		enable = true;

		settings = {
			# DNS port for Blocky to use.
			ports.dns = 53;

			# Use Cloudflare's DNS over HTTPS (DoH) server to resolve queries.
			upstreams.groups.default = [ "https://one.one.one.one/dns-query" ];

			# For initially solving DoH/DoT requests when no system resolver is available.
			bootstrapDns = {
				upstream = "https://one.one.one.one/dns-query";
				ips = [ "1.1.1.1" "1.0.0.1" ];
			};

			blocking = {
				# Deny lists. The more are used, the higher the RAM usage is.
				# https://firebog.net/
				# https://github.com/hagezi/dns-blocklists
				denylists = {
					suspicious = [
						# Firebog (✓)
						"https://raw.githubusercontent.com/PolishFiltersTeam/KADhosts/master/KADhosts.txt"
						"https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Spam/hosts"
						"https://v.firebog.net/hosts/static/w3kbl.txt"

						# Firebog (>)
						"https://raw.githubusercontent.com/matomo-org/referrer-spam-blacklist/master/spammers.txt"
						"https://someonewhocares.org/hosts/zero/hosts"
						"https://raw.githubusercontent.com/RooneyMcNibNug/pihole-stuff/master/SNAFU.txt"
					];

					advertising = [
						# Firebog (✓)
						"https://adaway.org/hosts.txt"
						"https://v.firebog.net/hosts/AdguardDNS.txt"
						"https://v.firebog.net/hosts/Admiral.txt"
						"https://raw.githubusercontent.com/anudeepND/blacklist/master/adservers.txt"
						"https://v.firebog.net/hosts/Easylist.txt"
						"https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext"
						"https://raw.githubusercontent.com/FadeMind/hosts.extras/master/UncheckyAds/hosts"
						"https://raw.githubusercontent.com/bigdargon/hostsVN/master/hosts"

						# Hagezi
						"https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/wildcard/popupads.txt"
					];

					tracking = [
						# Firebog (✓)
						"https://v.firebog.net/hosts/Easyprivacy.txt"
						"https://v.firebog.net/hosts/Prigent-Ads.txt"
						"https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.2o7Net/hosts"
						"https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt"
						"https://hostfiles.frogeye.fr/firstparty-trackers-hosts.txt"

						# hagezi
						"https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/wildcard/native.amazon.txt"
						"https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/wildcard/native.apple.txt"
						"https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/wildcard/native.huawei.txt"
						"https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/wildcard/native.winoffice.txt"
						"https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/wildcard/native.samsung.txt"
						"https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/wildcard/native.tiktok.txt"
						"https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/wildcard/native.tiktok.extended.txt"
						"https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/wildcard/native.lgwebos.txt"
						"https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/wildcard/native.roku.txt"
						"https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/wildcard/native.vivo.txt"
						"https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/wildcard/native.oppo-realme.txt"
						"https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/wildcard/native.xiaomi.txt"
					];

					malicious = [
						# Firebog (✓)
						"https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Alternate%20versions%20Anti-Malware%20List/AntiMalwareHosts.txt"
						"https://v.firebog.net/hosts/Prigent-Crypto.txt"
						"https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Risk/hosts"
						"https://phishing.army/download/phishing_army_blocklist_extended.txt"
						"https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-malware.txt"
						"https://raw.githubusercontent.com/Spam404/lists/master/main-blacklist.txt"
						"https://raw.githubusercontent.com/AssoEchap/stalkerware-indicators/master/generated/hosts"
						"https://urlhaus.abuse.ch/downloads/hostfile/"
						"https://lists.cyberhost.uk/malware.txt"

						# Firebog (>)
						"https://malware-filter.gitlab.io/malware-filter/phishing-filter-hosts.txt"
						"https://v.firebog.net/hosts/Prigent-Malware.txt"
						"https://raw.githubusercontent.com/jarelllama/Scam-Blocklist/main/lists/wildcard_domains/scams.txt"
						"https://v.firebog.net/hosts/RPiList-Malware.txt"
						"https://v.firebog.net/hosts/RPiList-Phishing.txt"

						# Hagezi
						"https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/wildcard/fake.txt"
						"https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/wildcard/tif.txt"
						"https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/wildcard/dyndns.txt"
						"https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/wildcard/hoster.txt"
					];
				};

				# Which groups to block, per profile.
				clientGroupsBlock = {
					default = [
						"suspicious"
						"advertising"
						"tracking"
						"malicious"
					];
				};
			};
		};
	};
}