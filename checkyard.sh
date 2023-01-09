#!/bin/bash

curl "https://www.picknpull.com/check_inventory.aspx?Zip=90210&Make=226&Model=4153&Year=1900-2001&Distance=25" &> temp

cat temp | grep "No Vehicles Found" &> /dev/null

if [[ $? ]]; then
	echo the exit code is not zero and there is no car found
	rm temp
	curl -X POST https://textbelt.com/text \
		--data-urlencode phone='1234567890' \
		--data-urlencode message='No Impreza :(' \
		-d key=textbelt
	exit 0
else {
	rm temp
	echo should get a text because exit code was 0 meaning parts found	
	curl -X POST https://textbelt.com/text \
		--data-urlencode phone='1234567890' \
		--data-urlencode message='IMPREZA AVAILABLE' \
		-d key=textbelt

	exit 0

}
fi
