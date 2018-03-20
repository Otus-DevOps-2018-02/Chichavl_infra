# Chichavl_infra
Chichavl Infra repository

# Подключение через bastion host

## Подключение одной командой
`ssh -i ~/.ssh/appuser -A appuser@104.155.36.168 'ssh -tt 10.128.0.2'` - используем ssh, чтобы запустить комманду ssh -tt 10.128.0.2 на бастион хосте, -tt нужны для корректного выделеления tty на внутреннем хосте
Но оно отдает душком и с ним есть проблема, команды сначала выводятся в консоль, потом выводится результат их исполнения
```
Last login: Tue Mar 13 21:22:36 2018 from 10.132.0.2
appuser@someinternalhost:~$ hostname
hostname
someinternalhost
appuser@someinternalhost:~$ ls -al
ls -al
total 32
drwxr-xr-x 4 appuser appuser 4096 Mar 13 22:21 .
drwxr-xr-x 5 root root 4096 Mar 13 22:16 ..
-rw------- 1 appuser appuser 16 Mar 13 22:21 .bash_history
-rw-r--r-- 1 appuser appuser 220 Aug 31 2015 .bash_logout
-rw-r--r-- 1 appuser appuser 3771 Aug 31 2015 .bashrc
drwx------ 2 appuser appuser 4096 Mar 13 11:15 .cache
-rw-r--r-- 1 appuser appuser 655 May 16 2017 .profile
drwx------ 2 appuser appuser 4096 Mar 13 11:10 .ssh
appuser@someinternalhost:~$
```
Не могу понять почему так происходит

И я бы решил первое задание также через ProxyCommand, как и второе, так как оно работает более ожидаемо и стабильно
`ssh -o ProxyCommand="ssh -W %h:%p appuser@104.155.36.168" appuser@10.128.0.2`

## Подключение через алиас
Добавляем пользователю конфиг ssh следующего содержания
```
$ cat ~/.ssh/config
Host internalhost
User appuser
Hostname 10.128.0.2 # internal host IP
ProxyCommand ssh -W %h:%p appuser@104.155.36.168 # Bastion external IP
```
После этого соединяемся командой `$ ssh internalhost` и попадаем сразу в консоль на внутренний хост, не имеющий доступа к интернету

bastion_IP = 104.155.36.168
someinternalhost_IP = 10.128.0.2

# Работа с gcloud
## Создание инстанса со startup-script
```
gcloud compute instances create reddit-app --boot-disk-size=10GB --image-family ubuntu-1604-lts --image-project=ubuntu-os-cloud --machine-type=g1-small --tags puma-server --restart-on-failure --metadata startup-script='wget -O - https://gist.githubusercontent.com/Chichavl/43179235635ac934b6780a03cbee1ec8/raw/34cdc303ffbeb8aff4362515318db599d8b72ec2/startup_script.sh | bash'
```
## Создание правила Firewall`а
```
gcloud compute --project=infra-197910 firewall-rules create default-puma-server --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:9292 --source-ranges=0.0.0.0/0 --target-tags=puma-server
```
testapp_IP = 35.189.216.200
testapp_port = 9292
