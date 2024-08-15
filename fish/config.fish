if status is-interactive
  # Commands to run in interactive sessions can go here
  zoxide init fish | source
  pyenv init - | source
end

# Created by `pipx` on 2024-08-13 16:50:53
set PATH $PATH /home/ytoga/.local/bin

# set `fastfetch` as the `fish` shell greeting
function fish_greeting
  fastfetch
end
# funcsave fish_greeting
