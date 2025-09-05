#!/usr/bin/env bash

##### Settings

# OS icon output size (px)
OUTPUT_SIZE_OS_PX=512
# Big UI element (arrows) output size (px)
OUTPUT_SIZE_UI_BIG_PX=512
# Small UI element (tool icons) output size (px)
OUTPUT_SIZE_UI_SMALL_PX=128

# OS icon crop (percentage of full image)
OUTPUT_CROP_OS=80

# Big UI element icon crop (percentage of full image)
OUTPUT_CROP_BIG=90
# Big selection icon crop (percentage of full image)
OUTPUT_CROP_SEL_BIG=95

# Tool icon crop (percentage of full image)
OUTPUT_CROP_TOOL=90
# Small selection icon crop (percentage of full image)
OUTPUT_CROP_SEL_SMALL=100





##### Code
# Create working directory folder
mkdir -p WorkingDirectory
mkdir -p Result

# Clear old working files
rm -r WorkingDirectory/*
rm -r Result/*

# Create folders
mkdir -p WorkingDirectory/os/
mkdir -p WorkingDirectory/ui/
mkdir -p WorkingDirectory/ui/small/
mkdir -p WorkingDirectory/ui/big/
mkdir -p WorkingDirectory/ui/selection/
mkdir -p Result/icons/



### OS
echo "----- Processing OS icons -----"
osoutputbase=$(($(($OUTPUT_SIZE_OS_PX * $OUTPUT_CROP_OS)) / 100))

# Process png files
if find Source/os/png/ -mindepth 1 -maxdepth 1 | read; then
	for file in Source/os/png/*
	do
	    newfilename="WorkingDirectory/os/"
	    newfilename+="os_"
	    newfilename+=$(basename "$file" .png)
	    newfilename+=".png"
	    magick "$file" -resize "$osoutputbase"x"$osoutputbase" "$newfilename"
	    echo "Processed .png file and outputted result to '$newfilename'."
	done
fi

# Process svg files
if find Source/os/svg/ -mindepth 1 -maxdepth 1 | read; then
	for file in Source/os/svg/*
	do
	    newfilename="WorkingDirectory/os/"
	    newfilename+="os_"
	    newfilename+=$(basename "$file" .svg)
	    newfilename+=".png"
	    inkscape -w $osoutputbase -h $osoutputbase "$file" -o "$newfilename"
	    echo "Processed .svg file and outputted result to '$newfilename'."
	done
fi

echo ""

# Add transparent border
if find WorkingDirectory/os/ -mindepth 1 -maxdepth 1 | read; then
	for file in WorkingDirectory/os/*
	do
	    magick -background none $file -background transparent -gravity center -scale "$osoutputbase"x"$osoutputbase" -extent "$OUTPUT_SIZE_OS_PX"x"$OUTPUT_SIZE_OS_PX" $file
	    echo "Added transparent border to .png file '$file'."
	done
fi

## Move to results folder
if find WorkingDirectory/os/ -mindepth 1 -maxdepth 1 | read; then
	mv WorkingDirectory/os/* Result/icons/
fi



### UI elements
echo ""
echo "----- Processing UI elements -----"


## Big element selection overlay
selbigoutputbase=$(($(($OUTPUT_SIZE_OS_PX * $OUTPUT_CROP_SEL_BIG)) / 100))
filepng="Source/ui/png/selection/selection_big.png"
filesvg="Source/ui/svg/selection/selection_big.svg"
newfilename="WorkingDirectory/ui/selection/selection_big.png"

if test -f $filesvg; then
# Process svg file
	inkscape -w $selbigoutputbase -h $selbigoutputbase $filesvg -o $newfilename
	echo "Created $newfilename file."
elif test -f $filepng; then
# Process png file
	magick $filepng -resize "$selbigoutputbase"x"$selbigoutputbase" $newfilename
	echo "Created $newfilename file."
else
	echo "Warning: No $newfilename file was created."
fi

# Add border
magick -background none $newfilename -background transparent -gravity center -scale "$selbigoutputbase"x"$selbigoutputbase" -extent "$OUTPUT_SIZE_OS_PX"x"$OUTPUT_SIZE_OS_PX" $newfilename
echo "Added transparent border to .png file '$newfilename'."



## Small element selection overlay
selsmalloutputbase=$(($(($OUTPUT_SIZE_UI_SMALL_PX * $OUTPUT_CROP_SEL_SMALL)) / 100))
filepng="Source/ui/png/selection/selection_small.png"
filesvg="Source/ui/svg/selection/selection_small.svg"
newfilename="WorkingDirectory/ui/selection/selection_small.png"

if test -f $filesvg; then
# Process svg file
	inkscape -w $selbigoutputbase -h $selbigoutputbase $filesvg -o $newfilename
	echo "Created $newfilename file."
elif test -f $filepng; then
# Process png file
	magick $filepng -resize "$selsmalloutputbase"x"$selsmalloutputbase" $newfilename
	echo "Created $newfilename file."
else
	echo "Warning: No $newfilename file was created."
fi


# Add border
magick -background none $newfilename -background transparent -gravity center -scale "$selsmalloutputbase"x"$selsmalloutputbase" -extent "$OUTPUT_SIZE_UI_SMALL_PX"x"$OUTPUT_SIZE_UI_SMALL_PX" $newfilename
echo "Added transparent border to .png file '$newfilename'."

## Move to results folder
if find WorkingDirectory/ui/selection/ -mindepth 1 -maxdepth 1 | read; then
	mv WorkingDirectory/ui/selection/* Result/icons/
fi



## Big items / arrows
################### to-do
arrowoutputbase=$(($(($OUTPUT_SIZE_UI_BIG_PX * $OUTPUT_CROP_BIG)) / 100))

# Process png files
if find Source/ui/png/big/ -mindepth 1 -maxdepth 1 | read; then
	for file in Source/ui/png/big/*
	do
	    newfilename="WorkingDirectory/ui/big/"
	    newfilename+=$(basename "$file" .png)
	    newfilename+=".png"
	    magick "$file" -resize "$arrowoutputbase"x"$arrowoutputbase" "$newfilename"
	    echo "Processed .png file and outputted result to '$newfilename'."
	done
fi

# Process svg files
if find Source/ui/svg/big/ -mindepth 1 -maxdepth 1 | read; then
	for file in Source/ui/svg/big/*
	do
	    newfilename="WorkingDirectory/ui/big/"
	    newfilename+=$(basename "$file" .svg)
	    newfilename+=".png"
	    inkscape -w $arrowoutputbase -h $arrowoutputbase "$file" -o "$newfilename"
	    echo "Processed .svg file and outputted result to '$newfilename'."
	done
fi

# Add transparent border
if find WorkingDirectory/ui/big/ -mindepth 1 -maxdepth 1 | read; then
	for file in WorkingDirectory/ui/big/*
	do
	    magick -background none $file -background transparent -gravity center -scale "$arrowoutputbase"x"$arrowoutputbase" -extent "$OUTPUT_SIZE_UI_BIG_PX"x"$OUTPUT_SIZE_UI_BIG_PX" $file
	    echo "Added transparent border to .png file '$file'."
	done
fi

if find WorkingDirectory/ui/big/ -mindepth 1 -maxdepth 1 | read; then
	mv WorkingDirectory/ui/big/* Result/icons/
fi



## Function items / tools
tooloutputbase=$(($(($OUTPUT_SIZE_UI_SMALL_PX * $OUTPUT_CROP_TOOL)) / 100))

# Process png files
if find Source/ui/png/small/ -mindepth 1 -maxdepth 1 | read; then
	for file in Source/ui/png/small/*
	do
	    newfilename="WorkingDirectory/ui/small/"
	    newfilename+=$(basename "$file" .png)
	    newfilename+=".png"
	    magick "$file" -resize "$tooloutputbase"x"$tooloutputbase" "$newfilename"
	    echo "Processed .png file and outputted result to '$newfilename'."
	done
fi

# Process svg files
if find Source/ui/svg/small/ -mindepth 1 -maxdepth 1 | read; then
	for file in Source/ui/svg/small/*
	do
	    newfilename="WorkingDirectory/ui/small/"
	    newfilename+=$(basename "$file" .svg)
	    newfilename+=".png"
	    inkscape -w $tooloutputbase -h $tooloutputbase "$file" -o "$newfilename"
	    echo "Processed .svg file and outputted result to '$newfilename'."
	done
fi

# Add transparent border
if find WorkingDirectory/ui/small/ -mindepth 1 -maxdepth 1 | read; then
	for file in WorkingDirectory/ui/small/*
	do
	    magick -background none $file -background transparent -gravity center -scale "$tooloutputbase"x"$tooloutputbase" -extent "$OUTPUT_SIZE_UI_SMALL_PX"x"$OUTPUT_SIZE_UI_SMALL_PX" $file
	    echo "Added transparent border to .png file '$file'."
	done
fi


## Move to results folder
if find WorkingDirectory/ui/small/ -mindepth 1 -maxdepth 1 | read; then
	mv WorkingDirectory/ui/small/* Result/icons/
fi