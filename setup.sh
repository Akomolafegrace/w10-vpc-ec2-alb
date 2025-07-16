#!/bin/bash

# Update system
sudo yum update -y

# Install Apache
sudo yum install -y httpd

# Start and enable Apache
sudo systemctl start httpd
sudo systemctl enable httpd

# Create a custom HTML file
cat <<EOF | sudo tee /var/www/html/index.html
<html>
  <body style="background-color:#47D34F;">
    <h1>
      <p>Welcome to utrains, the place to learn DevOps, Cloud, Linux!!!<br> 
      This traffic is served from: <span style="color: purple;">${HOSTNAME}</span></p>
    </h1>
  </body>
</html>
EOF
