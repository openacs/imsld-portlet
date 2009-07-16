<if @shaded_p@ false>

<if @list_of_package_ids@ not nil>
	<include src="/packages/imsld/lib/imsld-chunk" list_of_package_ids=@list_of_package_ids@ orderby=@orderby@>
 </if>
</if>
<else>
    #new-portal.when_portlet_shaded#
</else>
