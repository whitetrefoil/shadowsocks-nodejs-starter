yargs = require('yargs')
.usage 'Usage: ss-start [--options] [-- shadowsocks_arguments]'
.example 'daemon server with ssserver options:', 'ss-start -Sd -- -c ~/ssserver.json'

.alias 'S', 'server'
.describe 'S', 'start "ssserver", default is "sslocal"'
.boolean 'S'

.alias 's', 'stop'
.describe 's', 'stop a running daemon server/client'
.boolean 's'

.alias 'r', 'restart'
.describe 'r', 'restart the running daemon server/client\n
                or start a new one (if not running yet)'
.boolean 'r'

.alias 'd', 'daemon'
.describe 'd', 'start the server/client as a daemon'
.boolean 'd'

.alias 'p', 'pid='
.describe 'p', 'specify the path of .pid file\n
                this is default when run w/ --daemon\n
                if no path is given, put under the cwd\n
                and name "sslocal.pid" or "ssserver.pid"'
.string 'p'

.alias 'P', 'no-pid'
.describe 'P', 'don\'t create a .pid file\n
                This is default when run w/o --daemon'

.alias 'h', 'help'
.describe 'h', 'print this help message'
.boolean 'h'

.wrap 80

module.exports = yargs
