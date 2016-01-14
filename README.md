# nodemcu-mcp41xx
NodeMCU interface for MCP4131 and other similar chips

    dofile('mcp4131.lua')

    pot1 = MCP4131:new({cs = 8}))

    pot1:set(0)   -- 0%
    pot1:set(100) -- 100%

    pot1:increment()
    pot1:decrement()
