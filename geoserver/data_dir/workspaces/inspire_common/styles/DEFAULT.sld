<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" 
		xsi:schemaLocation="http://www.opengis.net/sld StyledLayerDescriptor.xsd" 
		xmlns="http://www.opengis.net/sld" 
		xmlns:ogc="http://www.opengis.net/ogc" 
		xmlns:xlink="http://www.w3.org/1999/xlink" 
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
		<!-- a named layer is the basic building block of an sld document -->

	<NamedLayer>
		<Name>Default Line</Name>
		<UserStyle>
		    <!-- they have names, titles and abstracts -->
		  
			<Title>Generic Link Default Style</Title>
			<Abstract>The geometry is rendered as a solid Black line with a stroke width of 3 pixel (#000000). Ends are rounded and have a 2 pixel black casing (#000000).</Abstract>
			<!-- FeatureTypeStyles describe how to render different features -->
			<!-- a feature type for lines -->

			<FeatureTypeStyle>
				<!--FeatureTypeName>Feature</FeatureTypeName-->
				<Rule>
					<Name>Black line</Name>
					<Title>Black line</Title>
					<Abstract>a solid Black line with a stroke width of 3 pixel (#000000)</Abstract>

					<!-- like a polygonsymbolizer -->
					<LineSymbolizer>
						<Stroke>
							<CssParameter name="stroke">#000000</CssParameter>
						</Stroke>
					</LineSymbolizer>
				</Rule>

		    </FeatureTypeStyle>
		</UserStyle>
	</NamedLayer>
</StyledLayerDescriptor>