<if @shaded_p@ false>

<if @community_id@ not nil>
 <if @imslds_in_class:rowcount@ gt 0>
  <blockquote>
  <multiple name="imslds_in_class">
  <li><strong>@imslds_in_class.imsld_title@</strong><br />
      <include src="../../imsld/lib/imsld-chunk" imsld_item_id="@imslds_in_class.imsld_id@"> 
  <br /><br />
  </multiple>
  </blockquote>
 </if>
 <else>
  <# There are no units of learning for this course. #>
 </else>
 </if>
<else>
not implemented
</else>

</if>
<else>
  &nbsp;
</else>
