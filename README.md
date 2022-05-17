# IP address by email

## Introduction

In this tutorial, I will explain how to set up a notification system that sends an email to your personal email address whenever the public IP address of the machine changes. By the end of the tutorial, you will be able to set up this system on your own Ubuntu server with your own email address.

First of all, why do we need such a system? The motivation is simple: if you do not have a registered domain or you don't want to pay for a DNS service, chances are that your ISP will keep changing the public address of your router for reasons that most of the times we are not aware of.
This situation might be daunting, especially when setting up a personal server in a house or office that is not close to where you currently live, so that you are not physically able to reach it and check for the new IP address of the router.

Here I will explain you how to implement a cost-free and resilient solution to this problem.

Let's jump right in!

## How to discover your public IP address

Most of the times, when we talk about IP addresses in local networks we refer to the *local* (or *private*) IP address. This is the address that identifies the machine in the local network. Most of the times this address can change due to the DHCP server that is present in most routers but it is possible to set up a static local IP address if we want to run a server inside the private network. 

In this tutorial, whenever I will speak about IP address, I will mean the *public* address, which is the unique identifier of the router on a global scale. By knowing this IP address, you will be able to access your network from anywhere in the world. However, this address is managed by the ISP that provides internet connection to the router, thus, it might be subject to changes from time to time.

In Ubuntu, it is possible to discover the public IP address of the router by simply issuing the following command:

```
$ curl ifconfig.me
```

The output of this command will be something like ``123.123.123.123`` and that is your public IP address.
## How to send an email from an Ubuntu server

## How to schedule the execution of a shell script

## Putting all together
