# Adds monitoring to crontab - runs every minute
(crontab -l 2>/dev/null; echo "* * * * * /tmp/monitoring/monitoring.sh") | crontab -