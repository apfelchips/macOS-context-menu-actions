STATE=$(defaults read com.apple.finder AppleShowAllFiles)

if [ $STATE == "TRUE" ]
then
defaults write com.apple.finder AppleShowAllFiles FALSE
else
defaults write com.apple.finder AppleShowAllFiles TRUE
fi

killall Finder