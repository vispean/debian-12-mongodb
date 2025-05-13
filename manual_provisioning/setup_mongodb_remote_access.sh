#!/bin/bash

#########
    #
    #  setup
    #
    #  shell script for provisioning of a debian 12 machine with a LAMP stack and possibly phpMyAdmin and/or a local python installation
    #
    #  @package     Debian-12-Bookworm-CH
    #  @subpackage  LAMP-phpMyAdmin
    #  @author      Christian Locher <locher@faithpro.ch>
    #  @copyright   2025 Faithful programming
    #  @license     http://www.gnu.org/licenses/gpl-3.0.en.html GNU/GPLv3
    #  @version     alpha - 2025-05-02
    #  @since       File available since release alpha
    #
    #########

# make sure that the vagrant user belongs to the group vboxsf to access a shared folder:
# $ groups
#
# if the user doesn't belong to the group, add it:
# $ sudo usermod -a -G vboxsf vagrant

set_up_mongodb_compass() {
    # install wget
    sudo apt-get install -y wget

    # download MongoDB Compass installation package
    wget https://downloads.mongodb.com/compass/mongodb-compass_1.45.4_amd64.deb

    # install MongoDB Compass
    sudo apt-get install ./mongodb-compass_1.45.4_amd64.deb

    # delete installation package
    rm ./mongodb-compass_1.45.4_amd64.deb

    # uninstall wget
    sudo apt-get purge -y wget

    # start MongoDB Compass
    touch /home/vagrant/Schreibtisch/mongodb-compass.sh
    chmod ugo+x /home/vagrant/Schreibtisch/mongodb-compass.sh
    echo "#!/bin/bash\nmongodb-compass 'mongodb://192.168.56.10:27017'" >> /home/vagrant/Schreibtisch/mongodb-compass.sh

    # create AirBnB directory
    mkdir /home/vagrant/Schreibtisch/AirBnB

    # copy excercise and solution files in to the new directory
    cp /mnt/AirBnBZurich_Aufgaben.md /home/vagrant/Schreibtisch/AirBnB/AirBnBZurich_Aufgaben.md
    cp /mnt/AirBnBZurich_Lösungen.md /home/vagrant/Schreibtisch/AirBnB/AirBnBZurich_Lösungen.md
    cp /mnt/AirBnBZurich_Exercises.md /home/vagrant/Schreibtisch/AirBnB/AirBnBZurich_Exercises.md
    cp /mnt/AirBnBZurich_Solutions.md /home/vagrant/Schreibtisch/AirBnB/AirBnBZurich_Solutions.md
}

echo "#########################"
echo "# setup MongoDB Compass #"
echo "#########################"
set_up_mongodb_compass
