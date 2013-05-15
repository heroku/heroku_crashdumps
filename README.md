Heroku Crashdumps
=================

# Include in App

Simply include in your apps `rebar.config`:

```
{deps, [
       {heroku_crashdumps, "", {git, "git@git.herokai.com:heroku_crashdumps.git", {tag, "0.1.0"}}}
       ...
       ]
       ...
}
```

And to .app.src:

```
  ...
  {applications, [
                 kernel
                 ,stdlib
                 ...
                 ,heroku_crashdumps
                 ...
                 ]},
  ...
```

# Configure

* `ERL_CRASH_DUMP` : Path to store crash dump files under on system.
* `INSTANCE_NAME` : Name of instance to use in crash dump file name.
