Ohai.plugin(:IbmPower) do
  provides 'ibm_power'
  depends 'kernel'

  collect_data(:linux) do
    ibminfo = Mash.new
    cpuinfo = Mash.new
    cpu_number = 0
    cpu_model = nil
    current_cpu = nil

    # Only run this on ppc64le
    if kernel[:machine] == 'ppc64le'
      File.open('/proc/cpuinfo', 'r').each do |line|
        case line
        when /processor\s+:\s(.+)/
          cpuinfo[Regexp.last_match(1)] = Mash.new
          current_cpu = Regexp.last_match(1)
          cpu_number += 1
        when /^cpu\s+:\s(.+)/
          cpuinfo[current_cpu]['cpu'] = Regexp.last_match(1)
          cpu_model = Regexp.last_match(1).match(/(POWER\w+)/)[1].downcase
        when /^clock\s+:\s(.+)/
          cpuinfo[current_cpu]['clock'] = Regexp.last_match(1)
        when /^revision\s+:\s(.+)/
          cpuinfo[current_cpu]['revision'] = Regexp.last_match(1)
        when /^timebase\s+:\s(.+)/
          cpuinfo['timebase'] = Regexp.last_match(1)
        when /^platform\s+:\s(.+)/
          cpuinfo['platform'] = Regexp.last_match(1)
        when /^model\s+:\s(.+)/
          cpuinfo['machine_model'] = Regexp.last_match(1).strip
        when /^machine\s+:\s(.+)/
          cpuinfo['machine'] = Regexp.last_match(1).strip
        when /^firmware\s+:\s(.+)/
          cpuinfo['firmware'] = Regexp.last_match(1)
        when /^MMU\s+:\s(.+)/
          cpuinfo['mmu'] = Regexp.last_match(1)
        end
      end
      ibminfo[:cpu] = cpuinfo
      ibminfo[:cpu][:total] = cpu_number
      ibminfo[:cpu][:cpu_model] = cpu_model
    end

    ibm_power ibminfo
  end
end
