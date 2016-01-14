MCP4131 = {
  _speed = 10,
  _spi = 1,
  _was_setup = false,
  cs = 8,
  max_pos = 0x7f,
  wiper = 0x00,
}

function MCP4131:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  o:_setup_once()
  gpio.mode(o.cs, gpio.OUTPUT)
  return o
end

function MCP4131:increment() self:_write_byte(0x04) end
function MCP4131:decrement() self:_write_byte(0x08) end
function MCP4131:set(p) self:_write_word(0x00, p * self.max_pos / 100) end

function MCP4131:_setup_once()
  if not MCP4131._was_setup then
    spi.setup(self._spi, spi.MASTER, spi.CPHA_LOW, spi.CPOL_LOW, spi.DATABITS_8, self._speed)
    MCP4131._was_setup = true
  end
end

function MCP4131:_cs_low() gpio.write(self.cs, gpio.LOW) end
function MCP4131:_cs_high() gpio.write(self.cs, gpio.HIGH) end

function MCP4131:_write_byte(b)
  b = bit.band(b, 0xff)
  b = bit.bor(b, self.wiper)
  
  self:_cs_low()
  spi.send(self._spi, b)
  self:_cs_high()
  tmr.delay(100)
end

function MCP4131:_write_word(b1, b2)
  b1 = bit.band(b1, 0xff)
  b1 = bit.bor(b1, self.wiper)
  b2 = bit.band(b2, 0xff)

  self:_cs_low()
  spi.send(self._spi, b1)
  spi.send(self._spi, b2)
  self:_cs_high()
  tmr.delay(100)
end
