content_text = ''

return if node['ibm_power']['cpu'].nil?

case node['ibm_power']['cpu']['cpu_model']
when /power8/
  content_text = 'power8'
when /power9/
  content_text = 'power9'
end

file '/tmp/ibm-power-test' do
  content content_text
end
