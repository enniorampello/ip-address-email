# IP address by email

## Introduction

In this tutorial, I will explain how to set up a notification system that sends an email to your personal email address whenever the public IP address of the machine changes. By the end of the tutorial, you will be able to set up this system on your own Ubuntu server with your own email address.

First of all, why do we need such a system? The motivation is simple: if you do not have a registered domain or you don't want to pay for a DNS service, chances are that your ISP will keep changing the public address of your router for reasons that most of the times we are not aware of.
This situation might be daunting, especially when setting up a personal server in a house or office that is not close to where you currently live, so that you are not physically able to reach it and check for the new IP address of the router.

Here I will explain you how to implement a cost-free and resilient solution to this problem.

Let's jump right in!

## How to send an email from an Ubuntu server
