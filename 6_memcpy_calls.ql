import cpp

from FunctionCall c
where
  c.getTarget().hasName("memcpy")
select c
