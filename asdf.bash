# Setup asdf

if command -v brew >/dev/null && command -v asdf >/dev/null; then
  . $(brew --prefix asdf)/libexec/asdf.sh
  . $(brew --prefix asdf)/etc/bash_completion.d/asdf
fi
