WALLPAPER_DIR=~/Wallpapers/
INTERVAL="30s"

cd "$WALLPAPER_DIR" || exit

while true; do
	FILE="$(ls *.* | sort -R | tail -1)"
	
	swww img "$FILE" --transition-type fade --transition-fps 60

	sleep "$INTERVAL"
done
