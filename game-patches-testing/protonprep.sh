#!/bin/bash
    # steam_helper patches
    #git checkout steam_helper
    #cd steam_helper
    #cd ..

    # warframe controller fix
    git checkout lsteamclient
    cd lsteamclient
    patch -Np1 < ../game-patches-testing/proton-hotfixes/steamclient-disable_SteamController007_if_no_controller.patch
    cd ..

    # VKD3D patches
    cd vkd3d
    git reset --hard HEAD
    git clean -xdf
    cd ..

    # Valve DXVK patches
    cd dxvk
    git reset --hard HEAD
    git clean -xdf
    patch -Np1 < ../game-patches-testing/dxvk-patches/valve-dxvk-avoid-spamming-log-with-requests-for-IWineD3D11Texture2D.patch
    patch -Np1 < ../game-patches-testing/dxvk-patches/proton-add_new_dxvk_config_library.patch
    cd ..

    #WINE
    cd wine
    git reset --hard HEAD
    git clean -xdf

    # needed for mfplat alpha patches
    #cp ../game-patches-testing/wine-patches/test.mp4 dlls/mfplat/tests/
    #cp ../game-patches-testing/wine-patches/test.mp4 dlls/mfreadwrite/tests/

    #WINE STAGING
    echo "applying staging patches"
    ../wine-staging/patches/patchinstall.sh DESTDIR="." --all \
    -W server-Desktop_Refcount \
    -W ws2_32-TransmitFile \
    -W winex11.drv-mouse-coorrds \
    -W winex11-MWM_Decorations \
    -W winex11-_NET_ACTIVE_WINDOW \
    -W winex11-WM_WINDOWPOSCHANGING \
    -W user32-rawinput-mouse \
    -W user32-rawinput-nolegacy \
    -W user32-rawinput-mouse-experimental \
    -W user32-rawinput-hid \
    -W dinput-SetActionMap-genre \
    -W dinput-axis-recalc \
    -W dinput-joy-mappings \
    -W dinput-reconnect-joystick \
    -W dinput-remap-joystick \
    -W winex11-key_translation 

    #WINE FAUDIO
    echo "applying faudio patches"
    patch -Np1 < ../game-patches-testing/faudio-patches/faudio-ffmpeg.patch

    #WINE GAME PATCHES

    echo "mech warrior online"
    patch -Np1 < ../game-patches-testing/game-patches/mwo.patch

    echo "final fantasy XIV"
    patch -Np1 < ../game-patches-testing/game-patches/ffxiv-launcher.patch

    #disabled, not working
    #echo "final fantasy XV"
    #patch -Np1 < ../game-patches-testing/game-patches/ffxv-steam-fix.patch

    echo "assetto corsa"
    patch -Np1 < ../game-patches-testing/game-patches/assettocorsa-hud.patch

    echo "sword art online"
    patch -Np1 < ../game-patches-testing/game-patches/sword-art-online-gnutls.patch

    echo "origin downloads fix" 
    patch -Np1 < ../game-patches-testing/game-patches/origin-downloads_fix.patch

    echo "blackops 2 fix"
    patch -Np1 < ../game-patches-testing/game-patches/blackops_2_fix.patch

    echo "NFSW launcher fix"
    patch -Np1 < ../game-patches-testing/game-patches/NFSWLauncherfix.patch

    #disabled for now - broken on wine 5.0+
    #echo "applying MHW ntdll patch"
    #patch -Np1 < ../game-patches-testing/game-patches/MHW-new.patch

    echo "fix steep and AC Odyssey fullscreen"
    patch -Np1 < ../game-patches-testing/wine-patches/0001-Add-some-semi-stubs-in-user32.patch

    #WINE FSYNC
    echo "applying fsync patches"
    patch -Np1 < ../game-patches-testing/proton-valve-patches/proton-fsync_staging.patch
    #patch -Np1 < ../game-patches-testing/proton-valve-patches/proton-fsync-spincounts.patch

    #PROTON
    echo "applying proton patches"
    patch -Np1 < ../game-patches-testing/proton-valve-patches/proton-steamclient_swap.patch
    patch -Np1 < ../game-patches-testing/proton-valve-patches/proton-protonify_staging_rpc.patch
    patch -Np1 < ../game-patches-testing/proton-valve-patches/proton-protonify_staging.patch
    patch -Np1 < ../game-patches-testing/proton-valve-patches/proton-win10_default.patch
    patch -Np1 < ../game-patches-testing/proton-valve-patches/proton-dxvk_config.patch
    patch -Np1 < ../game-patches-testing/proton-valve-patches/proton-steam-bits.patch
    patch -Np1 < ../game-patches-testing/proton-valve-patches/proton-LAA_staging.patch

    #disabled, not working
    #echo "mk11 patch"
    #patch -Np1 < ../game-patches-testing/game-patches/mk11.patch

    echo "clock monotonic, amd ags, hide prefix update"
    patch -Np1 < ../game-patches-testing/proton-valve-patches/proton-use_clock_monotonic.patch
    patch -Np1 < ../game-patches-testing/proton-valve-patches/proton-amd_ags.patch

    echo "fullscreen hack"
    patch -Np1 < ../game-patches-testing/proton-valve-patches/proton-FS_bypass_compositor.patch
    patch -Np1 < ../game-patches-testing/proton-valve-patches/valve_proton_fullscreen_hack-staging.patch
    patch -Np1 < ../game-patches-testing/proton-valve-patches/proton-hide_wine_prefix_update_window.patch

    echo "raw input"
    patch -Np1 < ../game-patches-testing/proton-valve-patches/proton-rawinput.patch

    echo "applying staging patches that need to be applied after proton rawinput and fullscreen hack"

    echo "staging winex11-key_translation"
    patch -Np1 < ../wine-staging/patches/winex11-key_translation/0001-winex11-Match-keyboard-in-Unicode.patch
    patch -Np1 < ../wine-staging/patches/winex11-key_translation/0002-winex11-Fix-more-key-translation.patch
    patch -Np1 < ../wine-staging/patches/winex11-key_translation/0003-winex11.drv-Fix-main-Russian-keyboard-layout.patch

    echo "staging winex11-MWM_Decorations"
    patch -Np1 < ../game-patches-testing/proton-hotfixes/proton-staging_winex11-MWM_Decorations.patch

    # staging winex11-_NET_ACTIVE_WINDOW - disabled, currently not working
    #patch -Np1 < ../game-patches-testing/proton-hotfixes/proton-staging_winex11-_NET_ACTIVE_WINDOW.patch

    # staging winex11-WM_WINDOWPOSCHANGING - disabled, currently not working
    #patch -Np1 < ../game-patches-testing/proton-hotfixes/proton-staging_winex11-WM_WINDOWPOSCHANGING.patch

    echo "Valve VR patches"
    patch -Np1 < ../game-patches-testing/proton-valve-patches/proton-vr.patch

    echo "Valve vulkan patches"
    patch -Np1 < ../game-patches-testing/proton-valve-patches/proton-vk-bits-4.5.patch

    echo "FS Hack integer scaling"
    patch -Np1 < ../game-patches-testing/proton-valve-patches/proton_fs_hack_integer_scaling.patch

    echo "SDL Joystick"
    patch -Np1 < ../game-patches-testing/proton-valve-patches/proton-sdl_joy.patch
    patch -Np1 < ../game-patches-testing/proton-valve-patches/proton-sdl_joy_2.patch

    echo "proton gamepad additions"
    patch -Np1 < ../game-patches-testing/proton-valve-patches/proton-gamepad-additions.patch

    echo "msvcrt overrides"
    patch -Np1 < ../game-patches-testing/proton-valve-patches/proton-msvcrt_nativebuiltin.patch

    echo "valve registry entries"
    patch -Np1 < ../game-patches-testing/proton-valve-patches/proton-apply_LargeAddressAware_fix_for_Bayonetta.patch
    patch -Np1 < ../game-patches-testing/proton-valve-patches/proton-Set_amd_ags_x64_to_built_in_for_Wolfenstein_2.patch

    #echo "mfplat alpha testing patches"
    #patch -Np1 < ../game-patches-testing/wine-patches/mfplat_rebase_patchset.patch

    echo "fs hack improvement PRs"
    patch -Np1 < ../game-patches-testing/wine-patches/winevulkan_fshack_opts.patch

    #WINE VULKAN - must be applied after fshack
    echo "applying winevulkan patches"
    patch -Np1 < ../game-patches-testing/wine-patches/winevulkan-childwindow.patch

    echo "applying WoW vkd3d wine patches"
    patch -Np1 < ../game-patches-testing/wine-patches/D3D12SerializeVersionedRootSignature.patch
    patch -Np1 < ../game-patches-testing/wine-patches/D3D12CreateVersionedRootSignatureDeserializer.patch

    #WINE CUSTOM PATCHES
    #add your own custom patch lines below


    ./tools/make_requests
    autoreconf -f

    #end
