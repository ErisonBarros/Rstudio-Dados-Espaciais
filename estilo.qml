<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.12.1-București" simplifyDrawingTol="1" simplifyMaxScale="1" simplifyAlgorithm="0" simplifyLocal="1" labelsEnabled="0" styleCategories="AllStyleCategories" minScale="100000000" hasScaleBasedVisibilityFlag="0" readOnly="0" simplifyDrawingHints="1" maxScale="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
  </flags>
  <renderer-v2 type="singleSymbol" enableorderby="0" symbollevels="0" forceraster="0">
    <symbols>
      <symbol clip_to_extent="1" force_rhr="0" type="fill" name="0" alpha="1">
        <layer locked="0" pass="0" class="SimpleLine" enabled="1">
          <prop k="capstyle" v="square"/>
          <prop k="customdash" v="5;2"/>
          <prop k="customdash_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="customdash_unit" v="MM"/>
          <prop k="draw_inside_polygon" v="0"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="line_color" v="35,35,35,255"/>
          <prop k="line_style" v="solid"/>
          <prop k="line_width" v="0.26"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="offset" v="0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <prop k="use_custom_dash" v="0"/>
          <prop k="width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" name="name" value=""/>
              <Option name="properties"/>
              <Option type="QString" name="type" value="collection"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
    </symbols>
    <rotation/>
    <sizescale/>
  </renderer-v2>
  <customproperties>
    <property value="0" key="embeddedWidgets/count"/>
    <property key="variableNames"/>
    <property key="variableValues"/>
  </customproperties>
  <blendMode>0</blendMode>
  <featureBlendMode>0</featureBlendMode>
  <layerOpacity>1</layerOpacity>
  <SingleCategoryDiagramRenderer diagramType="Histogram" attributeLegend="1">
    <DiagramCategory scaleBasedVisibility="0" height="15" lineSizeScale="3x:0,0,0,0,0,0" showAxis="1" spacing="5" backgroundColor="#ffffff" lineSizeType="MM" width="15" opacity="1" direction="0" labelPlacementMethod="XHeight" spacingUnit="MM" sizeScale="3x:0,0,0,0,0,0" diagramOrientation="Up" penWidth="0" rotationOffset="270" sizeType="MM" minScaleDenominator="0" maxScaleDenominator="1e+08" penAlpha="255" backgroundAlpha="255" scaleDependency="Area" enabled="0" penColor="#000000" barWidth="5" minimumSize="0" spacingUnitScale="3x:0,0,0,0,0,0">
      <fontProperties style="" description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0"/>
      <axisSymbol>
        <symbol clip_to_extent="1" force_rhr="0" type="line" name="" alpha="1">
          <layer locked="0" pass="0" class="SimpleLine" enabled="1">
            <prop k="capstyle" v="square"/>
            <prop k="customdash" v="5;2"/>
            <prop k="customdash_map_unit_scale" v="3x:0,0,0,0,0,0"/>
            <prop k="customdash_unit" v="MM"/>
            <prop k="draw_inside_polygon" v="0"/>
            <prop k="joinstyle" v="bevel"/>
            <prop k="line_color" v="35,35,35,255"/>
            <prop k="line_style" v="solid"/>
            <prop k="line_width" v="0.26"/>
            <prop k="line_width_unit" v="MM"/>
            <prop k="offset" v="0"/>
            <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
            <prop k="offset_unit" v="MM"/>
            <prop k="ring_filter" v="0"/>
            <prop k="use_custom_dash" v="0"/>
            <prop k="width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
            <data_defined_properties>
              <Option type="Map">
                <Option type="QString" name="name" value=""/>
                <Option name="properties"/>
                <Option type="QString" name="type" value="collection"/>
              </Option>
            </data_defined_properties>
          </layer>
        </symbol>
      </axisSymbol>
    </DiagramCategory>
  </SingleCategoryDiagramRenderer>
  <DiagramLayerSettings zIndex="0" linePlacementFlags="18" priority="0" showAll="1" placement="1" obstacle="0" dist="0">
    <properties>
      <Option type="Map">
        <Option type="QString" name="name" value=""/>
        <Option name="properties"/>
        <Option type="QString" name="type" value="collection"/>
      </Option>
    </properties>
  </DiagramLayerSettings>
  <geometryOptions geometryPrecision="0" removeDuplicateNodes="0">
    <activeChecks/>
    <checkConfiguration type="Map">
      <Option type="Map" name="QgsGeometryGapCheck">
        <Option type="double" name="allowedGapsBuffer" value="0"/>
        <Option type="bool" name="allowedGapsEnabled" value="false"/>
        <Option type="QString" name="allowedGapsLayer" value=""/>
      </Option>
    </checkConfiguration>
  </geometryOptions>
  <referencedLayers/>
  <referencingLayers/>
  <fieldConfiguration>
    <field name="bairro_codigo">
      <editWidget type="Range">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="bairro_nome_ca">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="rpa">
      <editWidget type="Range">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="microrregiao">
      <editWidget type="Range">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="bairro_nome">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="bairro_codigo" name="" index="0"/>
    <alias field="bairro_nome_ca" name="" index="1"/>
    <alias field="rpa" name="" index="2"/>
    <alias field="microrregiao" name="" index="3"/>
    <alias field="bairro_nome" name="" index="4"/>
  </aliases>
  <excludeAttributesWMS/>
  <excludeAttributesWFS/>
  <defaults>
    <default field="bairro_codigo" applyOnUpdate="0" expression=""/>
    <default field="bairro_nome_ca" applyOnUpdate="0" expression=""/>
    <default field="rpa" applyOnUpdate="0" expression=""/>
    <default field="microrregiao" applyOnUpdate="0" expression=""/>
    <default field="bairro_nome" applyOnUpdate="0" expression=""/>
  </defaults>
  <constraints>
    <constraint field="bairro_codigo" unique_strength="0" constraints="0" notnull_strength="0" exp_strength="0"/>
    <constraint field="bairro_nome_ca" unique_strength="0" constraints="0" notnull_strength="0" exp_strength="0"/>
    <constraint field="rpa" unique_strength="0" constraints="0" notnull_strength="0" exp_strength="0"/>
    <constraint field="microrregiao" unique_strength="0" constraints="0" notnull_strength="0" exp_strength="0"/>
    <constraint field="bairro_nome" unique_strength="0" constraints="0" notnull_strength="0" exp_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint desc="" field="bairro_codigo" exp=""/>
    <constraint desc="" field="bairro_nome_ca" exp=""/>
    <constraint desc="" field="rpa" exp=""/>
    <constraint desc="" field="microrregiao" exp=""/>
    <constraint desc="" field="bairro_nome" exp=""/>
  </constraintExpressions>
  <expressionfields/>
  <attributeactions>
    <defaultAction value="{00000000-0000-0000-0000-000000000000}" key="Canvas"/>
  </attributeactions>
  <attributetableconfig actionWidgetStyle="dropDown" sortExpression="" sortOrder="0">
    <columns>
      <column hidden="0" width="-1" type="field" name="bairro_codigo"/>
      <column hidden="0" width="-1" type="field" name="bairro_nome_ca"/>
      <column hidden="0" width="-1" type="field" name="rpa"/>
      <column hidden="0" width="-1" type="field" name="microrregiao"/>
      <column hidden="0" width="-1" type="field" name="bairro_nome"/>
      <column hidden="1" width="-1" type="actions"/>
    </columns>
  </attributetableconfig>
  <conditionalstyles>
    <rowstyles/>
    <fieldstyles/>
  </conditionalstyles>
  <storedexpressions/>
  <editform tolerant="1"></editform>
  <editforminit/>
  <editforminitcodesource>0</editforminitcodesource>
  <editforminitfilepath></editforminitfilepath>
  <editforminitcode><![CDATA[# -*- código: utf-8 -*-
"""
Formas QGIS podem ter uma função Python que é chamada quando o formulário é
aberto.

Use esta função para adicionar lógica extra para seus formulários.

Digite o nome da função na "função Python Init"
campo.
Um exemplo a seguir:
"""
de qgis.PyQt.QtWidgets importar QWidget

def my_form_open(diálogo, camada, feição):
	geom = feature.geometry()
	control = dialog.findChild(QWidget, "MyLineEdit")
]]></editforminitcode>
  <featformsuppress>0</featformsuppress>
  <editorlayout>generatedlayout</editorlayout>
  <editable>
    <field editable="1" name="bairro_codigo"/>
    <field editable="1" name="bairro_nome"/>
    <field editable="1" name="bairro_nome_ca"/>
    <field editable="1" name="microrregiao"/>
    <field editable="1" name="rpa"/>
  </editable>
  <labelOnTop>
    <field name="bairro_codigo" labelOnTop="0"/>
    <field name="bairro_nome" labelOnTop="0"/>
    <field name="bairro_nome_ca" labelOnTop="0"/>
    <field name="microrregiao" labelOnTop="0"/>
    <field name="rpa" labelOnTop="0"/>
  </labelOnTop>
  <widgets/>
  <previewExpression>bairro_nome_ca</previewExpression>
  <mapTip></mapTip>
  <layerGeometryType>2</layerGeometryType>
</qgis>
