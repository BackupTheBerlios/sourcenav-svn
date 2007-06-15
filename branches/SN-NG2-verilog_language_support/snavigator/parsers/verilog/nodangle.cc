/*
 * Copyright (c) 1999 Stephen Williams (steve@icarus.com)
 *
 *    This source code is free software; you can redistribute it
 *    and/or modify it in source code form under the terms of the GNU
 *    General Public License as published by the Free Software
 *    Foundation; either version 2 of the License, or (at your option)
 *    any later version.
 *
 *    This program is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License
 *    along with this program; if not, write to the Free Software
 *    Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA
 */
#if !defined(WINNT) && !defined(macintosh)
#ident "$Id: nodangle.cc,v 1.1 2000/12/21 21:57:13 jrandrews Exp $"
#endif

/*
 * This functor scans the design looking for dangling objects and
 * excess local signals. These deletions are not necessarily required
 * for proper functioning of anything, but they can clean up the
 * appearance of design files that are generated.
 */
# include  "functor.h"
# include  "netlist.h"

class nodangle_f  : public functor_t {
    public:
      void event(Design*des, NetEvent*ev);
      void signal(Design*des, NetNet*sig);
};

void nodangle_f::event(Design*des, NetEvent*ev)
{
      if (NetEvent*match = ev->find_similar_event()) {
	    ev->replace_event(match);
      }

      if (ev->nwait() != 0)
	    return;

      if (ev->ntrig() != 0)
	    return;

      delete ev;
}

void nodangle_f::signal(Design*des, NetNet*sig)
{
      if (! sig->local_flag())
	    return;
      if (sig->get_eref() > 0)
	    return;

	/* Look for a completely unconnected signal. */
      unsigned unlinked = 0;
      for (unsigned idx =  0 ;  idx < sig->pin_count() ;  idx += 1)
	    if (! sig->pin(idx).is_linked()) unlinked += 1;

      if (unlinked == sig->pin_count()) {
	    delete sig;
	    return;
      }

	/* Check to see if there is some significant signal connected
	   to every pin of this signal. */
      unsigned significant_flags = 0;
      for (unsigned idx = 0 ;  idx < sig->pin_count() ;  idx += 1) {
	    Nexus*nex = sig->pin(idx).nexus();

	    for (Link*cur = nex->first_nlink()
		       ; cur ;  cur = cur->next_nlink()) {

		  if (cur == &sig->pin(idx))
			continue;

		  NetNet*cursig = dynamic_cast<NetNet*>(cur->get_obj());
		  if (cursig == 0)
			continue;

		  if (cursig->local_flag())
			continue;

		  significant_flags += 1;
		  break;
	    }
      }

	/* If every pin is connected to another significant signal,
	   then I can delete this one. */
      if (significant_flags == sig->pin_count())
	    delete sig;
}

void nodangle(Design*des)
{
      nodangle_f fun;
      des->functor(&fun);
}

/*
 * $Log: nodangle.cc,v $
 * Revision 1.1  2000/12/21 21:57:13  jrandrews
 * initial import
 *
 * Revision 1.8  2000/06/25 19:59:42  steve
 *  Redesign Links to include the Nexus class that
 *  carries properties of the connected set of links.
 *
 * Revision 1.7  2000/05/31 02:26:49  steve
 *  Globally merge redundant event objects.
 *
 * Revision 1.6  2000/05/07 04:37:56  steve
 *  Carry strength values from Verilog source to the
 *  pform and netlist for gates.
 *
 *  Change vvm constants to use the driver_t to drive
 *  a constant value. This works better if there are
 *  multiple drivers on a signal.
 *
 * Revision 1.5  2000/04/28 21:00:29  steve
 *  Over agressive signal elimination in constant probadation.
 *
 * Revision 1.4  2000/04/18 04:50:20  steve
 *  Clean up unneeded NetEvent objects.
 *
 * Revision 1.3  2000/02/23 02:56:55  steve
 *  Macintosh compilers do not support ident.
 *
 * Revision 1.2  1999/11/28 23:42:02  steve
 *  NetESignal object no longer need to be NetNode
 *  objects. Let them keep a pointer to NetNet objects.
 *
 * Revision 1.1  1999/11/18 03:52:20  steve
 *  Turn NetTmp objects into normal local NetNet objects,
 *  and add the nodangle functor to clean up the local
 *  symbols generated by elaboration and other steps.
 *
 */
