function data()
  return {  
	info = {
		minorVersion = 0,
		severityAdd = "NONE",
		severityRemove = "WARNING", 
		name = _("mod_name"),
		description = _(
						"mod_desc"
						),
		authors = {
			{
				name = 'jay_',
				role = 'CREATOR',
				text = 'Modell',
				tfnetId = 28954,
			},
					    {
		        name = "ModWerkstatt",
		        role = "CREATOR",
		    },  
		},
		params = {		
			{
				key = "zugschluss_land",
				name = _("tafel_aktiv"),
				values = {_("schluss_de"), _("schluss_fr"),},
				tooltip = _("schluss_tooltip"),
				defaultIndex = 0,
			},
			{
				key = "ctc_versionen",
				name = _("ctc_aktiv"),
				values = {_("yes"), _("no"),},
				tooltip = _("ctc_tooltip"),
				defaultIndex = 0,
			},
			{
				key = "fr_versionen",
				name = _("fr_aktiv"),
				values = {_("yes"), _("no"),},
				tooltip = _("frVersion_tooltip"),
				defaultIndex = 0,
			},
						{
				key = "it_versionen",
				name = _("it_aktiv"),
				values = {_("yes"), _("no"),},
				tooltip = _("itVersion_tooltip"),
				defaultIndex = 0,
			},
			
			{
				key = "soundCheck",
				name = _("sound_check"),
				uiType = "CHECKBOX",
				values = { "No", "Yes", },				
				defaultIndex = 1,	
			},
		},
		tags = { "Europe", "Vehicle", "Freight", "Wagon", "CTC", "Transcereales", "Hopper", "Uagps", },
		dependencies = {},
		}, 
		
		runFn = function (settings, modParams)
		local params = modParams[getCurrentModId()]

		
		-- Filter the foldersssssssssss
		
		local function excludeFolderFilter_german(fileName, data)
			print(fileName)
			if fileName:match('/schluss_fr/base/') or fileName:match('/schluss_fr/ctc/') or fileName:match('/schluss_fr/fra/') or fileName:match('/schluss_fr/ita/') then
				return false 
			end
			return true 
		end
		
		local function excludeFolderFilter_french(fileName, data)
			print(fileName)
			if fileName:match('/schluss_de/base/') or fileName:match('/schluss_de/ctc/') or fileName:match('/schluss_de/fra/') or fileName:match('/schluss_de/ita/') then
				return false 
			end
			return true 
		end
		
		-- CTC Filter
		
		local function excludeFolderFilter_ctc(fileName, data)
			print(fileName)
			if fileName:match('/schluss_fr/ctc/') or fileName:match('/schluss_de/ctc/') then
				return false 
			end
			return true 
		end
		
		-- Filter france
		
		local function excludeFolderFilter_france(fileName, data)
			print(fileName)
			if fileName:match('/schluss_fr/fra/') or fileName:match('/schluss_de/fra/') then
				return false 
			end
			return true 
		end
		
		-- Filer italia
		
		local function excludeFolderFilter_italy(fileName, data)
			print(fileName)
			if fileName:match('/schluss_fr/ita/') or fileName:match('/schluss_de/ita/') then
				return false 
			end
			return true 
		end
		
		if modParams[getCurrentModId()] ~= nil then
			local params = modParams[getCurrentModId()]		
			-- zugschluss
			if params["zugschluss_land"] == 0 then
				addFileFilter("model/vehicle", excludeFolderFilter_german)		
			end
			if params["zugschluss_land"] == 1 then
				addFileFilter("model/vehicle", excludeFolderFilter_french)		
			end
			-- ctc
			if params["ctc_versionen"] == 1 then
				addFileFilter("model/vehicle", excludeFolderFilter_ctc)		
			end
			-- france
			if params["fr_versionen"] == 1 then
				addFileFilter("model/vehicle", excludeFolderFilter_france)		
			end
			-- italy
			if params["it_versionen"] == 1 then
				addFileFilter("model/vehicle", excludeFolderFilter_italy)		
			end
			
		else
			addFileFilter("model/vehicle", modelFilter)	
		end	
		

		

		local function metadataHandler(fileName, data)
			if params.soundCheck == 0 then
			local waggon_types = { "uagpsA", "uagpsB" }
			local zugschluss = { "schluss_de", "schluss_fr" }
			local versions = { "base", "ctc", "fra", "ita" }

			for _, waggon_type in ipairs(waggon_types) do
				for _, schluss in ipairs(zugschluss) do
					for _, version in ipairs(versions) do
						if fileName:match('/vehicle/waggon/' .. waggon_type .. '/' .. schluss .. '/' .. version .. '/' .. waggon_type .. '_([^/]*.mdl)') then
							data.metadata.railVehicle.soundSet.name = "waggon_freight_modern"
							break
						end
					end
				end
			end
		end
		return data
	end

		addModifier( "loadModel", metadataHandler )
	end,
}
end