# UMLet.app
Install UMLet as OS X 10.10 App

Prerequisites:
* wget
* awk
* unzip
* curl
* makeicns

Execute the following commands to build prerequisites:

    > sudo port install wget
    > sudo port install curl
    > sudo port install awk
    > sudo port install unzip
    > sudo port install makeicns

Execute the following command to install UMLet.app:

    > git clone http://github.com/YauHsien/MakeOSXGood
    > cd MakeOSXGood/UMLet.app
    > sudo make install

Execute the following command to uninstall UMLet.app:

    > sudo make uninstall
