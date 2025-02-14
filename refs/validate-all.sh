#!/bin/bash

run_unix_cmd() {
    # $1 is the line number
    # $2 is the cmd to run
    # $3 is the expected exit code
    output=$($2 2>&1)
    exit_code=$?
    if [[ $exit_code -ne $3 ]]; then
        printf "failed (incorrect exit status code) on line $1.\n"
        printf "  - exit code: $exit_code (expected $3)\n"
        printf "  - command: $2\n"
        if [[ -z $output ]]; then
            printf "  - output: <none>\n\n"
        else
            printf "  - output: <starts on next line>\n$output\n\n"
        fi
        exit 1
    fi
}

DATE=$(date +%Y-%m-%d)

# Validation of the "netconf-quic" module

printf "Testing ietf-netconf-quic.yang (pyang)..."
command="pyang -Werror --ietf --max-line-length=72 ../ietf-netconf-quic\@*.yang"
run_unix_cmd $LINENO "$command" 0
command="pyang --canonical ../ietf-netconf-quic\@*.yang"
run_unix_cmd $LINENO "$command" 0
printf "ok.\n"
