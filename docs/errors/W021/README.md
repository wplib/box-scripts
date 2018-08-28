```
 __          _______  _      _ _       ____
 \ \        / /  __ \| |    (_) |     |  _ \
  \ \  /\  / /| |__) | |     _| |__   | |_) | _____  __
   \ \/  \/ / |  ___/| |    | | '_ \  |  _ < / _ \ \/ /
    \  /\  /  | |    | |____| | |_) | | |_) | (_) >  <
     \/  \/   |_|    |______|_|_.__/  |____/ \___/_/\_\
```

![WPLib-Box](https://github.com/wplib/box-scripts/blob/master/WPLib-Box-100x.png)

# W021 - box-scripts not present.

## Cause
The /opt/box scripts are not present on the Box.

## Common fixes
Pull down the latest box-scripts by doing the following:
* sudo git clone -q https://github.com/wplib/box-scripts/ /opt/box
Run an update:
* /opt/box/bin/box self-update


### 


## See Also
[Complete Error code repository for WPLib Box](https://github.com/wplib/box-scripts/tree/master/docs/errors)

