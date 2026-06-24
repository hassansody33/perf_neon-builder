#!/bin/bash

# Default exports
export REKERNEL_PATCH="https://github.com/JackA1ltman/NonGKI_Kernel_Build_2nd/raw/refs/heads/mainline/Patches/Rekernel/rekernel_patches.sh"
export REKERNEL_EXTRA="https://github.com/JackA1ltman/NonGKI_Kernel_Build_2nd/raw/refs/heads/mainline/Patches/Rekernel/rekernel_extra.patch"

case "$REKERNEL_SELECTOR" in
    rekernel)
        # Start of rekernel integration
        echo "-- Setting up rekernel..."

        # Download rekernel patch and extra patch
        wget -qO- $REKERNEL_PATCH | bash || { echo "-- Fatal: Failed to apply rekernel patch!"; exit 1; }
        wget -qO- $REKERNEL_EXTRA | patch -s -p1 --fuzz=5 || { echo "-- Fatal: Failed to apply rekernel extra patch!"; exit 1; }
        
        # Enable the necessary Rekernel configs
        echo "CONFIG_REKERNEL=y" >> $MAIN_DEFCONFIG
        ;;
    none|"")
        echo "-- Rekernel is not selected."
        ;;
    *)
        echo "- Invalid REKERNEL_SELECTOR: $REKERNEL_SELECTOR. Valid options: rekernel, none."
        exit 1
        ;;
esac