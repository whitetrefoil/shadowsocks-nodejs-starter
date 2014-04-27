This is a internal lib file.  It will be included at the head of [starter.coffee](starter.html).

Code
-----

Use [Yargs](https://github.com/chevex/yargs) to build the argv function and help display.

    yargs = require('yargs')
    .usage 'Usage: ss-start [--options] [-- shadowsocks_arguments]'
    .example 'daemon server with ssserver options:', 'ss-start -Sd -- -c ~/ssserver.json'

Specify to run the server.
If this argument isn't given, will run the local service by default.

    .alias 'S', 'server'
    .describe 'S', 'start "ssserver", default is "sslocal"'
    .boolean 'S'

If neither of `--stop` & `--restart` is given, the starter will have **NO** privilege to stop a running service.
As a result, if it detects there's already a server running, it will just quit.

if `--stop` is given, the starter will only stop the service, but won't start it again.
if `--restart` is given, it will stop then start the service.
Even if the service is not running actually, it will still start the service.

Both `--stop` & `--restart` internally rely on the PID file, and should only affect the daemon services usually.
If no `--pid=` given, these arguments will use the default ones.

    .alias 's', 'stop'
    .describe 's', 'stop a running daemon server/client'
    .boolean 's'

    .alias 'r', 'restart'
    .describe 'r', 'restart the running daemon server/client\n
                  or start a new one (if not running yet)'
    .boolean 'r'

Run the shadowsocks (server or local) as a daemon service.
This will cause a PID file to be created,
because it's the only way for the starter to operate them later.

The `--pid=` argument is **not** required.
If not given, the starter will use the current working directory (`process.cwd`),
and save the PID files according to which shadowsocks services is used.
`sslocal.pid` or `ssserver.pid`.

If you really don't want a PID file, give a `--no-pid`.
But if you do that, the starter has no way to stop / restart the service later.
Use your OS's process manager to do that.

    .alias 'd', 'daemon'
    .describe 'd', 'start the server/client as a daemon'
    .boolean 'd'

    .alias 'p', 'pid'
    .describe 'p', 'specify the path of .pid file\n
                    this is default when run w/ --daemon\n
                    if no path is given, put under the cwd\n
                    and name "sslocal.pid" or "ssserver.pid"'
    .string 'p'

    .alias 'P', 'no-pid'
    .describe 'P', 'don\'t create a .pid file\n
                    This is default when run w/o --daemon'
    .boolean 'P'

Print the help text.
[Yargs](https://github.com/chevex/yargs) didn't

    .alias 'h', 'help'
    .describe 'h', 'print this help message'
    .boolean 'h'

Change a new line at the 80th character.

    .wrap 80


Exports the whole yargs instance.

As a result, all properties & results of that are available.

    module.exports = yargs
