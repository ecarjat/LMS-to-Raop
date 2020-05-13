############################################################################
# FindFlac.txt
# Heavily borrowed from FindOpus.cmake from
# Copyright (C) 2014  Belledonne Communications, Grenoble France
#
############################################################################
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
############################################################################
#
# - Find the opus include file and library
#
#  FLAC_FOUND - system has opus
#  FLAC_INCLUDE_DIRS - the opus include directory
#  FLAC_LIBRARIES - The libraries needed to use opus

find_path(FLAC_INCLUDE_DIRS 
	NAMES stream_encoder.h
	 PATH_SUFFIXES FLAC
	)

if(FLAC_INCLUDE_DIRS)
	set(FLAC_FOUND 1)
endif()

find_library(FLAC_LIBRARIES FLAC)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Flac
	DEFAULT_MSG
	FLAC_INCLUDE_DIRS  FLAC_LIBRARIES 
)
mark_as_advanced(FLAC_INCLUDE_DIRS FLAC_LIBRARIES)