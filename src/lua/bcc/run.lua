--[[
Copyright 2016 GitHub, Inc

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
]]

return function()
  local BCC = require("bcc.init")
  local BPF = BCC.BPF

  BPF.script_root(arg[1])

  local utils = {
    argparse = require("bcc.vendor.argparse"),
    posix = require("bcc.vendor.posix"),
    sym = BCC.sym
  }

  local tracefile = table.remove(arg, 1)
  local command = dofile(tracefile)
  local res, err = pcall(command, BPF, utils)

  if not res then
    io.stderr:write("[ERROR] "..err.."\n")
  end

  BPF.cleanup_probes()
  return res, err
end
