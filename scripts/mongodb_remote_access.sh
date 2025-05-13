#!/bin/bash
# https://docs.vagrantup.com/v2/provisioning/shell.html

#########
    #
    #  MongoDB Compass
    #
    #  shell script for provisioning of a debian 12 machine with MongoDB compass.
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

function setUpMongoDBCompass {
    # install wget
    apt-get install -y wget

    # download MongoDB Compass installation package
    wget https://downloads.mongodb.com/compass/mongodb-compass_1.45.4_amd64.deb

    # install MongoDB Compass
    apt-get install ./mongodb-compass_1.45.4_amd64.deb

    # delete installation package
    rm ./mongodb-compass_1.45.4_amd64.deb

    # uninstall wget
    apt-get purge -y wget

    # start MongoDB Compass
    touch /home/vagrant/Schreibtisch/mongodb-compass.sh
    chmod o+x /home/vagrant/Schreibtisch/mongodb-compass.sh
    echo -e "#!/bin/bash\nmongodb-compass 'mongodb://192.168.56.10:27017'" >> /home/vagrant/Schreibtisch/mongodb-compass.sh

    # create AirBnB directory
    mkdir /home/vagrant/Schreibtisch/AirBnB

    # copy excercise and solution files in to the new directory
    cp /vagrant/AirBnB/AirBnBZurich_Aufgaben.md /home/vagrant/Schreibtisch/AirBnB/AirBnBZurich_Aufgaben.md
    cp /vagrant/AirBnB/AirBnBZurich_Lösungen.md /home/vagrant/Schreibtisch/AirBnB/AirBnBZurich_Lösungen.md
    cp /vagrant/AirBnB/AirBnBZurich_Exercises.md /home/vagrant/Schreibtisch/AirBnB/AirBnBZurich_Exercises.md
    cp /vagrant/AirBnB/AirBnBZurich_Solutions.md /home/vagrant/Schreibtisch/AirBnB/AirBnBZurich_Solutions.md
}

echo "#########################"
echo "# setup MongoDB Compass #"
echo "#########################"
setUpMongoDBCompass
