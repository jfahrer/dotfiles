# Setup asdf

if [ ! -x $(which brew) ] && [ ! -z $(which asdf) ]; then
  . $(brew --prefix asdf)/libexec/asdf.sh
  . $(brew --prefix asdf)/etc/bash_completion.d/asdf.bash
fi
