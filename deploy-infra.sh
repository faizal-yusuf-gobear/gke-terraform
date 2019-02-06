
#!/usr/bin/env bash
# Bash strict mode
# Functions inherit ERR traps
# Exit on ERR
# Exit on undefined variable
# Exit on pipe failures
set -Eeuo pipefail
# Useful variables
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Better error handling and exit cleanup
trap cleanup EXIT
trap err_report ERR
err_report() {
s=$?
echo "$0: Error on line "$LINENO": $BASH_COMMAND"
exit $s
}
cleanup(){
# Exit cleanup here
:
}
terraform init

terraform apply -yes