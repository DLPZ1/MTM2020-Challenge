# System configuration

sudo yum group install "Development Tools" -y
sudo dnf install python36 -y

sudo dnf install firewalld
sudo systemctl enable firewalld
sudo systemctl start firewalld
sudo firewall-cmd --zone=public --add-port=5000/tcp
sudo firewall-cmd --zone=public --add-port=80/tcp

mkdir MTM2020-Challenge && cd MTM2020-Challenge
sudo yum install virtualenv -y
virtualenv env
source ~/MTM2020-Challenge/env/bin/activate
pip3 install flask
pip3 install uwsgi

# TEST
#python3 app.py
#uwsgi --socket 0.0.0.0:5000 --protocol=http -w wsgi
#ps -ef | grep python

deactivate


# Create MTM2020 service

sudo vi /etc/systemd/system/mtm2020.service
#[Unit]
#Description=uWSGI instance to serve myproject
#After=network.target
#
#[Service]
#User=linux1
#Group=nginx
#WorkingDirectory=/home/linux1/MTM2020-Challenge
#Environment="PATH=/home/linux1/MTM2020-Challenge/env/bin"
#ExecStart=/home/linux1/MTM2020-Challenge/env/bin/uwsgi --ini mtm2020.ini
#
#[Install]
#WantedBy=multi-user.target

sudo systemctl daemon-reload
sudo systemctl start mtm2020
sudo systemctl enable mtm2020



# Configure NGINX server

sudo vi /etc/nginx/nginx.conf
#server {
#    listen 80;
#    server_name 148.100.78.134;
#
#    location / {
#        include uwsgi_params;
#        uwsgi_pass unix:/home/linux1/MTM2020-Challenge/mtm2020.sock;
#    }
#}
#
#server {
# ....
#}

sudo usermod -a -G linux1 nginx
chmod 710 /home/linux1
sudo nginx -t