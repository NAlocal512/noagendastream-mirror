#!/bin/bash
PASS_LENGTH=12
. /home/icecast2/util.bash

check_env_vars
mk_configs /home/icecast2
main $@
