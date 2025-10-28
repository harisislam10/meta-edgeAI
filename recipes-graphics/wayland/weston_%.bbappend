# File: meta-yourlayer/recipes-graphics/wayland/weston_%.bbappend

# 1. Disable the GL renderer to avoid GBM version mismatch (original fix for -Drenderer-gl=true)
# The 'egl' PACKAGECONFIG option sets -Drenderer-gl=true in Meson.
# Removing this option ensures -Drenderer-gl=false.
#PACKAGECONFIG:remove = "egl"

# 2. Exclude 'dmabuf-feedback' from Weston's simple clients.
# The error message explicitly states this is needed.
# We redefine SIMPLECLIENTS to include all options *except* 'dmabuf-feedback'.
# Based on the list in weston.bb: 'damage', 'im', 'egl', 'shm', 'touch', 'dmabuf-v4l', 'dmabuf-egl'
#SIMPLECLIENTS = "damage im egl shm touch dmabuf-v4l dmabuf-egl"
