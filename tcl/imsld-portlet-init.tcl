ad_library {

    Sweep for expired activities.

    @cvs-id $Id$
    @author jopez@inv.it.uc3m.es
    @creation-date jan 2006

}

set TimeLimitIntervalCheck [parameter::get -package_id [apm_package_id_from_key imsld-portlet] -parameter TimeLimitIntervalCheck]

# Only schedule proc if we've set the sweep interval
if { $TimeLimitIntervalCheck > 0 } {
    # Schedule proc to run every TimeLimitIntervalCheck seconds
    ad_schedule_proc -thread t $TimeLimitIntervalCheck imsld::sweep_expired_activities
}
