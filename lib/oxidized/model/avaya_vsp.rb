class Avaya_Vsp < Oxidized::Model
  prompt /^\s*[-a-zA-Z0-9_(): ]+\S[>#]$/
  comment '! '

  cmd :all do |cfg|
    # This normalizes output. It removes newlines and carriage returns.
    # It also strips the first line of the output. This is because for
    # some reason, the prompt is always the first line of the output.
    a = cfg.each_line.to_a[1..-2].map { |e| e.gsub( /[\n\r]/, "" )}.select { |e| !(e.match /^\s*$/) }.join("\n")
    a + "\n"
  end

  cmd 'terminal more disable' do |cfg|
    comment cfg
  end
  cmd 'show autotopology nmm-table' do |cfg|
    comment cfg
  end
  cmd 'show running-config' do |cfg|
    cfg
  end
  cfg :telnet do
    username /Login:/
    password /Password:/
    post_login 'enable'
    pre_logout 'exit'
  end
end
