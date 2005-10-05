ad_library {

    Procedures to support the imsld portlets

    @creation-date 2005-09-27
    @author eperez@it.uc3m.es
    @cvs_id $Id$

}

namespace eval imsld_portlet {}
namespace eval imsld_admin_portlet {}


#
# imsld namespace
#

ad_proc -private imsld_portlet::get_my_name {
} {
    return "imsld_portlet"
}



ad_proc -private imsld_portlet::my_package_key {
} {
    return "imsld-portlet"
}



ad_proc -public imsld_portlet::get_pretty_name {
} {
    return "#imsld.units-of-learning#"
}



ad_proc -public imsld_portlet::link {
} {
    return ""
}



ad_proc -public imsld_portlet::add_self_to_page {
    {-portal_id:required}
    {-package_id:required}
    {-param_action:required}
    {-force_region ""}
    {-page_name "" }
} {
    Adds a imsld PE to the given portal.
    
    @param portal_id The page to add self to
    @param package_id The community with the folder
    
    @return element_id The new element's id
} {
    return [portal::add_element_parameters \
                -portal_id $portal_id \
                -portlet_name [get_my_name] \
                -value $package_id \
                -force_region $force_region \
		-page_name $page_name \
                -pretty_name [get_pretty_name] \
                -param_action $param_action
           ]
}



ad_proc -public imsld_portlet::remove_self_from_page {
    {-portal_id:required}
    {-package_id:required}
} {
    Removes a imsld PE from the given page or the package_id of the
    imsld package from the portlet if there are others remaining
    
    @param portal_id The page to remove self from
    @param package_id
} {
    portal::remove_element_parameters \
        -portal_id $portal_id \
        -portlet_name [get_my_name] \
        -value $package_id
}



ad_proc -public imsld_portlet::show {
    cf
} {
    portal::show_proc_helper \
        -package_key [my_package_key] \
        -config_list $cf \
        -template_src "imsld-portlet"
}

#
# imsld admin namespace
#

ad_proc -private imsld_admin_portlet::get_my_name {} {
    return "imsld_admin_portlet"
}


ad_proc -public imsld_admin_portlet::get_pretty_name {} {
    return "#imsld.units-of-learning_Administration#"
}



ad_proc -private imsld_admin_portlet::my_package_key {} {
    return "imsld-portlet"
}



ad_proc -public imsld_admin_portlet::link {} {
    return ""
}



ad_proc -public imsld_admin_portlet::add_self_to_page {
    {-portal_id:required}
    {-page_name ""}
    {-package_id:required}
} {
    Adds a imsld admin PE to the given portal

    @param portal_id The page to add self to
    @param package_id The package_id of the imsld package

    @return element_id The new element's id
} {
    return [portal::add_element_parameters \
                -portal_id $portal_id \
                -portlet_name [get_my_name] \
                -key package_id \
                -value $package_id
           ]
}

ad_proc -public imsld_admin_portlet::remove_self_from_page {
    {-portal_id:required}
} {
    Removes a imsld admin PE from the given page
} {
    portal::remove_element \
        -portal_id $portal_id \
        -portlet_name [get_my_name]
}


ad_proc -public imsld_admin_portlet::show {
    cf
} {
    portal::show_proc_helper \
        -package_key [my_package_key] \
        -config_list $cf \
        -template_src "imsld-admin-portlet"
}

ad_proc -private imsld_portlet::after_install {} {
    Create the datasources needed by the imsld portlet.
} {
    
    db_transaction {
	set ds_id [portal::datasource::new \
		       -name "imsld_portlet" \
		       -description "IMS LD Portlet"]

	portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key shadeable_p \
            -value t

	portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key hideable_p \
            -value t

        portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key user_editable_p \
            -value f

        portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key shaded_p \
            -value f

        portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key link_hideable_p \
            -value f

        portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p f \
            -key package_id \
            -value ""

	register_portal_datasource_impl

    }
}

ad_proc -private imsld_portlet::register_portal_datasource_impl {} {
    Create the service contracts needed by the imsld portlet.
} {
    set spec {
        name "imsld_portlet"
	contract_name "portal_datasource"
	owner "imsld-portlet"
        aliases {
	    GetMyName imsld_portlet::get_my_name
	    GetPrettyName  imsld_portlet::get_pretty_name
	    Link imsld_portlet::link
	    AddSelfToPage imsld_portlet::add_self_to_page
	    Show imsld_portlet::show
	    Edit imsld_portlet::edit
	    RemoveSelfFromPage imsld_portlet::remove_self_from_page
        }
    }
    
    acs_sc::impl::new_from_spec -spec $spec
}

ad_proc -private imsld_admin_portlet::after_install {} {
    Create the datasources needed by the imsld portlet.
} {

    db_transaction {
	set ds_id [portal::datasource::new \
		       -name "imsld_admin_portlet" \
		       -description "IMS LD Admin Portlet"]

	portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key shadeable_p \
            -value f

	portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key hideable_p \
            -value f

        portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key user_editable_p \
            -value f

        portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key shaded_p \
            -value f

        portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key link_hideable_p \
            -value t

        portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p f \
            -key package_id \
            -value ""

	register_portal_datasource_impl
    }

}



ad_proc -private imsld_admin_portlet::register_portal_datasource_impl {} {
    Create the service contracts needed by the imsld admin portlet.
} {
    set spec {
        name "imsld_admin_portlet"
	contract_name "portal_datasource"
	owner "imsld-portlet"
        aliases {
	    GetMyName imsld_admin_portlet::get_my_name
	    GetPrettyName  imsld_admin_portlet::get_pretty_name
	    Link imsld_admin_portlet::link
	    AddSelfToPage imsld_admin_portlet::add_self_to_page
	    Show imsld_admin_portlet::show
	    Edit imsld_admin_portlet::edit
	    RemoveSelfFromPage imsld_admin_portlet::remove_self_from_page
        }
    }
    
    acs_sc::impl::new_from_spec -spec $spec
}

ad_proc -private imsld_portlet::uninstall {} {
    IMS LD Portlet package uninstall proc
} {
    unregister_implementations
    set ds_id [portal::get_datasource_id imsld_portlet]
    db_exec_plsql delete_imsld_ds { *SQL* }
}

ad_proc -private imsld_admin_portlet::uninstall {} {
    IMS LD Portlet package uninstall proc
} {
    unregister_implementations
    set ds_id [portal::get_datasource_id imsld_admin_portlet]
    db_exec_plsql delete_admin_ds { *SQL* }
}

ad_proc -private imsld_portlet::unregister_implementations {} {
    Unregister service contract implementations
} {
    acs_sc::impl::delete \
        -contract_name "portal_datasource" \
        -impl_name "imsld_portlet"
}

ad_proc -private imsld_admin_portlet::unregister_implementations {} {
    Unregister service contract implementations
} {
    acs_sc::impl::delete \
        -contract_name "portal_datasource" \
        -impl_name "imsld_admin_portlet"
}
