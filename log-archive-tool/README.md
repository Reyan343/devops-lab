The log-archive.sh script is used to create a backup of a specifed directory passed as an argument.

ex) ./log-archive.sh /var/logs will create a tar.gz archive of the /var/logs directory in the root location of where the script is located.

in order to schedule the runtime of this script a crontab can be used.
