# Generated automatically from Makefile.in by configure.
#
#    This source code is free software; you can redistribute it
#    and/or modify it in source code form under the terms of the GNU
#    Library General Public License as published by the Free Software
#    Foundation; either version 2 of the License, or (at your option)
#    any later version. In order to redistribute the software in
#    binary form, you will need a Picture Elements Binary Software
#    License.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Library General Public License for more details.
#
#    You should have received a copy of the GNU Library General Public
#    License along with this program; if not, write to the Free
#    Software Foundation, Inc.,
#    59 Temple Place - Suite 330
#    Boston, MA 02111-1307, USA
#
#ident "$Id: Makefile.in,v 1.4 2001/01/25 16:30:55 jrandrews Exp $"
#
#
SHELL = /bin/sh

VERSION = 0.3PRE

prefix = /usr/local
exec_prefix = ${prefix}
srcdir = .


host = i686-pc-linux-gnu

bindir = $(exec_prefix)/bin
libdir = $(exec_prefix)/lib
mandir = ${prefix}/man
includedir = $(prefix)/include

CC = gcc
CXX = c++
INSTALL = /usr/bin/install -c
INSTALL_SCRIPT = ${INSTALL_PROGRAM}
INSTALL_PROGRAM = ${INSTALL}
INSTALL_DATA = ${INSTALL} -m 644
STRIP = strip

CPPFLAGS =   -DHAVE_GETOPT_H=1 -DRDYNAMIC=\"-rdynamic\"  -I$(srcdir)/../snverilog/include
CXXFLAGS = -O0 -g -I$(srcdir)
LDFLAGS = -ldl  -lieee -lm
LIBS = $(srcdir)/../snverilog/lib/$(host)/libsnptools.a \
	$(srcdir)/../snverilog/lib/$(host)/libdbutils.a \
	$(srcdir)/../snverilog/lib/$(host)/libdb.a \
	$(srcdir)/../snverilog/lib/$(host)/libcommon.a \
	$(srcdir)/../snverilog/lib/$(host)/libutils.a \
	$(srcdir)/../snverilog/lib/$(host)/libtcl8.1.a

all: snvp

clean:
	rm -f *.o parse.cc parse.cc.output parse.h dep/*.d lexor.cc lexor_keyword.cc snvp

install: all $(bindir)/snvp 
	$(INSTALL_PROGRAM) ./snvp $(bindir)/snvp
	$(INSTALL_PROGRAM) $(srcdir)/../snverilog/bin/$(host)/hyper $(bindir)/hyper
	$(INSTALL_PROGRAM) $(srcdir)/../snverilog/share/etc/sn_prop.cfg $(exec_prefix)/share/etc/sn_prop.cfg
	$(INSTALL_PROGRAM) $(srcdir)/../snverilog/share/gui/sninit.tcl $(exec_prefix)/share/gui/sninit.tcl


distclean: clean
	rm -f config.status config.cache config.log
	rm -f Makefile

TT = t-null.o t-verilog.o t-vvm.o t-xnf.o
FF = nodangle.o synth.o syn-rules.o xnfio.o

O = main.o cprop.o design_dump.o dup_expr.o elaborate.o elab_expr.o \
elab_net.o elab_pexpr.o elab_scope.o elab_sig.o emit.o eval.o eval_tree.o \
expr_synth.o functor.o lexor.o lexor_keyword.o link_const.o \
mangle.o netlist.o \
net_design.o net_event.o net_force.o net_link.o net_proc.o net_scope.o \
net_udp.o \
pad_to_width.o \
parse.o parse_misc.o pform.o pform_dump.o \
set_width.o \
verinum.o verireal.o target.o targets.o util.o Module.o PDelays.o PEvent.o \
PExpr.o PGate.o \
PTask.o PFunction.o PWire.o Statement.o sn_main.o \
$(FF) $(TT)

Makefile: Makefile.in config.status
	./config.status

snvp: $O
	$(CXX) $(CXXFLAGS) -o snvp $O $(LIBS) $(LDFLAGS)

%.o dep/%.d: %.cc
	@[ -d dep ] || mkdir dep
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -MD -c $< -o $*.o
	mv $*.d dep/$*.d


lexor.o dep/lexor.d: lexor.cc parse.h

parse.o dep/parse.d: parse.cc

parse.h parse.cc: $(srcdir)/parse.y
	bison --verbose -t -p VL -d $(srcdir)/parse.y -o parse.cc
	mv parse.cc.h $(srcdir)/parse.h

syn-rules.cc: $(srcdir)/syn-rules.y
	bison --verbose -p syn_ -o syn-rules.cc $(srcdir)/syn-rules.y

lexor.cc: $(srcdir)/lexor.lex
	flex -PVL -s -olexor.cc $(srcdir)/lexor.lex

lexor_keyword.o dep/lexor_keyword.d: lexor_keyword.cc

lexor_keyword.cc: $(srcdir)/lexor_keyword.gperf
	gperf -o -i 7 -C -k 1-3,$$ -L ANSI-C -H keyword_hash -N check_identifier -t $(srcdir)/lexor_keyword.gperf > lexor_keyword.cc || (rm -f lexor_keyword.cc ; false)


-include $(patsubst %.o, dep/%.d, $O)
