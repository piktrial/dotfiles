{ config, lib, ... }:

let
	appImagesDir = "${config.home.homeDirectory}/.nix/programs/appimages";

	appImages = [
		"cider"
		"thorium"
	];

	capitalize = s:
		lib.strings.concatStrings [
			(lib.strings.toUpper (lib.strings.substring 0 1 s))
			(lib.strings.substring 1 (lib.stringLength s) s)
		];

	mkWrapper = name: {
		".local/bin/${name}" = {
			text = ''
				#!/usr/bin/env bash
				exec appimage-run ${appImagesDir}/${name}.appimage "$@"
			'';
			executable = true;
		};

		".local/share/applications/${name}.desktop" = {
			text = ''
				[Desktop Entry]
				Name=${capitalize name}
				Exec=${config.home.homeDirectory}/.local/bin/${name} %u
				Icon=${name}
				Type=Application
				Categories=Utility;
				MimeType=application/x-executable;
				Terminal=false
			'';
		};
	};

	# Collect all wrapped files under `home.file`
	mergedFiles = lib.attrsets.mergeAttrsList (
		map (n: mkWrapper n) appImages
	);
in
{
	home.file = mergedFiles;
}


