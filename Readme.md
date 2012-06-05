# Usage

The generated upstart configuration completely ignores the `concurrency`
setting from foreman. The number of processes running will be controlled by
environment variables of the following format:

```
APP_PROCESSNAME_SCALE=N
```

If there is no such variable in the user's environment (where `user` is the one
being used to launch the process), the upstart configuration assumes
`APP_PROCESSNAME_SCALE=0`.


# Authors

Fabio Kung

# Credits

David Dollar (@ddollar), for the work on foreman.
Keith Rarick (@kr), for the `fifo(7)` dance.

# License

MIT

