# Copyright (c) 2000, Red Hat, Inc.
# 
# This file is part of Source-Navigator.
# 
# Source-Navigator is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as published
# by the Free Software Foundation; either version 2, or (at your option)
# any later version.
# 
# Source-Navigator is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
# 
# You should have received a copy of the GNU General Public License along
# with Source-Navigator; see the file COPYING.  If not, write to
# the Free Software Foundation, 59 Temple Place - Suite 330, Boston,
# MA 02111-1307, USA.
# 
AUTOMAKE_OPTIONS = cygnus

## Process this file with automake to create Makefile.in.

htmldir = $(prefix)/html
html_DATA=cygnus1.css index-1.gif redhatlogo.png index.html
userguidedir = $(htmldir)/userguide
srchtmldir = $(top_srcdir)/doc/html

install-data-local:
	$(mkinstalldirs) $(htmldir)
	for p in @SN_BOOKS@; do \
		$(mkinstalldirs) $(htmldir)/$$p; \
		rm -f $(htmldir)/$$p/*.html; \
		rm -f $(htmldir)/$$p/*.gif; \
		echo "copying $$p to $(htmldir)/$$p" ;\
		( \
		cd $(srcdir)/@SN_DOCSET@/$$p ;\
		$(TAR) -ch$(OLDTARFLAG) -f /tmp/$$p.tar-$$$$ *.html *.gif ;\
		cp /tmp/$$p.tar-$$$$ $(htmldir)/$$p ;\
		rm /tmp/$$p.tar-$$$$ ;\
		cd $(htmldir)/$$p ;\
		$(TAR) -xf $$p.tar-$$$$ ;\
		rm $$p.tar-$$$$ ;\
		) \
	done;
