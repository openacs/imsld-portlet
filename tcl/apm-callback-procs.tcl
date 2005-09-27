ad_library {
    Procedures for initializing service contracts etc. for the
    imsld portlet package. Should only be executed 
    once upon installation.
    
    @creation-date 2005-09-27
    @author eperez@it.uc3m.es
    @cvs-id $Id$
}

namespace eval apm::imsld_portlet {}
namespace eval apm::imsld_admin_portlet {}

ad_proc -public apm::imsld_portlet::after_install {} {
    Create the datasources needed by the imsld portlets.
} {
        imsld_portlet::after_install
        imsld_admin_portlet::after_install
}

ad_proc -public apm::imsld_portlet::before_uninstall {} {
    IMS LD Portlet package uninstall proc
} {

    db_transaction {
        imsld_portlet::uninstall
        imsld_admin_portlet::uninstall
    }
}
