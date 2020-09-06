if defined?(PryByebug)
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 'ss', 'show-source'
  Pry.commands.alias_command 'sm', 'show-models'
  Pry.commands.alias_command 'sr', 'show-routes'
  Pry.commands.alias_command 'sd', 'show-doc'
end

Pry::Commands.command /^$/, "repeat last command" do
  _pry_.run_command Pry.history.to_a.last
end

Pry.config.pager = false
