import cpp

from MacroInvocation m
where
  m.getMacroName() in ["ntohs", "ntohl", "ntohll"]
select m
