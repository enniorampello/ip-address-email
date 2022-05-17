# IP address by email

## Introduction

In this tutorial, I will explain how to set up a notification system that sends an email to your personal email address whenever the public IP address of the machine changes. By the end of the tutorial, you will be able to set up this system on your own Ubuntu server with your own email address.

First of all, why do we need such a system? The motivation is simple: if you do not have a registered domain or you don't want to pay for a DNS service, chances are that your ISP will keep changing the public address of your router for reasons that most of the times we are not aware of.
This situation might be daunting, especially when setting up a personal server in a house or office that is not close to where you currently live, so that you are not physically able to reach it and check for the new IP address of the router.

Here I will explain you how to implement a cost-free and resilient solution to this problem.

Let's jump right in!

![image](https://user-images.githubusercontent.com/48623568/168865434-7a640714-9d67-43e3-bd4c-df5130635e6f.jpeg)

## How to discover your public IP address

Most of the times, when we talk about IP addresses in local networks we refer to the *local* (or *private*) IP address. This is the address that identifies the machine in the local network. Most of the times this address can change due to the DHCP server that is present in most routers but it is possible to set up a static local IP address if we want to run a server inside the private network. 

In this tutorial, whenever I will speak about IP address, I will mean the *public* address, which is the unique identifier of the router on a global scale. By knowing this IP address, you will be able to access your network from anywhere in the world. However, this address is managed by the ISP that provides internet connection to the router, thus, it might be subject to changes from time to time.

In Ubuntu, it is possible to discover the public IP address of the router by simply issuing the following command:

```
$ curl ifconfig.me
```

The output of this command will be something like ``123.123.123.123`` and that is your public IP address.

Now that we know how to get the public IP address, we can see how to send an email from a linux server.

## How to send an email from an Ubuntu server

There are several ways to send an email from an Ubuntu 20.04 server. The method that I am going to use for this tutorial is to set up a ssmtp server on the linux machine and send emails through the gmail servers. You can install the required tools by running the following commands:

```
$ sudo apt update
$ sudo apt install ssmtp
```

Once everything is installed, you proceed with the configuration of the ssmtp server. In order to proceed, you must edit the file ``/etc/ssmtp/ssmtp.conf`` by using:

```
$ sudo vim /etc/ssmtp/ssmtp.conf
```

Inside the file, you have to add the following lines:

```
root=<your-gmail-address>

mailhub=smtp.gmail.com:587
AuthUser=<your-gmail-address>
AuthPass=<your-gmail-password>
UseTLS=YES
UseSTARTTLS=YES
AuthMethod=LOGIN
```

This configuration basically specifies the SMTP server to use to send emails and the credentials of your gmail address. Remember to "Allow less secure apps" in your gmail setting, otherwise the following commands will not work.

At this point, you can check that your mail system is working by creating a new file that you can call ``message.txt``:

```
$ vim message.txt
```

Inside the file, you can write the following content:

```
Subject: <this is the subject>

<this is line 1 of the body>
<this is line 2 of the body>
```

Once you have written the file, you can send yourself an email by running:

```
ssmtp <any-email-address> < message.txt
```

Congratulations! You just received an email from your server.

Now, we can move on to dynamically check the IP address and check if it changed.

## How to schedule the execution of a shell script

In order to keep checking the IP address of the machine, the solution that I decided to implement is to execute a shell file as a cron job and schedule its execution every 5 minutes. So how to do this? Here below are all the steps that you need.

First of all, create a shell file and make sure it is executable. We do this by running the following commands:

```
$ touch mail.sh
$ sudo chmod +x mail.sh
```

Once you have created the file, you can execute whatever you want inside it.
Now, we can schedule the execution of the file using ``crontab``.

```
$ crontab -e
```

I will schedule the execution of our shell script for every 5 minutes by adding the following line in the crontab file:

```
*/5 * * * * <path-to-your-file>/mail.sh
```

Now your file will get executed every 5 minutes. Awesome!

## Putting all together

For the final part of this tutorial, it is time to write the content of the file ``mail.sh``, that we created before.

So, here is a small script that will check the current IP address and compares it with the one obtained by the previous check. Then, if the IP address has changed, it sends an email notification that contains the new IP address.

```
#!/bin/bash
# check and send ip address to email

MYIP=`curl ifconfig.me`;
TIME=`date`;

LASTIPFILE='<path-of-choice>/.last_ip_addr';
LASTIP=`cat ${LASTIPFILE}`;

if [[ ${MYIP} != ${LASTIP} ]]
then
        echo "New IP = ${MYIP}"
        echo "sending email.."
        echo -e "Hello\n\nTimestamp = ${TIME}\nIP = ${MYIP}\n\nBye" | \
                ssmtp -s "[INFO] New IP" <any-email-address>;
        echo ${MYIP} > ${LASTIPFILE};
else
        echo "no IP change!"
fi
```

And that is it! Congratulations for coming this far, I hope it was worth [it](https://www.memecreator.org/meme/is-it-really-worth-it/).
