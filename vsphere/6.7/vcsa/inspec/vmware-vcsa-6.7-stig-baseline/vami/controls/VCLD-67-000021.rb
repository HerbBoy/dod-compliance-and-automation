control "VCLD-67-000021" do
  title "VAMI must not have the Web Distributed Authoring (WebDAV) servlet
installed."
  desc  "A web server can be installed with functionality that, by its nature,
is not secure. WebDAV is an extension to the HTTP protocol that, when
developed, was meant to allow users to create, change, and move documents on a
server, typically a web server or web share. Allowing this functionality,
development, and deployment is much easier for web authors.

    WebDAV is not widely used and has serious security concerns because it may
allow clients to modify unauthorized files on the web server.
  "
  desc  'rationale', ''
  desc  'check', "
    At the command prompt, execute the following command:

    # /opt/vmware/sbin/vami-lighttpd -p -f
/opt/vmware/etc/lighttpd/lighttpd.conf|awk '/server\\.modules/,/\\)/'|grep
mod_webdav

    If any value is returned, this is a finding.
  "
  desc  'fix', "
    Navigate to and open /opt/vmware/etc/lighttpd/lighttpd.conf.

    Delete or comment out the \"mod_webdav\" line.

    The line may be in an included config and not in the parent config.
  "
  impact 0.5
  tag severity: 'medium'
  tag gtitle: 'SRG-APP-000141-WSR-000085'
  tag gid: 'V-239729'
  tag rid: 'SV-239729r679297_rule'
  tag stig_id: 'VCLD-67-000021'
  tag fix_id: 'F-42921r679296_fix'
  tag cci: ['CCI-000381']
  tag nist: ['CM-7 a']

  runtime = command("#{input('lighttpdBin')} -p -f #{input('lighttpdConf')}").stdout

  describe parse_config(runtime).params['mod_webdav'] do
    it { should eq nil }
  end

end

