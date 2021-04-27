# encoding: UTF-8

control 'V-239733' do
  title 'VAMI must restrict access to the web root.'
  desc  "As a rule, accounts on a web server are to be kept to a minimum, and
those accounts are then restricted as to what they are allowed to access. The
web root of the VAMI Lighttpd installation contains the content that is served
up to the end user. This content must have the minimum necessary permissions
and proper ownership to help protect against unprivileged modification of the
content."
  desc  'rationale', ''
  desc  'check', "
    At the command prompt, execute the following command:

    # find /opt/vmware/share/htdocs/ -xdev -type d -a '(' -not -perm 0755 -o
-not -user root -o -not -group root ')' -exec ls -ld {} \\;

    If any files are returned, this is a finding.
  "
  desc  'fix', "
    At the command prompt, execute the following commands:

    # chmod 0755 <directory>
    # chown root:root <directory>

    Note: Substitute <directory> with each directory returned from the check.
  "
  impact 0.5
  tag severity: 'medium'
  tag gtitle: 'SRG-APP-000211-WSR-000030'
  tag gid: 'V-239733'
  tag rid: 'SV-239733r679309_rule'
  tag stig_id: 'VCLD-67-000026'
  tag fix_id: 'F-42925r679308_fix'
  tag cci: ['CCI-001082']
  tag nist: ['SC-2']

  describe command("find /opt/vmware/share/htdocs/ -xdev -type d -a '(' -not -perm 0755 -o -not -user root -o -not -group root ')' -exec ls -ld {} ;") do
    its("stdout.strip") { should cmp "" }
  end

end

