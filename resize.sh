declare -a nameArray=("drawable-mdpi" "drawable-hdpi" "drawable-xhdpi" "drawable-xxhdpi" "drawable-xxxhdpi")
declare -a scaleArray=(1 3/2 2 3 4)
imageFile=$1
test -f $imageFile || (echo "you should input an image file to resize" && exit 0)
dpHeightWidthMax=${2:-48}
echo dpHeightWidthMax=$dpHeightWidthMax
fileName=$(basename $imageFile)
dirName="${fileName%.*}"
mkdir $dirName
tempImage=$dirName/${fileName}_temp
cp $imageFile $tempImage
tLen=${#nameArray[@]}
for (( i=0; i<${tLen}; i++ ));
do
	mkdir $dirName/${nameArray[$i]}
	destiFile=$dirName/${nameArray[$i]}/$fileName
	cp $tempImage $destiFile
	pxHeightWidthMax=$[$dpHeightWidthMax*${scaleArray[$i]}]
	sips -Z $pxHeightWidthMax $destiFile
done
rm $tempImage
echo "finish"