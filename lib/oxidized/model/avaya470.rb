class Avaya470 < Oxidized::Model
  prompt /^\s*470-48T[>#]$/m
  comment '! '

  expect /^.*Enter Ctrl-Y to begin.*\*{62}.*\*{62}.*$/ do |data,re|
    sleep 1.0
    send "\C-y"
    ''
  end
  expect /^.*Ethernet Switch 470-48T Main Menu.*ogout.*select option.*25l$/ do |data,re|
    sleep 1.0
    send "c"
    data.gsub re, ''
  end
  cmd :all do |cfg|
    # This normalizes output. It removes newlines and carriage returns.
    # It also strips the first line of the output. This is because for
    # some reason, the prompt is always the first line of the output.
    a = cfg.each_line.to_a[1..-2].map { |e| e.gsub( /[\n\r]/, "" )}.select { |e| !(e.match /^\s*$/) }.join("\n")
    a + "\n"
  end

  cmd 'terminal length 0' do |cfg|
    comment cfg
  end
  cmd 'show system verbose' do |cfg|
    comment cfg
  end
  cmd 'show running-config' do |cfg|
    cfg
  end
  cmd 'exit' do |cfg|
    ''
  end

  cfg :telnet do
    post_login 'enable'
    pre_logout 'l'
  end
end
