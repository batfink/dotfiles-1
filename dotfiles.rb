
require 'fileutils'

DOTFILES = %w(.amethyst .commonrc .config .gitconfig .js .oh-my-zsh .tmux.conf .tmux.reset.conf
              .tmuxinator .zshrc)

def backup dest
  DOTFILES.each do |file|
    print "#{file}\n"
    if File.exist? "#{ENV['HOME']}/#{file}"
      FileUtils.cp_r("#{ENV['HOME']}/#{file}", "#{ENV['HOME']}/#{dest}", remove_destination: true)
    end
  end
end

def restore
  backup "dotfiles.bak"
  DOTFILES.each{ |f| FileUtils.rm_r("#{ENV['HOME']}/#{f}") }
  DOTFILES.each do |file|
    FileUtils.ln_s "#{ENV['HOME']}/dotfiles/#{file}", "#{ENV['HOME']}/#{file}"
  end
end

if ARGV[0] == "backup"
  backup "dotfiles"
elsif ARGV[0] == "restore"
  restore
else
  print "Provide a valid argument [backup | restore]"
end

