local wezterm = require("wezterm")
local platform = require("utils.platform")

local function detect_gpus(backend)
	local discrete_gpu, integrated_gpu = nil, nil

	for _, gpu in ipairs(wezterm.gui.enumerate_gpus()) do
		if gpu.backend == backend then
      -- It might make opacity weird if you use an NVIDIA graphics card
			if gpu.device_type == "DiscreteGpu" and not gpu.name:match("NVIDIA") then
				discrete_gpu = gpu
        break
			elseif gpu.device_type == "IntegratedGpu" and not gpu.name:match("NVIDIA") then
				integrated_gpu = gpu
			end
		end
	end

	return discrete_gpu or integrated_gpu
end

local function get_suitable_gpu()
	if platform.is_mac then
		return detect_gpus("Metal")
	else
		return detect_gpus("Vulkan")
	end
end

local suitable_gpu = get_suitable_gpu()
if not suitable_gpu then
	print("No suitable GPU found.")
end

return suitable_gpu
