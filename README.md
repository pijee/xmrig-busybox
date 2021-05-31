# Mining Monero on Docker intro busybox

(xmrig)[https://github.com/xmrig/xmrig] is a free open source for mining Monero.
I made a simple Dockerfile to containerize this application and to deploy it easyly. I used alpine to compile and busybox to deploy.
When i wrote this file, the final image size is under 7MB.