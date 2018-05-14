function start_ssh_agent
    rm -f $SSH_AUTH_SOCK
    ssh-agent -c -a $SSH_AUTH_SOCK | sed 's/^echo/#echo/' > $SSH_ENV
    chmod 600 $SSH_ENV 
    . $SSH_ENV > /dev/null
    ssh-add ~/.ssh/id_rsa > /dev/null 2>&1
end
