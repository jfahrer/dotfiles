# Setup asdf

if [ -x $(which brew) ] && [ -x $(which asdf) ]; then
  . $(brew --prefix asdf)/libexec/asdf.sh
  . $(brew --prefix asdf)/etc/bash_completion.d/asdf
fi
