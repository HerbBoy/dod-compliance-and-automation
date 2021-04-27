control "VCLD-67-000003" do
  title "VAMI must use cryptography to protect the integrity of remote
sessions."
  desc  "Data exchanged between the user and the web server can range from
static display data to credentials used to log in to the hosted application.
Even when data appears to be static, the non-displayed logic in a web page may
expose business logic or trusted system relationships. The integrity of all the
data being exchanged between the user and web server must always be trusted. To
protect the integrity and trust, encryption methods should be used to protect
the complete communication session.

    To protect the integrity and confidentiality of the remote sessions, VAMI
uses SSL/TLS.
  "
  desc  'rationale', ''
  desc  'check', "
    At the command prompt, execute the following command:

    # /opt/vmware/sbin/vami-lighttpd -p -f
/opt/vmware/etc/lighttpd/lighttpd.conf|grep \"ssl.engine\"

    Expected result:

    ssl.engine                 = \"enable\"

    If the output does not match the expected result, this is a finding.
  "
  desc  'fix', "
    Navigate to and open /opt/vmware/etc/lighttpd/lighttpd.conf.

    Add or reconfigure the following value:

    ssl.engine = \"enable\"
  "
  impact 0.5
  tag severity: 'medium'
  tag gtitle: 'SRG-APP-000015-WSR-000014'
  tag satisfies: ['SRG-APP-000015-WSR-000014', 'SRG-APP-000172-WSR-000104',
'SRG-APP-000315-WSR-000003', 'SRG-APP-000141-WSR-000076',
'SRG-APP-000439-WSR-000151', 'SRG-APP-000439-WSR-000152',
'SRG-APP-000442-WSR-000182']
  tag gid: 'V-239717'
  tag rid: 'SV-239717r679261_rule'
  tag stig_id: 'VCLD-67-000003'
  tag fix_id: 'F-42909r679260_fix'
  tag cci: ['CCI-000197', 'CCI-000381', 'CCI-001453', 'CCI-002314',
'CCI-002418', 'CCI-002422']
  tag nist: ['IA-5 (1) (c)', 'CM-7 a', 'AC-17 (2)', 'AC-17 (1)', 'SC-8', "SC-8
(2)"]

  runtime = command("#{input('lighttpdBin')} -p -f #{input('lighttpdConf')}").stdout

  describe parse_config(runtime).params['ssl.engine'] do
    it { should cmp "#{input('sslEngine')}" }
  end

end

