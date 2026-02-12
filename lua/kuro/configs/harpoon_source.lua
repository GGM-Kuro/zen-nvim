return {
	finder = function()
		local output = {}
		for _, item in ipairs(require("harpoon"):list().items) do
			if item and item.value:match("%S") then
				table.insert(output, {
					text = item.value,
					file = item.value,
					pos = { item.context.row, item.context.col },
				})
			end
		end
		return output
	end,
	filter = {
		transform = function()
			return true
		end,
	},
	format = function(item)
		return {
			{ item.text },
			{ ":", "SnacksPickerDelim" },
			{ tostring(item.pos[1]), "SnacksPickerRow" },
			{ ":", "SnacksPickerDelim" },
			{ tostring(item.pos[2]), "SnacksPickerCol" },
		}
	end,
	preview = function(ctx)
		if Snacks.picker.util.path(ctx.item) then
			return Snacks.picker.preview.file(ctx)
		else
			return Snacks.picker.preview.none(ctx)
		end
	end,
	confirm = "jump",
}

