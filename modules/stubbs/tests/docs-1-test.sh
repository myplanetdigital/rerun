#!/usr/bin/env roundup
#

# Let's get started
# -----------------

# Helpers
# ------------

rerun() {
    command $RERUN -M $RERUN_MODULES "$@"
}

validate() {
    doc=$1
    test -f $doc

    file $doc | grep -q roff
    grep -q '.TH stubbs 1' $doc
    grep -q '.SH NAME' $doc
    grep -q '.SH SYNOPSIS' $doc
    grep -q '.SH COMMANDS' $doc

}

# The Plan
# --------

describe "docs"


it_runs_interactively() {
    rerun stubbs:docs <<EOF
stubbs
EOF
    validate $RERUN_MODULE_DIR/stubbs.1

}

it_runs_fully_optioned() {
    FILE=$(mktemp /tmp/stubbs.1.XXXX)
    rerun stubbs:docs --module "stubbs" --file $FILE
    
    validate $FILE
    rm -f $FILE
}

