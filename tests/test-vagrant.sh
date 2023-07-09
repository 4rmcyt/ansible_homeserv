#!/bin/bash
DIR=$(dirname "$0")
PLAYBOOK_DIR=$DIR/..

header() {
    clear
    cat <<"EndOfMessage"
                          4MMMMMMMMMMMML
                       4MMMMMMMMMMMMMMMML
                      MMMMMMMMMMMMMMMMMMML
                     4MMMMMMMMMMMMMMMMMMMMM
                    4MMMMMMMMMMMMMMMMMMMMMML
                    MMMMP   MMMMMM   MMMMMMM
                    MMMM MM  MMM  MM  MMMMMM
                    MMMM MM  MMM  MM  MMMMML
                     MMM MP,,,,,,,MM  MMMMMM
                      MM,"          "MMMMMMP
                      MMw           'MMMMMM
                      MM"w         w MMMMMMML
                      MM" w       w " MMMoMMML
                     MMM " wwwwwww "  MMMMMMML
                   MMMP   ".,,,,,,"     MMMMMMMML
                  MMMP                    MMMMMMMML
                MMMMM                      MMMMMMMML
               MMMMM,,-''             ''-,,MMMMMMMMML
              MMMMM                          MMMMMMMMML
             MMMMM                            MMMMMMMMML
            MMMMM                             MMMMMMMMMM
            MMMM                               MMMMMMMMMM
           MMMMM                               MMMMMMMMMML
          MMMMM                                MMMMMMMMMMM
         MMMMMM                                MMMMMMMMMMM
         MMMMMMM                               MMMMMMMMMMM
         """"MMMM                             MMMMMMMMMMP
        "     ""MMM                            MMMMMMMMP
   "" "         "MMMMMM                      """"MMMMMP"""
 "               "MMMMMMM                   ""   """"""   "
 "                ""MMMMMM                 M"             " ""
  "                 "                   MMM"                  "
 "                   "M               MMMM"                   "
 "                    "MM        MMMMMMMMM"                ""
 "                    "MMMMMMMMMMMMMMMMMMM"              """
  """"                "MMMMMMMMMMMMMMMMMM"           """"
      """"""""       MMMMM               "        ""
              """"""""                      """""""
   a n s i b l e -  homelab      https://github.com/4rmcyt/ansible_homeserv

EndOfMessage
    sleep 5
}

log() {
    printf "${TIME_FORMAT} %b\n" "$*";
}

fatal_error() {
    printf "${TIME_FORMAT} \e[41mERROR:\033[0m %b\n" "$*" >&2;
    exit 1
}

test_needs() {
    command -v $1 >/dev/null 2>&1 || fatal_error "Testing Ansible-NAS requires $1 but it's not installed. Please install it and try again."
}

testing_init() {
    log "Checking Vagrant installation"
    test_needs vagrant
}

header
testing_init

log "Starting Vagrant and running playbook"
while getopts ":p" opt; do
    case $opt in
    p)
        vagrant up --provision
        ;;
    \?)
        vagrant up
        ;;
    esac
done

log "Vagrant up completed, you can connect to the VM at http://172.30.1.5:10080. When you've finished testing, run 'vagrant destroy' to kill the VM."
