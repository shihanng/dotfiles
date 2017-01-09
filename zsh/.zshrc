function must_source() {
	if [ -f $1 ]; then
	    source $1
	else
	    (>&2 echo "must_source: ${1} not found")
	fi
}

# load zgen
must_source "${HOME}/.zgen/zgen.zsh"

# if the init scipt doesn't exist
if ! zgen saved; then
  zgen load git/contrib/completion/git-completion.zsh

  # Generate the init script from plugins above
  zgen save
fi
