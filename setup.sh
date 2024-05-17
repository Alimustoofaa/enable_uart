#!/bin/bash

# 1. Compile setuart.c
gcc setuart.c -o setuart -lmraa

# Check if compilation was successful
if [ $? -eq 0 ]; then
    echo "Compilation successful."
else
    echo "Compilation failed. Exiting."
    exit 1
fi

# 2. Copy setuart to /etc/init.d/
cp setuart /etc/init.d/

# Check if copy was successful
if [ $? -eq 0 ]; then
    echo "setuart copied to /etc/init.d/ successfully."
else
    echo "Failed to copy setuart to /etc/init.d/. Exiting."
    exit 1
fi

# 3. Create disable_uart.service
tee /etc/systemd/system/disable_uart.service > /dev/null <<EOF
[Unit]
Description=Configure UART at startup
After=default.target

[Service]
ExecStart=/etc/init.d/setuart
Type=oneshot
RemainAfterExit=true

[Install]
WantedBy=default.target
EOF

# Check if service file creation was successful
if [ $? -eq 0 ]; then
    echo "disable_uart.service created successfully."
else
    echo "Failed to create disable_uart.service. Exiting."
    exit 1
fi

# Reload systemd to pick up changes
systemctl daemon-reload

# Enable the service
systemctl enable disable_uart.service

# Check if service was enabled successfully
if [ $? -eq 0 ]; then
    echo "Service enabled successfully."
else
    echo "Failed to enable service. Exiting."
    exit 1
fi

# Inform user about next steps
echo "Setup completed successfully. You may need to reboot for changes to take effect."
