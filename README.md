# Mining Monero on Docker intro busybox

[Xmrig](https://github.com/xmrig/xmrig) is a free open source tool for mining Monero.
I made a simple Dockerfile to containerize this application and make deployment easy. I used alpine to compile and busybox to deploy.
When i wrote this file, the final image size is under 7MB.

## How it's works ?

Clone this git and launch tty in the same path of the **Dockerfile**. Then just run
```bash
$ docker build -t [your_name]/xmrig .
```

You will have a lot of informations, just wait.
Once you have finished, run container by typing :
```bash
$ docker run -it -d --name xmrig --restart always [your_name]/xmrig -o [url_of_your_pool] -u [your_wallet_id]
```

It creates one container whith label **xmrig** and launch xmrig app into background.
To view logs in real time :
```bash
$ docker logs -f xmrig
```
*(CTRL+C to exit)*

## Args
xmrig-busybox use ENTRYPOINT to start container, so you can add your args with command line when you start your container. By default, xmrig will show you help.

## Contribution
By default, Xmrig use 1% of your mining time for developer. In this version, the value of donation is set to 0% but you can ajust by command args :

```bash
$ docker run --rm pj/xmrig --help
Usage: xmrig [OPTIONS]

Network:
    [...]
      --donate-level=N          donate level, default 1%% (1 minute in 100 minutes)
      --donate-over-proxy=N     control donate over xmrig-proxy feature
```

If you don't want it, please consider make a donation to developer by using :
```
 * XMR: 48edfHu7V9Z84YzzMa6fUueoELZ9ZRXq9VetWzYGzKt52XU5xvqgzYnDK9URnRoJMk1j8nLwEVsaSWJ4fhdUyZijBGUicoD
 * BTC: 1P7ujsXeX7GxQwHNnJsRMgAdNkFZmNVqJT
```

To verify it's not my wallet, check [this out](https://github.com/xmrig/xmrig/blob/master/src/donate.h).