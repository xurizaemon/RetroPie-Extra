#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="crispy-doom"
rp_module_desc="Crispy Doom - Enhanced port of the official DOOM source"
rp_module_menus="4+"
rp_module_flags="!mali !x86"

function depends_crispy-doom() {
    getDepends libsdl1.2-dev libsdl-net1.2-dev libsdl-mixer1.2-dev python-imaging automake autoconf
}

function sources_crispy-doom() {
    gitPullOrClone "$md_build" https://github.com/fabiangreffrath/crispy-doom.git
}

function build_crispy-doom() {
    ./autogen.sh
    ./configure --prefix="$md_inst"
    make
    md_ret_require="$md_build/src/crispy-doom"
    md_ret_require="$md_build/src/crispy-hexen"
    md_ret_require="$md_build/src/crispy-heretic"
    md_ret_require="$md_build/src/crispy-strife"
}

function install_crispy-doom() {
    md_ret_files=(
        'src/crispy-doom'
        'src/crispy-hexen'
        'src/crispy-heretic'
        'src/crispy-strife'
        'src/crispy-doom-setup'
        'src/crispy-hexen-setup'
        'src/crispy-heretic-setup'
        'src/crispy-strife-setup'
        'src/crispy-setup'
        'src/crispy-server'
    )
}

function configure_crispy-doom() {
    mkRomDir "ports"
    mkRomDir "ports/doom"

    mkUserDir "$home/.config"
    moveConfigDir "$home/.crispy-doom" "$configdir/crispy-doom"

    # download doom 1 shareware
    if [[ ! -f "$romdir/ports/doom/doom1.wad" ]]; then
        wget "$__archive_url/doom1.wad" -O "$romdir/ports/doom/doom1.wad"
    fi

    if [[ ! -f "$romdir/ports/doom/freedoom1.wad" ]]; then
        wget "https://github.com/freedoom/freedoom/releases/download/v0.10.1/freedoom-0.10.1.zip"
        unzip freedoom-0.10.1.zip 
        mv freedoom-0.10.1/*.wad "$romdir/ports/doom"
        rm -rf freedoom-0.10.1
        rm freedoom-0.10.1.zip
    fi

    # Temporary until the official RetroPie WAD selector is complete.
    if [[ -f "$romdir/ports/doom/doom1.wad" ]]; then
       chown $user:$user "$romdir/ports/doom/doom1.wad"
       addPort "$md_id" "crispy-doom1" "Crispy Doom Shareware" "$md_inst/crispy-doom -iwad $romdir/ports/doom/doom1.wad"
    fi

    if [[ -f "$romdir/ports/doom/doom.wad" ]]; then
       chown $user:$user "$romdir/ports/doom/doom.wad"
       addPort "$md_id" "crispy-doom" "Crispy Doom Registered" "$md_inst/crispy-doom -iwad $romdir/ports/doom/doom.wad"
    fi

    if [[ -f "$romdir/ports/doom/freedoom1.wad" ]]; then
       chown $user:$user "$romdir/ports/doom/freedoom1.wad"
       addPort "$md_id" "crispy-freedoom1" "Crispy Free Doom: Phase 1" "$md_inst/crispy-doom -iwad $romdir/ports/doom/freedoom1.wad"
    fi

    if [[ -f "$romdir/ports/doom/freedoom2.wad" ]]; then
       chown $user:$user "$romdir/ports/doom/freedoom2.wad"
       addPort "$md_id" "crispy-freedoom2" "Crispy Free Doom: Phase 2" "$md_inst/crispy-doom -iwad $romdir/ports/doom/freedoom2.wad"
    fi

    if [[ -f "$romdir/ports/doom/doom2.wad" ]]; then
       chown $user:$user "$romdir/ports/doom/doom2.wad"
       addPort "$md_id" "crispy-doom2" "Crispy Doom II: Hell on Earth" "$md_inst/crispy-doom -iwad $romdir/ports/doom/doom2.wad"
    fi

    if [[ -f "$romdir/ports/doom/doomu.wad" ]]; then
       chown $user:$user "$romdir/ports/doom/doomu.wad"
       addPort "$md_id" "crispy-doomu" "Crispy Ultimate Doom" "$md_inst/crispy-doom -iwad $romdir/ports/doom/doomu.wad"
    fi

    if [[ -f "$romdir/ports/doom/tnt.wad" ]]; then
       chown $user:$user "$romdir/ports/doom/tnt.wad"
       addPort "$md_id" "crispy-doomtnt" "Crispy Final Doom - TNT: Evilution" "$md_inst/crispy-doom -iwad $romdir/ports/doom/tnt.wad"
    fi

    if [[ -f "$romdir/ports/doom/plutonia.wad" ]]; then
       chown $user:$user "$romdir/ports/doom/plutonia.wad"
       addPort "$md_id" "crispy-doomplutonia" "Crispy Final Doom - The Plutonia Experiment" "$md_inst/crispy-doom -iwad $romdir/ports/doom/plutonia.wad"
    fi

    if [[ -f "$romdir/ports/doom/heretic1.wad" ]]; then
       chown $user:$user "$romdir/ports/doom/heretic1.wad"
       addPort "$md_id" "crispy-heretic1" "Crispy Heretic Shareware" "$md_inst/crispy-heretic -iwad $romdir/ports/doom/heretic1.wad"
    fi

    if [[ -f "$romdir/ports/doom/heretic.wad" ]]; then
       chown $user:$user "$romdir/ports/doom/heretic.wad"
       addPort "$md_id" "crispy-heretic" "Crispy Heretic Registered" "$md_inst/crispy-heretic -iwad $romdir/ports/doom/heretic.wad"
    fi
    
    if [[ -f "$romdir/ports/doom/hexen.wad" ]]; then
       chown $user:$user "$romdir/ports/doom/hexen.wad"
       addPort "$md_id" "crispy-hexen" "Crispy Hexen" "$md_inst/crispy-hexen -iwad $romdir/ports/doom/hexen.wad"
    fi

    if [[ -f "$romdir/ports/doom/strife1.wad" ]]; then
       chown $user:$user "$romdir/ports/doom/strife1.wad"
       addPort "$md_id" "crispy-strife1" "Crispy Strife" "$md_inst/crispy-strife -iwad $romdir/ports/doom/strife1.wad"
    fi

    __INFMSGS+=("Please add your iWAD files to $romdir/ports/doom/ and reinstall $md_id to create entries for each game to EmulationStation. Run 'crispy-setup' to configure your controls and options.")
}