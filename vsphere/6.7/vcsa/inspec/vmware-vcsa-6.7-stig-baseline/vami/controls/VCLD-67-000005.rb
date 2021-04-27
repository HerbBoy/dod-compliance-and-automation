control "VCLD-67-000005" do
  title 'VAMI must generate log records for system startup and shutdown.'
  desc  "Logging must be started as soon as possible when a service starts and
when a service is stopped. Many forms of suspicious actions can be detected by
analyzing logs for unexpected service starts and stops. Also, by starting to
log immediately after a service starts, it becomes more difficult for
suspicious activity to go unlogged."
  desc  'rationale', ''
  desc  'check', "
    At the command prompt, execute the following command:

    # /opt/vmware/sbin/vami-lighttpd -p -f
/opt/vmware/etc/lighttpd/lighttpd.conf|grep \"server.errorlog\"

    Expected result:

        server.errorlog                   =
\"/opt/vmware/var/log/lighttpd/error.log\"

    If the output does not match the expected result, this is a finding.
  "
  desc  'fix', "
    Navigate to and open /opt/vmware/etc/lighttpd/lighttpd.conf.

    Add or reconfigure the following value:

    server.errorlog = \"/opt/vmware/var/log/lighttpd/error.log\"
  "
  impact 0.5
  tag severity: 'medium'
  tag gtitle: 'SRG-APP-000089-WSR-000047'
  tag gid: 'V-239719'
  tag rid: 'SV-239719r679267_rule'
  tag stig_id: 'VCLD-67-000005'
  tag fix_id: 'F-42911r679266_fix'
  tag cci: ['CCI-000169']
  tag nist: ['AU-12 a']

  runtime = command("#{input('lighttpdBin')} -p -f #{input('lighttpdConf')}").stdout

  describe parse_config(runtime).params['server.errorlog'] do
    it { should cmp "#{input('errorLog')}" }
  end

end

