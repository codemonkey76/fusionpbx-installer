#cp "$(dirname $0)/source/freeswitch.service.source" /lib/systemd/system/freeswitch.service
cp "$(dirname $0)/source/freeswitch.service.source" /etc/systemd/system/freeswitch.service
cp "$(dirname $0)/source/etc.default.freeswitch.source" /etc/default/freeswitch

systemctl enable freeswitch
systemctl unmask freeswitch.service
systemctl daemon-reload
systemctl start freeswitch
