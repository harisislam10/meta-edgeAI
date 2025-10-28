#!/bin/sh

chromium \
  --no-sandbox \
  --enable-features=UseOzonePlatform \
  --ozone-platform=wayland \
  --disable-web-security \
  --disable-features=VizDisplayCompositor \
  --ignore-certificate-errors \
  --user-data-dir=/tmp/chromium-profile
