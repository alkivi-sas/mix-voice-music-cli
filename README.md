# mix-voice-music-cli
Mix music and French synthetic voice by bash script on macOS.
We use Siri voice from Mac with Say command and an URL for the music.
We use it for for phone rings. So it's compressed with 8k rate.

## We use SoX and Siri on macOS
First of all, you have to install SoX and Siri

   `$ brew install SoX`
   
After that, you can follow this tutorial http://osxdaily.com/2011/07/25/how-to-add-new-voices-to-mac-os-x/ to add Audrey's voice for french.

## Installation 
You have to 
   ```
   $ git clone https://github.com/alkivi-sas/mix-voice-music-cli
   $ cd mix-voice-music-cli
   $ chmod +x mix-voice-music-cli.sh
   ```
## Use
   `$ ./mix-voice-music-cli.sh`

And that's it, you just have to follow instructions

Final file will be in /tmp/mixed-compressed-1channel.wav

