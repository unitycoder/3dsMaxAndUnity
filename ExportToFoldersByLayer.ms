-- more info : forum.unity3d.com/threads/looking-for-a-maxscripter.394941
-- Current features:
-- Print object names per layer
-- Export layer objects as fbx, to max project export folder with layername as subfolder

-- iterate all layers
for i = 0 to layerManager.count-1 do
(
	ilayer = layerManager.getLayer i
	layerName = ilayer.name
	
	layer = ILayerManager.getLayerObject i
	
	-- get all objects in this layer
	layerNodes = refs.dependents layer 
	
	-- filter object list, get only geometry objects, not used for now
	--layerGeometries = for ref in layerNodes where (superClassOf ref == GeometryClass) collect ( ref )
	
	-- display layer name
	format "\n------- Layer: %" layerName
	
	-- print objects from that layer
	for obj in layerNodes do
	(
		format "\nObject: %" obj
	)
	
	-- clear selection
	max select none
	
	-- select all objects in layer 
	layer.select true
	
	-- get path to project export folder
	exportPath = GetDir #export + "\\" + layerName
	-- check if folder exists
	if not doesFileExist exportPath do
	(
		format "\nFolder not found, creating it : % \n" exportPath
		makeDir exportPath
	)
	
	fullPath = (exportPath+"\\"+layerName+".fbx")
	format "Exporting layer % to '%'\n" layerName fullPath
	
	-- export (selected) objects from the layer
	exportfile fullPath #noPrompt selectedOnly:true
)

