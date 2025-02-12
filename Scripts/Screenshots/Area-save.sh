#!/usr/bin/env bash

cd "$HOME/Images/Screenshots" || exit

IMAGE=$(date +'Screenshot_%d-%m-%Y_%H-%M-%S') && \
	grimblast \
		--freeze \
		copysave \
		area \
		"$IMAGE".png \
		--notify && \
		oxipng --strip all -v "$IMAGE".png && \
		magick "$IMAGE".png -quality 100 "$IMAGE".webp && \
		rm "$IMAGE".png
