#
# obs-gstreamer. OBS Studio plugin.
# Copyright (C) 2018-2021 Florian Zwoch <fzwoch@gmail.com>
#
# This file is part of obs-gstreamer.
#
# obs-gstreamer is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#
# obs-gstreamer is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with obs-gstreamer. If not, see <http://www.gnu.org/licenses/>.
#

project('obs-gstreamer', 'c',
  default_options : [
    'prefix=~/.config/obs-studio/plugins/obs-gstreamer/bin/64bit',
    'libdir='
  ],
)

obs_dep = dependency('libobs', required : false)
if not obs_dep.found()
  obs_dep = meson.get_compiler('c').find_library('obs', has_headers : 'obs/obs.h')
endif

name_suffix = []
if host_machine.system() == 'darwin'
  name_suffix = 'so'
endif

CXX = meson.get_compiler('c')

shared_library('obs-gstreamer',
  'gstreamer.c',
  'gstreamer-source.c',
  'gstreamer-encoder.c',
  'gstreamer-filter.c',
  'gstreamer-output.c',
  vcs_tag(
    command : ['git', 'rev-parse', '--short', 'HEAD'],
    input : 'version.c.in',
    output : 'version.c',
  ),
  name_prefix : '',
  name_suffix : name_suffix,
  dependencies : [
    obs_dep,
    CXX.find_library('gstreamer-1.0', dirs : ['/opt/homebrew/Cellar/gstreamer/1.24.7/lib']),
    CXX.find_library('gstvideo-1.0', dirs : ['/opt/homebrew/Cellar/gstreamer/1.24.7/lib']),
    CXX.find_library('gstaudio-1.0', dirs : ['/opt/homebrew/Cellar/gstreamer/1.24.7/lib']),
    CXX.find_library('gstapp-1.0', dirs : ['/opt/homebrew/Cellar/gstreamer/1.24.7/lib']),
    CXX.find_library('gstnet-1.0', dirs : ['/opt/homebrew/Cellar/gstreamer/1.24.7/lib']),
    CXX.find_library('glib-2.0', dirs : ['/opt/homebrew/Cellar/glib/2.80.4/lib']),
    CXX.find_library('gobject-2.0', dirs : ['/opt/homebrew/Cellar/glib/2.80.4/lib']),
  ],
  install : true,
)
