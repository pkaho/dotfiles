local wezterm = require("wezterm")
local platform = require("utils.platform")

local options = {
  front_end = "OpenGL"
}

local gpu_priority = {
  Vulkan = 1,
  Dx12 = 2,
  Gl = 3,
}
if platform.is_mac then
  gpu_priority = { Metal = 1}
end

local function detect_gpus()
  local best_discrete_gpu = nil
  local best_integrated_gpu = nil

  for _, gpu in ipairs(wezterm.gui.enumerate_gpus()) do
    -- 排除 NVIDIA GPU
    if gpu.name:match("NVIDIA") then
      goto continue
    end

    -- 根据后端和设备类型选择 GPU
    local current_priority = gpu_priority[gpu.backend] or math.huge
    if gpu.device_type == "DiscreteGpu" then
      if not best_discrete_gpu or current_priority < best_discrete_gpu.priority then
        best_discrete_gpu = { gpu = gpu, priority = current_priority }
      end
    elseif gpu.device_type == "IntegratedGpu" then
      if not best_integrated_gpu or current_priority < best_integrated_gpu.priority then
        best_integrated_gpu = { gpu = gpu, priority = current_priority }
      end
    end

    ::continue::
  end

  return best_discrete_gpu or best_integrated_gpu
end

local selected_gpu = detect_gpus()
if selected_gpu then
  options.front_end = "WebGpu"
  options.webgpu_preferred_adapter = selected_gpu.gpu
  options.webgpu_power_preference = "HighPerformance"
  options.webgpu_force_fallback_adapter = false
end

return options
