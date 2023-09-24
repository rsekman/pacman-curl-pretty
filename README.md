# pacman-curl-pretty

Lets pacman download packages using curl, but keep pretty output.

## Rationale

Arch Linux's package manager, `pacman`, can be configured to use an external command to download files.
You might want to do this to access the flexibility and configurability of, e.g., `curl`.
One use case is proxy settings.
In my case, one package list would often time out, making `pacman -Syu` fail, so I wanted to increase the timeout limit.
However, the output of `curl` is not quite as pretty as that of the default downloader of `pacman`.
It does contain, though, all the information we need to reconstruct pretty output.
`pacman-curl-pretty` is essentially an `awk` script that does this, and a wrapper around `curl`.

## Installation

Put the executable (`pacman-curl-pretty`) somewhere on your `$PATH`.
It looks for `pacman-curl-pretty.awk` in `$PWD, /usr/lib/pacman-curl-pretty/, /var/lib/pacman-curl-pretty/`, in that order.

## Usage

Simply edit `/etc/pacman.conf` appropriately, viz.

```
[config]
XferCommand = /usr/bin/pacman-curl-pretty %o %u [options]
```
The `[options]` are passed directly to `curl`.
As an example, here is my configuration, with increased timeout:
```
XferCommand = /usr/bin/pacman-curl-pretty %o %u --location --continue - --fail --insecure --connect-timeout 60
```

## License

MIT License
