# ~/.bash_logout

echo "Stopping ssh-agent (PID: $SSH_AGENT_PID)"
eval `ssh-agent -k`

