#!/bin/bash


if [ $# -lt 2 ];
then
	echo "Use: apply_n3.sh <directory> <case ID>"
	exit 1
fi

#try to enter dicom de directory
cd $1
if [ $? -ne 0 ];
then
 exit 1
fi

dicoms=(*)
LEN=${#dicoms[@]}

#verify if it's not empty
if [$LEN -le 0];
then
	echo "$1 is empty"
	exit 1
fi

file=${dicoms[1]}
name=$2;

mri_convert -odt float $file ${name}.mgz
if [ $? -ne 0 ];
then
	echo "ERROR: ${name}.mgz not created."
	exit 1
fi

mri_convert ${name}.mgz ${name}.mnc
if [ $? -ne 0 ];
then
        echo "ERROR: ${name}.mnc not created."
        exit 1
fi

nu_correct -distance 50 -iterations 1000 ${name}.mnc ${name}_nu_correct.mnc
if [ $? -ne 0 ];
then
        echo "ERROR: ${name}.mnc not created."
        exit 1
fi

mri_convert ${name}_nu_correct.mnc ${name}_nu_correct.mgz
if [ $? -ne 0 ];
then
        echo "ERROR: ${name}_nu_correct.mgz not created."
        exit 1
fi

 
