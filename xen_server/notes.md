# Random Xen Server Notes


## Mount Another Disk
```bash
xe sr-create content-type=user device-config:device=/dev/sda host-uuid=10ea6aaf-74e6-421d-9e00-bf81c81c48de name-label="Local Storage 2" shared=false type=ext
1fc2f765-9db3-8987-8830-f065194eb1a6
```

## Create a Library To Mount Images
```bash
xe sr-create name-label="ISO Library" type=iso device-config:location=/var/run/sr-mount/1fc2f765-9db3-8987-8830-f065194eb1a6/iso_library device-config:legacy_mode=true content-type=iso
05f1317b-7e41-e1e8-6b71-3af013d7598d
```

```
root@xen01 iso_library]# netstat -tap
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address               Foreign Address             State       PID/Program name   
tcp        0      0 *:ssh                       *:*                         LISTEN      3945/sshd           
tcp        0      0 *:ipcserver                 *:*                         LISTEN      3188/rpc.statd      
tcp        0      0 *:https                     *:*                         LISTEN      4269/stunnel        
tcp        0      0 localhost:9501              *:*                         LISTEN      4654/vncterm        
tcp        0      0 localhost:4094              *:*                         LISTEN      2890/xcp-networkd   
tcp        0      0 localhost:5901              *:*                         LISTEN      4654/vncterm        
tcp        0      0 localhost:5902              *:*                         LISTEN      29350/qemu-dm-6     
tcp        0      0 localhost:sunrpc            *:*                         LISTEN      2869/portmap        
tcp        0      0 *:http                      *:*                         LISTEN      3653/xapi           
tcp        0    296 192.168.81.8:ssh            192.168.81.245:61846        ESTABLISHED 1158/sshd           
tcp        0      0 localhost:47566             localhost:http              ESTABLISHED 4269/stunnel        
tcp        0      0 localhost:http              localhost:47593             TIME_WAIT   -                   
tcp        0      0 localhost:http              localhost:47566             ESTABLISHED 3653/xapi           
tcp        0      0 localhost:http              localhost:47567             ESTABLISHED 3653/xapi           
tcp        0      0 192.168.81.8:https          192.168.81.111:50774        ESTABLISHED 4269/stunnel        
tcp        0      0 192.168.81.8:https          192.168.81.111:50773        ESTABLISHED 4269/stunnel        
tcp        0      0 localhost:47567             localhost:http              ESTABLISHED 4269/stunnel      
```

```
Nmap scan report for 192.168.81.8
Host is up (0.16s latency).
Not shown: 992 closed ports
PORT     STATE    SERVICE
22/tcp   open     ssh
80/tcp   open     http
110/tcp  open     pop3
143/tcp  open     imap
443/tcp  open     https
993/tcp  open     imaps
995/tcp  open     pop3s
2638/tcp filtered sybase
```
