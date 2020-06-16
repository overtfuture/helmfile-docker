#!/bin/ash

echo $PASSPHRASE > $HOME/.gpg_passphrase

cat $HOME/private_key.asc | gpg --batch --import

echo "no-tty" > $HOME/.gnupg/gpg.conf
echo "pinentry-program pinentry-curses" > $HOME/.gnupg/gpg-agent.conf
echo "default-cache-ttl-ssh 60480000" >> $HOME/.gnupg/gpg-agent.conf
echo "max-cache-ttl-ssh 60480000" >> $HOME/.gnupg/gpg-agent.conf
gpg-connect-agent reloadagent /bye
echo 'Pre-caching gpg passphrase' | gpg --pinentry-mode loopback --passphrase-file=$HOME/.gpg_passphrase --clear-sign

rm -rf $HOME/.gpg_passphrase

helmfile -e $ENVIRONMENT sync