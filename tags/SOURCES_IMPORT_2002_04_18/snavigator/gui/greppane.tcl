# Copyright (c) 2000, 2001, Red Hat, Inc.
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
########################################
##
## Grep (Find in Files...)
##
########################################

itcl::class Grep {
    inherit sourcenav::MultiChild

    constructor {args} {
        global sn_options

        # Load formats for pattern once, when the first instance is created
        if {! [info exists PatternFormats]} {
            set PatternFormats [list]

            set fil_file [sn_search_file grep.fil]
            sn_log "greppane loading pre-defined pattern formats file"
            if {[file isfile ${fil_file}]} {
                set fd [open ${fil_file}]
                fconfigure ${fd} -encoding $sn_options(def,system-encoding) -blocking 0
                foreach l [split [read -nonewline ${fd}] "\n"] {
                    set split_l [split ${l} \"]
                    lappend PatternFormats [list \
                        [lindex $split_l 1] \
                        [lindex $split_l 3]]
                }
                close ${fd}
            }

            # Make entries for the combo box
            set PatternFormatsCombo [list]
            foreach l ${PatternFormats} {
                lappend PatternFormatsCombo [lindex ${l} 0]
            }
        }

	# Process arguements
	eval itk_initialize $args

        # Add menu entries
        if {$itk_option(-menu) != ""} {
        }

        # Add toolbar icons
        if {$itk_option(-toolbar) != ""} {

	    # Toolbar grep frame

            itk_component add greptoolbar {
		frame $itk_option(-toolbar).grepframe
	    }

            # Previous button

	    itk_component add prev {
		button $itk_component(greptoolbar).prev \
                        -takefocus 0 \
			-image del_image \
                        -command [itcl::code ${this} next_entry -1] \
			-text [get_indep String Prev]
	    }
            balloon_bind_info $itk_component(prev) [get_indep String PrevINFO]

            # Next button

	    itk_component add next {
		button $itk_component(greptoolbar).next \
                        -takefocus 0 \
			-image add_image \
                        -command [itcl::code ${this} next_entry +1] \
			-text [get_indep String Next]
	    }
            balloon_bind_info $itk_component(next) [get_indep String NextINFO]

        }

        # Frame for input

	itk_component add input {
	    frame $itk_component(hull).input
	}

        # The label width needs to depend on the longest string that will
        # be displayed in the label and we need to set it at creation time.

        set longest_label 8
        foreach str [list [get_indep String MultiGrepPattern] \
                          [get_indep String UtilFiles] \
                          [get_indep String MultiGrepFormat]] {
            set len [string length $str]
            if {$len > $longest_label} {
                set longest_label $len
            }
        }

        # Entries for pattern, file pattern, filter, and checkbuttons

        # Pattern

	itk_component add pattern {
	    Combo& $itk_component(input).pattern \
                    -labelwidth $longest_label \
                    -anchor ne \
                    -entryvariable [itcl::scope pattern] \
		    -exportselection n \
                    -selectcommand \
		        [itcl::code ${this} history_combo_select_command] \
		    -label [get_indep String MultiGrepPattern] \
		    -underline [get_indep Pos MultiGrepPattern]
	} {}

        # File Pattern
        itk_component add filepattern {
            Combo& $itk_component(input).filepattern \
                -labelwidth $longest_label \
                -anchor ne \
                -entryvariable [itcl::scope filepattern] \
		-exportselection n \
		-label [get_indep String UtilFiles] \
		-underline [get_indep Pos UtilFiles]
	} {}

        # Filter
        itk_component add filtercombo {
            Combo& $itk_component(input).filtercombo \
                -labelwidth $longest_label \
                -anchor ne \
                -entryvariable [itcl::scope GrepPatFilter] \
                -contents ${PatternFormatsCombo} \
                -selectcommand \
                    [itcl::code ${this} disp_filter $itk_component(input).filtercombo] \
                -width 0 \
		-label [get_indep String MultiGrepFormat] \
		-underline [get_indep Pos MultiGrepFormat]
	} {}

        # Search button

        itk_component add buttons {
            frame $itk_component(input).buttonsframe
	}

	itk_component add search {
            button $itk_component(buttons).search \
                -command [itcl::code ${this} ExecGrep] \
                -text [get_indep String UtilSearch] \
                -underline [get_indep Pos UtilSearch]
	}
        balloon_bind_info $itk_component(search) [get_indep String GrepSearchINFO]

        # Cancel Button

        itk_component add cancel {
            button $itk_component(buttons).cancel \
                -text [get_indep String Cancel] \
                -underline [get_indep Pos Cancel] \
                -command [itcl::code ${this} cancel_grep] \
                -state disabled
	}
	balloon_bind_info $itk_component(cancel) [get_indep String GrepCancelINFO]


# FIXME : This feature is not documented

        # Format button: Take the string that the user entered and format
        # it with the format pattern from the combobox

        itk_component add format {
            button $itk_component(buttons).format \
                -text [get_indep String Format] \
                -underline [get_indep Pos Format] \
                -command "$this FormatPattern"
	}

        balloon_bind_info $itk_component(format) [get_indep String GrepFormatINFO]

        # Flags

	itk_component add case {
	    checkbutton $itk_component(input).case \
                -onvalue 1 \
                -offvalue 0 \
                -variable [itcl::scope GrepNocase] \
		-text [get_indep String IgnoreCase] \
		-underline [get_indep Pos IgnoreCase]
	}

	# Search limit

        itk_component add limit {
            Entry& $itk_component(input).limit \
                -labelwidth 10 \
                -width 4 \
                -anchor ne \
                -exportselection n \
                -textvariable [itcl::scope maxmatches] \
                -label [get_indep String MultiGrepMaxMatches] \
                -filter natural
        } {}

	itk_component add lines-label {
            label $itk_component(input).lines \
                -text [get_indep String MultiGrepLines]
	}

        # Slider for grep status/progress.
        itk_component add progressbar {
            ProgressBar $itk_option(-mesg_area).grep_status \
                -variable [itcl::scope scalevalue]
	} { }

	balloon_bind_info $itk_component(progressbar) \
                [get_indep String GrepProcessing]
        

        # Grep Results
	itk_component add resultsframe {
	    frame $itk_component(hull).resultsframe
	}

	itk_component add results {
	    text $itk_component(resultsframe).results \
                -wrap none \
                -exportselection 0
	} {}
 
	itk_component add hscroll {
	    scrollbar $itk_component(resultsframe).hscroll \
                -orient horizontal \
                -command "$itk_component(results) xview"
	}

	itk_component add vscroll {
	    scrollbar $itk_component(resultsframe).vscroll \
                -orient vertical \
                -command "$itk_component(results) yview"
	}

        $itk_component(results) configure \
            -xscrollcommand "$itk_component(hscroll) set" \
            -yscrollcommand "$itk_component(vscroll) set"

        # Layout Management

        if {[info exists itk_component(greptoolbar)]} {
            pack $itk_component(greptoolbar) -side left
            pack $itk_component(prev) -side left -fill x -expand n
            pack $itk_component(next) -side left -fill x -expand n
        }

        grid $itk_component(pattern) -row 0 -column 0 -sticky ew -columnspan 5

        grid $itk_component(filepattern) -row 1 -column 0 -sticky ew -columnspan 5

        grid $itk_component(filtercombo) -row 2 -column 0 -sticky ew -columnspan 5

        grid $itk_component(case) -row 3 -column 1

        grid $itk_component(limit) -row 3 -column 2

        grid $itk_component(lines-label) -row 3 -column 3

        grid columnconfigure $itk_component(input) 1 -pad 50
        grid columnconfigure $itk_component(input) 4 -weight 1

        # FIXME: This is a rather nasty hack, but at least it is better
        # than the last hack with the empty label!
        update
        grid columnconfigure $itk_component(input) 0 \
            -minsize [winfo width $itk_component(pattern).label]

        grid rowconfigure $itk_component(input) 0 -weight 1
        grid rowconfigure $itk_component(input) 1 -weight 1
        grid rowconfigure $itk_component(input) 2 -weight 1
        grid rowconfigure $itk_component(input) 3 -weight 1



        # Frame for the 3 command buttons

        grid $itk_component(buttons) -row 0 -column 5 -sticky ns -rowspan 4

        pack $itk_component(search) -side top -padx 8 -pady 4 -fill x

	pack $itk_component(cancel) -side top -padx 8 -pady 4 -fill x

        pack $itk_component(format) -side top -padx 8 -pady 4 -fill x


        # Frame for the grep text and its scrollbars

        grid $itk_component(results) -row 0 -column 0 -sticky news
        grid $itk_component(hscroll) -row 1 -column 0 -sticky ew
        grid $itk_component(vscroll) -row 0 -column 1 -sticky ns

# FIXME: scrollbars should always be minsized to the width or height of the scroll!
# of course it would be better to just use an autoscroll widget!
        grid rowconfigure $itk_component(resultsframe) 0 -weight 1
        grid columnconfigure $itk_component(resultsframe) 0 -weight 1

        # Main frame for top section of the grep window.

        grid $itk_component(resultsframe) -row 1 -column 0 -sticky news
        grid $itk_component(input) -row 0 -column 0 -sticky ew -padx 5

        grid rowconfigure $itk_component(hull) 1 -weight 1
        grid columnconfigure $itk_component(hull) 0 -weight 1

        # Bindings and other initializations

        [$itk_component(pattern) component entry] select to end

        # It would be better to bind to the hull and reorder the events.
        foreach widget [list \
                           [$itk_component(limit) component entry] \
                           [$itk_component(pattern) component entry] \
                           [$itk_component(filepattern) component entry]] {
            bind $widget <Return> [itcl::code ${this} ExecGrep]
        }

# FIMXE: Tag for the text widget?
	$itk_component(results) tag config sel -background $sn_options(def,select-bg)

# FIXME : why would we care about tabs in this widget?
        Editor&::set_tab $itk_component(results) 2

        # Lock down bindings for this widget so we only use ours
        bindtags $itk_component(results) $itk_component(results)
	bind $itk_component(results) <ButtonPress-1> [itcl::code $this text_b1_down %W %x %y]
        bind $itk_component(results) <Double-1> [itcl::code $this text_b1_double %W %x %y]

        # Add history to the combo boxes
        refresh_combo_history

        Update_Layout

# FIXME : are we breaking an external API by sending a text widget here?
        #call user defined function
        catch {sn_rc_grep $itk_component(hull) $itk_component(results)} err
        sn_log "trying to execute sn_rc_grep:${err}"

        Focus
    }

    destructor {
        # Make sure any grep process is terminated
        if {[catch {close ${grep_fd}} err]} {
            sn_log "caught error in Grep dtor : \"$err\""
        }
    }

    method handle_cancel {} {
        if {${cancelcommand} != ""} {
            eval ${cancelcommand}
        }
    }

    private method disp_filter {combo txt} {
        foreach l ${PatternFormats} {
            if {${txt} == [lindex ${l} 0]} {
                set GrepPatFilter [lindex ${l} end]
                break
            }
        }
    }

    # Format the current value of -pattern

    public method FormatPattern {} {
        set pat $pattern

        if {${pat} != ""} {
            # Convert string to be used for grep
            regsub -all {\^|\\|\.|\*|\$|\-|\[|\]} ${pat} {\\&} pat
            regsub -all {\<|\>} ${pat} {[&]} pat
        }
    }

    private method refresh_combo_history {} {
        global sn_options
        global history_List

        if {![info exists history_List(grep)]} {
            set history_List(grep) ""
        }
        set lbls ""
        foreach e $history_List(grep) {
            set lbl [lindex ${e} 2]
            set len [string first " " ${lbl}]
            lappend lbls [string range ${lbl} [expr {${len} + 1}] end]
        }
        $itk_component(pattern) configure -contents ${lbls}

        # Add file filter to the history stack of the file filters
        sn_add_to_histroy_stack sn_options(history,grep,file) \
	    [$itk_component(filepattern) cget -entrytext]
        $itk_component(filepattern) configure -contents $sn_options(history,grep,file)
    }

    # This method is invoked by the grep history combo box, it
    # resets the history based on the pattern in the combobox

    private method history_combo_select_command {txt} {
        global sn_options
        global history_List

        # FIXME: this is a terrible interface, we need a History class !!
        # Search the history array to see if we can find a match for
        # the given pattern like "grep Tcl_(*.tcl)"
        foreach l $history_List(grep) {
            if {[lindex ${l} 2] == "grep ${txt}"} {
                set args [lindex ${l} 1]

                sn_log "Now to reset grep history to \{$args\}"

                if {[llength $args] == 4} {
                    # FIXME: This means and old "grep history" was pulled out of an
                    # old project file, we did not want to make the file format
                    # incompatible so we just hack around it for now
                    foreach {pat fpat} $args break
		    set icase $GrepNocase
                } else {
                    foreach {pat fpat icase} $args break
                }

                # Split the arguments up and pass them, don't use eval!
                $this GrepResetFromHistory $pat $fpat $icase
                return
            }
        }
    }

    public method ExecGrep {} {
        global sn_options sn_path
        global errorInfo errorCode

        # A grep process is already running, close it down and start a new one
        if {${Proceed} != 0} {
            ${this} close_grep
        }

        set pat ${pattern}
        if {[string compare [string trim ${pat}] ""] == 0} {
            return
        }

        if {[string compare [string index ${pat} 0] "-"] == 0} {
            set pat "\\${pat}"
        }

        # Set toplevel window title to a tool specific string
        SetTitle

        # Pattern for files to search, AKA file name filter
        set filter ${filepattern}

        # Convert "\" into "/" on windows
        set filter [file nativename $filter]

        # Read matched files from the project file
        set files [lsort -command sn_compare \
            [lmatch -glob [sn_project_file_list 0] ${filter}]]

        # Count files
        set files_Count [llength ${files}]

        # No files matched the file filter
        if {$files_Count == 0} {
            sn_error_dialog "[get_indep String ErrorNoMatches] \"${filepattern}\" !"
            return
        }

        # The actual count is off by one because we update the % done meter
        # based on the match read back from grep
        incr files_Count -1

        # If there is a pattern filter, substitute the current
        # value of ${pat} into the %s in the filter

        set pat_filt ${GrepPatFilter}

        if {[string compare ${pat_filt} ""] != 0} {
            if {[regsub -all {%s} ${pat_filt} ${pat} pat_filt]} {
                set pat ${pat_filt}
            }
        } else {
            regsub -all {\<} ${pat} {\\<} pat
            regsub -all {\>} ${pat} {\\>} pat
        }

        # Remove tabs from the pattern
        regsub -all {\\t} ${pat} "\t" pat

        # grep command
	
	# If there is a grep in the directory with other binaries, use it.
	# Otherwise, use whatever is on the path. This insures that we use
	# GNU grep, but don't install our own version on linux.
	set grep_cmd [file join $sn_path(bindir) "grep"]
	if {![file exists $grep_cmd]} {
	    set grep_cmd "grep"
	}	
        set cmd [list $grep_cmd "-n" "--with-filename"]

        # Ignore case
	if {${GrepNocase}} {
            lappend cmd -i
        }

        # The pattern to search for
        set activePattern ${pat}
        lappend cmd ${pat}

        sn_log "Executing: ${cmd} \$FILES"

        # Add the files to search for to the
        # grep command. We also create an array
        # that mapps the file name to its
        # position in the search so that we
        # can update our % done meter. 

        # Clear out old array (it could be huge!)
        catch {unset files_Matched}

        set filecount 0
        set groupcount 0
        set groupsize 40
        set filegroups($groupcount) ""

        set len [llength $files]
        for {set i 0} {$i < $len} {incr i} {
            set file [lindex $files $i]
            set files_Matched($file) $i
            if {$filecount > $groupsize} {
                set filecount 0
                incr groupcount
                set filegroups($groupcount) ""
	    }
            lappend filegroups($groupcount) $file
            incr filecount
        }

        tixBusy $itk_component(results) on
        update idletasks
        $itk_component(results) config -state normal
        $itk_component(results) delete 0.0 end
        $itk_component(results) config -state disabled
        # Clear selected line property
        set text_b1_current_line_num -1
        tixBusy $itk_component(results) off

        # FIXME : use one but not both!
        update idletasks
        update

        # Disable horizontal scrolling during the grep. This is to
        # prevent the horizontal scroll bar from flying all over the
        # place while the grep is running

	$itk_component(hscroll) configure -command {}
        $itk_component(results) configure -xscrollcommand {}

        sn_log "GREP: detach horizontal scroll"

        $itk_component(progressbar) configure -maxvalue ${files_Count}
        set scalevalue 0
        set max_search_reached 0
        set errorInfo ""
        set counter 0
        set grep_canceled 0

        handle_proceed disabled

        for {set groupindex 0} {$groupindex <= $groupcount} {incr groupindex} {
            sn_log "grouploop $groupindex : will run $cmd"
            set execCmd "$cmd $filegroups($groupindex)"

            if {$grep_canceled} {
                sn_log "breaking out of group loop because of grep_canceled"
                break
            }

            if {$max_search_reached} {
                sn_log "breaking out of group loop because of max_search_reached"
                break
            }

            set grep_running 1
            ExecGrepEvent $execCmd
            vwait [itcl::scope grep_running]
            set scalevalue [expr $groupindex * $groupsize + $groupsize]
	}

        finish_grep 
    }

    # Private method that takes a grep command to exec and
    # actually does the pipe open and stuff

    private method ExecGrepEvent {cmd} {
        global sn_options
        global errorInfo errorCode env
        global tcl_platform

        #make sure we stay in project directory (different interpeters).
        catch {cd $sn_options(sys,project-dir)}

# FIXME: I think it would be better to use glob for this!
        if {$tcl_platform(platform) != "windows"} {
            set home $env(HOME)
            if {[string compare ${home} "/"] != 0} {
                append home "/"
            }
            regsub -all "~/" ${cmd} ${home} cmd
        }

        sn_log "Start grep : [clock format [clock seconds]]"

        if {[catch {set grep_fd [open "| ${cmd}" r]} errmsg]} {
            sn_error_dialog "-code error -errorinfo ${errorInfo}\
              -errorcode ${errorCode} ${errmsg}"
            return
        }

# FIXME: we should play around with the default buffer size to see
# if we can improve the grep read performance!
        fconfigure ${grep_fd} \
            -encoding $sn_options(def,system-encoding) \
            -blocking 0 \
            -buffering full

        if {[catch {fileevent ${grep_fd} readable \
            [itcl::code ${this} grepReadableEvent]} err]} {
            sn_log "caught error assigning fileevent : \"$err\""
            ${this} close_grep
        }
    }

    # Grab the current selection from the window system
    # and put it in the pattern text box. Use passed in
    # pat if given.

    public method setPatternFromClipboard { {pat {}} } {
        if {$pat == {} && [catch {set pat [string trim [selection get]]}]} {
            bell
            sn_error_dialog \
	        [get_indep String NoSelection] \
	        [get_indep String MultiGrep]
            return
        }

        set pattern $pat
    }

    # Invoked when the user presses the Cancel button

    private method cancel_grep {} {
        set grep_canceled 1
        $this close_grep
    }

    # Close down the grep pipe and do everything that is needed to return
    # the widget to the state it was in before the grep was started

    private method close_grep {} {
        global sn_options

        sn_log "Done grep : [clock format [clock seconds]]"

        # close older descriptor to be secure that no other grep
        # is running

# FIXME: the blocking async close behavior should be fixed
# now but double check to make sure it is working.
	
        if {[catch {close ${grep_fd}} err]} {
            sn_log "caught error while closing grep fd : \"$err\""
        }
        set grep_running 0
	sn_log "closed grep fd ${grep_fd}"
    }


    # Do everything that is needed to return the widget to the state
    # it was in before the grep was started.  Also colorize results.

    private method finish_grep {} {
        # The text tagging could take quite some time, so block the GUI
        tixBusy $itk_component(results) on
        update idletasks

	# Set progress bar/meter to 100%.
        set scalevalue [$itk_component(progressbar) cget -maxvalue]

#        sn_log "Done grep : [clock format [clock seconds]]"

        set t $itk_component(results)
        $t configure -state normal

        set pat $activePattern
        set pat_len [string length $pat]
        set numlines [expr {int([$t index end]) - 1}]
        set index_list [list]

        if {$GrepNocase} {
            set case -nocase
        } else {
            set case -exact
        }

        # Preform highlighing (colorization) of the results.

        set patt_len 0
        set line_index [$t search -count patt_len -regexp -- \
                   {^(([A-Z].)(:?)([^:]*)|([^:]*))(:?)([0-9]+)(:?)} 1.0 end]
  
        while {$line_index != ""} {

            set start_next_line [list $line_index + 1 lines]
            set line_index [list $line_index + $patt_len chars]
            set index [$t search $case -- $pat $line_index $start_next_line]

            if {$index == ""} {
                 sn_log "GREP: Colorizing error at ($line_index,$start_next_line) or attempting to colorize a Formatted pattern."
                 break
            }

            # Now that we've skipped over the filename and
            # line number we can tag every match until the
            # the line.

            while {$index != ""} {
                set end_index [list $index + $pat_len chars]
                lappend index_list $index $end_index
                set index [$t search $case -- $pat $end_index $start_next_line]
            }

            # Skip the filename and line number at the begining again.
            # {^(([A-Z].)(:?)([^:]*)|([^:]*))(:?)([0-9]+)(:?)}
            # matches things like:
            #
            #        /home/user/work/files/project.c:108:
            #        C:/home/user/work/files/project.c:108:
            #
            # So we don't color parts of the filename by mistake.

	    set line_index [$t search -count patt_len -regexp \
                       -- {^(([A-Z].)(:?)([^:]*)|([^:]*))(:?)([0-9]+)(:?)} \
                       $end_index end]
        }

        if {$index_list != {}} {
            eval {$t tag add grep} ${index_list}
        }

        if {$max_search_reached} {
          $itk_component(results) insert end \n
          $itk_component(results) insert end "*** TRUNCATED ***"
	} elseif {$grep_canceled} {
          # FIXME: We might want to check to see if the last
          # character in the last line is a \n, if not add one!
          #$itk_component(results) insert end \n
          $itk_component(results) insert end "*** CANCELED ***"
        }
        $t see end
        $t configure -state disabled

        sn_log "Done tagging : [clock format [clock seconds]], $numlines lines"

        # Add the grep info to the history

        sn_log "adding \{${pattern} ${filter} ${GrepNocase}\} to history"

        # This 3.0 business is a goofy thing that the text
        # widget does. We just want to find out if the text
        # widget has any matches (meaning it is not empty)
        if {[$t index end] >= 3.0} {
            sn_add_history grep [list ${pattern} ${filter} ${GrepNocase}] \
                [sn_make_history_title grep ${filter} ${pattern}] \
                [itcl::code $this GrepResetFromHistory]

            refresh_combo_history
        }
	
	# Re-attach the horizontal scrollbar to the text widget

        sn_log "re-attach horizontal scroll"

        $itk_component(hscroll) configure -command "$itk_component(results) xview"
        $itk_component(results) configure \
            -xscrollcommand "$itk_component(hscroll) set"

        # Release the GUI block
        tixBusy $itk_component(results) off

        handle_proceed normal
    }

    # User seleted a pattern from the histroy, reset our widgets to that pattern
    # and run a new grep.

    private method GrepResetFromHistory {oldpattern oldfilepattern oldicase} {
        set pattern ${oldpattern}
        set filepattern ${oldfilepattern}
        set GrepNocase $oldicase
        sn_log "GrepResetFromHistory $oldpattern $oldfilepattern $oldicase"
        $this ExecGrep
    }

# FIXME: all of this functionality needs to be in a more general superclass!
    #disable/enable input fields when the process is running/terminated
    private method handle_proceed {state} {
        if {${state} == "normal"} {
            set wasLineSelected 0

            $itk_component(search) configure -state normal
            $itk_component(cancel) configure -state disabled

            pack forget $itk_component(progressbar)

            set Proceed 0

            $itk_component(search) configure -state normal
        } else {
            set Proceed 1
            set wasLineSelected 0

            $itk_component(search) configure -state ${state}
            $itk_component(cancel) configure -state normal

            # Display the state of the grep command
            pack $itk_component(progressbar) -side right -fill y
        }

        # Set widget state, this will change the color for a label
        # and make an entry or button inactive

        foreach component {pattern filepattern filtercombo case
                limit lines-label format prev next} {
            $itk_component($component) configure -state ${state}
        }
    }


    # Get the currently selected grep results line

    method Split_Line {} {
        global sn_options

        set line $exported_current_line

        # calculate the remaining line in the source file to highlight
        # the found grep pattern
        if {${line} != ""} {
            set foundidx [expr {[string length [lrange [split ${line} :] 0 1]]\
              + 1}]
            set textualline [string range ${line} ${foundidx} end]
        } else {
            return ""
        }
        set pars [sn_goto_comp_error_or_grep ${line}]
        if {${pars} == ""} {
            return ""
        }
        set file [lindex ${pars} 0]
        set pos [lindex ${pars} 1]
# FIXME: This does not convert path names like /tmp/foo/foo.c into foo/foo.c !!!
        set file [sn_convert_FileName ${file}]

        return [list ${file} ${pos}]
    }

    private method next_entry {amount} {
        $this incr_selected_line $amount
        return [handle_single_click]
    }

    method Title {{full 1}} {
        global sn_options

        set t [string trimright [get_indep String MultiGrep] "."]
        set txt $pattern
        if {${txt} != ""} {
            set t "${t}: ${txt}"
        }
        if {${full}} {
            return [sn_title ${t}]
        } else {
            return ${t}
        }
    }
    method Icon {} {
        return [sn_view_icon [get_indep String MultiGrep]]
    }

    method SetTitle {} {
	# FIXME: this is a bit of a hack
	set top [winfo toplevel $itk_component(hull)]

# FIXME: If we change to -title in Window class, this needs fixing.
        ${top} title [Title]
        ${top} configure -iconname [Icon]
    }

    # A single click will select a given line, if we have
    # an split pane goto the given symbol in the other pane.
    # Note that we set exported_current_line here, it
    # does not get set by a double click.

    private method handle_single_click {} {
        set exported_current_line $text_current_line

        if {$itk_option(-selectcommand) != ""} {
            tixBusy $itk_component(results) on
            update idletasks
            set ret [eval $itk_option(-selectcommand) [Selection]]
            highlight_editor_matches
            tixBusy $itk_component(results) off
        } else {
            set ret 0
        }
        set wasLineSelected 1

        return ${ret}
    }

    # This method seems to display a selected line from the grep
    # results in a split pane editor.

# FIXME: This line hightlight and tagging code is a mess
    method highlight_editor_matches {} {
        global sn_options

        # Highlight the match in the editor.
        if {$itk_option(-next) != "" && [$itk_option(-next) whoami] == "edit" && ${foundranges} != ""} {
            set ed [$itk_option(-next) editor]

# FIXME: This is screwing around with the editor text widget! very ugly.

            #verify if the line in the editor has been changed
            if {${textualline} != [${ed} get "${foundline}.0" "${foundline}.end"]} {
                if {$sn_options(def,grep-mark-all)} {
                    ${ed} tag remove sel 0.0 end
                }
                return 0
            }

            set lineranges ""
            foreach pos ${foundranges} {
                set col [expr {[lindex [split ${pos} .] end] - ${foundidx}}]
                lappend lineranges "${foundline}.${col}"
            }

            ${ed} tag remove sel 0.0 end
            ${ed} tag remove grep 0.0 end

            foreach {from to} ${lineranges} {
                ${ed} tag add sel ${from} ${to}
                if {! $sn_options(def,grep-mark-all)} {
                    break
                }
            }

            #move to the first selection position in the editor.
            ${ed} mark set lastpos insert
            ${ed} mark set insert [lindex ${lineranges} 0]
            ${ed} see insert

            return 1
        }
        return 0
    }

    # These methods handle our custom interaction with the
    # text widget. We use a text widget like it is a listbox
    # so we have to do our own special bindings.

    private method text_b1_down { w x y } {
        # Don't allow selection action while grep is running
        if {${Proceed} != 0} {
            sn_log "ignoring click selection, grep is active"
            bell
            return
        }

        # Get the line number at the given x y position
        set line [lindex [split [$w index @$x,$y] .] 0]
        text_select_line $line
        bind $w <B1-Motion> [itcl::code $this text_b1_motion %W %x %y]
        bind $w <ButtonRelease-1> [itcl::code $this text_b1_up %W %x %y]
    }

    private method text_b1_motion { w x y } {
        # Get the line number at the given x y position
        set line [lindex [split [$w index @$x,$y] .] 0]
        text_select_line $line
    }

    private method text_b1_up { w x y } {
        set text_b1_really_up_after [after 500 [itcl::code $this handle_single_click]]

        bind $w <B1-Motion> {}
        bind $w <ButtonRelease-1> {}
    }

    # Double clicking on a line will open the given file
    # in the editor or in another window if reuse is
    # deselected. It does not set regular the export line.

    private method text_b1_double { w x y } {
        # Don't allow selection action while grep is running
        if {${Proceed} != 0} {
            sn_log "ignoring double click selection, grep is active"
            bell
            return
        }

        after cancel $text_b1_really_up_after

        bind $w <B1-Motion> {}
        bind $w <ButtonRelease-1> {}

        sn_log "greppane Text -> Button double $text_b1_current_line_num"

        tixBusy $itk_component(results) on
        update idletasks
        sn_grep_edit_file $text_current_line
        tixBusy $itk_component(results) off
    }

    # Highlight the given line in the grep results

    private method text_select_line { linenum } {
        sn_log "text_select_line $linenum"

        if {$linenum == $text_b1_current_line_num} {
            return
        }

        set w $itk_component(results)

        $w tag remove sel 0.0 end
        $w tag add sel $linenum.0 [list $linenum.0 lineend]
        $w see $linenum.0
        set text_b1_current_line_num $linenum
        set text_current_line [$w get $linenum.0 [list $linenum.0 lineend]]
        sn_log "new selected line_num is $text_b1_current_line_num, line is \"$text_current_line\""
    }

    # Move the selected line up or down by one element

    private method incr_selected_line { amount } {
        if {$amount != "+1" && $amount != "-1"} {
            error "incr amount must be +1 or -1, you gave \"$amount\""            
        }

        # Get last index and take last newline into account
        set lastline [lindex [split [$itk_component(results) index end] .] 0]
        incr lastline -1

        set nextline [expr {$text_b1_current_line_num + $amount}]

        if {$nextline == 0} {
            # Text widget treats line 0 as line 1
            text_select_line $lastline
        } elseif {$nextline > $lastline} {
            # If they are on the last line, shoot them back to line 1
            text_select_line 1
        } else {
            text_select_line $nextline
        }
    }

# FIXME: Printing support for this widget?

    method print {} {
        if {$itk_option(-next) != ""} {
            $itk_option(-next) print
        } else {
            Editor&::print_dialog $itk_component(results)
        }
    }

    method filter {{all 0}} {
    }

    #this function is called, when the symbols combobox
    #is called
    method postcommand {m} {
        set ed [MultiWindow&::list_find $itk_option(-next) edit]
        if {$itk_option(-symbols) == "" || ${ed} == ""} {
            return
        }
        ${ed} postcommand ${m}
    }

    method activate {} {
        if {$itk_option(-symbols) != ""} {
            if {[MultiWindow&::list_find $itk_option(-next) edit] == ""} {
                $itk_option(-symbols) configure -state disabled
            }
        }

        if {$itk_option(-menu) != ""} {
        }

        if {$itk_option(-toolbar) != ""} {
            pack $itk_component(greptoolbar) -side left
        }
    }

    method deactivate {} {
        if {$itk_option(-symbols) != ""} {
            $itk_option(-symbols) configure -state normal
        }
        if {$itk_option(-menu) != ""} {
        }
        if {$itk_option(-toolbar) != ""} {
            pack forget $itk_component(greptoolbar)
        }
    }

    method Selection {} {
        global tcl_platform

        # No selection has been made
        if {$text_b1_current_line_num == -1} {
            return [list "" "" "" "" "" "" "" ""]
        }

        set sel [$this Split_Line]

        sn_log "Split_Line returned \"$sel\""

        if {${sel} != ""} {
            set file [file nativename [lindex ${sel} 0]]
# What the heck is this regsub for? Why convert to nativename and then back again?
            if {$tcl_platform(platform) == "windows"} {
                regsub -all {\\} ${file} {/} file
            }
            set foundline [lindex ${sel} 1]

# What is this doing?
            if {$tcl_platform(platform) != "windows"} {
                set last [string last "/" ${file}]
                set len [string length ${file}]
                #sometimes we get strang results from\
                  'sn_goto_comp_error_or_grep'
                if {${last} != -1 && [expr ${last} + 1] == ${len} ||\
                  [string first "**" ${file}] == 0} {
                    set file ""
                    set foundline ""
                }
            }
        } else {
            set file ""
            set foundline ""
            set foundranges ""
        }
        return [list "" "" "" ${file} ${foundline} "" "" ""]
    }

    method gotosymbol {{scope ""} {sym ""} {cls ""} {file ""} {from ""} \
            {type ""} {prm ""} {to ""} {always 1}} {
        set pattern ${sym}
        ${this} FormatPattern
        return 1
    }

# FIXME: I think this is broken!
    method clearselection {} {
        $itk_component(results) clear
    }

    # This method is called externally when things like editor prefs change!
    public method Update_Layout {} {
        global sn_options

        $itk_component(results) tag configure grep -font $sn_options(def,grep-found-font)\
          -foreground $sn_options(def,grep-found-fg)
        $itk_component(results) config -font $sn_options(def,grep-font)\
          -selectforeground $sn_options(def,select-fg)\
          -selectbackground $sn_options(def,select-bg)
    }

    method Focus {} {
        focus [$itk_component(pattern) component entry]
    }

    #make a title for the Dump position, this is usefull
    #for the views stack (prev/next)
    method DumpTitle {{dump ""}} {
        if {${dump} == ""} {
            set dump [Dump]
        }
        set grepstr [lindex ${dump} 0]
        set grepfpat [lindex ${dump} 1]
        return "Grep [string trim ${grepstr}(${grepfpat})]"
    }

# FIXME: Will this be needed once we move to multichild?
    method AddHistoryFromDump {dump title} {
    }

    #return the important data to restore this widget
    #in later time again (used by saving the project)
    method Dump {} {
        set cnts [$itk_component(results) get 0.0 end]

        return [list ${pattern} ${filepattern} ${GrepPatFilter}\
          ${GrepNocase} ${maxmatches}]
    }

# FIXME: where are these dump and restore methods ever used ???

    #gets the result from the function "Dump" to
    #restore the older state (used by restoring the project)
    method Restore {str} {
        set pattern [lindex ${str} 0]
        set filepattern [lindex ${str} 1]
        set GrepPatFilter [lindex ${str} 2]
        set GrepNocase [lindex ${str} 3]
        set maxmatches [lindex ${str} 4]

        #restore result and it's highlights
        GrepResetFromHistory ${pattern} ${filepattern} ${GrepNocase}
    }

    method Close {{mode 0}} {
        return 1
    }

    method whoami {} {
        return grep
    }

    #if an editor is added to the grep, call the
    #goto function of the editor.
    method goto {combo txt} {
        set ed [MultiWindow&::list_find $itk_option(-next) edit]
        if {$itk_option(-symbols) != "" && ${ed} != ""} {

            #dump the current view into the history stack
            $itk_option(-parent) history_stack_add_point ${ed}

            ${ed} goto ${combo} ${txt}
        }
    }

    # Callback when line is ready to be read from grep fd.

    private method grepReadableEvent {} {
        set close_it 0

        if {[catch {read ${grep_fd}} buf] || [eof ${grep_fd}]} {
            sn_log "closing grep fd because of read error or EOF"
            set close_it 1
        } else {

        sn_log "grepReadableEvent read [string length $buf] bytes ([llength [split $buf \n]] lines)"
        #sn_log "\"$buf\""

        $itk_component(results) config -state normal
        $itk_component(results) insert end $buf

        # Trim the grep to the maximum number of lines
        
        set numlines [expr {int([$itk_component(results) index end]) - 1}]
        
        if {$numlines > $maxmatches} {
            set close_it 1
            set max_search_reached 1
            $itk_component(results) delete [list $maxmatches.0 + 1 lines] end
            sn_log "trimmed grep result to [expr {int([$itk_component(results) index end]) - 1}] lines]"
        }

        $itk_component(results) see end

        # Update the % done meter, we grab the last full
        # line out of the match, get the file name, and
        # then map that to the file position in the search.

        set last [$itk_component(results) get {end - 2 lines} {end - 1 lines}]
        sn_log "Last line from grep is \"$last\""

        if {$last != ""} {
	    set last_file [lindex [split $last :] 0]
            if {[info exists files_Matched($last_file)]} {
                sn_log "Last file in read buffer is \"$last_file\""
                set scalevalue $files_Matched($last_file)
                sn_log "New scale value is $scalevalue of ${files_Count}"
            }
        }

        $itk_component(results) config -state disabled

        } ; # end else block

        if {$close_it} {
          $this close_grep
        }

        # Note: It is critically important that we never
        # call update inside this fileevent callback!
        # If we did, it would recursively process fileevent
        # callbacks. That could trash the stack if the
        # grep results were large enough.
    }


    #
    # VARIABLES
    #

# FIXME: These should be itk rename and keep options not variables !!!
#itk_option define -value value Value "" { ... }

    # interface to query and set the string we will grep for
    public variable pattern ""

    public variable filepattern * {
        if {$filepattern == ""} {
            set filepattern *
        }
    }

    # Pattern selected in the "Format" combo box
    private variable GrepPatFilter ""

    # If true, then ignore case during the grep command
    private variable GrepNocase 0

    # Max number of matches before stopping grep
    public variable maxmatches 100 {
        if {$maxmatches <= 0} {
            # Reject new setting
            break
        }
    }

    private variable MaxFound
    private common PatternFormats
    private common PatternFormatsCombo

    # Boolean to determine if user selected on of the
    # lines in the grep output

    # This will be set to the last line in the grep
    # results that the user clicked on.
    private variable selectedLine -1

    private variable counter 0

    # Set to the pattern we are searching for only while
    # a grep is actually active, otherwise set to ""
    private variable activePattern ""

    # Variables used in implementing custom listbox like
    # bindings on the text widet

    private variable text_b1_really_up_after ""
    private variable text_b1_current_line_num -1

    # The text from the currently selected line
    # in the text widget.
    private variable text_current_line

    # The text from the last "selected" line
    # in the text widget. This can be different
    # from the text_current_line in the case
    # of a double click. A double click will
    # change the text_current_line but it
    # does not modify the exported_current_line
    private variable exported_current_line ""

    #protected variable progressbar ""
    protected variable foundidx 0
    protected variable foundline 0
    protected variable foundranges ""
    protected variable lineranges ""
    protected variable textualline ""

    protected variable filter "*"
    protected variable grep_fd ""
    protected variable file_list ""
    protected variable Configure_binding ""

    protected variable Proceed 0

    # The number of files that are being searched through in a grep
    protected variable files_Count 0

    # The names of each file being grepped
    protected variable files_Matched

    # Variable linked to the progress bar display
    private variable scalevalue 0

    # Set to "1" if max seach limit is hit.
    private variable max_search_reached

    # Don't close window after selecting an entry
    public variable hold 1

    public variable width 80
    public variable height 10

    public variable cancelcommand ""
    private variable grep_canceled
    private variable grep_running

}

# FIXME: need to convert over to class decl and method bodies!
