# To check:
# https://nts.strzibny.name/improving-irb-with-custom-irbrc/
#
# require 'irb/ext/save-history'
# IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-history"
# IRB.conf[:SAVE_HISTORY] = 200

# require "awesome_print"
# AwesomePrint.irb!

# INPUTRC=/dev/null irb
# IRB.conf[:INPUTRC] = '~/workspaces/dot-files/.inputrc.irb'
# INPUTRC=~/.inputrc.irb irb


# # ~/.irbc

# Load awesome_print for prettier object output (if installed)
begin
  require 'awesome_print'
  AwesomePrint.irb!
rescue LoadError
  # fallback if awesome_print isn't available
end

begin
  # require 'pry'
  # Pry.start
  # exit
rescue LoadError
  # fallback if awesome_print isn't available
end

# Use readline with history
require 'irb/completion'
IRB.conf[:USE_READLINE] = true
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

# Set up a nice prompt
IRB.conf[:PROMPT_MODE] = :SIMPLE

# Enable auto-indentation
IRB.conf[:AUTO_INDENT] = true

# Display result of last expression with a variable (like `_`)
IRB.conf[:EVAL_HISTORY] = 100

# Add a helpful banner
puts "Ruby #{RUBY_VERSION} (#{RUBY_PLATFORM})"

# Add shortcuts or helpers
def reload!
  # load './your_script.rb'
end

# class Hash
#   def inspect
#     to_a.sort_by(&:first).inspect
#   end
# end
