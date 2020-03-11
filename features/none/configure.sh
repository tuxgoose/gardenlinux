cat /debuerreotype-epoch | md5sum | cut -f1 -d' ' > /etc/machine-id
chmod 0644 /etc/machine-id
	
aptVersion="$(dpkg-query --show --showformat "\${Version}\n" apt)"
isDebianJessie="$([ -f "/etc/os-release" ] && source "/etc/os-release" && [ "${ID:-}" = 'debian' ] && [ "${VERSION_ID:-}" = '8' ] && echo '1')" || :
if [ -n "$isDebianJessie" ] || [[ "$aptVersion" == 0.* ]] || dpkg --compare-versions "$aptVersion" '<<' '1.0.9.2~'; then
	cat >> "$targetDir/etc/apt/apt.conf.d/docker-gzip-indexes" <<-'EOF'
		Acquire::CompressionTypes::Order:: "gz";
	EOF
fi
