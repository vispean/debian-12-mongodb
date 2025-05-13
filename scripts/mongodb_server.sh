#!/bin/bash
# https://docs.vagrantup.com/v2/provisioning/shell.html

#########
    #
    #  MongoDB Community Server
    #
    #  shell script for provisioning of a debian 12 machine with a MongoDB community server.
    #
    #  @package     Debian-12-Bookworm-CH
    #  @subpackage  MongoDB
    #  @author      Christian Locher <locher@faithpro.ch>
    #  @copyright   2025 Faithful programming
    #  @license     http://www.gnu.org/licenses/gpl-3.0.en.html GNU/GPLv3
    #  @version     alpha - 2025-05-13
    #  @since       File available since release alpha
    #
    #########

function setUpMongoDB {
    # install gpg and curl
    apt-get install -y gnupg curl

    # import MongoDB public GPG key
    curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg --dearmor

    # create list file for debian
    echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] http://repo.mongodb.org/apt/debian bookworm/mongodb-org/8.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list

    # uninstall gpg and curl
    apt-get purge -y gnupg curl

    # install MongoDB
    apt-get update
    apt-get install -y mongodb-org

    # make the MongoDB remotely accessible
    cp /vagrant/auxiliary_files/mongodb/mongod.conf /etc/mongod.conf

    # start MongoDB
    systemctl start mongod

    # make MongoDB autostart after boot
    systemctl enable mongod

    # populate database
    mongoimport --db airbnb --collection listings --file /vagrant/auxiliary_files/mongodb/listings_zurich.json --jsonArray
}

echo "#################"
echo "# setup MongoDB #"
echo "#################"
setUpMongoDB
