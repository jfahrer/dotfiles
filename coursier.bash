if [ ! -z $(which cs) ]; then
  export JAVA_HOME=$(cs java-home)
fi
