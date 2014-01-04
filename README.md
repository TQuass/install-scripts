install-scripts
===============

Installation and cron scripts for the WeRelate software.

http://sandbox.werelate.org is configured using these scripts.
It runs on a micro instance with Ubuntu 12.04 at Amazon Web Services.

Pre-requisites
==============

The WeRelate software requires the following to be installed:

* a mail server like postfix
* memcached -- _assumed running on localhost port 11211; this is configurable_
* imagemagick
* mysql
* apache2
* php5 php5-curl php5-cli php5-mysql php-apc php-pear
* libapache2-mod-php5
* install apache2 mods using a2enmod: deflate expires php5 rewrite proxy proxy_http
* postfix or another mailer -- _for sending mail_
* java -- _needed only for search and gedcom upload - tested using openjdk-7-jdk_
* tomcat7 -- _needed only for search and gedcom upload_
* git -- _needed by the configure.sh script_
* ant and ant-optional -- _needed by the configure.sh script_
* flex 3.5 -- _needed only for gedcom review_ -- make sure files are readable by the ubuntu user

        mkdir /opt/flex3
        cd /opt/flex3
        wget http://download.macromedia.com/pub/flex/sdk/flex_sdk_3.5.zip
        unzip flex_sdk_3.5.zip
        cp /opt/flex3/ant/lib/flexTasks.jar /usr/share/ant/lib
        chmod a+r /usr/share/ant/lib/flexTasks.jar

Setting up the database
=======================

* A skeleton database can be downloaded from http://public.werelate.org.s3.amazonaws.com/wikidb.sql
* create a database in mysql and import the skeleton

Configuring the server
======================

The following assumes that you are running all of the WeRelate processes on localhost.

First, determine values for the following:

* DATABASE_NAME -- _the database that you imported the skeleton into_
* DATABASE_USER -- _a database user that has full access to the database_
* DATABASE_PASSWORD -- _password for that user_
* YOUR_WIKI_ACCOUNT_PASSWORD -- _password for the WikiSysop user account_
* YOUR_EMAIL

Next, fork this project and replace the placeholders in the following files with the values you determined.
(I know there's a lot of redundancy here; I hope to eliminate most of it eventually):

* apps/wiki/werelate
* apps/search/db_memcache.properties -- _needed only if you're running search_
* apps/search/indexer.properties -- _needed only if you're running search_
* server/tomcat7.extra -- _needed only if you're running search_
* apps/werelate-gedcom/gedcom.properties -- _needed only if you're importing gedcoms_
* jobs/environment -- _needed only if you're running cron jobs_
* You may want to edit other scripts as well to suit your environment, especially if you are not running on localhost as user ubuntu.

Finally, run `install-scripts/server/configure.sh`

Running the software
====================

* set the password for WikiSysop to the one you chose above:

        source install-scripts/jobs/environment
        php -q wiki/maintenance/changePassword.php --user=WikiSysop --password=YOUR_WIKI_ACCOUNT_PASSWORD

* start tomcat to run the search server: `sudo /etc/init.d/tomcat7 start`
* start apache to run the wiki: `sudo /etc/init.d/apache2 start`
* append crontab.extra to your /etc/crontab file to run the indexer, gedcom uploader, etc.
* sign in to the wiki as WikiSysop, click on Settings, change the email address, and
confirm your new address by clicking on the link in the confirmation email.

Caveats
=======

* The software is running on www.werelate.org, but this is the first time it has been made available externally.
There may be assumptions about the WeRelate environment embedded in the software that I haven't yet caught and externalized.
If you run into problems, please post issues.  Pull requests are welcome!

* Place auto-complete doesn't currently work because the place namespace in the skeleton database is empty.
I plan to eventually make place auto-complete available through WeRelate. Let me know if you need this.

Roadmap
=======

The wiki software is running on an ancient version of MediaWiki.
I'd like to start migrating the wiki software to the current version of MediaWiki.
Help is welcome.

test push
