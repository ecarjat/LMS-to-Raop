############################################################################
# FindAlac.txt
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
#  ALAC_FOUND - system has opus
#  ALAC_INCLUDE_DIRS - the opus include directory
#  ALAC_LIBRARIES - The libraries needed to use opus

find_path(ALAC_INCLUDE_DIRS 
	NAMES ALACEncoder.h
	PATH_SUFFIXES alac )

if(ALAC_INCLUDE_DIRS)
	set(ALAC_FOUND 1)
endif()

find_library(ALAC_LIBRARIES alac)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Alac
	DEFAULT_MSG
	ALAC_INCLUDE_DIRS  ALAC_LIBRARIES 
)
mark_as_advanced(ALAC_INCLUDE_DIRS ALAC_LIBRARIES)
