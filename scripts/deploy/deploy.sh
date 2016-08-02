#!/usr/bin/env bash
# This is can be triggered by a githook e.g .post-checkout, .post-merge, etc.
#

#Install and update libraries.
composer_install() {
    cd /var/www/html/htdocs
    composer install
    echo "Composer Install Complete"
}

# Run drush update.php, cache rebuild (cache clear in druapl 7), config-import (features-revert all), and finally
# another cache rebuild. The second cr's are probably not needed however this was a long standing bug in Drupal 7
# and this script was written hastily by a dev and not an op's guy. I've done my best.
config_import() {
    cd /var/www/html/htdocs/web
    ../vendor/bin/drush updb -y
	../vendor/bin/drush cr all
    ../vendor/bin/drush cim git -y
	../vendor/bin/drush cr all
	echo "Config Import Complete"
}

composer_install;
config_import;

echo "Deployment Complete"