## ============================================================================
##                                  Prompt
## ============================================================================
# Returns a non-zero exit code for previous command
return_nonzero ()
{
    local RETVAL=$?
    [ $RETVAL -ne 0 ] && echo "$RETVAL"
}

# Returns the current branch information along with dirty/clean git status
parse_git_branch ()
{
    local BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [ ! "${BRANCH}" == "" ]; then
        local STAT=`parse_git_dirty`
        echo "(${BRANCH}${STAT})"
    else
        echo ""
    fi
}

# Returns the dirty/clean git status of the current repository
parse_git_dirty ()
{
    local status=`git status 2>&1 | tee`
    bits=''

    local dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
    [ "${dirty}" == "0" ] && bits="!${bits}"

    local untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
    [ "${untracked}" == "0" ] && bits="?${bits}"

    local ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
    [ "${ahead}" == "0" ] && bits="*${bits}"

    local newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
    [ "${newfile}" == "0" ] && bits="+${bits}"

    local renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
    [ "${renamed}" == "0" ] && bits=">${bits}"

    local deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
    [ "${deleted}" == "0" ] && bits="x${bits}"

    if [ ! "${bits}" == "" ]; then
        echo " ${bits}"
    else
        echo ""
    fi
}

# Set a colorful fancy prompt with Git branch and dirty status
PS1="\[\e[32m\]\u@\h\[\e[0m\] \[\e[35m\]\s\[\e[0m\] \[\e[33m\]\w\[\e[0m\] \[\e[34m\]\`parse_git_branch\`\[\e[0m\] \[\e[31m\]\`return_nonzero\`\[\e[0m\]\n\$ "
