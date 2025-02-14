control 'VCUI-70-000006' do
  title 'vSphere UI must generate log records for system startup and shutdown.'
  desc  "
    Logging must be started as soon as possible when a service starts and when a service is stopped. Many forms of suspicious actions can be detected by analyzing logs for unexpected service starts and stops. Also, by starting to log immediately after a service starts, it becomes more difficult for suspicious activity to go unlogged.

    On the vCenter Server Appliance (VCSA), the \"vmware-vmon\" service starts up the Java virtual machines (JVMs) for various vCenter processes, including vSphere UI, and the individual json configuration files control the early JVM logging. Ensuring these json files are configured correctly enables early Java \"stdout\" and \"stderr\" logging.
  "
  desc  'rationale', ''
  desc  'check', "
    At the command prompt, run the following command:

    # grep StreamRedirectFile /etc/vmware/vmware-vmon/svcCfgfiles/vsphere-ui.json

    Expected result:

    \"StreamRedirectFile\": \"%VMWARE_LOG_DIR%/vmware/vsphere-ui/logs/vsphere-ui-runtime.log\",

    If no log file is specified for the StreamRedirectFile setting, this is a finding.
  "
  desc 'fix', "
    Navigate to and open:

    /etc/vmware/vmware-vmon/svcCfgfiles/vsphere-ui.json

    Below the last line of the \"PreStartCommandArg\" block, add or reconfigure the following line:

    \"StreamRedirectFile\": \"%VMWARE_LOG_DIR%/vmware/vsphere-ui/logs/vsphere-ui-runtime.log\",

    Restart the appliance for changes to take effect.
  "
  impact 0.5
  tag severity: 'medium'
  tag gtitle: 'SRG-APP-000089-WSR-000047'
  tag satisfies: ['SRG-APP-000092-WSR-000055']
  tag gid: 'V-256783'
  tag rid: 'SV-256783r889348_rule'
  tag stig_id: 'VCUI-70-000006'
  tag cci: ['CCI-000169', 'CCI-001464']
  tag nist: ['AU-12 a', 'AU-14 (1)']

  describe json("#{input('svcJsonPath')}") do
    its('StreamRedirectFile') { should eq "#{input('streamRedirectFile')}" }
  end
end
