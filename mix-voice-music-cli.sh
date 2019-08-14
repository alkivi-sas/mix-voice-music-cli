#!/bin/zsh
echo "URL de la musique : "
read URL
echo "Texte à faire lire : "
read TXT
sox $URL /tmp/music.wav rate 22050
say -v "Audrey" $TXT -o /tmp/voice.wav --data-format=LEI24 --channels=2
sox -n -r 22050 -c 2 /tmp/silence-30sec.wav trim 0.0 30
sox -n -r 22050 -c 2 /tmp/silence-2sec.wav trim 0.0 2
sox /tmp/silence-2sec.wav /tmp/voice.wav /tmp/silence-30sec.wav /tmp/voice.wav /tmp/voice-with-silence.wav
sox -M /tmp/music.wav /tmp/voice-with-silence.wav /tmp/mixed.wav
sox /tmp/mixed.wav /tmp/mixed-compressed.wav rate 8k
sox /tmp/mixed-compressed.wav /tmp/mixed-compressed-1channel.wav channels 1
play /tmp/mixed-compressed-1channel.wav
