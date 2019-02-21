```
 __          _______  _      _ _       ____
 \ \        / /  __ \| |    (_) |     |  _ \
  \ \  /\  / /| |__) | |     _| |__   | |_) | _____  __
   \ \/  \/ / |  ___/| |    | | '_ \  |  _ < / _ \ \/ /
    \  /\  /  | |    | |____| | |_) | | |_) | (_) >  <
     \/  \/   |_|    |______|_|_.__/  |____/ \___/_/\_\
```

![WPLib-Box](https://github.com/wplib/box-scripts/blob/master/WPLib-Box-100x.png)

# W009 - Error image not found locally.

## Cause
Usually an error returned from the `box` command with any of the sub-commands `install`, `start`, `stop`, `rm`, `clean` and `refresh`.
The specified container image hasn't been pulled from the WPLib Box repository.

## Common fixes
Run a `box container create <image name>` to download and install the container.

### 


## See Also
[Complete Error code repository for WPLib Box](https://github.com/wplib/box-scripts/tree/master/docs/errors)

