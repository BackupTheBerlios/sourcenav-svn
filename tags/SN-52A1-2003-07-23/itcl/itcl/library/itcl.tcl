#
# itcl.tcl
# ----------------------------------------------------------------------
# Invoked automatically upon startup to customize the interpreter
# for [incr Tcl].
# ----------------------------------------------------------------------
#   AUTHOR:  Michael J. McLennan
#            Bell Labs Innovations for Lucent Technologies
#            mmclennan@lucent.com
#            http://www.tcltk.com/itcl
#
#      RCS:  $Id$
# ----------------------------------------------------------------------
#            Copyright (c) 1993-1998  Lucent Technologies, Inc.
# ======================================================================
# See the file "license.terms" for information on usage and
# redistribution of this file, and for a DISCLAIMER OF ALL WARRANTIES.

# ----------------------------------------------------------------------
#  USAGE:  local <className> <objName> ?<arg> <arg>...?
#
#  Creates a new object called <objName> in class <className>, passing
#  the remaining <arg>'s to the constructor.  Unlike the usual
#  [incr Tcl] objects, however, an object created by this procedure
#  will be automatically deleted when the local call frame is destroyed.
#  This command is useful for creating objects that should only remain
#  alive until a procedure exits.
# ----------------------------------------------------------------------
proc ::itcl::local {class name args} {
    set ptr [uplevel [list $class $name] $args]
    uplevel [list set itcl-local-$ptr $ptr]
    set cmd [uplevel namespace which -command $ptr]
    uplevel [list trace variable itcl-local-$ptr u \
        "itcl::delete object $cmd; list"]
    return $ptr
}

# ----------------------------------------------------------------------
# auto_mkindex
# ----------------------------------------------------------------------
# Define Itcl commands that will be recognized by the auto_mkindex
# parser in Tcl...
#

# RED HAT LOCAL: don't require namespace qualifier
#
# USAGE:  itcl::class name body
# Adds an entry for the given class declaration.
#
foreach cmd {itcl::class itcl_class class} {
    auto_mkindex_parser::command $cmd {name body} {
        variable index
        variable scriptFile
        append index "set [list auto_index([fullname $name])]"
        append index " \[list source \[file join \$dir [list $scriptFile]\]\]\n"

        variable parser
        variable contextStack
        set contextStack [linsert $contextStack 0 $name]
        $parser eval $body
        set contextStack [lrange $contextStack 1 end]
    }
}

# RED HAT LOCAL: don't require namespace qualifier
#
# USAGE:  itcl::body name arglist body
# Adds an entry for the given method/proc body.
#
foreach cmd {itcl::body body} {
    auto_mkindex_parser::command $cmd {name arglist body} {
        variable index
        variable scriptFile
        append index "set [list auto_index([fullname $name])]"
        append index " \[list source \[file join \$dir [list $scriptFile]\]\]\n"
    }
}

# RED HAT LOCAL: don't require namespace qualifier
#
# USAGE:  itcl::configbody name arglist body
# Adds an entry for the given method/proc body.
#
foreach cmd {itcl::configbody configbody} {
    auto_mkindex_parser::command $cmd {name body} {
        variable index
        variable scriptFile
        append index "set [list auto_index([fullname $name])]"
        append index " \[list source \[file join \$dir [list $scriptFile]\]\]\n"
    }
}

# RED HAT LOCAL: don't require namespace qualifier
#
# USAGE:  ensemble name ?body?
# Adds an entry to the auto index list for the given ensemble name.
#
foreach cmd {itcl::ensemble ensemble} {
    auto_mkindex_parser::command $cmd {name {body ""}} {
        variable index
        variable scriptFile
        append index "set [list auto_index([fullname $name])]"
        append index " \[list source \[file join \$dir [list $scriptFile]\]\]\n"
    }
}

# RED HAT LOCAL: treat public differently, since we do care about
#                public procs
#
# USAGE:  public arg ?arg arg...?
#         protected arg ?arg arg...?
#         private arg ?arg arg...?
#
# Evaluates the arguments as commands, so we can recognize proc
# declarations within classes.
#
foreach cmd {protected private} {
    auto_mkindex_parser::command $cmd {args} {
        variable parser
        $parser eval $args
    }
}

# RED HAT LOCAL: When the user has used "public {...}" (llength $args == 1),
#                we must eval $args again into its component statements so
#                that we look at every line in the "body". Otherwise,
#                we'll be looking for the contents of the "{...}" as a
#                command, which is funny business.
auto_mkindex_parser::command public {args} {
    variable parser
    if {[llength $args] == 1} {
        eval $parser eval $args
    } else {
        $parser eval $args
    }
}

# RED HAT LOCAL
# This version of auto_import does not work, because it relies
# WHOLLY on the tclIndex files, but the tclIndex files have no
# notion of what the export list for a namespace is.  So at the 
# time you do "namespace import" the export list is empty, and
# so nothing is imported.
# Until that is fixed, it is best just to go back to the original
# Tcl version of auto_import...

# ----------------------------------------------------------------------
# auto_import
# ----------------------------------------------------------------------
# This procedure overrides the usual "auto_import" function in the
# Tcl library.  It is invoked during "namespace import" to make see
# if the imported commands reside in an autoloaded library.  If so,
# stubs are created to represent the commands.  Executing a stub
# later on causes the real implementation to be autoloaded.
#
# Arguments -
# pattern	The pattern of commands being imported (like "foo::*")
#               a canonical namespace as returned by [namespace current]

#proc auto_import {pattern} {
#    global auto_index

#     set ns [uplevel namespace current]
#     set patternList [auto_qualify $pattern $ns]

#     auto_load_index

#     foreach pattern $patternList {
#         foreach name [array names auto_index $pattern] {
#             if {"" == [info commands $name]} {
#                 ::itcl::import::stub create $name
#             }
#         }
#     }
# }
