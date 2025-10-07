# ~/.bash_logout

if [[ -n $SSH_AGENT_PID ]]; then
	echo "Stopping ssh-agent (PID: $SSH_AGENT_PID)"
	eval `ssh-agent -k`
fi

history -a

