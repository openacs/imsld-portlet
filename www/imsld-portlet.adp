<if @shaded_p@ false>

<if @list_of_package_ids@ not nil>
	<include src="../../imsld/lib/imsld-chunk" list_of_package_ids=@list_of_package_ids@ orderby=@orderby@>
 </if>
<else>
not implemented
</else>

</if>
<else>
  &nbsp;
</else>
