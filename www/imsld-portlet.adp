<if @shaded_p@ false>

<if @community_id@ not nil>
	<include src="../../imsld/lib/imsld-chunk" community_id=@community_id@ orderby=@orderby@>
 </if>
<else>
not implemented
</else>

</if>
<else>
  &nbsp;
</else>
