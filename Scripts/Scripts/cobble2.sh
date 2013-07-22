#!/bin/sh

#  cobble2.sh
#  FishLampScripts
#
#  Created by Mike Fullerton on 7/14/13.
#

#!/bin/bash

SCRIPT_PATH="`dirname \"$0\"`"
SCRIPT_PATH="`( cd \"$MY_PATH\" && pwd )`"

set -e

build_project="YES"
build_installer="YES"
sign_installer="YES"
archive_build="YES"
check_commits="YES"
tag_build="YES"

action="clean build"
input_file="cobble-config.sh"
output_path="$HOME/Desktop/CobbleBuildLog.txt"
configuration="Release"
plist_file="Info.plist"
packagemaker="/Applications/PackageMaker.app/Contents/MacOS/PackageMaker"
build_folder="$HOME/Enlistments/DerivedData/Build"
archive_folder="$HOME/Enlistments/Cobble-Builds"
build_destination_folder="$build_folder/Products/$configuration"
build_version=""
verbose="NO"
built_product_extension=".app"
app_name=""

# required

project=""
target=""
installer_file=""
package_name=""
signing_developer_id=""

working_dir=`pwd`

for var in "$@"
do
    if [[ "$var" == "--no-clean" ]]; then 
        action="build"
    elif [[ "$var" == "--debug" ]]; then
    	configuration="Debug"
    elif [[ "$var" == "--no-build" ]]; then
    	build_project="NO"
    elif [[ "$var" == "--no-installer" ]]; then
    	build_installer="NO"
    elif [[ "$var" == "--no-sign" ]]; then
    	sign_installer="NO"
    elif [[ "$var" == "--no-archive" ]]; then
    	archive_build="NO"
    elif [[ "$var" == "--no-commit-check" ]]; then
    	check_commits="NO"
    elif [[ "$var" == "--help" ]]; then
    	usage
    elif [[ "$var" == "--verbose" ]]; then
    	verbose="YES"
    elif [[ "$var" == "--no-tag" ]]; then
    	tag_build="NO"
    else
        input_file="$var"
    fi
done

function verbose() {
    line=""
    for var in "$@"; do
        if [[ "$line" == "" ]]; then
            line="## $var"
        else
            line="$line $var"
        fi
    done

    if [[ $verbose == "YES" ]]; then
        echo "$line"
    fi
}

function print_options() {
    verbose "input options:"
    verbose "verbose = $verbose"
    verbose "tag_build = $tag_build"
    verbose "check_commits = $check_commits"
    verbose "archive_build = $archive_build"
    verbose "sign_installer = $sign_installer"
    verbose "build_installer = $build_installer"
    verbose "build_project = $build_project"
    verbose "configuration = $configuration"
    verbose "action = \"$action\""
    verbose "input_file = $input_file"
    verbose "archive_folder = $archive_folder"
    verbose "build_destination_folder = $build_destination_folder"
    verbose "build_folder = $build_folder"
    verbose "output_path = $output_path"
    verbose "built_product_extension = $built_product_extension"

    verbose "built_app = $built_app"
    verbose "package_path = $package_path"

    verbose ""
}

function usage() {
	echo "cobble2 [cobble-config.sh --no-clean, --debug, --no-build, --no-installer, --no-sign, --no-archive, --no-commit-check, --no-tag --help]"
	exit 0;
}

function assert_exists() {

    path="$1"
    name="$2"
        
    if [ ! -f "$path" -a ! -d "$path" ]; then
        echo "##! \"$path\" not found"
        exit 1
    else
        verbose "found \"$name\" at \"$path\" ok"
    fi
}

function build_project() {

	echo "xcode is building. Output is here: $output_path"

	xcodebuild -project $project -target "$target" -configuration $configuration ONLY_ACTIVE_ARCH="NO" SYMROOT="$build_folder/Products" OBJROOT="$build_folder/Intermediates" $action > "$output_path"
}

function build_package() {

	# must be absolute path
	pm_doc="`pwd`/$installer_file"
	
	assert_exists "$built_app" "Built App"
	assert_exists "$pm_doc" "Package Maker project file $pm_doc"

	echo ""
	echo "NOTE: if you get this error \"ERROR: Package source does not exist on disk\""
	echo "      then you need to fix the relative path to the built $built_product_extension in the installer.pm file. Use package maker to do this."
	echo "      This is NOT a error in the script."
	echo ""
	echo "Building installer for version: $build_version"
	
	"$packagemaker" --no-relocate --doc "$pm_doc" --out "$package_path" --version "$build_version"  || { echo "Creating package failed: \"$temp_name\""; exit 1; }

	assert_exists "$package_path" "built package"
}

function sign_package() {

	pushd $build_destination_folder > /dev/null

	temp_name="unsigned package.mpkg"

	assert_exists "$package_name" "unsigned package"

	mv "$package_name" "$temp_name"
	assert_exists "$temp_name" "temp package"

	productsign --sign "Developer ID Installer: $signing_developer_id" "$temp_name" "$package_name" || { echo "Signing package failed"; exit 1; }
	spctl -a -v --type install "$package_name" || { echo "Verifying Signed package failed"; exit 1; }
	
	assert_exists "$package_name" "Signed Package"
	
	rm "$temp_name"

	echo "signed $package_name ok"

	popd > /dev/null
}

function archive() {
	echo "archiving"	

	if [ ! -d "$archive_folder" ]; then
		mkdir "$archive_folder" || { echo "creating archive folder failed: \"archive_folder\""; exit 1; }
	fi
	
	pushd $build_destination_folder > /dev/null
	
	folder_name="$target"_"$build_version" 
	
	mkdir "$folder_name"
	
	if [ -d "$target.$built_product_extension.dSYM" ]
		then
		mv "$target.$built_product_extension.dSYM" "$folder_name"
	fi

	mv "$package_path" "$folder_name" 
	
	echo "archive contents:"
	ls "$folder_name"
	echo ""
		
	zip -r "$folder_name.zip" "$folder_name" > /dev/null
	
	# move the archive contents back to parent folder since we're done archiving them
	mv "$folder_name"/* .
	
	# remove archive folder now that we've zipped it up
	rm -r "$folder_name"
	
	mv "$folder_name.zip" "$archive_folder/$folder_name.zip"

	assert_exists "$archive_folder/$folder_name.zip" "Build archive"

	echo "Archived $folder_name.zip to $archive_folder"

	open "$archive_folder"
	
	popd > /dev/null
}

function assert_value() {
    if [[ "$2" == "" ]]; then
        echo "##! value for $1 is required"
        exit 1
    else
        verbose "$1 = $2"
    fi
}

function load_input_file() {

    assert_exists "$input_file" "cobble input file"

    path=$(cd $(dirname $input_file); pwd)/$(basename $input_file)

    verbose "path to file: $path"

    working_dir=$(cd $(dirname $path); pwd)

    verbose "working dir: $working_dir"

    source "$input_file"


    if [ "$app_name" == "" ]; then
        app_name="$target"
    fi

    assert_value "project" "$project"
    assert_value "app_name" "$app_name"
    assert_value "configuration" "$configuration"
    assert_value "target" "$target"
    assert_value "plist_file" "$plist_file"
    assert_value "installer_file" "$installer_file"
    assert_value "package_name" "$package_name"
    assert_value "signing_developer_id" "$signing_developer_id"

    output_path="$HOME/Desktop/$target-$configuration-build.log"
    built_app="$build_destination_folder/$app_name.$built_product_extension"
    package_path="$build_destination_folder/$package_name"
}

function tag() {

    short_name="${target// /}"

    branch=`git rev-parse --abbrev-ref HEAD`
    git add -A
    git commit -a -m "$target $build_version"
    git tag "$short_name-v$build_version"
    git push --tags origin $branch || { echo "##! pushing tag failed"; exit 1; }
}

function main() {

    echo ""
    echo "# starting build"
    echo ""

    load_input_file
    print_options

    cd "$working_dir"
    verbose "set working dir to $working_dir"

    if [[ $check_commits == "YES" ]]; then
        status=`git status -s`
        if [ "$status" != "" ]; then
            echo "##! your git repo has uncommitted changes - please commit changes before building."
            exit 1;
        fi
    fi

    assert_exists "$plist_file" "info plist file"
    assert_exists "$project" "Project"
    assert_exists "$installer_file" "Installer file"
    assert_exists "$packagemaker" "Package maker tool"

    build_version=`plist-bump-version "$plist_file"` 

    if [[ $build_project == "YES" ]]; then
        build_project
    fi

    if [[ $build_installer == "YES" ]]; then
        build_package
    fi

    if [[ $sign_installer == "YES" ]]; then
        sign_package
    fi

    if [[ $tag_build == "YES" ]]; then
        tag
    fi

    if [[ $archive_build == "YES" ]]; then
        archive
    fi
}

main

exit 0


function example_input() {
    project="Downloader.xcodeproj"
    configuration="Release"
    target="Zenfolio Downloader"
    plist_file="Info.plist"
    installer_file="Installer/Installer.pmdoc"
    package_name="Zenfolio Downloader.mpkg"
    signing_developer_id="Zenfolio"
}
