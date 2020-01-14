#!/bin/bash
PS3='Which music do you want to use ? :'
options=("Acqua e Sapone" "Silk Road" "Your own URL")
select opt in "${options[@]}"
do
    case $opt in
        "Acqua e Sapone")
            URL="https://ia600303.us.archive.org/15/items/pj007/2erobello.mp3"
            break
            ;;
        "Silk Road")
            URL="https://ia800704.us.archive.org/23/items/jamendo-001290/01.mp3"
            break
            ;;
        "Your own URL")
            echo "Enter URL of your own music : "
            read URL
            break
            ;;        
        *) echo "Not a good choice";;
    esac
done
echo "The music URL is : "
echo $URL
echo "Text to read in French : "
read TXT
echo "Combien de fois voulez vous répétez le message : "
read OCCURENCE
echo "Le message sera répété $((OCCURENCE)) fois"
echo "Combien de secondes doit faire la musique ? (0 = musique en entier): "
read TEMPS
sox $URL /tmp/music.wav rate 22050
say -v "Audrey" $TXT -o /tmp/voice.wav --data-format=LEI24 --channels=2
sox -n -r 22050 -c 2 /tmp/silence-30sec.wav trim 0.0 30
sox -n -r 22050 -c 2 /tmp/silence-3sec.wav trim 0.0 3
sox /tmp/silence-3sec.wav /tmp/voice.wav /tmp/silence-30sec.wav /tmp/voice-with-silence.wav
if [ $TEMPS = "0" ]
then
    echo "La musique sera jouée en entier"
else
    echo "La musique sera coupée au bout de $((TEMPS)) sec"
    sox /tmp/music.wav /tmp/music-cropped.wav trim 0 $TEMPS
    sox /tmp/voice-with-silence.wav /tmp/voice-with-silence-cropped.wav trim 0 $TEMPS
    mv -f /tmp/music-cropped.wav /tmp/music.wav
    mv -f /tmp/voice-with-silence-cropped.wav /tmp/voice-with-silence.wav
fi
NBROCCURENCE=1
until [ $NBROCCURENCE = $OCCURENCE ]
do
sox /tmp/voice-with-silence.wav /tmp/voice.wav /tmp/silence-30sec.wav /tmp/voice-with-after.wav
cp -f /tmp/voice-with-after.wav /tmp/voice-with-silence.wav
((NBROCCURENCE++))
done
sox -M -v 0.7 /tmp/music.wav /tmp/voice-with-silence.wav /tmp/mixed.wav
sox /tmp/mixed.wav /tmp/mixed-compressed.wav rate 8k
sox /tmp/mixed-compressed.wav /tmp/mixed-compressed-1channel.wav channels 1
play /tmp/mixed-compressed-1channel.wav
