control "PHTN-67-000112" do
  title 'The Photon operating system must not perform IPv4 packet forwarding.'
  desc  "Routing protocol daemons are typically used on routers to exchange
network topology information with other routers. If this software is used when
not required, system network information may be unnecessarily transmitted
across the network."
  desc  'rationale', ''
  desc  'check', "
    At the command line, execute the following command:

    # /sbin/sysctl -a --pattern \"net.ipv4.ip_forward$\"

    Expected result:

    net.ipv4.ip_forward = 0

    If the system is intended to operate as a router, this is N/A.

    If the output does not match the expected result, this is a finding.
  "
  desc  'fix', "
    At the command line, execute the following commands:

    # sed -i -e \"/^net.ipv4.ip_forward/d\" /etc/sysctl.conf
    # echo net.ipv4.ip_forward=0>>/etc/sysctl.conf
  "
  impact 0.5
  tag severity: 'medium'
  tag gtitle: 'SRG-OS-000480-GPOS-00227'
  tag gid: 'V-239183'
  tag rid: 'SV-239183r675357_rule'
  tag stig_id: 'PHTN-67-000112'
  tag fix_id: 'F-42353r675356_fix'
  tag cci: ['CCI-000366']
  tag nist: ['CM-6 b']

  describe kernel_parameter('net.ipv4.ip_forward') do
    its('value') { should eq 0 }
  end

end

