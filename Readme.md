# Usage

The generated upstart configuration completely ignores the `concurrency`
setting from foreman. The number of processes running will be controlled by
environment variables of the following format:

```
PROCESSNAME_SCALE=N
```

If there is no such variable in the user's environment (where `user` is the one
being used to launch the process), the upstart configuration assumes
`PROCESSNAME_SCALE=0`. If the process name contains `-` (dashes), they will be
replaced with `_` (underscores).


# Authors

* Fabio Kung

# Credits

* David Dollar (@ddollar), for the work on foreman.
* Keith Rarick (@kr), for the `fifo(7)` dance.

# License

MIT

