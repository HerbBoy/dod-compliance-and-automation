control "VCLD-67-000014" do
  title 'Rsyslog must be configured to monitor VAMI logs.'
  desc  "For performance reasons, rsyslog file monitoring is preferred over
configuring VAMI to send events to a syslog facility. Without ensuring that
logs are created, that rsyslog configs are created, and that those configs are
loaded, the log file monitoring and shipping will not be effective.
  "
  desc  'rationale', ''
  desc  'check', "
    At the command prompt, execute the following command:

    # grep -v \"^#\" /etc/vmware-syslog/stig-services-vami.conf

    Expected result:

    input(type=\"imfile\" File=\"/opt/vmware/var/log/lighttpd/access.log\"
    Tag=\"vami-access\"
    Severity=\"info\"
    Facility=\"local0\")

    If the file does not exist, this is a finding.

    If the output of the command does not match the expected result above, this
is a finding.
  "
  desc  'fix', "
    Navigate to and open /etc/vmware-syslog/stig-services-vami.conf.

    Create the file if it does not exist.

    Set the contents of the file as follows:

    input(type=\"imfile\" File=\"/opt/vmware/var/log/lighttpd/access.log\"
    Tag=\"vami-access\"
    Severity=\"info\"
    Facility=\"local0\")
  "
  impact 0.5
  tag severity: 'medium'
  tag gtitle: 'SRG-APP-000125-WSR-000071'
  tag satisfies: ['SRG-APP-000125-WSR-000071', 'SRG-APP-000358-WSR-000063',
'SRG-APP-000358-WSR-000163']
  tag gid: 'V-239722'
  tag rid: 'SV-239722r679276_rule'
  tag stig_id: 'VCLD-67-000014'
  tag fix_id: 'F-42914r679275_fix'
  tag cci: ['CCI-001348', 'CCI-001851']
  tag nist: ['AU-9 (2)', 'AU-4 (1)']

  describe file('/etc/vmware-syslog/stig-services-vami.conf') do
    it { should exist }
  end
  describe command('grep -v "^#" /etc/vmware-syslog/stig-services-vami.conf') do
    its ('stdout') { should match "input(type=\"imfile\" File=\"/opt/vmware/var/log/lighttpd/access.log\"\nTag=\"vami-access\"\nSeverity=\"info\"\nFacility=\"local0\")\n" }
  end

end

