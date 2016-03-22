var wol     = require('wol');
var http    = require('http');
var os      = require('os');
var options = {};

if (!process.env.MAC) {
  console.log('missing environment variables: MAC');
  process.exit(1);
}
if (process.env.IP) {
  options.address = process.env.IP;
}
if (process.env.PORT) {
  options.port = process.env.PORT;
}

function callback (req, res) {
  console.log(
    'sending WOL request to ' + process.env.MAC +
    ' with ' + JSON.stringify(options)
  );
  wol.wake(process.env.MAC, options, function(err){
    if (err) {
      console.log('err', err);
    } else {
      console.log('> send magic packet to %s success .', process.env.MAC);
    }

    res.end();
  });
}
function listening () {
  console.log('listening on 3488...');
}

http.createServer(callback).listen(3488, listening);
