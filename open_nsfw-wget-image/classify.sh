#!/bin/sh

_url="$1"

wget -q "${_url}" -O /tmp/output-image 
python /usr/src/open_nsfw/classify_nsfw.py \
    --model_def /usr/src/open_nsfw/nsfw_model/deploy.prototxt \
    --pretrained_model /usr/src/open_nsfw/nsfw_model/resnet_50_1by2_nsfw.caffemodel \
    /tmp/output-image 2>/dev/null
