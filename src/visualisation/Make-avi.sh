
for ((i=1; i < 87; i++))
do
    MO=MO$i
    echo MO$i
    cd $1/$MO
    rm $MO.avi
#   ffmpeg -y -an -r 10 -s 591×443 -i "$MO-%03d.png" $MO.avi -qscale 0
#    ffmpeg -y -an -r 10 -i "$MO-%03d.png" $MO.avi -qscale 0 -s 591×443 -vcodec ffv3 -level 3 -coder 1 -context 1 -g 1 -b:v 2M
#    ffmpeg -y -an -r 24 -i "$MO-%03d.png" -vcodec rawvideo $MO.avi
#    ffmpeg -y -an -r 12 -i "$MO-%03d.png" -q:v 1 -qscale 1 -b:v 8M $MO.avi
#    ffmpeg -y -an -r 12 -i "$MO-%03d.png" -q:v 1 -qscale 0 -b:v 8M $MO.avi

    ffmpeg -y -an -r 12 -i "$MO-%03d.png" -q:v 1 -b:v 100M -vcodec msmpeg4 -r 24 $MO.avi # !!! work
    cd ../..
done


#ffmpeg -f image2 -i *.png -qscale 0 -y -an -r 48 all.flv

