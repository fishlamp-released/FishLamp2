#!/bin/bash
#
# Copyright (C) 2011 GreenTongue Software <hello@greentongue.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
#

# make sure the script fails if a command, or a command in the pipe fails.
# set -e
# set -o pipefail

# define globals
g_build_folder=""
g_app_name=""
g_build_path=""
g_input_file="" 

g_build_root=""

function PrintUsage
{
	echo ""
	echo "gtbuild <options>"
	echo "Required:"
	echo " -i or --input-file: path to input file plist"
	echo "Optional:"
	echo " -v verbose output"
	echo " -o or --output-folder: path to destination build folder. Uses \$FishLamp-Cocoa-x86/build by default."
	echo "Example:"
	echo " gtbuild -i my_app.plist -o ~/builds"
	echo ""
}

verbose="false"

mode=""
for i in "$@"
do
	if [[ "$i" == "-v" ]]
		then
		echo "verbose output enabled"
		verbose="true"
	elif [ "$mode" == "" ]
		then
		mode="$i"
	elif [[ "$mode" == "-i" || "$mode" == "--input-file" ]]
		then
		eval g_input_file="$i"
		mode=""
	elif [[ "$mode" == "-o" || "$mode" == "--output-folder" ]]
		then
		eval g_build_root="$i"
		mode=""
	elif [[ "$mode" == "--help" || "$mode" == "?" || "$mode" == "-?" ]]
		then
		PrintUsage
		exit 0
	else
		echo "unknown option $i"
		PrintUsage
		exit 1
	fi
done

if [ "$g_input_file" == "" ]
	then
	PrintUsage
	exit 1
fi

if [ "$g_build_root" == "" ]
	then
	
	if [ "$GT_ENLISTMENTS" == "" ]
		then
		echo "GT_ENLISTMENTS environment var not set - needed for default build location"
		exit 1
	fi
	
	g_build_root="$GT_ENLISTMENTS/Xcode/Builds"
fi

# echo $g_input_file
# echo $g_build_root

function verbose_log() {
	if [[ "$verbose" == "true" ]]
		then
		echo "    $1"
	fi
}

if [ ! -d "$g_build_root" ]
	then
	mkdir $g_build_root || { echo "creating build folder \"$g_build_root\" failed"; exit 1; }
	echo "created build folder: \"$g_build_root\""
fi

function check_dir()  {
	dir="$1"
	if [ ! -d "$dir" ]
		then
		echo "Directory not found: $dir"
		exit 1
	fi
	
	verbose_log "Found directory: \"$dir\""
}

function check_file()  {
	dir="$1"
	if [ ! -f "$dir" ]
		then
		echo "Directory not found: $dir"
		exit 1
	fi

	verbose_log "Found file: \"$dir\""
}

function assert_exists_on_disk() {
	path="$1"
	name="$2"
	
	if [ ! -f "$path" -a ! -d "$path" ]; then
		echo "$name not found at path: \"$path\""
		exit 1
	fi
	
	verbose_log "Found item at path: \"$path\""
}

assert_exists_on_disk "/usr/libexec/PlistBuddy" "PlistBuddy Tool"
assert_exists_on_disk "$g_build_root" "Build Root"
assert_exists_on_disk "$g_input_file" "Input File"
assert_exists_on_disk "$GT_ENLISTMENTS" "Enlistments Folder"

function set_build_path()
{
	project=`/usr/libexec/PlistBuddy -c "Print :project" $g_input_file` || { echo "project not found in input file"; exit 1; }
	workspace=`/usr/libexec/PlistBuddy -c "Print :workspace" $g_input_file` || { echo "workspace not found in input file"; exit 1; }
	configuration=`/usr/libexec/PlistBuddy -c "Print :configuration" $g_input_file` || { echo "configuration not found in input file"; exit 1; }
	platform=`/usr/libexec/PlistBuddy -c "Print :platform" $g_input_file` || { echo "platform not found in input file"; exit 1; }

	if [ "$project" != "" ]
		then
		local dir=`basename "$project" .xcodeproj`
	elif [ "$workspace" != "" ]
		then
		local dir=`basename "$workspace" .xcworkspace`
	else
		echo "need to set either workspace or project in input plist file"
		exit 1
	fi
	
	# check the platform
	if [ "$platform" = "macosx" ]
	then
		platform=""
	elif [ "$platform" = "iphoneos" ]
	then
		platform="-iphoneos"
	else
		echo "Unknown platform: $platform"
		exit 1
	fi

	eval g_build_folder="$g_build_root/$dir"

	if [ ! -d "$g_build_folder" ]
		then
		mkdir "$g_build_folder" || { echo "creating build folder \"$g_build_folder\" failed"; exit 1; }
	fi
	
	assert_exists_on_disk "$g_build_folder" "Build Folder"
	
	g_build_path="$g_build_folder/$configuration$platform"
	if [ ! -d "$g_build_path" ]
		then
		mkdir "$g_build_path" || { echo "creating $g_build_path folder failed"; exit 1; }
	fi
	assert_exists_on_disk "$g_build_path" "Build Path"
	
	pushd "$g_build_path" > /dev/null || { echo "couldn't clear $g_build_path"; exit 1; }
	local contents=`ls`
	if [ "$contents" != "" ]
		then
		rm -r * 
	fi
	popd > /dev/null
	
	verbose_log "Set Build Path: \"$g_build_path\""
}

function check_input()
{
	# error if the passed in file can't be found.
	if [ ! -f "$g_input_file" ]
		then
		echo "Can't find file: $g_input_file";
		exit 1;	
	fi

	# check to see if the script is should be run in a subdirectory of the current working directory
	# we'll do this by comparing the script_dir to the file. If they're the same, we're going to run
	# in the current working directory.
	local script_dir=${g_input_file%/*}
	local file=${g_input_file##*/}

	# cd into subdir if needed
	if [ "$script_dir" != "$file" ]
		then
		cd "$script_dir"
		g_input_file="$file"
	fi
	
	assert_exists_on_disk "$g_input_file" "Input File"
	
}

function bump_version()
{
	# make sure plist file is there
	app_info_plist=`/usr/libexec/PlistBuddy -c "Print :app_info_plist" $g_input_file` || { echo "app_info_plist not found in input file"; exit 1; }

	assert_exists_on_disk "$app_info_plist" "Project's info plist file"
		
	# note that we can't use agvtool to read version because it returns an empty string if the version
	# isn't a float format eg. 1.1 and our version is in the format 1.2.3.4, so we'll use PListBuddy
	# to read the CFBundleVersion from the plist version
	# so this doesn't work: vers=`agvtool what-version -terse`
	vers=`/usr/libexec/PlistBuddy -c "Print :CFBundleVersion" $app_info_plist` || { echo "CFBundleVersion not found in input file"; exit 1; }

	# parse build num from vers
	build_num=${vers##*.}

	# parse version number without build number from vers
	vers_base=${vers%.*}
	
	# increment build number (is there a better way to do this?)
	build_num=`echo $build_num + 1 | bc`

	# rebuild full version number
	vers="$vers_base.$build_num"

	echo "bumping build to $vers"
	
	# we can write the build number in format 1.2.3.4 with agvtool (though reading doesn't work)
	agvtool -noscm new-version -all $vers > /dev/null
}

function build_project()
{
	project=`/usr/libexec/PlistBuddy -c "Print :project" $g_input_file` || { project "target not found in input file"; exit 1; }
	
	assert_exists_on_disk "$project" "Xcode Project"
		
	clean=`/usr/libexec/PlistBuddy -c "Print :clean" $g_input_file` || exit 1
	if [ "$clean" = true ]; then
		action="clean build"
	else
		action="build"
	fi
	
	configuration=`/usr/libexec/PlistBuddy -c "Print :configuration" $g_input_file` || { echo "configuration not found in input file"; exit 1; }
	target=`/usr/libexec/PlistBuddy -c "Print :target" $g_input_file` || { echo "target not found in input file"; exit 1; }
	
	echo "Building: project $project, configuration: $configuration, target: $target, into $g_build_folder, keep your pants on..."
	echo "Build File is here: $g_build_path/last_build.log"

	buildfile="$g_build_path/last_build.log"
	
	xcodebuild -project $project -target "$target" -configuration $configuration ONLY_ACTIVE_ARCH="NO" SYMROOT="$g_build_folder" OBJROOT="$g_build_folder" $action > "$buildfile" || { cat "$buildfile"; exit 1; }
	
	tail -30 "$buildfile"
}

function build_workspace()
{
	workspace=`/usr/libexec/PlistBuddy -c "Print :workspace" $g_input_file` || { echo "workspace not found in input file"; exit 1; }

	assert_exists_on_disk "$workspace" "Xcode Workspace"
		
	clean=`/usr/libexec/PlistBuddy -c "Print :clean" $g_input_file` || { echo "clean not found in input file"; exit 1; }
	if [ "$clean" = true ]; then
		action="clean build"
	else
		action="build"
	fi
	
	scheme=`/usr/libexec/PlistBuddy -c "Print :scheme" $g_input_file` || { echo "scheme not found in input file"; exit 1; }
	configuration=`/usr/libexec/PlistBuddy -c "Print :configuration" $g_input_file` || { echo "configuration not found in input file"; exit 1; }

	local buildfile="$g_build_path/last_build.log"
	
	echo "Building: workspace: $workspace, scheme: $scheme, configuration: $configuration into $g_build_folder, keep your pants on..."

	xcodebuild -workspace $workspace -configuration $configuration -scheme $scheme ONLY_ACTIVE_ARCH="NO" SYMROOT="$g_build_folder" OBJROOT="$g_build_folder" $action > "$buildfile" || { cat "$buildfile"; exit 1; }
	
	tail -30 "$buildfile"
}

function build()
{
	project=`/usr/libexec/PlistBuddy -c "Print :project" $g_input_file` || { echo "project not found in input file"; exit 1; }
	workspace=`/usr/libexec/PlistBuddy -c "Print :workspace" $g_input_file` || { echo "workspace not found in input file"; exit 1; }
	if [ "$project" != "" ]
		then
		build_project
	elif [ "$workspace" != "" ]
		then
		build_workspace
	else
		echo "need to set either workspace or project in input plist file"
		exit 1
	fi
}

function make_ipa()
{
	signature=`/usr/libexec/PlistBuddy -c "Print :signature" $g_input_file` || { echo "signature not found in input file"; exit 1; }
	profile=`/usr/libexec/PlistBuddy -c "Print :profile" $g_input_file` || { echo "profile not found in input file"; exit 1; }

	assert_exists_on_disk "$signature" "Signature to sign ipa"
	assert_exists_on_disk "$profile" "Profile to sign ipa"
	assert_exists_on_disk "$g_build_path/$g_app_name.app" ".app file for making ipa"

	echo "building ipa file: $g_build_path/$g_app_name.ipa"
	xcrun -sdk iphoneos PackageApplication "$g_build_path/$g_app_name.app" -o "$g_build_path/$g_app_name.ipa" --sign "$signature" --embed "$profile" || { echo "Creating ipa file failed"; exit 1; }
}

# function sign_app()
# {
# 	codesign -force --verify --verbose -sign "$DistributionIdentity" "$APPDIR"
# }

function post_to_testflight()
{
	echo "posting to testflightapp.com"

	test_flight_team_token=`/usr/libexec/PlistBuddy -c "Print :test_flight_team_token" $g_input_file` || { echo "test_flight_team_token not found in input file"; exit 1; }
	test_flight_api_token=`/usr/libexec/PlistBuddy -c "Print :test_flight_api_token" $g_input_file` || { echo "test_flight_api_token not found in input file"; exit 1; }
	test_flight_teams=`/usr/libexec/PlistBuddy -c "Print :test_flight_teams" $g_input_file` || { { echo "test_flight_teams not found in input file"; exit 1; } }

	pushd $g_build_path > /dev/null
	zipfile="$g_app_name.app.dSYM.zip"
	zip -r "$zipfile" "$g_app_name.app.dSYM" > /dev/null
	
	curl http://testflightapp.com/api/builds.json \
	  -F file=@"$g_app_name.ipa" \
	  -F dsym=@"$zipfile" \
	  -F api_token="$test_flight_api_token" \
	  -F team_token="$test_flight_team_token" \
	  -F notes='This build was uploaded via an automated build system. This build has not been published and the developer needs to add releases notes.' \
	  -F notify=False  \
	  -F distribution_lists="$test_flight_teams" || { rm "$zipfile"; echo "posting to testflightapp.com failed"; exit 1; }

	rm "$zipfile"

	popd > /dev/null

	echo ""
	echo "Be sure to log into http://www.testflightapp.com and publish the build with good release notes!"
}

function archive_build()
{
	archive_folder=`/usr/libexec/PlistBuddy -c "Print :archive_folder" $g_input_file` || { echo "archive_folder not found in input file"; exit 1; }
		
	# this resolves the ~ in the path, if it's there.
	eval archive_folder=$archive_folder

	assert_exists_on_disk "$archive_folder" "archive folder"
	
	# get the build version
	build_version=`agvtool what-version -terse`
	
	if [ "$build_version" == "" ]
		then
		# make sure plist file is there
		app_info_plist=`/usr/libexec/PlistBuddy -c "Print :app_info_plist" $g_input_file` || { echo "app_info_plist not found in input file"; exit 1; }

		assert_exists_on_disk "$app_info_plist" "Project\'s info plist file"
		
		build_version=`/usr/libexec/PlistBuddy -c "Print :CFBundleVersion" $app_info_plist` || { echo "CFBundleVersion not found in $app_info_plist"; exit 1; }
	fi
	
	if [ "$build_version" == "" ]
		then
		echo "Failed to get build number"
		exit 1
	fi
	
	# switch to build folder to make things easier.
	pushd $g_build_path > /dev/null
	
	# destination folder we'll zip up and then copy to archive folder
	folder_name="$g_app_name"_"$build_version"
		
	# make the new folder	
	mkdir "$folder_name"
	
	assert_exists_on_disk "$folder_name" "Destination folder"
	
	#if  there's an ipa, move that into the folder, if not
	# move the .app file. No point in archiving both.
	if [ -f "$g_app_name.ipa" ]
		then
		mv "$g_app_name.ipa" "$folder_name"
	elif [ -f "$g_app_name.mpkg" ]
		then
		mv "$g_app_name.mpkg" "$folder_name"
	elif [ -d "$g_app_name.app" ]
		then
		mv "$g_app_name.app" "$folder_name"
	else
		echo "didn't find .app, .ipa, or .mpkg to archive"
		exit 1
	fi

	# archive sym file
	if [ -d "$g_app_name.app.dSYM" ]
		then
		mv "$g_app_name.app.dSYM" "$folder_name"
		echo "archived $g_app_name.app.dSYM"
	fi

	# zip up the archive
	zip -r "$folder_name.zip" "$folder_name" > /dev/null

	# move the archive contents back to parent folder since we're done archiving them
	mv "$folder_name"/* .
	
	# remove archive folder now that we've zipped it up
	rm -r "$folder_name"

	# move zipped archive to archive folder
	mv "$folder_name.zip" "$archive_folder/$folder_name.zip"
	assert_exists_on_disk "$archive_folder/$folder_name.zip" "Build archive"

	echo "Archived $folder_name.zip to $archive_folder"

	open "$archive_folder"
	
	# pop back to original working directory
	popd > /dev/null
}



function build_package()
{
	pm_doc=`/usr/libexec/PlistBuddy -c "Print :package_maker_document" $g_input_file` || { echo "package_maker_document not found in input file"; exit 1; }
	package_name=`/usr/libexec/PlistBuddy -c "Print :package_name" $g_input_file` || { echo "package_name not found in input file"; exit 1; }
	
	dir=`pwd`
	pm_doc="$dir/$pm_doc"
	packagemaker="/Applications/PackageMaker.app/Contents/MacOS/PackageMaker"
	temp_name="$g_build_path/unsigned_installer.mpkg"
	final_name="$g_build_path/$package_name"


	built_path="$GT_ENLISTMENTS/Xcode/Builds/Zenfolio/Release/Zenfolio.iPhotoExporter"


	echo ""
	echo "Building package:" 
	echo "$pm_doc"
	echo "  into"
	echo "$temp_name" 

	assert_exists_on_disk "$packagemaker" "Package maker tool"
	assert_exists_on_disk "$pm_doc" "Package Maker project file"
	assert_exists_on_disk "$built_path" "Built exporter"
	
	vers=`/usr/libexec/PlistBuddy -c "Print :CFBundleVersion" $app_info_plist` || { echo "CFBundleVersion not found in input file"; exit 1; }
	echo "Setting installer to version: $vers"
	
# --resources "$built_path
	
	"$packagemaker" --doc "$pm_doc" --out "$temp_name" --version "$vers"  || { echo "Creating package failed: \"$temp_name\""; exit 1; }

	assert_exists_on_disk "$temp_name" "unsigned built package"
	
	echo ""
	echo "Signing installer:"
	echo "$temp_name"
	echo "  into";
	echo "$final_name"
	echo ""

# HACK AlERT
# TODO: get developer id from config file.
	productsign --sign "Developer ID Installer: Zenfolio" "$temp_name" "$final_name" || { echo "Signing package failed"; exit 1; }
	spctl -a -v --type install "$final_name" || { echo "Verifying Signed package failed"; exit 1; }
	
	assert_exists_on_disk "$final_name" "Signed Package"
	
	rm "$temp_name"
}

function main()
{
	check_input
	set_build_path
	
	increment_version=`/usr/libexec/PlistBuddy -c "Print :increment_version" $g_input_file` || { echo "increment_version not found in input file"; exit 1; }
	if [ "$increment_version" = true ]
		then
		bump_version
	fi

	build
	
	app=`find "$g_build_path" -name "*.app"`
	if [ "$app" != "" ]
		then
		g_app_name=`basename "$app" .app`
	fi
	
	make_ipa=`/usr/libexec/PlistBuddy -c "Print :make_ipa" $g_input_file` || { echo "make_ipa not found in input file"; exit 1; }
	if [ "$make_ipa" = true ]
		then
		make_ipa
	fi

	build_package=`/usr/libexec/PlistBuddy -c "Print :build_package" $g_input_file` || { echo "build_package not found in input file"; exit 1; }
	if [ "$build_package" = true ]
		then
		build_package

		app=`find "$g_build_path" -name "*.mpkg"`
		g_app_name=`basename "$app" .mpkg`
	fi

	if [ "$g_app_name" = "" ]
		then
		echo "app name not set"
		exit 1
	fi

	archive=`/usr/libexec/PlistBuddy -c "Print :archive" $g_input_file` || { echo "archive not found in input file"; exit 1; }
	if [ "$archive" = true ]
		then
		archive_build
	fi

	post_testflight_build=`/usr/libexec/PlistBuddy -c "Print :post_testflight_build" $g_input_file` || { echo "post_testflight_build not found in input file"; exit 1; }
	if [ "$post_testflight_build" = true ]
		then
		post_to_testflight
	fi	
}

# just making things more readable by using a fake main()

main

