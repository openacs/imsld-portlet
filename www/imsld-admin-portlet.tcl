# /imsld-portlet/www/imsld-admin-portlet.tcl

ad_page_contract {
    The display logic for the imsld admin portlet

    @author eperez@it.uc3m.es
    @creation-date 2005-09-27
    @cvs_id $Id$
} -properties {
    
}

array set config $cf
set user_id [ad_conn user_id]
set list_of_package_ids $config(package_id)

if {[llength $list_of_package_ids] > 1} {
    # We have a problem!
    return -code error "[_ imsld-portlet.error_one_imsld] "
}        

set package_id [lindex $list_of_package_ids 0]        

set url [lindex [site_node::get_url_from_object_id -object_id $package_id] 0]

ad_return_template 
