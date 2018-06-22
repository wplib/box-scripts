<?php

if ( ! isset( $argv[1] ) ) {
	echo "ERROR: Root directory not passed to " . __FILE__;
	die();
}
remove_composer_require_dev( $argv[1] );

function remove_composer_require_dev( $root_dir ) {
	/*
	 * Look for $composer->{'require-dev'}
	 */
	do {

		$composer_file = $_SERVER['WPLIB_BOX_COMPOSER_FILE'];

		if ( ! is_file( $composer_file ) ) {
			break;
		}

		$json = file_get_contents( $composer_file );

		$composer = json_decode( $json );
		if ( ! $composer ) {
			error_die( "*Composer file {$composer_file} is not valid JSON.");
		}

		if ( ! isset( $composer->{'require-dev'} ) ) {
			break;
		}

		$object_ref = '$composer->extra';
		if ( ! isset( $composer->extra ) ) {
			error_die( "*'{$object_ref}' is not set in {$composer_file}.");
		}

		$extra =  $composer->extra;
		$object_ref .= '->{"installer-paths"}';
		if ( ! isset( $extra->{'installer-paths'} ) ) {
			error_die( "*'{$object_ref}' is not set in {$composer_file}.");
		}

		$installer_paths = $extra->{'installer-paths'};
		if ( ! is_object( $installer_paths ) ) {
			error_die( "*'{$object_ref}' is not an object in {$composer_file}.");
		}

		$installer_paths = @get_object_vars( $installer_paths );
		if ( ! $installer_paths ) {
			error_die( "*'{$object_ref}' from {$composer_file} could not be converted into an array.");
		}

		/*
		 * Scan through $composer->extra->{'installer-paths'} to find names we can match
		 *
		 * $items will look something like this:
		 *
		 *      Array
		 *      (
		 *          [wpackagist-plugin/wp-redis] => [${PROJECT_BASE}/${CURRENT_PROJECT}/www/content/mu-plugins/wpackagist-plugin/wp-redis],
		 *          [newclarity/facetwp]         => [${PROJECT_BASE}/${CURRENT_PROJECT}/www/content/mu-plugins/newclarity/facetwp],
		 *          [newclarity/bb-plugin]       => [${PROJECT_BASE}/${CURRENT_PROJECT}/www/content/plugins/newclarity/bb-plugin],
		 *      )
		 *
		 */
		$items = array();
		foreach( $installer_paths as $installer_path_name => $item_list ) {
			preg_match( '#/(mu-plugins|plugins|themes)/#', $installer_path_name, $match );
			foreach( $item_list as $item_name ) {
				if ( preg_match( '#^type:#', $item_name ) ) {
					continue;
				}
				$items[ $item_name ] = isset( $match[ 1 ] )
					? $match[ 1 ]
					: null;
			}
		}

		/*
		 * Look for $composer->config->{'vendor-dir'}
		 */
		do {
			$vendor_dir = null;
			if ( ! isset( $composer->config ) ) {
				break;
			}
			$config = $composer->config;
			if ( ! isset( $config->{'vendor-dir'} ) ) {
				break;
			}
			$vendor_dir = trim( $config->{'vendor-dir'}, '/' );
			$vendor_dir = preg_replace( '#^www/(.+)$#', '$1', $vendor_dir );
			$vendor_dir = "{$root_dir}/{$vendor_dir}";

		} while ( false );

		/**
		 * Now got back and get the list of require dev items.
		 */
		$require_dev = (array) $composer->{'require-dev'};

		$items_to_delete = array();
		foreach( array_keys( $require_dev ) as $dev_only ) {
			preg_match( '#^([^/]+)/(.+)$#', $dev_only, $segments );

			if ( ! isset( $segments[ 2 ] ) ) {
				continue;
			}

			if ( isset( $items[ $dev_only ] ) ) {
				$item = "{$root_dir}/wp-content/{$items[ $dev_only ]}/{$segments[ 2 ]}";

			} else if ( preg_match( '#^wpackagist-(plugin|theme)$#', $segments[ 1 ], $type ) ) {

				$item = "{$root_dir}/wp-content/{$type[ 1 ]}s/{$segments[ 2 ]}";

			} else {
				$item = "{$vendor_dir}/{$segments[ 2 ]}";

			}
			if ( empty( $item ) ) {
				continue;
			}

			if ( '/' === $item ) {
				continue;
			}

			if ( ! is_dir( $item ) ) {
				continue;
			}
			$regex = '#^' . preg_quote( $root_dir ). '(.+)$#';
			$content_key = preg_replace( $regex, '$1', $item );
			$items_to_delete[ $content_key ] = $item;

		}

		/**
		 * Now, finally, delete all them thar files
		 */
		ksort( $items_to_delete );
		foreach( $items_to_delete as $content_key => $item_to_delete ) {

			if ( ! file_exists( $item_to_delete ) ) {
				/**
				 * This checks file OR directory
				 */
				continue;
			}

			echo_if_not_quiet( "=\tDeleting {$content_key} from build directory..." );
			system( "rm -rf " . escapeshellarg( $item_to_delete ) );

		}

	} while ( false );

}
