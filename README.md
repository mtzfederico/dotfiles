# dotfiles

## To install ##
```
git clone https://github.com/mtzfederico/dotfiles.git
cd dotfiles
./install.sh
```

## Functions ##
To compress a folder with tar and gzip
```
targz {folder}
```

To decompress a folder with tar and gzip
```
untargz {folder.tar.gz}
```

To create a folder and cd into it
```
mkcd {folder name}
```

Alias to open the nginx logs (/var/log/nginx)
```
nginxlogs
```

Alias to open the nginx config directory (/etc/nginx)
```
nginxconf
```

Alias to run the gunicorn server (gunicorn --bind 0.0.0.0:9080 wsgi:app)
```
runserver
```

Alias to open the web files directory (/var/www)
```
webdir
```

Alias to make shred replace the file with zeros after shreding and then deletes the file
```
shred <filename> (runs shred -zu <filename>)
```
