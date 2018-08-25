ZPLUG_HOME=""
if [ -d "/usr/share/zsh/scripts/zplug" ]; then
  ZPLUG_HOME="/usr/share/zsh/scripts/zplug"
elif [ -d "/usr/local/opt/zplug" ]; then
  ZPLUG_HOME="/usr/local/opt/zplug"
fi
export ZPLUG_HOME
source $ZPLUG_HOME/init.zsh
