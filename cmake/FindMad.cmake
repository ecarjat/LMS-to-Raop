#Mad###########################################################################
# FindMad.txt
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
#  MAC_FOUND - system has opus
#  MAC_INCLUDE_DIRS - the opus include directory
#  MAC_LIBRARIES - The libraries needed to use opus

find_path(MAD_INCLUDE_DIRS 
	NAMES mad.h
	)

if(MAD_INCLUDE_DIRS)
	set(MAC_FOUND 1)
endif()

find_library(MAD_LIBRARIES mad)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Mad
	DEFAULT_MSG
	MAD_INCLUDE_DIRS  MAD_LIBRARIES 
)
mark_as_advanced(MAD_INCLUDE_DIRS MAD_LIBRARIES)