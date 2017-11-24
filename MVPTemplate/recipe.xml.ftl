<?xml version="1.0"?>
<recipe>

	
    <instantiate from="src/app_package/classes/Model.java.ftl"
    to="${escapeXmlAttribute(srcOut)}/model/${className}Model.java" />
      
    <instantiate from="src/app_package/classes/Fragment.java.ftl"
    to="${escapeXmlAttribute(srcOut)}/view/${className}Fragment.java" />
    
    <instantiate from="src/app_package/classes/Contract.java.ftl"
    to="${escapeXmlAttribute(srcOut)}/contract/${className}Contract.java" />
    
    <instantiate from="src/app_package/classes/Presenter.java.ftl"
    to="${escapeXmlAttribute(srcOut)}/presenter/${className}Presenter.java" />

    <open file="${srcOut}/view/${className}Fragment.java"/>
</recipe>
