ad_page_contract {

    The logic for the imsld portlet.

    @author eperez@it.uc3m.es
    @creation-date 2005-09-27
    @cvs-id $Id$

} -query {
}

array set config $cf

set shaded_p $config(shaded_p)
set list_of_package_ids [lsort $config(package_id)]
set one_instance_p [ad_decode [llength $list_of_package_ids] 1 1 0]

ad_return_template 
