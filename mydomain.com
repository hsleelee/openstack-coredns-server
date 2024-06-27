$ORIGIN mydomain.com.
$TTL 5
@	IN	SOA ns.mydomain.com. no-op.mydomain.com. (
				1719476968 ; serial
				7200             ; refresh (2 hours), only affects secondary dns servers
				3600             ; retry (1 hour), only affects secondary dns servers
				604800           ; expire (1 week), only affects secondary dns servers
				5     ;
				)


dev IN A 172.17.250.175



